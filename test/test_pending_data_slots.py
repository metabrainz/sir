import contextlib
import logging
import os
import unittest
from configparser import ConfigParser
from unittest import mock

from sqlalchemy.orm import sessionmaker

from sir import __main__ as sir_main
from sir import config
from sir.pending_data import handler

from . import test_pending_data_sql as base

UPDATES_DIR = os.path.join(base.SIR_SQL_DIR, 'updates')
MIGRATION = os.path.join(UPDATES_DIR, '20261103-pending-data-slots.sql')
ROLLBACK = os.path.join(UPDATES_DIR, '20261103-pending-data-slots-rollback.sql')

# The schema before slots were introduced.
OLD_SCHEMA = """
    CREATE TABLE sir.pending_data (
        seqid           BIGINT NOT NULL,
        xid             BIGINT NOT NULL,
        tablename       TEXT NOT NULL,
        op              "char" NOT NULL,
        olddata         JSON,
        newdata         JSON,
        attempts        SMALLINT NOT NULL DEFAULT 0,
        last_attempted  TIMESTAMP WITH TIME ZONE,
        failure_reason  TEXT NOT NULL DEFAULT ''
    );
    ALTER TABLE sir.pending_data
        ADD CONSTRAINT pending_data_pkey PRIMARY KEY (seqid);

    CREATE FUNCTION sir.a_ins_dbmirror2_pending_data() RETURNS trigger AS $$
    BEGIN
        INSERT INTO sir.pending_data
                (seqid, xid, tablename, op, olddata, newdata,
                 attempts, last_attempted, failure_reason)
            SELECT ir.seqid, ir.xid, ir.tablename, ir.op,
                   ir.olddata, ir.newdata, 0, NULL, ''
            FROM inserted_rows ir;
        RETURN NULL;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER copy_pending_data_sir
        AFTER INSERT ON dbmirror2.pending_data
        REFERENCING NEW TABLE AS inserted_rows
        FOR EACH STATEMENT
        EXECUTE FUNCTION sir.a_ins_dbmirror2_pending_data();
"""


class SlotDBTestCase(base.PendingDataDBTestCase):

    def _all_queue(self):
        return self._execute("""SELECT slot, seqid, attempts, failure_reason
                                FROM sir.pending_data_queue
                                ORDER BY slot, seqid""").fetchall()

    def _insert_rows(self, count):
        # `sir.control` isn't an entity table, so the handler treats these
        # rows as irrelevant and doesn't need Solr to process them.
        return [
            self._scalar("""INSERT INTO dbmirror2.pending_data
                                (tablename, op, xid, newdata)
                            VALUES ('sir.control', 'i', txid_current(), '{}')
                            RETURNING seqid""")
            for _ in range(count)
        ]

    def _fake_engine(self):
        """An engine whose transactions run inside the test's transaction."""
        engine = mock.Mock()
        engine.begin.side_effect = lambda: contextlib.nullcontext(self.connection)
        return engine


class HandlerQueueTestCase(SlotDBTestCase):
    """The handler's queries run against real tables."""

    def setUp(self):
        super().setUp()
        self._execute("INSERT INTO sir.pending_data_slot VALUES (2, 'Second')")

        patchers = [
            mock.patch.object(handler, 'solr_connection'),
            mock.patch.object(handler, 'solr_version_check'),
            mock.patch.object(handler, 'live_index'),
            mock.patch.object(handler, 'PROCESS_FLAG', mock.Mock(value=True)),
            mock.patch.object(handler, 'db_session', return_value=sessionmaker(
                bind=self.connection,
                join_transaction_mode='create_savepoint')),
        ]
        for patcher in patchers:
            patcher.start()
            self.addCleanup(patcher.stop)
        self.live_index = handler.live_index

    def _handler(self, slot, **attrs):
        h = handler.Handler([], slot)
        for name, value in attrs.items():
            setattr(h, name, value)
        return h

    def test_poll_only_returns_rows_of_its_own_slot(self):
        s1, s2 = self._insert_rows(2)
        self._execute("DELETE FROM sir.pending_data_queue WHERE slot = 2 AND seqid = :s",
                      {"s": s1})

        h1, h2 = self._handler(1), self._handler(2)

        self.assertEqual(2, h1.poll())
        self.assertEqual([s1, s2], h1.pending_seqids)
        self.assertEqual(1, h2.poll())
        self.assertEqual([s2], h2.pending_seqids)

    def test_poll_respects_batch_size_and_order(self):
        seqids = self._insert_rows(3)
        h = self._handler(1, batch_size=2)

        self.assertEqual(2, h.poll())
        self.assertEqual(seqids[:2], h.pending_seqids)

    def test_poll_returns_nothing_when_indexing_is_disabled(self):
        self._insert_rows(1)
        self._execute("UPDATE sir.control SET indexing_enabled = FALSE")

        self.assertEqual(0, self._handler(1).poll())

    def test_poll_skips_exhausted_and_backed_off_rows(self):
        exhausted, backed_off, retryable, fresh = self._insert_rows(4)
        self._execute("""UPDATE sir.pending_data_queue
                         SET attempts = 4, last_attempted = NOW() - interval '1 day'
                         WHERE slot = 1 AND seqid = :s""", {"s": exhausted})
        self._execute("""UPDATE sir.pending_data_queue
                         SET attempts = 2, last_attempted = NOW() - interval '9 minutes'
                         WHERE slot = 1 AND seqid = :s""", {"s": backed_off})
        self._execute("""UPDATE sir.pending_data_queue
                         SET attempts = 2, last_attempted = NOW() - interval '11 minutes'
                         WHERE slot = 1 AND seqid = :s""", {"s": retryable})

        h = self._handler(1, max_retries=4)
        h.poll()

        self.assertEqual([retryable, fresh], h.pending_seqids)

    def test_poll_starts_a_fresh_batch(self):
        self._insert_rows(1)
        h = self._handler(1)
        h.pending_seqids = [12345]

        h.poll()

        self.assertNotIn(12345, h.pending_seqids)

    def test_processed_rows_are_only_removed_from_its_own_queue(self):
        s1, s2 = self._insert_rows(2)
        h1, h2 = self._handler(1), self._handler(2)

        h1.poll()
        h1.process_messages()

        self.live_index.assert_called_once()
        self.assertEqual([(2, s1), (2, s2)],
                         [(r.slot, r.seqid) for r in self._all_queue()])
        self.assertEqual([s1, s2], self._pending_seqids())

        h2.poll()
        h2.process_messages()

        self.assertEqual([], self._all_queue())
        self.assertEqual([], self._pending_seqids())

    def test_failures_are_recorded_per_slot(self):
        s1, = self._insert_rows(1)
        self.live_index.side_effect = RuntimeError("solr is down")
        h1 = self._handler(1)

        h1.poll()
        h1.process_messages()

        self.assertEqual(
            [(1, s1, 1, "solr is down"), (2, s1, 0, "")],
            [tuple(r) for r in self._all_queue()])
        self.assertEqual([s1], self._pending_seqids())

    def test_interrupted_processing_marks_rows_failed(self):
        s1, = self._insert_rows(1)
        h = self._handler(1)
        h.poll()

        with mock.patch.object(handler, 'PROCESS_FLAG', mock.Mock(value=False)):
            h.process_messages()

        self.assertEqual(
            [(1, s1, 1, "SIR terminated while processing."), (2, s1, 0, "")],
            [tuple(r) for r in self._all_queue()])

    def test_unparsable_rows_fail_without_blocking_the_others(self):
        bad, = self._insert_rows(1)
        self._execute("""UPDATE sir.pending_data SET tablename = 'musicbrainz.artist', op = 'x'
                         WHERE seqid = :s""", {"s": bad})
        good, = self._insert_rows(1)
        h = self._handler(1)

        self.assertEqual(2, h.poll())

        self.assertEqual([good], h.pending_seqids)
        failed = {(r.slot, r.seqid): r.attempts for r in self._all_queue()}
        self.assertEqual(1, failed[(1, bad)])
        self.assertEqual(0, failed[(2, bad)])

    def test_check_slot(self):
        self.assertEqual("Default", self._handler(1).check_slot())

        with self.assertRaisesRegex(handler.SLOT_NOT_FOUND, "slot 3 does not exist"):
            self._handler(3).check_slot()


class WatchConfigTestCase(unittest.TestCase):

    def test_missing_section_exits(self):
        with mock.patch.object(config, 'CFG', ConfigParser()), \
                mock.patch.object(handler, '_watch_impl') as watch_impl:
            with self.assertRaises(SystemExit) as cm:
                handler.watch({"entity_type": None})
        self.assertEqual(1, cm.exception.code)
        watch_impl.assert_not_called()

    def test_missing_option_exits(self):
        cfg = ConfigParser()
        cfg.read_dict({"sir": {"poll_interval": "5"}})
        with mock.patch.object(config, 'CFG', cfg), \
                mock.patch.object(handler, '_watch_impl') as watch_impl:
            with self.assertRaises(SystemExit) as cm:
                handler.watch({"entity_type": None})
        self.assertEqual(1, cm.exception.code)
        watch_impl.assert_not_called()

    def test_slot_is_passed_to_the_handler(self):
        cfg = ConfigParser()
        cfg.read_dict({"sir": {"pending_data_slot": "7"}})
        with mock.patch.object(config, 'CFG', cfg), \
                mock.patch.object(handler, '_watch_impl') as watch_impl:
            handler.watch({"entity_type": ["artist"]})
        watch_impl.assert_called_once_with(["artist"], 7)


class WatchLoopTestCase(unittest.TestCase):

    def setUp(self):
        process_flag = mock.Mock(value=True)
        sleeps = []

        def sleep(seconds):
            # Stop the loop if the dropped slot goes unnoticed.
            sleeps.append(seconds)
            if len(sleeps) >= 3:
                process_flag.value = False

        patchers = [
            mock.patch.object(handler, 'Handler'),
            mock.patch.object(handler, 'PROCESS_FLAG', process_flag),
            mock.patch.object(handler.signal, 'signal'),
            mock.patch.object(handler.time, 'sleep', side_effect=sleep),
        ]
        for patcher in patchers:
            patcher.start()
            self.addCleanup(patcher.stop)
        self.handler = handler.Handler.return_value
        self.handler.poll_interval = 5

    def test_dropped_slot_is_noticed_on_an_idle_poll(self):
        self.handler.poll.side_effect = [1, 0]
        self.handler.check_slot.side_effect = ["Default", handler.SLOT_NOT_FOUND(1)]

        with self.assertRaises(handler.SLOT_NOT_FOUND):
            handler._watch_impl(["artist"], 1)

        self.handler.process_messages.assert_called_once()
        self.assertEqual(2, self.handler.check_slot.call_count)

    def test_dropped_slot_exits(self):
        cfg = ConfigParser()
        cfg.read_dict({"sir": {"pending_data_slot": "7"}})
        self.handler.poll.return_value = 0
        self.handler.check_slot.side_effect = ["Default", handler.SLOT_NOT_FOUND(7)]

        with mock.patch.object(config, 'CFG', cfg), \
                self.assertLogs('sir', level=logging.ERROR) as logs, \
                self.assertRaises(SystemExit) as cm:
            handler.watch({"entity_type": None})

        self.assertEqual(1, cm.exception.code)
        self.assertIn("slot 7 does not exist", logs.output[-1])


class SlotCommandsTestCase(SlotDBTestCase):

    def setUp(self):
        super().setUp()
        patcher = mock.patch('sir.util.engine', return_value=self._fake_engine())
        patcher.start()
        self.addCleanup(patcher.stop)

    def test_create_slot_queues_new_changes_only(self):
        before, = self._insert_rows(1)

        sir_main.create_slot({"id": 2, "description": "Second"})
        after, = self._insert_rows(1)

        self.assertEqual("Second", self._scalar(
            "SELECT description FROM sir.pending_data_slot WHERE id = 2"))
        self.assertEqual([(1, before), (1, after), (2, after)], self._queue())

    def test_drop_slot_removes_the_slot_and_its_queue(self):
        self._execute("INSERT INTO sir.pending_data_slot VALUES (2, 'Second')")
        s1, s2 = self._insert_rows(2)
        self._execute("DELETE FROM sir.pending_data_queue WHERE slot = 1")

        sir_main.drop_slot({"id": 2})

        self.assertEqual([], self._queue())
        self.assertEqual([], self._pending_seqids())
        self.assertEqual([1], [r.id for r in self._execute(
            "SELECT id FROM sir.pending_data_slot")])

    def test_drop_slot_keeps_rows_needed_by_other_slots(self):
        self._execute("INSERT INTO sir.pending_data_slot VALUES (2, 'Second')")
        s1, s2 = self._insert_rows(2)

        sir_main.drop_slot({"id": 2})

        self.assertEqual([s1, s2], self._pending_seqids())
        self.assertEqual([(1, s1), (1, s2)], self._queue())

    def test_drop_slot_empties_the_queue_in_batches(self):
        self._execute("INSERT INTO sir.pending_data_slot VALUES (2, 'Second')")
        self._insert_rows(5)
        original = self.connection.execute
        statements = []

        def record(clause, *args, **kwargs):
            statements.append(str(clause))
            return original(clause, *args, **kwargs)

        with mock.patch.object(self.connection, 'execute', side_effect=record):
            sir_main.drop_slot({"id": 2})

        deletes = [s for s in statements if 'DELETE FROM sir.pending_data_queue' in s]
        # One batch which deletes rows, and one which finds nothing left.
        self.assertEqual(2, len(deletes))

    def test_drop_slot_which_does_not_exist_warns(self):
        with self.assertLogs('sir', level=logging.WARNING) as logs:
            sir_main.drop_slot({"id": 9})

        self.assertIn("does not exist", logs.output[0])

    def test_writes_work_after_dropping_a_slot(self):
        self._execute("INSERT INTO sir.pending_data_slot VALUES (2, 'Second')")
        sir_main.drop_slot({"id": 2})

        s1, = self._insert_rows(1)

        self.assertEqual([(1, s1)], self._queue())


class MigrationTestCase(SlotDBTestCase):
    """The update and rollback scripts in ``sql/updates``."""

    def _use_old_schema(self, standalone):
        self._execute("DROP SCHEMA sir CASCADE")
        self._execute("CREATE SCHEMA sir")
        self._execute("""CREATE TABLE sir.control (
                             indexing_enabled BOOLEAN NOT NULL DEFAULT TRUE);
                         INSERT INTO sir.control VALUES (TRUE)""")
        self._execute(OLD_SCHEMA)
        if standalone:
            for name in ['CreateStandaloneOnlyFunctions.sql',
                         'CreateStandaloneOnlyTriggers.sql']:
                self._execute_file(os.path.join(base.SIR_SQL_DIR, name))

    def _old_rows(self):
        return self._execute("""SELECT seqid, attempts, failure_reason
                                FROM sir.pending_data ORDER BY seqid""").fetchall()

    def _seed_old_rows(self):
        ok = self._scalar("""INSERT INTO dbmirror2.pending_data
                                 (tablename, op, xid, olddata, newdata)
                             VALUES ('musicbrainz.artist', 'i', 1001, NULL,
                                     '{"id": 1, "name": "Artist"}')
                             RETURNING seqid""")
        failed = self._scalar("""INSERT INTO dbmirror2.pending_data
                                     (tablename, op, xid, olddata, newdata)
                                 VALUES ('musicbrainz.release', 'u', 1002,
                                         '{"id": 2, "name": "Old name"}',
                                         '{"id": 2, "name": "New name"}')
                                 RETURNING seqid""")
        self._execute("""UPDATE sir.pending_data
                         SET attempts = 3, failure_reason = 'boom',
                             last_attempted = '2026-11-01 12:34:56+00'
                         WHERE seqid = :s""", {"s": failed})
        return ok, failed

    def _full_old_rows(self):
        return self._execute("""SELECT seqid, xid, tablename, op,
                                       CAST(olddata AS TEXT), CAST(newdata AS TEXT),
                                       attempts, last_attempted, failure_reason
                                FROM sir.pending_data
                                ORDER BY seqid""").fetchall()

    def _full_migrated_rows(self, slot):
        return self._execute("""SELECT pd.seqid, pd.xid, pd.tablename, pd.op,
                                       CAST(pd.olddata AS TEXT), CAST(pd.newdata AS TEXT),
                                       q.attempts, q.last_attempted, q.failure_reason
                                FROM sir.pending_data pd
                                JOIN sir.pending_data_queue q ON q.seqid = pd.seqid
                                WHERE q.slot = :slot
                                ORDER BY pd.seqid""", {"slot": slot}).fetchall()

    def _describe_schema(self):
        """The parts of the sir schema the migration changes."""
        return {
            'columns': self._execute(
                """SELECT table_name, column_name, data_type, is_nullable, column_default
                   FROM information_schema.columns
                   WHERE table_schema = 'sir' AND table_name LIKE 'pending_data%'
                   ORDER BY table_name, ordinal_position""").fetchall(),
            'constraints': self._execute(
                """SELECT CAST(CAST(conrelid AS regclass) AS TEXT), conname,
                          pg_get_constraintdef(oid)
                   FROM pg_constraint
                   WHERE connamespace = CAST('sir' AS regnamespace)
                   ORDER BY 1, 2""").fetchall(),
            'indexes': self._execute(
                """SELECT indexdef FROM pg_indexes
                   WHERE schemaname = 'sir' AND tablename LIKE 'pending_data%'
                   ORDER BY indexname""").fetchall(),
            'triggers': self._execute(
                """SELECT pg_get_triggerdef(t.oid)
                   FROM pg_trigger t
                   JOIN pg_proc p ON p.oid = t.tgfoid
                   WHERE p.pronamespace = CAST('sir' AS regnamespace)
                     AND NOT t.tgisinternal
                   ORDER BY t.tgname""").fetchall(),
            'functions': self._execute(
                """SELECT proname, prosrc FROM pg_proc
                   WHERE pronamespace = CAST('sir' AS regnamespace)
                   ORDER BY proname""").fetchall(),
        }

    def _migrate(self):
        self._execute_file(MIGRATION)

    def _rollback(self):
        self._execute_file(ROLLBACK)

    def _columns(self, table):
        return [r.column_name for r in self._execute(
            """SELECT column_name FROM information_schema.columns
               WHERE table_schema = 'sir' AND table_name = :t
               ORDER BY ordinal_position""", {"t": table})]

    def test_migration_moves_failure_state_to_slot_one(self):
        self._use_old_schema(standalone=False)
        ok, failed = self._seed_old_rows()

        self._migrate()

        self.assertEqual(['seqid', 'xid', 'tablename', 'op', 'olddata', 'newdata'],
                         self._columns('pending_data'))
        self.assertEqual([ok, failed], self._pending_seqids())
        self.assertEqual([(1, ok, 0, ''), (1, failed, 3, 'boom')],
                         [tuple(r) for r in self._all_queue()])
        self.assertEqual([(1, 'Default')], [tuple(r) for r in self._execute(
            "SELECT id, description FROM sir.pending_data_slot")])

    def test_migration_keeps_every_column(self):
        self._use_old_schema(standalone=False)
        self._seed_old_rows()
        before = self._full_old_rows()

        self._migrate()

        self.assertEqual(before, self._full_migrated_rows(1))

    def test_migrated_schema_matches_a_fresh_install(self):
        for standalone in [False, True]:
            with self.subTest(standalone=standalone):
                self._use_old_schema(standalone)
                self._migrate()
                migrated = self._describe_schema()

                self._execute("DROP SCHEMA sir CASCADE")
                names = ['CreateTables.sql', 'CreateFunctions.sql', 'CreateTriggers.sql']
                if standalone:
                    names += ['CreateStandaloneOnlyFunctions.sql',
                              'CreateStandaloneOnlyTriggers.sql']
                for name in names:
                    self._execute_file(os.path.join(base.SIR_SQL_DIR, name))

                self.assertEqual(self._describe_schema(), migrated)

    def test_migrated_schema_mirrors_seqid_shifts(self):
        self._use_old_schema(standalone=False)
        self._migrate()
        self._execute("INSERT INTO sir.pending_data_slot VALUES (2, 'Second')")
        s1, s2 = self._insert_rows(2)

        s3 = self._shift_seqids(s1, s2)

        self.assertEqual([s2, s3], self._pending_seqids())
        self.assertEqual([(1, s2), (1, s3), (2, s2), (2, s3)], self._queue())

    def test_migrated_schema_queues_new_changes(self):
        self._use_old_schema(standalone=False)
        self._migrate()
        self._execute("INSERT INTO sir.pending_data_slot VALUES (2, 'Second')")

        s1, = self._insert_rows(1)

        self.assertEqual([(1, s1), (2, s1)], self._queue())

    def test_migrated_schema_deletes_rows_without_a_queue(self):
        self._use_old_schema(standalone=False)
        ok, failed = self._seed_old_rows()
        self._migrate()

        self._execute("DELETE FROM sir.pending_data_queue WHERE seqid = :s", {"s": ok})

        self.assertEqual([failed], self._pending_seqids())

    def test_migration_keeps_the_standalone_cleanup_trigger(self):
        self._use_old_schema(standalone=True)
        ok, failed = self._seed_old_rows()
        self._migrate()

        self._execute("DELETE FROM sir.pending_data_queue WHERE seqid = :s", {"s": ok})

        self.assertEqual([failed], [r.seqid for r in self._execute(
            "SELECT seqid FROM dbmirror2.pending_data ORDER BY seqid")])

    def test_migration_without_the_standalone_trigger_leaves_dbmirror2_alone(self):
        self._use_old_schema(standalone=False)
        ok, failed = self._seed_old_rows()
        self._migrate()

        self._execute("DELETE FROM sir.pending_data_queue WHERE seqid = :s", {"s": ok})

        self.assertEqual([ok, failed], [r.seqid for r in self._execute(
            "SELECT seqid FROM dbmirror2.pending_data ORDER BY seqid")])

    def test_rollback_restores_the_old_schema(self):
        self._use_old_schema(standalone=False)
        ok, failed = self._seed_old_rows()
        self._migrate()
        self._execute("INSERT INTO sir.pending_data_slot VALUES (2, 'Second')")
        # Slot 1 gave up on `failed` more times than slot 2 did.
        self._execute("""INSERT INTO sir.pending_data_queue
                             (slot, seqid, attempts, failure_reason)
                         VALUES (2, :s, 1, 'less')""", {"s": failed})

        self._rollback()

        self.assertEqual(
            ['seqid', 'xid', 'tablename', 'op', 'olddata', 'newdata',
             'attempts', 'last_attempted', 'failure_reason'],
            self._columns('pending_data'))
        self.assertEqual([], self._columns('pending_data_queue'))
        self.assertEqual([], self._columns('pending_data_slot'))
        self.assertEqual([(ok, 0, ''), (failed, 1, 'less')],
                         [tuple(r) for r in self._old_rows()])

    def test_rollback_keeps_every_column(self):
        self._use_old_schema(standalone=False)
        self._seed_old_rows()
        before = self._full_old_rows()

        self._migrate()
        self._rollback()

        self.assertEqual(before, self._full_old_rows())

    def test_rollback_restores_the_copy_trigger(self):
        self._use_old_schema(standalone=False)
        self._migrate()
        self._rollback()

        s1, = self._insert_rows(1)

        self.assertEqual([(s1, 0, '')], [tuple(r) for r in self._old_rows()])

    def test_rollback_keeps_the_standalone_cleanup_trigger(self):
        self._use_old_schema(standalone=True)
        ok, failed = self._seed_old_rows()
        self._migrate()
        self._rollback()

        self._execute("DELETE FROM sir.pending_data WHERE seqid = :s", {"s": ok})

        self.assertEqual([failed], [r.seqid for r in self._execute(
            "SELECT seqid FROM dbmirror2.pending_data ORDER BY seqid")])

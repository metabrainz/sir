import os
import re
import unittest

import mbdata
from sqlalchemy import text

from sir import config, util

SIR_SQL_DIR = os.path.join(
    os.path.dirname(os.path.realpath(__file__)), '..', 'sql')

DBMIRROR2_SQL_DIR = os.path.join(
    os.path.dirname(os.path.realpath(mbdata.__file__)), 'sql', 'dbmirror2')


def _read_sql(path):
    with open(path, encoding='utf-8') as f:
        sql = f.read()
    return '\n'.join(
        line for line in sql.splitlines()
        if not line.startswith('\\')
        and not re.fullmatch(r'(BEGIN|COMMIT);', line.strip())
    )


class PendingDataTriggersTestCase(unittest.TestCase):
    """
    Tests for the triggers copying ``dbmirror2.pending_data`` into
    ``sir.pending_data``.
    """

    @classmethod
    def setUpClass(cls):
        config.read_config()

    def setUp(self):
        self.connection = util.engine().connect()
        self.addCleanup(self.connection.close)
        self.transaction = self.connection.begin()
        self.addCleanup(self.transaction.rollback)

        if not self._scalar("SELECT to_regclass('dbmirror2.pending_data') IS NOT NULL"):
            self._execute("CREATE SCHEMA dbmirror2")
            self._execute_file(os.path.join(DBMIRROR2_SQL_DIR, 'dbmirror2.sql'))

        self._execute("DROP SCHEMA IF EXISTS sir CASCADE")
        for name in ['CreateTables.sql', 'CreateFunctions.sql', 'CreateTriggers.sql']:
            self._execute_file(os.path.join(SIR_SQL_DIR, name))

    def _execute(self, sql, params=None):
        return self.connection.execute(text(sql), params or {})

    def _execute_file(self, path):
        with self.connection.connection.cursor() as cursor:
            cursor.execute(_read_sql(path))

    def _scalar(self, sql, params=None):
        return self._execute(sql, params).scalar()

    def test_seqid_shifts_are_mirrored(self):
        # `inc_v()` runs before `recordchange()` and updates the row being
        # inserted. The UPDATE's `recordchange()` therefore runs before the
        # INSERT's, which then detects the out-of-order operation and shifts
        # the UPDATE's seqid after its own.
        self._execute("""
            DROP SCHEMA IF EXISTS sir_test CASCADE;
            CREATE SCHEMA sir_test;

            CREATE TABLE sir_test.t (id INTEGER PRIMARY KEY, v INTEGER NOT NULL);

            CREATE FUNCTION sir_test.inc_v() RETURNS trigger AS $$
            BEGIN
                UPDATE sir_test.t SET v = v + 1 WHERE id = NEW.id;
                RETURN NULL;
            END;
            $$ LANGUAGE plpgsql;

            CREATE TRIGGER a_ins_t AFTER INSERT ON sir_test.t
                FOR EACH ROW EXECUTE PROCEDURE sir_test.inc_v();

            CREATE TRIGGER reptg2_t AFTER INSERT OR DELETE OR UPDATE ON sir_test.t
                FOR EACH ROW EXECUTE PROCEDURE dbmirror2.recordchange();
        """)

        self._execute("INSERT INTO sir_test.t VALUES (1, 0)")

        query = """SELECT seqid, op, CAST(olddata AS TEXT), CAST(newdata AS TEXT)
                   FROM {}
                   WHERE xid = txid_current()
                   ORDER BY seqid"""
        dbmirror2_rows = self._execute(query.format('dbmirror2.pending_data')).fetchall()
        sir_rows = self._execute(query.format('sir.pending_data')).fetchall()

        self.assertEqual(['i', 'u'], [row.op for row in dbmirror2_rows])
        self.assertEqual(dbmirror2_rows, sir_rows)

    def _insert_dbmirror2_rows(self, count):
        return [
            self._scalar("""INSERT INTO dbmirror2.pending_data (tablename, op, xid, newdata)
                            VALUES ('sir.control', 'i', txid_current(), '{}')
                            RETURNING seqid""")
            for _ in range(count)
        ]

    def _queue(self):
        return self._execute("""SELECT slot, seqid
                                FROM sir.pending_data_queue
                                ORDER BY slot, seqid""").fetchall()

    def _pending_seqids(self):
        return [row.seqid for row in self._execute(
            "SELECT seqid FROM sir.pending_data ORDER BY seqid")]

    def test_rows_are_queued_for_every_slot(self):
        self._execute("INSERT INTO sir.pending_data_slot VALUES (2, 'Second')")
        s1, s2 = self._insert_dbmirror2_rows(2)

        self.assertEqual([s1, s2], self._pending_seqids())
        self.assertEqual([(1, s1), (1, s2), (2, s1), (2, s2)], self._queue())

    def test_nothing_is_copied_without_slots(self):
        self._execute("DELETE FROM sir.pending_data_slot")
        self._insert_dbmirror2_rows(1)

        self.assertEqual([], self._pending_seqids())
        self.assertEqual([], self._queue())

    def test_seqid_shifts_update_the_queue(self):
        self._execute("INSERT INTO sir.pending_data_slot VALUES (2, 'Second')")
        s1, s2 = self._insert_dbmirror2_rows(2)
        s3 = self._scalar("SELECT nextval('dbmirror2.pending_data_seqid_seq')")

        # Shift the same way `recordchange()` does. Start from the highest
        # seqid, and shift each one into the seqid freed by the last shift.
        self._execute("UPDATE dbmirror2.pending_data SET seqid = :new WHERE seqid = :old",
                      {"new": s3, "old": s2})
        self._execute("UPDATE dbmirror2.pending_data SET seqid = :new WHERE seqid = :old",
                      {"new": s2, "old": s1})

        self.assertEqual([s2, s3], self._pending_seqids())
        self.assertEqual([(1, s2), (1, s3), (2, s2), (2, s3)], self._queue())

    def test_rows_are_deleted_once_every_slot_has_processed_them(self):
        self._execute("INSERT INTO sir.pending_data_slot VALUES (2, 'Second')")
        s1, s2 = self._insert_dbmirror2_rows(2)

        self._execute("DELETE FROM sir.pending_data_queue WHERE slot = 1")
        self.assertEqual([s1, s2], self._pending_seqids())

        self._execute("DELETE FROM sir.pending_data_queue WHERE slot = 2 AND seqid = :s",
                      {"s": s1})
        self.assertEqual([s2], self._pending_seqids())

    def test_dropping_a_slot_deletes_rows_only_it_needed(self):
        self._execute("INSERT INTO sir.pending_data_slot VALUES (2, 'Second')")
        s1, s2 = self._insert_dbmirror2_rows(2)
        self._execute("DELETE FROM sir.pending_data_queue WHERE slot = 1 AND seqid = :s",
                      {"s": s1})

        self._execute("DELETE FROM sir.pending_data_slot WHERE id = 2")

        self.assertEqual([s2], self._pending_seqids())
        self.assertEqual([(1, s2)], self._queue())

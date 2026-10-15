#!/usr/bin/env python
# Copyright (c) 2014, 2015, 2017 Wieland Hoffmann, MetaBrainz Foundation
# License: MIT, see LICENSE for details
import os
import signal
import time

from sir.pending_data.message import Message, _normalize_table_name
from sir import config
from sir.schema import SCHEMA, generate_update_map
from sir.indexing import live_index, PROCESS_FLAG
from sir.query_generation.paths import second_last_model_in_path, generate_query, generate_filtered_query
from sir.util import (db_session,
                      db_session_ctx,
                      solr_connection,
                      solr_version_check,
                      SIR_EXIT)
from logging import getLogger
from sqlalchemy.orm import class_mapper
from sqlalchemy import text
from sys import exit
from urllib.error import URLError
from configparser import NoOptionError, NoSectionError
from collections import defaultdict
from traceback import format_exc

__all__ = ["watch", "Handler", "delete_consumed_pending_data"]

logger = getLogger("sir")

update_map, column_map, model_map, core_map = generate_update_map()

#: The number of times we'll try to process a pending row before giving up.
_DEFAULT_MAX_RETRIES = 4

#: Default interval in seconds between polls of sir.pending_data.
_DEFAULT_POLL_INTERVAL = 5

# Tables which are core entities, but do not have a guid.
# These will be deleted via their `id`.
_ID_DELETE_TABLE_NAMES = ['annotation', 'tag', 'release_raw', 'editor']

# Set of normalized table names that we care about (present in update_map).
_KNOWN_TABLES = set(update_map.keys())


def delete_consumed_pending_data(session):
    """
    Delete sir.pending_data rows which all slots have moved past and
    which have no outstanding failures in any slot.
    """
    session.execute(
        text("""DELETE FROM sir.pending_data pd
                WHERE pd.seqid <= (SELECT min(seqid)
                                     FROM sir.pending_data_slot)
                  AND NOT EXISTS (SELECT 1
                                    FROM sir.pending_data_failure pdf
                                   WHERE pdf.seqid = pd.seqid)""")
    )


class INDEX_LIMIT_EXCEEDED(Exception):

    def __init__(self, core_name, total_ids, extra_data=None):
        exception_message = 'Index limit exceeded.'
        exception_message += ' Entity: {}, Total Rows: {}, Extra Data: {}'.format(core_name,
                                                                                  total_ids,
                                                                                  str(extra_data))
        Exception.__init__(self, exception_message)


class Handler(object):
    """
    Polls ``sir.pending_data`` for database changes and updates
    Solr cores accordingly.
    """

    def __init__(self, entities, slot):
        self.cores = {}
        for core_name in entities:
            self.cores[core_name] = solr_connection(core_name)
            solr_version_check(core_name)

        # Used to define the batch size of the pending rows to fetch
        try:
            self.batch_size = config.CFG.getint("sir", "live_index_batch_size")
        except (NoOptionError, AttributeError):
            self.batch_size = 500

        # Used to limit the number of queried rows from PGSQL. Anything above this limit
        # raises a INDEX_LIMIT_EXCEEDED error
        try:
            self.index_limit = config.CFG.getint("sir", "index_limit")
        except (NoOptionError, AttributeError):
            self.index_limit = 40000

        try:
            self.poll_interval = config.CFG.getint("sir", "poll_interval")
        except (NoOptionError, AttributeError):
            self.poll_interval = _DEFAULT_POLL_INTERVAL

        try:
            self.max_retries = config.CFG.getint("sir", "max_retries")
        except (NoOptionError, AttributeError):
            self.max_retries = _DEFAULT_MAX_RETRIES

        self.slot = slot

        logger.info("Pending data slot is set to %s", self.slot)
        logger.info("Batch size is set to %s", self.batch_size)
        logger.info("Index limit is set to %s rows", self.index_limit)
        logger.info("Poll interval is set to %s seconds", self.poll_interval)
        logger.info("Max retries is set to %s", self.max_retries)

        self.db_session = db_session()
        self.pending_entities = defaultdict(set)
        self.pending_seqids = []
        # The highest seqid fetched by the last poll; the slot is advanced
        # to this once the batch has been processed (or marked failed).
        self.max_seqid = None
        # All rows with a seqid <= safe_seqid have committed
        # (see _update_safe_seqid).
        self.safe_seqid = 0
        # The next value for safe_seqid, and the snapshot whose in-progress
        # transactions must finish before it can be used.
        self.candidate_safe_seqid = None
        self.candidate_snapshot = None
        self.last_message = time.time()

    def index_callback(self, parsed_message):
        """
        Process an index (insert/update) message, or a delete on a non-core table.

        In this handler we are doing a selection with joins which follow a "path"
        from a table that the change was recorded for to an entity (later
        "core", https://wiki.apache.org/solr/SolrTerminology). To know which
        data to retrieve we are using PK(s) of a table that was updated.
        ``update_map`` provides us with a view of dependencies between entities
        (cores) and all the tables. So if data in some table has been updated,
        we know which entities store this data in the index and need to be
        refreshed.

        :param sir.pending_data.message.Message parsed_message: Parsed pending_data row.
        """
        logger.debug("Processing `index` message from table: %s" % parsed_message.table_name)
        logger.debug("Message columns %s" % parsed_message.columns)
        if parsed_message.operation == 'delete':
            self._index_by_fk(parsed_message)
        else:
            self._index_by_pk(parsed_message)

    def delete_callback(self, parsed_message):
        """
        Process a delete message for a core entity table.

        This callback function is expected to receive messages only from
        entity tables all of which have a ``gid`` column on them except the ones
        in ``_ID_DELETE_TABLE_NAMES`` which are deleted via their ``id``.

        :param sir.pending_data.message.Message parsed_message: Parsed pending_data row.
        """
        table_name = parsed_message.table_name

        if "gid" in parsed_message.columns:
            doc_id = parsed_message.columns["gid"]
        elif "id" in parsed_message.columns and table_name in _ID_DELETE_TABLE_NAMES:
            doc_id = str(parsed_message.columns["id"])
        else:
            raise ValueError("`gid` column missing from delete message")

        logger.debug(f"Deleting {table_name}: {doc_id}")

        core_name = core_map[table_name]
        if core_name in self.cores:
            self.cores[core_name].delete(doc_id)
        self._index_by_fk(parsed_message)

    def process_messages(self):
        """
        Send all pending entities to Solr via live_index, then advance
        this handler's slot past the fetched rows.
        """
        try:
            if self.pending_seqids:
                live_index(self.pending_entities)
                if not PROCESS_FLAG.value:
                    # It might happen that the DB pool workers have
                    # all processed the queries and exited, while Solr process
                    # is still sending data to Solr. In this case no SIR_EXIT is
                    # raised by live_index. Thus we need to raise it to handle the
                    # pending rows properly.
                    raise SIR_EXIT
        except SIR_EXIT:
            logger.info('Processing terminated midway. Rows will be retried later.')
            self._mark_failed(self.pending_seqids, Exception('SIR terminated while processing.'))
        except Exception as exc:
            logger.error("Error encountered while processing messages: %s", exc)
            self._mark_failed(self.pending_seqids, exc)
        else:
            logger.info('Successfully processed %s pending rows', len(self.pending_seqids))
            self._mark_processed(self.pending_seqids)
        finally:
            self.pending_seqids = []
            self.max_seqid = None
            self.pending_entities.clear()
            self.last_message = time.time()

    def _mark_processed(self, seqids):
        """
        Clear any failures recorded by this slot for the successfully
        processed rows, then advance the slot.
        """
        with db_session_ctx(self.db_session) as session:
            session.execute(
                text("""DELETE FROM sir.pending_data_failure
                        WHERE slot = :slot
                          AND seqid = ANY(CAST(:seqids AS BIGINT[]))"""),
                {"slot": self.slot, "seqids": seqids}
            )
            self._advance_slot(session)

    def _mark_failed(self, seqids, exc):
        """
        Increment attempts and record failure_reason for the given rows
        in this slot, then advance the slot. Failed rows are retried via
        sir.pending_data_failure rather than the slot position.
        """
        with db_session_ctx(self.db_session) as session:
            self._record_failure(session, seqids, exc)
            self._advance_slot(session)

    def _mark_row_failed(self, seqid, exc):
        """Mark a single pending_data row as failed for this slot."""
        with db_session_ctx(self.db_session) as session:
            self._record_failure(session, [seqid], exc)

    def _record_failure(self, session, seqids, exc):
        if not seqids:
            return
        reason = str(exc)[:500]
        session.execute(
            text("""INSERT INTO sir.pending_data_failure
                        (slot, seqid, attempts, last_attempted, failure_reason)
                    SELECT :slot, s.seqid, 1, NOW(), :reason
                      FROM unnest(CAST(:seqids AS BIGINT[])) AS s (seqid)
                    ON CONFLICT (slot, seqid) DO UPDATE
                    SET attempts = sir.pending_data_failure.attempts + 1,
                        last_attempted = excluded.last_attempted,
                        failure_reason = excluded.failure_reason"""),
            {"slot": self.slot, "seqids": seqids, "reason": reason}
        )

    def _advance_slot(self, session):
        """
        Move this slot's position up to the highest fetched seqid, and
        delete sir.pending_data rows which are no longer needed.
        """
        if self.max_seqid is None:
            return
        session.execute(
            text("""UPDATE sir.pending_data_slot
                    SET seqid = GREATEST(seqid, :seqid)
                    WHERE id = :slot"""),
            {"slot": self.slot, "seqid": self.max_seqid}
        )
        delete_consumed_pending_data(session)

    def check_slot(self):
        """
        Ensure this handler's slot exists in sir.pending_data_slot.
        """
        with db_session_ctx(self.db_session) as session:
            row = session.execute(
                text("""SELECT seqid, description
                        FROM sir.pending_data_slot
                        WHERE id = :slot"""),
                {"slot": self.slot}
            ).fetchone()
        if row is None:
            raise ValueError(
                "Pending data slot %s does not exist; create it with "
                "`python -m sir create_slot`" % self.slot)
        logger.info("Using pending data slot %s (%s) at seqid %s",
                    self.slot, row.description, row.seqid)

    def _update_safe_seqid(self):
        """
        Advance ``safe_seqid``, the highest seqid this slot may consume.

        seqids are assigned on insert, not commit, so rows can appear out of
        order: if a poll sees seqid 11 while seqid 10 is uncommitted, moving
        the slot to 11 would skip 10.

        So we read the max seqid with the current snapshot, and only accept
        it once every transaction running in that snapshot has finished.
        Any uncommitted lower seqid belongs to one of them (assuming the
        seqid sequence has ``CACHE 1``, which is the default:
        https://www.postgresql.org/docs/current/sql-createsequence.html).
        """
        with db_session_ctx(self.db_session) as session:
            if self.candidate_safe_seqid is None:
                row = session.execute(
                    text("""SELECT max(seqid) AS seqid,
                                   CAST(pg_current_snapshot() AS TEXT) AS snapshot
                            FROM sir.pending_data""")
                ).fetchone()
                if row.seqid is None or row.seqid <= self.safe_seqid:
                    return
                self.candidate_safe_seqid = row.seqid
                self.candidate_snapshot = row.snapshot

            finished = session.execute(
                text("""SELECT NOT EXISTS (
                            SELECT 1
                            FROM pg_snapshot_xip(CAST(:snapshot AS pg_snapshot)) AS x
                            WHERE pg_xact_status(x) = 'in progress'
                        )"""),
                {"snapshot": self.candidate_snapshot}
            ).scalar()

        if finished:
            self.safe_seqid = self.candidate_safe_seqid
            self.candidate_safe_seqid = None
            self.candidate_snapshot = None
        else:
            logger.debug("Waiting on in-progress transactions before "
                         "consuming rows up to seqid %s", self.candidate_safe_seqid)

    def poll(self):
        """
        Fetch pending rows from sir.pending_data and process them.

        Fetches rows past this slot's position which haven't already
        failed in this slot, along with previously-failed rows which are
        due for a retry.

        :rtype: int  Number of rows fetched.
        """
        # This must run in a separate transaction from (and before) the
        # query below, so that rows committed by the transactions it waited
        # on are visible to it.
        self._update_safe_seqid()

        with db_session_ctx(self.db_session) as session:
            result = session.execute(
                text("""SELECT pd.seqid, pd.xid, pd.tablename, pd.op, pd.olddata, pd.newdata
                        FROM sir.pending_data pd
                        LEFT JOIN sir.pending_data_failure pdf
                          ON pdf.slot = :slot AND pdf.seqid = pd.seqid
                        WHERE COALESCE((SELECT indexing_enabled
                                        FROM sir.control), FALSE)
                          AND CASE WHEN pdf.seqid IS NULL
                                   THEN pd.seqid > (SELECT seqid
                                                    FROM sir.pending_data_slot
                                                    WHERE id = :slot)
                                        AND pd.seqid <= :safe_seqid
                                   ELSE pdf.attempts < :max_retries
                                        AND pdf.last_attempted <= (NOW() - (interval '5 minutes' * pdf.attempts))
                              END
                        ORDER BY pd.seqid
                        LIMIT :limit"""),
                {"slot": self.slot,
                 "safe_seqid": self.safe_seqid,
                 "max_retries": self.max_retries,
                 "limit": self.batch_size}
            )
            rows = result.fetchall()

        if not rows:
            return 0

        self.max_seqid = max(row.seqid for row in rows)

        for row in rows:
            table_name = _normalize_table_name(row.tablename)
            if table_name not in _KNOWN_TABLES:
                # Table not relevant to search indexing — mark for deletion
                logger.debug("Skipping irrelevant table: %s (seqid=%s)", table_name, row.seqid)
                self.pending_seqids.append(row.seqid)
                continue

            try:
                parsed = Message.from_pending_row(row)
            except Exception as exc:
                logger.error("Failed to parse pending row seqid=%s: %s", row.seqid, exc)
                self._mark_row_failed(row.seqid, exc)
                continue

            if parsed.changed_columns is not None:
                watched = column_map.get(table_name)
                if watched and not (parsed.changed_columns & watched):
                    logger.debug(
                        "Skipping update to %s (seqid=%s): changed columns %s "
                        "not in watched columns %s",
                        table_name, row.seqid, parsed.changed_columns, watched
                    )
                    self.pending_seqids.append(row.seqid)
                    continue

            try:
                is_core_entity_delete = (
                    parsed.operation == 'delete'
                    and parsed.table_name in core_map
                )
                if is_core_entity_delete:
                    self.delete_callback(parsed)
                else:
                    self.index_callback(parsed)
                self.pending_seqids.append(row.seqid)
            except INDEX_LIMIT_EXCEEDED as exc:
                logger.warning(exc)
                self._mark_row_failed(row.seqid, exc)
            except Exception as exc:
                logger.error("Error processing row seqid=%s: %s", row.seqid, exc, exc_info=True)
                self._mark_row_failed(row.seqid, exc)

        return len(rows)

    def _index_data(self, core_name, id_list, extra_data=None):
        total_ids = len(id_list)
        if total_ids > self.index_limit:
            raise INDEX_LIMIT_EXCEEDED(core_name, total_ids, extra_data)
        logger.debug("Queueing %s new rows for entity %s", total_ids, core_name)
        self.pending_entities[core_name].update(set(id_list))

    def _index_by_pk(self, parsed_message):
        for core_name, path in update_map[parsed_message.table_name]:

            if not core_name in self.cores:
                continue

            # Going through each core/entity that needs to be updated
            # depending on which table we receive a message from.
            entity = SCHEMA[core_name]
            with db_session_ctx(self.db_session) as session:
                select_query = None
                if path is None:
                    # If `path` is `None` then we received a message for an entity itself
                    ids = [parsed_message.columns["id"]]
                else:
                    # otherwise it's a different table...
                    logger.debug("Generating SELECT statement for %s with path '%s'" % (entity.model, path))
                    select_query = generate_filtered_query(entity.model, path, parsed_message.columns)
                    if select_query is None:
                        logger.warning("SELECT is `None`")
                        continue
                    else:
                        logger.debug("SQL: %s" % select_query)
                        ids = [row[0] for row in session.execute(select_query).fetchall()]

                # Retrieving actual data
                extra_data = {'table_name': parsed_message.table_name,
                              'path': path,
                              'select_query': str(select_query),
                              }
                self._index_data(core_name, ids, extra_data)

    def _index_by_fk(self, parsed_message):
        index_model = model_map[parsed_message.table_name]
        # We need to construct this since we only need to update tables which
        # have 'many to one' relationship with the table represented by `index_model`,
        # since index_by_fk is only called when an entity is deleted and we need
        # to update the related entities. For 'one to many' relationships, the related
        # entity would have had an update trigger firing off to unlink the `index_entity`
        # before `index_entity` itself is deleted, so we can ignore those.
        relevant_rels = dict((r.mapper.persist_selectable.name, (list(r.local_columns)[0].name, list(r.remote_side)[0]))
                             for r in class_mapper(index_model).mapper.relationships
                             if r.direction.name == 'MANYTOONE')
        for core_name, path in update_map[parsed_message.table_name]:

            if not core_name in self.cores:
                continue

            # Going through each core/entity that needs to be updated
            # depending on original index model
            entity = SCHEMA[core_name]
            # We are finding the second last model in path, since the rows related to
            # `index_model` are deleted and the sql query generated from that path
            # returns no ids, because of the way select query is generated.
            # We generate sql queries with the second last model in path, since that
            # will be related to the `index_model` by a FK and we can thus determine
            # the tables to be updated from the FK values emitted by the delete triggers
            related_model, new_path = second_last_model_in_path(entity.model, path)
            related_table_name = ""
            if related_model:
                related_table_name = class_mapper(related_model).persist_selectable.name
            if related_table_name in relevant_rels:
                with db_session_ctx(self.db_session) as session:
                    select_query = None
                    if new_path is None:
                        # If `path` is `None` then we received a message for an entity itself
                        ids = [parsed_message.columns['id']]
                    else:
                        logger.debug("Generating SELECT statement for %s with path '%s'" % (entity.model, new_path))
                        fk_name, remote_key = relevant_rels[related_table_name]
                        filter_expression = remote_key.__eq__(parsed_message.columns[fk_name])
                        # If `new_path` is blank, then the given table, was directly related to the
                        # `index_model` by a FK.
                        select_query = generate_query(entity.model, new_path, filter_expression)
                        if select_query is None:
                            logger.warning("SELECT is `None`")
                            continue
                        ids = [row[0] for row in session.execute(select_query).fetchall()]
                        logger.debug("SQL: %s" % (select_query))

                    # Retrieving actual data
                    extra_data = {'table_name': parsed_message.table_name,
                                  'path': path,
                                  'related_table_name': related_table_name,
                                  'new_path': new_path,
                                  'select_query': str(select_query),
                                  }
                    self._index_data(core_name, ids, extra_data)


def _watch_impl(entities, slot):

    handler = Handler(entities, slot)
    handler.check_slot()

    def signal_handler(signum, frame, pid=os.getpid()):

        # Doing this makes sure that only the main process is changing the PROCESS_FLAG.
        # Otherwise, SIR would set the PROCESS_FLAG to False, even when a PoolWorker is
        # terminated.
        if pid == os.getpid():
            # Simply set the `PROCESS_FLAG` to false to stop processing any and
            # all queries.
            PROCESS_FLAG.value = False

    signal.signal(signal.SIGTERM, signal_handler)
    signal.signal(signal.SIGINT, signal_handler)

    logger.info("Starting polling loop (interval=%ss)", handler.poll_interval)
    while PROCESS_FLAG.value:
        try:
            num_rows = handler.poll()
            if num_rows > 0:
                handler.process_messages()
            else:
                time.sleep(handler.poll_interval)
        except SIR_EXIT:
            break
        except Exception:
            logger.error("Error in poll loop: %s", format_exc())
            time.sleep(handler.poll_interval)

    logger.info('Terminating SIR')


def watch(args):
    """
    Poll sir.pending_data for database changes.

    :param [str] entity_type: Entity types to watch.
    """
    try:
        slot = config.CFG.getint("sir", "pending_data_slot")
    except (NoOptionError, NoSectionError):
        logger.error("`pending_data_slot` must be set in the [sir] section of config.ini")
        exit(1)
    try:
        entities = args["entity_type"] or SCHEMA.keys()
        _watch_impl(entities, slot)
    except URLError as e:
        logger.error("Connecting to Solr failed: %s", e)
        exit(1)

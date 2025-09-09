#!/usr/bin/env python
# Copyright (c) 2014, 2015, 2017 Wieland Hoffmann, MetaBrainz Foundation
# License: MIT, see LICENSE for details
import os
import signal
import time

from sir.amqp.message import Message, _normalize_table_name
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
from configparser import NoOptionError
from collections import defaultdict
from traceback import format_exc

__all__ = ["watch", "Handler"]

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

    def __init__(self, entities):
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

        logger.info("Batch size is set to %s", self.batch_size)
        logger.info("Index limit is set to %s rows", self.index_limit)
        logger.info("Poll interval is set to %s seconds", self.poll_interval)
        logger.info("Max retries is set to %s", self.max_retries)

        self.db_session = db_session()
        self.pending_entities = defaultdict(set)
        self.pending_seqids = []
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

        :param sir.amqp.message.Message parsed_message: Parsed pending_data row.
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

        :param sir.amqp.message.Message parsed_message: Parsed pending_data row.
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
        Send all pending entities to Solr via live_index, then delete
        the successfully processed rows from sir.pending_data.
        """
        if not self.pending_seqids:
            return

        try:
            live_index(self.pending_entities)
            if not PROCESS_FLAG.value:
                # It might happen that the DB pool workers have
                # all processed the queries and exited, while Solr process
                # is still sending data to Solr. In this case no SIR_EXIT is
                # raised by live_index. Thus we need to raise it to handle the
                # pending rows properly.
                raise SIR_EXIT
        except SIR_EXIT:
            logger.info('Processing terminated midway. Rows will be retried on next poll.')
            self._mark_failed(Exception('SIR terminated while processing.'))
        except Exception as exc:
            logger.error("Error encountered while processing messages: %s", exc)
            self._mark_failed(exc)
        else:
            logger.info('Successfully processed %s pending rows', len(self.pending_seqids))
            self._delete_processed()
        finally:
            self.pending_seqids = []
            self.pending_entities.clear()
            self.last_message = time.time()

    def _delete_processed(self):
        """Delete successfully processed rows from sir.pending_data."""
        with db_session_ctx(self.db_session) as session:
            session.execute(
                text("DELETE FROM sir.pending_data WHERE seqid = ANY(:seqids)"),
                {"seqids": self.pending_seqids}
            )

    def _mark_failed(self, exc):
        """Increment attempts and record failure_reason for pending rows."""
        reason = str(exc)[:500]
        with db_session_ctx(self.db_session) as session:
            session.execute(
                text("""UPDATE sir.pending_data
                        SET attempts = attempts + 1,
                            last_attempted = NOW(),
                            failure_reason = :reason
                        WHERE seqid = ANY(:seqids)"""),
                {"seqids": self.pending_seqids, "reason": reason}
            )

    def _mark_row_failed(self, seqid, exc):
        """Mark a single pending_data row as failed by incrementing its attempt count."""
        reason = str(exc)[:500]
        with db_session_ctx(self.db_session) as session:
            session.execute(
                text("""UPDATE sir.pending_data
                        SET attempts = attempts + 1,
                            last_attempted = NOW(),
                            failure_reason = :reason
                        WHERE seqid = :seqid"""),
                {"reason": reason, "seqid": seqid}
            )

    def poll(self):
        """
        Fetch pending rows from sir.pending_data and process them.

        :rtype: int  Number of rows fetched.
        """
        with db_session_ctx(self.db_session) as session:
            result = session.execute(
                text("""SELECT seqid, xid, tablename, op, olddata, newdata
                        FROM sir.pending_data
                        WHERE COALESCE((SELECT indexing_enabled
                                        FROM sir.control), FALSE)
                          AND attempts < :max_retries
                        ORDER BY seqid
                        LIMIT :limit"""),
                {"max_retries": self.max_retries, "limit": self.batch_size}
            )
            rows = result.fetchall()

        if not rows:
            return 0

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


def _watch_impl(entities):

    handler = Handler(entities)

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
        entities = args["entity_type"] or SCHEMA.keys()
        _watch_impl(entities)
    except URLError as e:
        logger.error("Connecting to Solr failed: %s", e)
        exit(1)

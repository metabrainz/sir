#!/usr/bin/env python
# coding: utf-8
# Copyright (c) 2014, 2015, 2017 Wieland Hoffmann, MetaBrainz Foundation
# License: MIT, see LICENSE for details
import errno
import os
import signal

import sentry_sdk

import sir.indexing as indexing
import time

from sir.amqp import message
from sir import config
from sir.schema import SCHEMA, generate_update_map
from sir.indexing import live_index
from sir.trigger_generation.paths import second_last_model_in_path, generate_query, generate_filtered_query
from sir.util import (create_amqp_connection,
                      db_session,
                      db_session_ctx,
                      solr_connection,
                      solr_version_check,
                      SIR_EXIT)
from amqp.exceptions import AMQPError
from functools import partial, wraps
from logging import getLogger
from retrying import retry
from socket import error as socket_error
from sqlalchemy.orm import class_mapper
from sys import exit
from urllib.error import URLError
from configparser import NoOptionError
from collections import defaultdict
from traceback import format_exc, format_exception

__all__ = ["callback_wrapper", "watch", "Handler"]

logger = getLogger("sir")

update_map, column_map, model_map, core_map = generate_update_map()

#: The number of times we'll try to process a message.
_DEFAULT_MB_RETRIES = 4

#: The number of seconds between each connection attempt to the AMQP server.
_RETRY_WAIT_SECS = 30

# Tables which are core entities, but do not have a guid.
# These will be deleted via their `id`.
_ID_DELETE_TABLE_NAMES = ['annotation', 'tag', 'release_raw', 'editor']


class INDEX_LIMIT_EXCEEDED(Exception):

    def __init__(self, core_name, total_ids, extra_data=None):
        exception_message = 'Index limit exceeded.'
        exception_message += ' Entity: {}, Total Rows: {}, Extra Data: {}'.format(core_name,
                                                                                  total_ids,
                                                                                  str(extra_data))
        Exception.__init__(self, exception_message)


def action_wrapper(f):
    """
    Common wrapper for a message action functions like `ack`, `reject` and `requeue`
    that provides exception handling and makes sure that the AMQP connection is
    connected before any interaction with the RabbitMQ.
    The following wrapper function is returned:

    .. py:function:: wrapper(self, msg, *args, **kwargs)

        :param sir.amqp.handler.Handler self: Handler object that is processing a message.
        :param amqp.basic_message.Message msg: Message itself.

        Calls ``f`` with ``self`` and an instance of :class:`~sir.amqp.message.Message`.
        If an exception gets raised by ``f``, it will be caught and logged.
    """
    @wraps(f)
    def wrapper(self, msg, *args, **kwargs):
        self.connect_to_rabbitmq()
        try:
            logger.debug('Performing %s on %s', f.__name__, vars(msg))
            return f(self, msg, *args, **kwargs)
        except Exception:
            logger.error('Unable to perform action %s on message %s. Exception encountered: %s',
                         f.__name__, vars(msg), format_exc())

    return wrapper


def callback_wrapper(f):
    """
    Common wrapper for a message callback function that provides basic sanity
    checking for messages and provides exception handling for a function it wraps.

    The following wrapper function is returned:

    .. py:function:: wrapper(self, msg, queue)

        :param sir.amqp.handler.Handler self: Handler object that is processing a message.
        :param amqp.basic_message.Message msg: Message itself.
        :param str queue: Name of the queue that the message has originated from.

        Calls ``f`` with ``self`` and an instance of :class:`~sir.amqp.message.Message`.
        If an exception gets raised by ``f``, it will be caught and the message will be
        :meth:`rejected <amqp:amqp.channel.Channel.basic_reject>` and sent to the
        ``search.failed`` queue (cf. :ref:`queue_setup`). Then the exception will not be
        reraised.

        If no exception is raised, the message will be :meth:`acknowledged
        <amqp:amqp.channel.Channel.basic_ack>`.

    """
    @wraps(f)
    def wrapper(self, msg, queue):
        try:
            logger.debug("Received message from queue %s: %s" % (queue, msg.body))
            parsed_message = message.Message.from_amqp_message(queue, msg)
            if parsed_message.table_name not in update_map:
                raise ValueError("Unknown table: %s" % parsed_message.table_name)
            f(self=self, parsed_message=parsed_message)
            self.pending_messages.append(msg)
        except INDEX_LIMIT_EXCEEDED as exc:
            logger.warning(exc)
            self.reject_message(msg)
            self.requeue_message(msg, exc, fail=True)
        except Exception as exc:
            logger.error(exc, extra={"data": {"message": vars(msg)}}, exc_info=True)
            self.reject_message(msg)
            self.requeue_message(msg, exc)
        else:
            self.ack_message(msg)

    return wrapper


class Handler(object):
    """
    This class is used to provide callbacks for AMQP messages and access to
    Solr cores.
    """

    def __init__(self, entities):
        self.cores = {}
        for core_name in entities:
            self.cores[core_name] = solr_connection(core_name)
            solr_version_check(core_name)

        # Used to define the batch size of the pending messages list
        try:
            self.batch_size = config.CFG.getint("sir", "live_index_batch_size")
        except (NoOptionError, AttributeError):
            self.batch_size = 1
        # Defines how long the handler should wait before processing messages.
        # Used to trigger the process_message callback to prevent starvation
        # in pending_messages in case it doesn't fill up to batch_size
        try:
            self.process_delay = config.CFG.getint("sir", "process_delay")
        except (NoOptionError, AttributeError):
            self.process_delay = 120
        # Used to limit the number of queried rows from PGSQL. Anything above this limit
        # raises a INDEX_LIMIT_EXCEEDED error
        try:
            self.index_limit = config.CFG.getint("sir", "index_limit")
        except (NoOptionError, AttributeError):
            self.index_limit = 40000

        logger.info("Batch size is set to %s", self.batch_size)
        logger.info("Process delay is set to %s seconds", self.process_delay)
        logger.info("Index limit is set to %s rows", self.index_limit)

        self.db_session = db_session()
        self.pending_messages = []
        self.pending_entities = defaultdict(set)
        self.processing = False
        self.channel = None
        self.connection = None
        self.last_message = time.time()

    def connect_to_rabbitmq(self, reconnect=False):

        def add_handler(queue, f, channel):
            logger.debug("Adding a callback to %s", queue)
            handler = partial(f, queue=queue)
            channel.basic_consume(queue, callback=handler)

        if self.connection and self.connection.connected and (not reconnect):
            return

        if reconnect:
            if self.channel is not None:
                self.channel.close()
            if self.connection is not None:
                self.connection.close()

        conn = create_amqp_connection()
        self.connection = conn
        logger.debug("Heartbeat value: %s" % conn.heartbeat)
        ch = conn.channel()
        self.channel = ch
        # Keep in mind that `prefetch_size` is not supported by the version of RabbitMQ that
        # we are currently using (https://www.rabbitmq.com/specification.html).
        # Limits are requires because consumer connection might time out when receive buffer
        # is full (http://stackoverflow.com/q/35438843/272770).
        prefetch_count = config.CFG.getint("rabbitmq", "prefetch_count")
        ch.basic_qos(prefetch_size=0, prefetch_count=prefetch_count, a_global=True)

        add_handler("search.index", self.index_callback, ch)
        add_handler("search.delete", self.delete_callback, ch)

    @action_wrapper
    def requeue_message(self, msg, exc, fail=False):
        if not hasattr(msg, "application_headers"):
            msg.properties['application_headers'] = {}
        retries_remaining = msg.application_headers.get("mb-retries", _DEFAULT_MB_RETRIES)
        routing_key = msg.delivery_info["routing_key"]
        msg.application_headers["mb-exception"] = format_exception(exc)
        if retries_remaining and not fail:
            msg.application_headers["mb-retries"] = retries_remaining - 1
            self.channel.basic_publish(msg, exchange="search.retry", routing_key=routing_key)
        else:
            self.channel.basic_publish(msg, exchange="search.failed", routing_key=routing_key)

    @action_wrapper
    def ack_message(self, msg):
        self.channel.basic_ack(msg.delivery_tag)

    @action_wrapper
    def reject_message(self, msg, requeue=False):
        self.channel.basic_reject(msg.delivery_tag, requeue=requeue)

    @callback_wrapper
    def index_callback(self, parsed_message):
        """
        Callback for processing `index` messages.

        Messages for indexing have the following format:

            <table name>, keys{<column name>, <value>}

        First value is a table name, followed by primary key values for that
        table. These are then used to lookup values that need to be updated.
        For example:

            {"_table": "artist_credit_name", "position": 0, "artist_credit": 1}

        In this handler we are doing a selection with joins which follow a "path"
        from a table that the trigger was received from to an entity (later
        "core", https://wiki.apache.org/solr/SolrTerminology). To know which
        data to retrieve we are using PK(s) of a table that was updated.
        `update_map` provides us with a view of dependencies between entities
        (cores) and all the tables. So if data in some table has been updated,
        we know which entities store this data in the index and need to be
        refreshed.

        :param sir.amqp.message.Message parsed_message: Message parsed by the `callback_wrapper`.
        """
        logger.debug("Processing `index` message from table: %s" % parsed_message.table_name)
        logger.debug("Message columns %s" % parsed_message.columns)
        if parsed_message.operation == 'delete':
            self._index_by_fk(parsed_message)
        else:
            self._index_by_pk(parsed_message)

    @callback_wrapper
    def delete_callback(self, parsed_message):
        """
        Callback for processing `delete` messages.

        Messages for deletion have the following format:

            <table name>, <id or gid>

        First value is a table name for an entity that has been deleted.
        Second is GID or ID of the row in that table. For example:

            {"_table": "release", "gid": "90d7709d-feba-47e6-a2d1-8770da3c3d9c"}

        This callback function is expected to receive messages only from
        entity tables all of which have a `gid` column on them except the ones
        in `_ID_DELETE_TABLE_NAMES` which are deleted via their `id`.

        :param sir.amqp.message.Message parsed_message: Message parsed by the `callback_wrapper`.
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
        if not self.pending_messages:
            return
        try:
            live_index(self.pending_entities)
            if not indexing.PROCESS_FLAG.value:
                # It might happen that the DB pool workers have
                # all processed the queries and exited, while Solr process
                # is still sending data to Solr. In this case no SIR_EXIT is
                # raised by live_index. Thus we need to raise it to requeue the
                # messages properly.
                raise SIR_EXIT
        except SIR_EXIT:
            logger.info('Processing terminated midway. Please wait, requeuing pending messages...')
            for msg in self.pending_messages:
                self.requeue_message(msg, Exception('SIR terminated while processing.'))
            logger.info('%s messages requeued.', len(self.pending_messages))
        except Exception as exc:
            logger.error("Error encountered while processing messages: %s", exc)
            logger.info("Requeuing %s pending messages.", len(self.pending_messages))
            for msg in self.pending_messages:
                self.requeue_message(msg, exc)
            logger.info('%s messages requeued.', len(self.pending_messages))
        else:
            logger.info('Successfully processed %s messages', len(self.pending_messages))
        finally:
            self.pending_messages = []
            self.pending_entities.clear()
            self.last_message = time.time()

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


def _should_retry(exc):
    logger.info("Retrying...")
    logger.exception(exc)
    if isinstance(exc, AMQPError) or isinstance(exc, socket_error):
        logger.info("Retrying in %i seconds", _RETRY_WAIT_SECS)
        return True

    return False


@retry(wait_fixed=_RETRY_WAIT_SECS * 1000, retry_on_exception=_should_retry)
def _watch_impl(entities):

    handler = Handler(entities)
    try:
        timeout = config.CFG.getint("rabbitmq", "timeout")
    except (NoOptionError, AttributeError):
        timeout = 30
    logger.info('AMQP timeout is set to %d seconds', timeout)

    def signal_handler(signum, frame, pid=os.getpid()):

        # Doing this makes sure that only the main process is changing the PROCESS_FLAG.
        # Otherwise, SIR would set the PROCESS_FLAG to False, even when a PoolWorker is
        # terminated.
        if pid == os.getpid():
            # Simply set the `PROCESS_FLAG` to false to stop processing any and
            # all queries.
            indexing.PROCESS_FLAG.value = False

    signal.signal(signal.SIGTERM, signal_handler)
    signal.signal(signal.SIGINT, signal_handler)

    handler.connect_to_rabbitmq()
    logger.info("Connection to RabbitMQ established")
    logger.debug("Waiting for a message")
    while indexing.PROCESS_FLAG.value:
        try:
            handler.connection.drain_events(timeout)
        except socket_error:
            # In case of a timeout, simply continue
            pass
        except Exception as exc:
            # Do not log system call interruption in case of SIGTERM or SIGINT
            if not hasattr(exc, 'errno') or exc.errno != errno.EINTR:
                logger.error(format_exc(exc))
        if indexing.PROCESS_FLAG.value:
            if (time.time() - handler.last_message) >= handler.process_delay \
                    or len(handler.pending_messages) >= handler.batch_size:
                handler.process_messages()

    # There might be some pending messages left in case we quit SIR while it's
    # sitting idle on drain_events.
    if handler.pending_messages:
        logger.info("Requeuing %s pending messages.", len(handler.pending_messages))
        for msg in handler.pending_messages:
            handler.requeue_message(msg, Exception('SIR terminated without processing this message.'))
        handler.pending_messages = []
        handler.pending_entities.clear()

    logger.info('Terminating SIR')


def watch(args):
    """
    Watch AMQP queues for messages.

    :param [str] entity_type: Entity types to watch.
    """
    try:
        create_amqp_connection()
    except socket_error as e:
        logger.error("Couldn't connect to RabbitMQ, check your settings. %s", e)
        exit(1)

    try:
        entities = args["entity_type"] or SCHEMA.keys()
        _watch_impl(entities)
    except URLError as e:
        logger.error("Connecting to Solr failed: %s", e)
        exit(1)

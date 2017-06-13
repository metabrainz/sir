#!/usr/bin/env python
# coding: utf-8
# Copyright (c) 2014, 2015 Wieland Hoffmann
# License: MIT, see LICENSE for details
from sir.amqp import message
from sir import get_sentry, config
from sir.schema import SCHEMA, generate_update_map
from sir.indexing import send_data_to_solr
from sir.trigger_generation.paths import walk_path
from sir.util import (create_amqp_connection,
                      db_session,
                      db_session_ctx,
                      solr_connection,
                      solr_version_check)
from amqp.exceptions import AMQPError
from functools import partial, wraps
from logging import getLogger
from retrying import retry
from socket import error as socket_error
from sqlalchemy import and_
from urllib2 import URLError

__all__ = ["callback_wrapper", "watch", "Handler"]

logger = getLogger("sir")

update_map = generate_update_map()

#: The number of times we'll try to process a message.
_DEFAULT_MB_RETRIES = 4

#: The number of seconds between each connection attempt to the AMQP server.
_RETRY_WAIT_SECS = 30


def callback_wrapper(f):
    """
    Common wrapper for a message callback function that provides basic sanity
    checking for messages and provides exception handling for a function it wraps.

    The following wrapper function is returned:

    .. py:function:: wrapper(self, msg, queue)

        :param sir.amqp.handler.Handler self: Handler object that is processing a message.
        :param sir.amqp.message.Message msg: Message itself.
        :param str queue:

        Calls ``f`` with ``self`` and  an instance of
        :class:`~sir.amqp.message.Message`.
        If an exception gets raised by ``f``, it will be caught and the
        message will be :meth:`rejected
        <amqp:amqp.channel.Channel.basic_reject>` and sent to the
        ``search.failed`` queue (cf. :ref:`queue_setup`).
        Then the exception will not be reraised.

        If no exception is raised, the message will be :meth:`acknowledged
        <amqp:amqp.channel.Channel.basic_ack>`.

    """
    @wraps(f)
    def wrapper(self, msg, queue):
        try:
            parsed_message = message.Message.from_amqp_message(queue, msg)
            if parsed_message.table_name not in update_map:
                raise ValueError("Unknown table: %s" % parsed_message.table_name)
            f(self=self, parsed_message=parsed_message)

        except Exception as exc:
            get_sentry().captureException(extra={"msg": msg, "attributes": msg.__dict__})
            logger.error(exc)

            msg.channel.basic_reject(msg.delivery_tag, requeue=False)

            if not hasattr(msg, "application_headers"):
                # TODO(roman): Document when this might happen
                get_sentry().captureMessage("Message doesn't have \"application_headers\" attribute",
                                            extra={"msg": msg, "attributes": msg.__dict__})
                return
            retries_remaining = msg.application_headers.get("mb-retries",
                                                            _DEFAULT_MB_RETRIES)
            routing_key = msg.delivery_info["routing_key"]
            if retries_remaining:
                msg.application_headers["mb-retries"] = retries_remaining - 1
                msg.application_headers["mb-exception"] = str(exc)
                msg.channel.basic_publish(msg, exchange="search.retry",
                                          routing_key=routing_key)
            else:
                msg.channel.basic_publish(msg, exchange="search.failed",
                                          routing_key=routing_key)
        else:
            msg.channel.basic_ack(msg.delivery_tag)

    return wrapper


class Handler(object):
    """
    This class is used to provide callbacks for AMQP messages and access to
    Solr cores.
    """
    def __init__(self):
        self.cores = {}
        for core_name in SCHEMA.keys():
            self.cores[core_name] = solr_connection(core_name)
            solr_version_check(core_name)

        self.db_session = db_session()

    @callback_wrapper
    def index_callback(self, parsed_message):
        """
        Callback for processing `index` messages.

        Messages for indexing have the following format:

            <table name>, PKs{<PK row name>, <PK value>}

        First value is a table name, followed by primary key values for that
        table. These are then used to lookup values that need to be updated.
        For example:

            {"_table": "artist_credit_name", "position": 0, "artist_credit": 1}

        :param sir.amqp.message.Message parsed_message: Message parsed by the `callback_wrapper`.
        """
        logger.debug("Processing `index` message from table: %s" % parsed_message.table_name)

        for core_name, path in update_map[parsed_message.table_name]:
            # Going through each core/entity that needs to be updated
            # depending on which table we receive a message from.
            entity = SCHEMA[core_name]
            query = entity.query

            select, pk_col_name = walk_path(entity.model, path)
            if select is None:
                # FIXME(roman): When can this happen? Can this happen at all?
                logger.error("SELECT is None")
                continue

            with db_session_ctx(self.db_session) as session:

                # Retrieving PK values of rows in the entity table that need to be updated
                # FIXME(roman): It would probably be a good idea to support tables with different set of PKs.
                # We have those in the `parsed_message` anyway.
                if pk_col_name not in parsed_message.columns:
                    raise ValueError("Unsupported table. PK is not `%s`." % pk_col_name)
                result = session.execute(select.render(), {"ids": parsed_message.columns[pk_col_name]})
                ids = [row[0] for row in result.fetchall()]

                # Retrieving actual data
                # TODO(roman): Figure out how to do this selection without doing two queries
                condition = and_(entity.model.id.in_(ids))
                query = query.filter(condition).with_session(session)
                data = [entity.query_result_to_dict(obj) for obj in query.all()]
                send_data_to_solr(self.cores[core_name], data)

    @callback_wrapper
    def delete_callback(self, parsed_message):
        """
        Callback for processing `delete` messages.

        Messages for deletion have the following format:

            <table name>, <gid>

        First value is a table name for an entity that has been deleted.
        Second is GID of the row in that table. For example:

            {"_table": "release", "gid": "90d7709d-feba-47e6-a2d1-8770da3c3d9c"}

        This callback function is expected to receive messages only from
        entity tables all of which have a `gid` column on them.

        :param sir.amqp.message.Message parsed_message: Message parsed by the `callback_wrapper`.
        """
        if "gid" not in parsed_message.columns:
            raise ValueError("`gid` column missing from delete message")
        logger.debug("Deleting {entity_type}: {id}".format(
            entity_type=parsed_message.table_name,
            id=parsed_message.columns["gid"]))
        self.cores[parsed_message.table_name].delete(parsed_message.columns["gid"])


def _should_retry(exc):
    logger.debug("Retrying...")
    logger.exception(exc)
    if isinstance(exc, AMQPError) or isinstance(exc, socket_error):
        logger.info("Retrying in %i seconds", _RETRY_WAIT_SECS)
        return True

    return False


@retry(wait_fixed=_RETRY_WAIT_SECS * 1000, retry_on_exception=_should_retry)
def _watch_impl():

    def add_handler(queue, f):
        logger.info("Adding a callback to %s", queue)
        handler = partial(f, queue=queue)
        ch.basic_consume(queue, callback=handler)

    try:
        conn = create_amqp_connection()
        logger.info("Connection to RabbitMQ established")
        logger.debug("Heartbeat value: %s" % conn.heartbeat)
        ch = conn.channel()
        # Keep in mind that `prefetch_size` is not supported by the version of RabbitMQ that
        # we are currently using (https://www.rabbitmq.com/specification.html).
        # Limits are requires because consumer connection might time out when receive buffer
        # is full (http://stackoverflow.com/q/35438843/272770).
        prefetch_count = config.CFG.getint("rabbitmq", "prefetch_count")
        ch.basic_qos(prefetch_size=0, prefetch_count=prefetch_count, a_global=True)

        handler = Handler()
        add_handler("search.index", handler.index_callback)
        add_handler("search.delete", handler.delete_callback)

        while True:
            logger.debug("Waiting for a message")
            conn.drain_events()
    except Exception:
        get_sentry().captureException()
        raise


def watch(args):
    """
    Watch AMQP queues for messages.

    :param args: will be ignored
    """
    try:
        create_amqp_connection()
    except socket_error as e:
        get_sentry().captureException()
        logger.error("Couldn't connect to RabbitMQ, check your settings")
        logger.error("The error was: %s", e)
        return

    try:
        _watch_impl()
    except URLError as e:
        get_sentry().captureException()
        logger.info("Connecting to Solr failed: %s", e)
        return

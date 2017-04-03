#!/usr/bin/env python
# coding: utf-8
# Copyright (c) 2014, 2015 Wieland Hoffmann
# License: MIT, see LICENSE for details
from sir.amqp import message
from sir import get_sentry, config
from sir.schema import SCHEMA
from sir.indexing import send_data_to_solr
from sir.trigger_generation.paths import unique_split_paths, last_model_in_path, walk_path
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
from collections import defaultdict
from sqlalchemy import and_
from sqlalchemy.orm import class_mapper
from urllib2 import URLError

__all__ = ["callback_wrapper", "watch", "Handler"]

logger = getLogger("sir")

#: The number of times we'll try to process a message.
_DEFAULT_MB_RETRIES = 4

#: The number of seconds between each connection attempt to the AMQP server.
_RETRY_WAIT_SECS = 30


def callback_wrapper(f):
    """
    Wraps a function ``f`` to provide basic exception handling around it.

    The following wrapper function is returned:

    .. py:function:: wrapper(self, msg, queue)

        :param sir.amqp.handler.Handler self:
        :param sir.amqp.message.Message msg:
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
            f(self=self, parsed_message=parsed_message)
        except Exception as exc:
            get_sentry().captureException(extra={"msg": msg, "attributes": msg.__dict__})
            logger.error(exc)

            msg.channel.basic_reject(msg.delivery_tag, requeue=False)

            if not hasattr(msg, "application_headers"):
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
            pass
            self.cores[core_name] = solr_connection(core_name)
            solr_version_check(core_name)

        self.db_session = db_session()
        self.update_map = self._generate_update_map()

    @callback_wrapper
    def index_callback(self, parsed_message):
        """
        Callback for processing `index` messages.

        :param sir.amqp.message.Message parsed_message:
        """
        logger.debug("Processing `index` message from table: %s" % parsed_message.table_name)

        if parsed_message.table_name not in self.update_map:
            raise ValueError("Unknown table: %s" % parsed_message.table_name)

        for core_name, path in self.update_map[parsed_message.table_name]:
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
                if pk_col_name not in parsed_message.primary_keys:
                    raise ValueError("Unsupported table. PK is not `%s`." % pk_col_name)
                result = session.execute(select.render(), {"ids": parsed_message.primary_keys[pk_col_name]})
                ids = [row[0] for row in result.fetchall()]

                # Retrieving actual data
                # TODO(roman): Figure out how to do this selection without doing two queries
                condition = and_(entity.model.id.in_(ids))
                query = query.filter(condition).with_session(session)
                data = [entity.query_result_to_dict(obj) for obj in query.all()]
                send_data_to_solr(self.cores[core_name], data)

    @callback_wrapper
    def delete_callback(self, parsed_message):
        logger.debug("Processing `delete` message")
        logger.debug("Deleting {entity_type}: {ids}".format(
            entity_type=parsed_message.entity_type,
            ids=parsed_message.ids))
        self.cores[parsed_message.entity_type].delete_many(parsed_message.ids)

    @staticmethod
    def _generate_update_map():
        """
        Generates mapping from tables to Solr cores (entities) that depend on
        these tables. In addition provides a path along which data of an
        entity can be retrieved by performing a set of JOINs.

        Uses paths to determine the dependency.

        :rtype dict
        """
        tables = defaultdict(set)
        for core_name, entity in SCHEMA.items():
            # Entity itself:
            tables[class_mapper(entity.model).mapped_table.name].add(core_name)
            # Related tables:
            for path in unique_split_paths([path for field in entity.fields
                                            for path in field.paths]):
                model = last_model_in_path(entity.model, path)
                if model is not None:
                    tables[class_mapper(model).mapped_table.name].add((core_name, path))
        return dict(tables)


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

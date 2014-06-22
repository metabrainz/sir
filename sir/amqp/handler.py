#!/usr/bin/env python
# coding: utf-8
# Copyright (c) 2014 Wieland Hoffmann
# License: MIT, see LICENSE for details
from . import message
from ..schema import SCHEMA
from ..util import create_amqp_connection, solr_connection
from functools import partial, wraps
from logging import getLogger


logger = getLogger("sir")


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
        Then the exception will be reraised.

        If no exception is raised, the message will be :meth:`acknowledged
        <amqp:amqp.channel.Channel.basic_ack>`.

    """
    @wraps(f)
    def wrapper(self, msg, queue):
        try:
            parsed_message = message.Message.from_amqp_message(queue, msg)
            f(self=self, parsed_message=parsed_message)
        except Exception as exc:
            logger.error(exc)
            msg.channel.basic_reject(msg.delivery_tag, requeue=False)
            msg.channel.basic_publish(msg, exchange="search.failed")
            raise

        msg.channel.basic_ack(msg.delivery_tag)

    return wrapper


class Handler(object):
    """
    This class is used to provide callbacks for AMQP messages and access to
    Solr cores.
    """
    def __init__(self):
        self.cores = {}  #: Maps entity type names to Solr cores
        for corename in SCHEMA.keys():
            self.cores[corename] = solr_connection(corename)

    @callback_wrapper
    def index_callback(self, parsed_message):
        print parsed_message.message_type, parsed_message.entity_type,\
              parsed_message.ids

    @callback_wrapper
    def delete_callback(self, parsed_message):
        self.cores[parsed_message.entity_type].delete_many(parsed_message.ids)


def watch(args):
    """
    Watch AMQP queues for messages.

    :param args: will be ignored
    """
    conn = create_amqp_connection()
    ch = conn.channel()

    handler = Handler()

    def add_handler(queue, f):
        logger.info("Adding a callback to %s", queue)
        handler = partial(f, queue=queue)
        ch.basic_consume(queue, callback=handler)

    add_handler("search.index", handler.index_callback)
    add_handler("search.delete", handler.delete_callback)

    while ch.callbacks:
        ch.wait()
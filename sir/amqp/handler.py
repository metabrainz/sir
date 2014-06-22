#!/usr/bin/env python
# coding: utf-8
# Copyright (c) 2014 Wieland Hoffmann
# License: MIT, see LICENSE for details
from . import message
from ..util import create_amqp_connection
from functools import partial, wraps
from logging import getLogger


logger = getLogger("sir")


def callback_wrapper(f):
    @wraps(f)
    def wrapper(msg, queue):
        try:
            parsed_message = message.Message.from_amqp_message(queue, msg)
            f(parsed_message)
        except Exception as exc:
            logger.error(exc)
            msg.channel.basic_reject(msg.delivery_tag, requeue=False)
            msg.channel.basic_publish(msg, exchange="search.failed")
            raise

        msg.channel.basic_ack(msg.delivery_tag)
    return wrapper


@callback_wrapper
def index_callback(parsed_message):
    print parsed_message.message_type, parsed_message.entity_type,\
          parsed_message.ids

@callback_wrapper
def delete_callback(parsed_message):
    pass


def watch(args):
    """
    Watch AMQP queues for messages.

    :param args: will be ignored
    """
    conn = create_amqp_connection()
    ch = conn.channel()

    def add_handler(queue, f):
        logger.info("Adding a callback to %s", queue)
        handler = partial(f, queue=queue)
        ch.basic_consume(queue, callback=handler)

    add_handler("search.index", index_callback)
    add_handler("search.delete", delete_callback)

    while ch.callbacks:
        ch.wait()
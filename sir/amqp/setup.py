#!/usr/bin/env python
# coding: utf-8
# Copyright (c) 2014 Wieland Hoffmann
# License: MIT, see LICENSE for details
import logging
import amqp

from sir import util
from functools import partial


logger = logging.getLogger("sir")


def setup_rabbitmq(args):
    """
    Set up the AMQP server.

    :param args: will be ignored
    """
    logger.info("Connecting to RabbitMQ")
    conn = util.create_amqp_connection()
    channel = amqp.Channel(conn)

    logger.info("Declaring exchanes")

    edecl = partial(channel.exchange_declare,
                    auto_delete=False,
                    durable=True)

    edecl("search", "direct")
    edecl("search.retry", "fanout")
    edecl("search.failed", "fanout")

    logger.info("Declaring queues")

    qdecl = partial(channel.queue_declare,
                    auto_delete=False,
                    durable=True)

    delq, _, _ = qdecl("search.delete")
    indq, _, _ = qdecl("search.index")
    retrq, _, _ = qdecl("search.retry", arguments={
                        "x-message-ttl":
                        4 * 60 * 60 * 1000,
                        "x-dead-letter-exchange":
                        "search"}
                        )
    failq, _, _ = qdecl("search.failed")

    logger.info("Binding queues")
    channel.queue_bind(delq, "search", "delete")
    channel.queue_bind(indq, "search", "index")
    channel.queue_bind(indq, "search", "update")
    channel.queue_bind(retrq, "search.retry")
    channel.queue_bind(failq, "search.failed")

    logger.info("Done")

    conn.close()

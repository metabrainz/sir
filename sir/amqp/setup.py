#!/usr/bin/env python
# coding: utf-8
# Copyright (c) 2014 Wieland Hoffmann
# License: MIT, see LICENSE for details
import amqp
import logging

from .. import config
from functools import partial


logger = logging.getLogger("sir")


def setup_rabbitmq(args):
    cget = partial(config.CFG.get, "rabbitmq")

    logger.info("Connecting to RabbitMQ")
    conn = amqp.Connection(host=cget("host"),
                           userid=cget("user"),
                           password=cget("password"),
                           virtual_host=cget("vhost"))
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

    logger.info("Done")

    conn.close()

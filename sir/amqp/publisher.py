#!/usr/bin/env python
# coding: utf-8
# Copyright (c) 2019 Matthew Glubb, Kite Development & Consulting Ltd.
# License: MIT, see LICENSE for details

import errno
import signal
import sentry_sdk
import time
import ujson

from amqp.basic_message import Message
from amqp.exceptions import AMQPError
from logging import getLogger
from retrying import retry
from sir.util import create_amqp_connection, db_session, db_session_ctx
from socket import error as socket_error
from sys import exit
from traceback import format_exc

### NEW

from sqlalchemy import Column, DateTime, Integer, String, Text
from sqlalchemy.ext.declarative import declarative_base


__all__ = ["SIRMessage", "Publisher", "AMQP_DELIVERY_MODE"]

logger = getLogger("sir")

#: The number of seconds between each connection attempt to the AMQP server.
_RETRY_WAIT_SECS = 30

#: The maximum number of sir.message records to fetch with each request
_SIR_MESSAGE_BATCH_SIZE = 100

#: The number of seconds between each connection attempt to the AMQP server.
_PROCESS_FLAG = True

AMQP_DELIVERY_MODE = 2

Base = declarative_base()

class SIRMessage(Base):
    """
    Represents a message in the sir.message table that is queued for delivery
    """

    __tablename__ = 'message'
    __table_args__ = { 'schema': 'sir' }

    id = Column(Integer, primary_key=True)
    exchange = Column(String)
    routing_key = Column(String)
    message = Column(Text)
    created = Column(DateTime(timezone=True))

    def to_amqp_message(self):
        json_message = ujson.dumps(self.message)
        return Message(json_message, delivery_mode=AMQP_DELIVERY_MODE)

    def __repr__(self):
        return "<SIRMessage(exchange='%s', routing_key='%s', message='%s', created='%s')>" % (
            self.exchange, self.routing_key, self.message, self.created.isoformat())


class Publisher(object):
    """
    This class is used to send sir.message database records to relevant AMPQ queues.
    """

    def __init__(self):
        self.db_session = db_session()
        self.processing = False
        self.channel = None
        self.connection = None

    def connect_to_rabbitmq(self, reconnect=False):
        if self.connection and self.connection.connected and (not reconnect):
            return
        if reconnect:
            if self.channel is not None:
                self.channel.close()
            if self.connection is not None:
                self.connection.close()
        conn = create_amqp_connection()
        logger.debug("Heartbeat value: %s" % conn.heartbeat)
        ch = conn.channel()
        self.connection = conn
        self.channel = ch

    def publish(self):
        try:
            messages_pending = True
            while messages_pending:
                with db_session_ctx(self.db_session) as session:
                    for msg in self._sir_message_query(session).limit(_SIR_MESSAGE_BATCH_SIZE):
                        logger.debug("Publishing sid.message ID: %s", msg.id)
                        try:
                            self._queue_message(msg.to_amqp_message(), msg.exchange, msg.routing_key)
                            session.delete(msg)
                        except Exception as e:
                            logger.error(format_exc(e))
                            raise
                    num_remaining = self._sir_message_query(session).count()
                    logger.info("%s messages pending", num_remaining)
                messages_pending = _PROCESS_FLAG and num_remaining > 0
        except Exception as e:
            logger.error(format_exc(e))

    def _sir_message_query(self, session):
        return session.query(SIRMessage).order_by(SIRMessage.id.asc())

    def _queue_message(self, msg, exchange, routing_key):
        self.channel.basic_publish(msg, exchange=exchange, routing_key=routing_key)


def _should_retry(exc):
    logger.info("Retrying...")
    logger.exception(exc)
    if isinstance(exc, AMQPError) or isinstance(exc, socket_error):
        logger.info("Retrying in %i seconds", _RETRY_WAIT_SECS)
        return True
    return False


@retry(wait_fixed=_RETRY_WAIT_SECS * 1000, retry_on_exception=_should_retry)
def _publish_impl():
    publisher = Publisher()

    def signal_handler(signum, frame):
        global _PROCESS_FLAG
        _PROCESS_FLAG = False

    signal.signal(signal.SIGTERM, signal_handler)
    signal.signal(signal.SIGINT, signal_handler)

    try:
        publisher.connect_to_rabbitmq()
        logger.info("Connection to RabbitMQ established")
        logger.debug("Publishing messages")
        while _PROCESS_FLAG:
            try:
                publisher.publish()
            except Exception as e:
                # Do not log system call interruption in case of SIGTERM or SIGINT
                if not hasattr(e, 'errno') or e.errno != errno.EINTR:
                    logger.error(format_exc(e))
            logger.info("Sleeping for %s seconds", _RETRY_WAIT_SECS)
            for i in range(_RETRY_WAIT_SECS):
                if not _PROCESS_FLAG:
                    break
                time.sleep(1)
    except Exception as e:
        sentry_sdk.captureException(e)
        raise

    logger.info('Terminating SIR Publisher')


def publish(args):
    """
    Publish AMQP messages from the sir.message table.

    :param args: will be ignored
    """
    try:
        create_amqp_connection()
    except socket_error as e:
        logger.error("Couldn't connect to RabbitMQ, check your settings. %s", e)
        exit(1)

    try:
        _publish_impl()
    except Exception as e:
        logger.error(format_exc(e))
        exit(1)

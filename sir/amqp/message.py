#!/usr/bin/env python
# coding: utf-8
# Copyright (c) 2014 Wieland Hoffmann
# License: MIT, see LICENSE for details
"""
This module contains functions and classes to parse and represent the content
of an AMQP message.
"""
from sir.trigger_generation.sql_generator import MSG_JSON_TABLE_NAME_KEY, MSG_JSON_OPERATION_TYPE
from enum import Enum
import ujson

MESSAGE_TYPES = Enum("MESSAGE_TYPES", "delete index")

QUEUE_TO_TYPE = {
    "search.delete": MESSAGE_TYPES.delete,
    "search.index": MESSAGE_TYPES.index,
}


class Message(object):
    """
    A parsed message from AMQP.
    """

    def __init__(self, message_type, table_name, columns, operation):
        """
        Construct a new message object.

        A message contains a set of columns (dict) which can be used to determine
        which row has been updated. In case of messages from the `index` queue
        it will be a set of PK columns, and `gid` column for `delete` queue messages.

        :param message_type: Type of the message. A member of :class:`MESSAGE_TYPES`.
        :param str table_name: Name of the table the message is associated with.
        :param dict columns: Dictionary mapping columns of the table to their values.
        """
        self.message_type = message_type
        self.table_name = table_name
        self.columns = columns
        self.operation = operation

    @classmethod
    def from_amqp_message(cls, queue_name, amqp_message):
        """
        Parses an AMQP message.

        :param str queue_name: Name of the queue where the message originated from.
        :param amqp.basic_message.Message amqp_message: Message object from the queue.
        :rtype: :class:`sir.amqp.message.Message`
        """
        if queue_name not in QUEUE_TO_TYPE.keys():
            raise ValueError("Unknown queue: %s" % queue_name)
        else:
            message_type = QUEUE_TO_TYPE[queue_name]

        try:
            data = ujson.loads(amqp_message.body)
        except ValueError as e:
            raise InvalidMessageContentException("Invalid message format (expected JSON): %s" % e)
        table_name = data.pop(MSG_JSON_TABLE_NAME_KEY, None)

        if not table_name:
            raise InvalidMessageContentException("Table name is missing")

        # After table name is extracted from the message only PK(s) should be left.
        if not data:
            # For the `index` queue the data will be a set of PKs, and for `delete`
            # queue it will be a GID value.
            raise InvalidMessageContentException("Reference values are not specified")

        operation = data.pop(MSG_JSON_OPERATION_TYPE, "")
        return cls(message_type, table_name, data, operation)


class InvalidMessageContentException(ValueError):
    """
    Exception indicating an error with the content of an AMQP message.
    """
    pass

#!/usr/bin/env python
# coding: utf-8
# Copyright (c) 2014 Wieland Hoffmann
# License: MIT, see LICENSE for details
"""
This module contains functions and classes to parse and represent the content
of an AMQP message.
"""
from sir.trigger_generation.sql_generator import MSG_JSON_TABLE_NAME_KEY
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

    def __init__(self, message_type, table_name, primary_keys):
        """
        Construct a new message object.

        :param message_type: Type of the message. A member of :class:`MESSAGE_TYPES`.
        :param str table_name: Name of the table the message is associated with.
        :param dict primary_keys: Dictionary mapping PK(s) of the table to their values.
                                  Can be used to determine which row was updated.
        """
        self.message_type = message_type
        self.table_name = table_name
        self.primary_keys = primary_keys

    @classmethod
    def from_amqp_message(cls, queue_name, amqp_message):
        """
        Parses an AMQP message.

        :param str queue_name: Name of the queue where the message originated from.
        :param amqp.basic_message.Message amqp_message: Message object.
        :rtype: :class:`sir.amqp.message.Message`
        """
        if queue_name not in QUEUE_TO_TYPE.keys():
            raise ValueError("Unknown queue: %s" % queue_name)
        else:
            message_type = QUEUE_TO_TYPE[queue_name]

        data = ujson.loads(amqp_message.body)
        table_name = data.pop(MSG_JSON_TABLE_NAME_KEY, None)
        if not table_name:
            raise InvalidMessageContentException("Table name is missing")
        # After table name is extracted from the message only PK(s) should be left.
        if not data:
            raise InvalidMessageContentException("PK(s) not specified")

        return cls(message_type, table_name, primary_keys=data)


class InvalidMessageContentException(ValueError):
    """
    Exception indicating an error with the content of an AMQP message.
    """
    pass

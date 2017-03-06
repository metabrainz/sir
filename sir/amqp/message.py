#!/usr/bin/env python
# coding: utf-8
# Copyright (c) 2014 Wieland Hoffmann
# License: MIT, see LICENSE for details
"""
This module contains functions and classes to parse and represent the content
of an AMQP message.
"""
from sir.schema import SCHEMA
from enum import Enum
from logging import getLogger

MESSAGE_TYPES = Enum("MESSAGE_TYPES", "delete index")

QUEUE_TO_TYPE = {
    "search.delete": MESSAGE_TYPES.delete,
    "search.index": MESSAGE_TYPES.index,
}

logger = getLogger("sir")


class InvalidMessageContentException(ValueError):
    """
    Exception indicating an error with the content of an AMQP message
    """
    pass


class Message(object):
    """
    A parsed message
    """
    def __init__(self, message_type, entity_type, ids):
        """
        Construct a new message object

        :param message_type: A member of :class:`MESSAGE_TYPES`
        :param str entity_type:
        :param ids:
        :type ids: Either a list of UUIDs as strings or a list of ints
        """
        self.message_type = message_type  #: The message type
        self.entity_type = entity_type  #: The entity type
        if message_type != MESSAGE_TYPES.delete:
            ids = map(int, ids)
        self.ids = ids  #: The IDs contained in the original message

    @classmethod
    def from_amqp_message(cls, queue, amqp_message):
        """
        Parses an AMQP message.

        :param str queue: The queue name
        :param amqp.basic_message.Message amqp_message:
        :rtype: :class:`sir.amqp.message.Message`
        :raises sir.amqp.message.InvalidMessageContentException: If the message
                content could not be parsed
        :raises ValueError: If the entity type in the message was invalid or
                any of the IDs was not numeric (in case ``type`` is not
                :data:`MESSAGE_TYPES.delete`) or the queue is unknown
        """
        if queue not in QUEUE_TO_TYPE.keys():
            raise ValueError("%s is not a valid queue name" % queue)
        else:
            message_type = QUEUE_TO_TYPE[queue]

        dbg_msg = amqp_message.body
        if len(dbg_msg) > 20:
            dbg_msg = dbg_msg[:20] + "..."
        logger.debug("Recieved message from queue %s: %s" % (queue, dbg_msg))

        split_message = amqp_message.body.split(" ")
        if not len(split_message) >= 2:
            raise InvalidMessageContentException("AMQP messages must at least "
                                                 "contain 2 entries separated"
                                                 " by spaces")

        entity_type = split_message[0].replace("_", "-")
        if entity_type == "release-raw":  # See https://git.io/vDcdo
            entity_type = "cdstub"
        if entity_type not in SCHEMA.keys():
            raise ValueError("Received a message with the invalid entity type "
                             "%s"
                             % entity_type)

        ids = split_message[1:]

        return cls(message_type, entity_type, ids)

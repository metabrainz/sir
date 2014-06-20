import unittest

from amqp import Message
from mock import patch
from sir.amqp.message import (InvalidMessageContentException,
                              Message as PMessage,
                              MESSAGE_TYPES)


class AmqpMessageTest(unittest.TestCase):
    @staticmethod
    def _parsed_message(body="artist 123 456", channel="search.index"):
        msg = Message(body=body)
        parsed_message = PMessage.from_amqp_message(channel, msg)
        return parsed_message

    def test_message_parses(self):
        parsed_message = self._parsed_message()
        self.assertEqual(parsed_message.entity_type, "artist")
        self.assertEqual(parsed_message.message_type, MESSAGE_TYPES.index)

    def test_invalid_channel_raises(self):
        self.assertRaises(ValueError, self._parsed_message, channel="foo.bar")

    @patch("sir.amqp.message.SCHEMA", new={'entity': None})
    def test_invalid_entity_raises(self):
        self.assertRaises(ValueError, self._parsed_message)

    def test_message_too_short_raises(self):
        self.assertRaises(InvalidMessageContentException, self._parsed_message,
                          body="foo")

    def test_non_delete_converts_to_int(self):
        parsed_message = self._parsed_message(channel="search.index")
        map(lambda id_: self.assertTrue(isinstance(id_, int)),
            parsed_message.ids)

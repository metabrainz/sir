import unittest

from amqp.basic_message import Message
from sir.amqp.message import (InvalidMessageContentException,
                              Message as PMessage,
                              MESSAGE_TYPES)


class AmqpMessageTest(unittest.TestCase):

    @staticmethod
    def _parsed_message(body='{"_table": "artist", "id": "42"}', channel="search.index"):
        msg = Message(body=body)
        parsed_message = PMessage.from_amqp_message(channel, msg)
        return parsed_message

    def test_message_parses(self):
        parsed_message = self._parsed_message()
        self.assertEqual(parsed_message.table_name, "artist")
        self.assertEqual(parsed_message.message_type, MESSAGE_TYPES.index)

    def test_invalid_channel_raises(self):
        self.assertRaises(ValueError, self._parsed_message, channel="foo.bar")

    def test_message_too_short_raises(self):
        self.assertRaises(InvalidMessageContentException, self._parsed_message, body="foo")

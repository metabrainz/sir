#!/usr/bin/env python
# coding: utf-8
# Copyright (c) 2014 Wieland Hoffmann
# License: MIT, see LICENSE for details
import mock
import unittest


from amqp import Message as Amqp_Message
from logging import basicConfig, CRITICAL
from sir.amqp import handler


# Some tests test exception handle which usually generates annoying "no handler
# configured for logger ..." messages
basicConfig(level=CRITICAL)


class AmqpTestCase(unittest.TestCase):
    def setUp(self):
        self.entity_type = "artist"
        self.id_string = "123 456"
        self.message = Amqp_Message(body="%s %s" % (self.entity_type,
                                    self.id_string),
                                    channel=mock.Mock())

        self.delivery_tag = object()
        self.message.delivery_tag = self.delivery_tag


class CallbackWrapperTest(AmqpTestCase):
    def test_ack(self):
        def wrapped_f(*args, **kwargs):
            pass

        f = handler.callback_wrapper(wrapped_f)
        f(mock.Mock(), self.message, "search.index")
        self.message.channel.basic_ack.assert_called_once_with(self.delivery_tag)

    def test_reject_on_exception(self):
        def wrapped_f(*args, **kwargs):
            raise ValueError()

        f = handler.callback_wrapper(wrapped_f)
        self.assertRaises(ValueError, f, mock.Mock(),
                          self.message, "search.index")
        self.message.channel.basic_reject.assert_called_once_with(
            self.delivery_tag,
            requeue=False)
        self.message.channel.basic_publish.assert_called_once_with(
            self.message,
            exchange="search.failed")


class HandlerTest(AmqpTestCase):
    def setUp(self):
        super(HandlerTest, self).setUp()
        handler.solr_connection = mock.Mock()

        self.handler = handler.Handler()
        self.handler.cores[self.entity_type] = mock.Mock()

    def test_delete_callback(self):
        self.handler.delete_callback(self.message, "search.delete")

        ids = map(int, self.id_string.split())

        self.handler.cores[self.entity_type].delete_many.\
            assert_called_once_with(ids)

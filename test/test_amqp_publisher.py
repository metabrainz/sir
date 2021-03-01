#!/usr/bin/env python
# coding: utf-8
# Copyright (c) 2019 Matthew Glubb, Kite Development & Consulting Ltd.
# License: MIT, see LICENSE for details

import sys
from os.path import dirname

sys.path.append(dirname(__file__) + '/../')

import amqp
import mock
import ujson
import unittest

from amqp.exceptions import AMQPError
from faker import Faker
from logging import basicConfig, CRITICAL
from sir.amqp.publisher import publish, Publisher, SIRMessage, AMQP_DELIVERY_MODE
from sir.util import create_amqp_connection

# Some tests test exception handle which usually generates annoying "no handler
# configured for logger ..." messages
basicConfig(level=CRITICAL)

faker = Faker()


class SIRMessageTestCase(unittest.TestCase):

    id = faker.random_number()
    exchange = faker.word()
    routing_key = faker.word()
    message = faker.pydict()
    created = faker.date_time_this_month(before_now=True, after_now=False)

    def setUp(self):
        self.subject = SIRMessage()
        self.subject.id = self.id
        self.subject.exchange = self.exchange
        self.subject.routing_key = self.routing_key
        self.subject.message = self.message
        self.subject.created = self.created
        
    def test_id(self):
        self.assertEqual(self.subject.id, self.id)
        
    def test_exchange(self):
        self.assertEqual(self.subject.exchange, self.exchange)
        
    def test_routing_key(self):
        self.assertEqual(self.subject.routing_key, self.routing_key)
        
    def test_message(self):
        self.assertEqual(self.subject.message, self.message)
        
    def test_created(self):
        self.assertEqual(self.subject.created, self.created)
        
    def test_to_amqp_message(self):
        amqp_message = self.subject.to_amqp_message()
        self.assertEqual(amqp_message.body, ujson.dumps(self.message))
        self.assertEqual(amqp_message.delivery_mode, AMQP_DELIVERY_MODE)
        
    def test_repr(self):
        self.assertEqual(repr(self.subject),
            "<SIRMessage(exchange='%s', routing_key='%s', message='%s', created='%s')>" % (
            self.exchange, self.routing_key, self.message, self.created.isoformat()) )


class PublisherTest(unittest.TestCase):

    def setUp(self):
        db_session_patcher = mock.patch("sir.amqp.publisher.db_session")
        self.addCleanup(db_session_patcher.stop)
        db_session_patcher.start()
        self.subject = Publisher()
        self.channel = mock.MagicMock()
        self.connection = mock.MagicMock()
        self.connection.channel.return_value = self.channel
    
    def test_init(self):
        self.assertFalse(self.subject.processing)
    
    @mock.patch('sir.amqp.publisher.create_amqp_connection')
    def test_connect_to_rabbitmq(self, test_create_amqp_connection):
        test_create_amqp_connection.return_value = self.connection
        self.subject.connect_to_rabbitmq()
        self.subject.channel.close.assert_not_called()
        self.subject.connection.close.assert_not_called()
        self.assertIs(self.subject.channel, self.channel)
        self.assertIs(self.subject.connection, self.connection)
    
    @mock.patch('sir.amqp.publisher.create_amqp_connection')
    def test_connect_to_rabbitmq_connected(self, test_create_amqp_connection):
        self.subject.channel = self.channel
        self.subject.connection = self.connection
        self.subject.connect_to_rabbitmq()
        self.subject.channel.close.assert_not_called()
        self.subject.connection.close.assert_not_called()
        test_create_amqp_connection.assert_not_called()
    
    @mock.patch('sir.amqp.publisher.create_amqp_connection')    
    def test_connect_to_rabbitmq_reconnect(self, test_create_amqp_connection):
        self.subject.channel = self.channel
        self.subject.connection = self.connection
        test_create_amqp_connection.return_value = self.connection
        self.subject.connect_to_rabbitmq(reconnect=True)
        self.subject.channel.close.assert_called_once()
        self.subject.connection.close.assert_called_once()
        self.assertIs(self.subject.channel, self.channel)
        self.assertIs(self.subject.connection, self.connection)
    
    @mock.patch('sir.amqp.publisher.db_session_ctx')
    def test_publish(self, test_db_session_ctx):
        test_session = mock.MagicMock()
        test_db_session_ctx().__enter__.return_value = test_session
        self.subject.channel = self.channel
        message_1 = mock.MagicMock()
        message_1.exchange = faker.word()
        message_1.routing_key = faker.word()
        message_1.to_amqp_message.return_value = '1'
        message_2 = mock.MagicMock()
        message_2.exchange = faker.word()
        message_2.routing_key = faker.word()
        message_2.to_amqp_message.return_value = '2'
        test_session.query().order_by().limit.return_value = [ message_1, message_2 ]
        test_session.query().order_by().count.return_value = 0
        self.subject.publish()
        calls = [
            mock.call.basic_publish('1', exchange=message_1.exchange, routing_key=message_1.routing_key),
            mock.call.basic_publish('2', exchange=message_2.exchange, routing_key=message_2.routing_key)
        ]
        self.subject.channel.assert_has_calls(calls)
        calls = [
            mock.call.delete(message_1),
            mock.call.delete(message_2)
        ]
        test_session.assert_has_calls(calls)
        
    @mock.patch('sir.amqp.publisher.db_session_ctx')
    def test_publish_error(self, test_db_session_ctx):
        test_session = mock.MagicMock()
        test_db_session_ctx().__enter__.return_value = test_session
        self.subject.channel = self.channel
        message_1 = mock.MagicMock()
        test_session.query().order_by().limit.return_value = [ message_1 ]
        test_session.query().order_by().count.return_value = 0
        self.subject.channel.basic_publish.side_effect = Exception('Some error')
        self.subject.publish()
        

if __name__ == "__main__":
    unittest.main()

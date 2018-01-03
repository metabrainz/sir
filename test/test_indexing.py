import mock
import unittest

from multiprocessing import Queue
from sir.indexing import queue_to_solr, send_data_to_solr


class QueueToSolrTest(unittest.TestCase):
    def setUp(self):
        self.solr_connection = mock.Mock()
        self.queue = Queue()
        self.queue.put({"foo": "bar"})
        self.queue.put(None)

    def test_normal_send(self):
        queue_to_solr(self.queue, 1, self.solr_connection)
        expected = [mock.call([{"foo": "bar"}], commit=False), mock.call([], commit=False), ]
        calls = self.solr_connection.add.call_args_list
        self.assertEqual(calls, expected)

    def test_queue_drained_send(self):
        queue_to_solr(self.queue, 2, self.solr_connection)
        self.solr_connection.add.assert_called_once_with([{"foo": "bar"}], commit=False)


class SendDataToSolrTest(unittest.TestCase):
    def setUp(self):
        self.solr_connection = mock.Mock()

    def test_normal_send(self):
        send_data_to_solr(self.solr_connection, [{"foo": "bar"}])
        expected = [mock.call([{"foo": "bar"}], commit=False)]
        calls = self.solr_connection.add.call_args_list
        self.assertEqual(calls, expected)

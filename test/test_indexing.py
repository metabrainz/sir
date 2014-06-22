import mock
import unittest

from multiprocessing import Queue
from solr import SolrException
from sir.indexing import queue_to_solr, send_data_to_solr


class QueueToSolrTest(unittest.TestCase):
    def setUp(self):
        self.solr_connection = mock.Mock()
        self.queue = Queue()
        self.queue.put({"foo": "bar"})
        self.queue.put(None)

    def test_bad_request_ignored(self):
        self.solr_connection.add_many.side_effect = [SolrException(400), None]
        queue_to_solr(self.queue, 1, self.solr_connection)

    def test_normal_send(self):
        queue_to_solr(self.queue, 1, self.solr_connection)
        expected = [mock.call([{"foo": "bar"}]), mock.call([])]
        calls = self.solr_connection.add_many.call_args_list
        self.assertEqual(calls, expected)

    def test_queue_drained_send(self):
        queue_to_solr(self.queue, 2, self.solr_connection)
        self.solr_connection.add_many.assert_called_once_with([{"foo": "bar"}])


class SendDataToSolrTest(unittest.TestCase):
    def setUp(self):
        self.solr_connection = mock.Mock()

    def test_normal_send(self):
        send_data_to_solr(self.solr_connection, [{"foo": "bar"}])
        expected = [mock.call([{"foo": "bar"}])]
        calls = self.solr_connection.add_many.call_args_list
        self.assertEqual(calls, expected)

    def test_bad_request_ignored(self):
        self.solr_connection.add_many.side_effect = [SolrException(400), None]
        send_data_to_solr(self.solr_connection, 1)
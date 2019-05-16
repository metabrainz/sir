import mock
import unittest

import sir.indexing

from multiprocessing import Queue
from sir.indexing import queue_to_solr, send_data_to_solr, FAILED
from pysolr import SolrError

class QueueToSolrTest(unittest.TestCase):
    def setUp(self):
        self.solr_connection = mock.Mock()
        self.queue = Queue()
        self.queue.put({"foo": "bar"})
        self.queue.put(None)

    def test_normal_send(self):
        queue_to_solr(self.queue, 1, self.solr_connection)
        expected = [mock.call([{"foo": "bar"}]), mock.call([]), ]
        calls = self.solr_connection.add.call_args_list
        self.assertEqual(calls, expected)

    def test_queue_drained_send(self):
        queue_to_solr(self.queue, 2, self.solr_connection)
        self.solr_connection.add.assert_called_once_with([{"foo": "bar"}])


class SendDataToSolrTest(unittest.TestCase):
    def setUp(self):
        self.solr_connection = mock.MagicMock()
        self.solr_connection.add = mock.MagicMock()

    def test_normal_send(self):
        send_data_to_solr(self.solr_connection, [{"foo": "bar"}])
        expected = [mock.call([{"foo": "bar"}])]
        calls = self.solr_connection.add.call_args_list
        self.assertEqual(calls, expected)

    def test_fail_send(self):
        self.solr_connection.add.side_effect = SolrError('Test Error')
        self.assertFalse(FAILED.value)
        send_data_to_solr(self.solr_connection, [{"foo": "bar"}])
        self.assertTrue(FAILED.value)

class LiveIndexFailTest(unittest.TestCase):
    def setUp(self):
        self.imp = sir.indexing._multiprocessed_import = mock.MagicMock()
        FAILED.value = False
        def set_flag_to_false(*args, **kwargs):
            FAILED.value = True
        self.imp.side_effect = set_flag_to_false

    def test_error_raised(self):
        self.assertFalse(FAILED.value)
        with self.assertRaises(Exception):
            sir.indexing.live_index(mock.MagicMock())
        self.assertTrue(FAILED.value)

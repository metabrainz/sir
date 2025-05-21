from unittest import mock, TestCase

from multiprocessing import Queue

import pysolr
import requests
from pysolr import SolrError

import sir.indexing
from sir.indexing import queue_to_solr, send_data_to_solr, FAILED


class QueueToSolrTest(TestCase):
    def setUp(self):
        self.queue = Queue()
        self.queue.put({"foo": "bar"})
        self.queue.put(None)

    @mock.patch.object(requests.Session, "get")
    @mock.patch.object(pysolr.Solr, "commit")
    @mock.patch.object(pysolr.Solr, "add")
    def test_normal_send(self, mock_add, mock_commit, mock_get):
        queue_to_solr(self.queue, 1, "test")
        expected = [mock.call([{"foo": "bar"}]), mock.call([]),]
        mock_add.assert_has_calls(expected)
        mock_commit.assert_called()

    @mock.patch.object(requests.Session, "get")
    @mock.patch.object(pysolr.Solr, "commit")
    @mock.patch.object(pysolr.Solr, "add")
    def test_queue_drained_send(self, mock_add, mock_commit, mock_get):
        queue_to_solr(self.queue, 2, "test")
        mock_add.assert_called_once_with([{"foo": "bar"}])
        mock_commit.assert_called()

class SendDataToSolrTest(TestCase):
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

class LiveIndexFailTest(TestCase):
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

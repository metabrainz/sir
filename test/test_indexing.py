from unittest import mock, TestCase

from multiprocessing import Queue

import pysolr
import requests
from pysolr import SolrError
from sqlalchemy import text
from sqlalchemy.exc import DataError

from sir import config, indexing
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
    @mock.patch.object(indexing, '_multiprocessed_import')
    def test_solr_add_failure_reaches_caller(self, run_import):
        self.addCleanup(setattr, FAILED, 'value', False)
        run_import.side_effect = lambda *args, **kwargs: setattr(FAILED, 'value', True)
        with self.assertRaisesRegex(Exception, 'Post to Solr failed'):
            indexing.live_index({'recording': [1]})


class DatabaseReadRetryTest(TestCase):
    def setUp(self):
        config.read_config()
        self.wait = self.enterContext(mock.patch.object(indexing, 'time')).sleep

    def test_live_worker_recovers_from_a_dropped_connection(self):
        sessions = []

        def read(session, *args):
            sessions.append(session)
            if len(sessions) == 1:
                session.connection().connection.driver_connection.close()
            return session.scalar(text('SELECT 1'))

        with mock.patch.object(indexing, 'live_index_entity', read):
            result = indexing._index_entity_process_wrapper(
                ('recording', [42], None), live=True)
        self.assertEqual(result, 1)
        self.assertIsNot(sessions[0], sessions[1])
        self.wait.assert_called_once()

    def test_reindex_aborts_after_capped_backoff_for_a_query_error(self):
        def fail_query(session, *args):
            session.scalar(text('SELECT 1 / 0'))

        with mock.patch.object(indexing, 'uniform', return_value=1), \
                mock.patch.object(indexing, 'index_entity',
                                  side_effect=fail_query) as read:
            with self.assertRaises(indexing.SIR_EXIT) as caught:
                indexing._index_entity_process_wrapper(('recording', (1, 10), None))
        self.assertIsInstance(caught.exception.__cause__, DataError)
        self.assertEqual(read.call_count, 7)
        self.assertEqual(self.wait.call_args_list,
                         [mock.call(s) for s in (3, 5, 9, 17, 33, 64)])

    def test_application_error_propagates_immediately(self):
        read = mock.Mock(side_effect=ValueError('invalid document'))
        with self.assertRaisesRegex(ValueError, 'invalid document'):
            indexing._read_with_retry(read, 'recording')
        read.assert_called_once()

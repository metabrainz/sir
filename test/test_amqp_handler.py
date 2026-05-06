#!/usr/bin/env python
# Copyright (c) 2014 Wieland Hoffmann, MetaBrainz Foundation
# License: MIT, see LICENSE for details
from unittest import mock, TestCase

from logging import basicConfig, CRITICAL
from sir.pending_data import handler
from sir.pending_data.message import Message
from sir.schema import SCHEMA


basicConfig(level=CRITICAL)


class TriggerTestCase(TestCase):

    def setUp(self):
        self.maxDiff = None
        self.entity_type = "artist"

        handler.solr_connection = mock.Mock()
        handler.solr_version_check = mock.Mock()
        handler.live_index = mock.MagicMock()

        db_session_patcher = mock.patch("sir.pending_data.handler.db_session")
        self.addCleanup(db_session_patcher.stop)
        db_session_patcher.start()


class HandlerTest(TriggerTestCase):

    def setUp(self):
        super(HandlerTest, self).setUp()
        handler.SCHEMA = {self.entity_type: None}

        solr_version_check_patcher = mock.patch("sir.pending_data.handler.solr_version_check")
        self.addCleanup(solr_version_check_patcher.stop)
        solr_version_check_patcher.start()

        self.handler = handler.Handler(handler.SCHEMA.keys())
        self.handler.cores[self.entity_type] = mock.Mock()

        for entity_type, entity in SCHEMA.items():
            patcher = mock.patch.object(entity, 'build_entity_query')
            patcher.start()
            self.addCleanup(patcher.stop)

    def test_delete_callback(self):
        entity_gid = "90d7709d-feba-47e6-a2d1-8770da3c3d9c"
        handler.SCHEMA = SCHEMA
        self.handler = handler.Handler(SCHEMA.keys())
        for entity_type, entity in SCHEMA.items():
            self.handler.cores[entity_type] = mock.Mock()

        parsed_message = Message(
            table_name="artist",
            columns={"id": 42, "gid": entity_gid, "name": "Test"},
            operation="delete",
            seqid=1,
            xid=100,
        )
        self.handler.delete_callback(parsed_message)
        self.handler.cores[self.entity_type].delete.assert_called_once_with(entity_gid)

    def test_handler_checks_solr_version(self):
        handler.solr_version_check.assert_called_once_with(self.entity_type)

    def test_index_by_fk_1(self):
        columns = {'id': '1',
                   'area': '2',
                   'type': '3'}
        parsed_message = Message('area_alias', columns, 'delete', seqid=1, xid=100)
        handler.SCHEMA = SCHEMA
        self.handler = handler.Handler(SCHEMA.keys())
        for entity_type, entity in SCHEMA.items():
            self.handler.cores[entity_type] = mock.Mock()

        self.handler._index_by_fk(parsed_message)
        calls = self.handler.db_session().execute.call_args_list
        self.assertEqual(len(calls), 6)
        actual_queries = [str(call[0][0]) for call in calls]
        expected_queries = [
            'SELECT place_1.id AS place_1_id \n'
            'FROM musicbrainz.place AS place_1 JOIN musicbrainz.area ON musicbrainz.area.id = place_1.area \n'
            'WHERE musicbrainz.area.id = :id_1',
            'SELECT label_1.id AS label_1_id \n'
            'FROM musicbrainz.label AS label_1 JOIN musicbrainz.area ON musicbrainz.area.id = label_1.area \n'
            'WHERE musicbrainz.area.id = :id_1',
            'SELECT artist_1.id AS artist_1_id \n'
            'FROM musicbrainz.artist AS artist_1 JOIN musicbrainz.area ON musicbrainz.area.id = artist_1.end_area \n'
            'WHERE musicbrainz.area.id = :id_1',
            'SELECT artist_1.id AS artist_1_id \n'
            'FROM musicbrainz.artist AS artist_1 JOIN musicbrainz.area ON musicbrainz.area.id = artist_1.area \n'
            'WHERE musicbrainz.area.id = :id_1',
            'SELECT artist_1.id AS artist_1_id \n'
            'FROM musicbrainz.artist AS artist_1 JOIN musicbrainz.area ON musicbrainz.area.id = artist_1.begin_area \n'
            'WHERE musicbrainz.area.id = :id_1',
            'SELECT musicbrainz.area.id AS musicbrainz_area_id \n'
            'FROM musicbrainz.area \n'
            'WHERE musicbrainz.area.id = :id_1']

        self.assertCountEqual(expected_queries, actual_queries)

    def test_index_by_fk_2(self):
        columns = {'id': '1'}
        parsed_message = Message('release_meta', columns, 'delete', seqid=1, xid=100)
        handler.SCHEMA = SCHEMA
        self.handler = handler.Handler(SCHEMA.keys())
        for entity_type, entity in SCHEMA.items():
            self.handler.cores[entity_type] = mock.Mock()

        self.handler._index_by_fk(parsed_message)
        calls = self.handler.db_session().execute.call_args_list
        self.assertEqual(len(calls), 1)
        actual_queries = [str(call[0][0]) for call in calls]
        expected_queries = [
            'SELECT musicbrainz.release.id AS musicbrainz_release_id \n'
            'FROM musicbrainz.release \n'
            'WHERE musicbrainz.release.id = :id_1']

        self.assertEqual(expected_queries, actual_queries)

    def test_index_by_fk_3(self):
        columns = {'release_group': 1}
        parsed_message = Message('release', columns, 'delete', seqid=1, xid=100)
        handler.SCHEMA = SCHEMA
        self.handler = handler.Handler(SCHEMA.keys())
        for entity_type, entity in SCHEMA.items():
            self.handler.cores[entity_type] = mock.Mock()

        self.handler._index_by_fk(parsed_message)
        calls = self.handler.db_session().execute.call_args_list
        self.assertEqual(len(calls), 1)
        actual_queries = [str(call[0][0]) for call in calls]
        expected_queries = [
            'SELECT musicbrainz.release_group.id AS musicbrainz_release_group_id \n'
            'FROM musicbrainz.release_group \n'
            'WHERE musicbrainz.release_group.id = :id_1']
        self.assertEqual(expected_queries, actual_queries)

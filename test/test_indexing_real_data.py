import os
import unittest
from pprint import pprint
from queue import Queue

from sqlalchemy import text
from sqlalchemy.orm import Session

from sir import config, querying, util
from sir.indexing import index_entity
from sir.schema import SCHEMA


class IndexingTestCase(unittest.TestCase):
    TEST_SQL_FILES_DIR = os.path.join(
        os.path.dirname(os.path.realpath(__file__)), 'sql')

    @classmethod
    def setUpClass(cls):
        config.read_config()

    def setUp(self):
        self.connection = util.engine().connect()
        self.transaction = self.connection.begin()
        self.session = Session(bind=self.connection)
        self.maxDiff = None

    def tearDown(self):
        self.session.close()
        self.transaction.rollback()
        self.connection.close()

    def _test_index_entity(self, entity, expected_messages, key="mbid"):
        with open(
            os.path.join(self.TEST_SQL_FILES_DIR, f"{entity}.sql"),
            encoding="utf-8"
        ) as f:
            self.session.execute(text(f.read()))

        bounds = querying.iter_bounds(
            self.session, SCHEMA[entity].model, 100, 0
        )

        queue = Queue()
        index_entity(self.session, entity, bounds[0], queue)

        received_messages = []
        while not queue.empty():
            received_messages.append(queue.get_nowait())
        pprint(received_messages, indent=4)

        self.assertEqual(len(expected_messages), len(received_messages))
        expected = {x[key]: x for x in expected_messages}
        received = {x[key]: x for x in received_messages}
        for expected_key, expected_val in expected.items():
            self.assertIn(expected_key, received)
            received_val = received[expected_key]
            self.assertCountEqual(expected_val.keys(), received_val.keys())
            for k, v in expected_val.items():
                if isinstance(v, list):
                    self.assertCountEqual(v, received_val[k])
                else:
                    self.assertEqual(v, received_val[k])

    def test_index_area(self):
        expected = [
            {
                "area": "Europe",
                "ended": "false",
                "iso1": "XE",
                "mbid": "89a675c2-3e37-3518-b83c-418bad59a85a",
                "ref_count": 0,
                "type": "Country",
                "type_gid": "06dd0ae4-8c74-30bb-b43d-95dcedf961de",
            },
            {
                "area": "United States",
                "ended": "false",
                "iso1": "US",
                "mbid": "489ce91b-6658-3307-9877-795b68554c98",
                "ref_count": 0,
                "type": "Country",
                "type_gid": "06dd0ae4-8c74-30bb-b43d-95dcedf961de",
            },
            {
                "area": "United Kingdom",
                "ended": "false",
                "iso1": "GB",
                "mbid": "8a754a16-0027-3a29-b6d7-2b40ea0481ed",
                "ref_count": 0,
                "type": "Country",
                "type_gid": "06dd0ae4-8c74-30bb-b43d-95dcedf961de",
            },
            {
                "area": "Japan",
                "ended": "false",
                "iso1": "JP",
                "mbid": "2db42837-c832-3c27-b4a3-08198f75693c",
                "ref_count": 0,
                "type": "Country",
                "type_gid": "06dd0ae4-8c74-30bb-b43d-95dcedf961de",
            },
            {
                "area": "Germany",
                "ended": "false",
                "iso1": "DE",
                "mbid": "85752fda-13c4-31a3-bee5-0e5cb1f51dad",
                "ref_count": 0,
                "type": "Country",
                "type_gid": "06dd0ae4-8c74-30bb-b43d-95dcedf961de",
            },
            {
                "alias": "オーストラリア",
                "alias_json": ['{"name":"オーストラリア","sort_name":"オーストラリア"}'],
                "area": "Australia",
                "ended": "false",
                "iso1": "AU",
                "mbid": "106e0bec-b638-3b37-b731-f53d507dc00e",
                "ref_count": 0,
                "sortname": "オーストラリア",
                "type": "Country",
                "type_gid": "06dd0ae4-8c74-30bb-b43d-95dcedf961de",
            },
            {
                "area": "Sydney",
                "ended": "false",
                "mbid": "3f179da4-83c6-4a28-a627-e46b4a8ff1ed",
                "ref_count": 0,
                "rel_json": [
                    (
                        '{"direction":"backward","type":"part '
                        'of","type_id":"de7cc874-8b1b-3a05-8272-f3834c968fb7","target":"106e0bec-b638-3b37-b731-f53d507dc00e","area":{"id":"106e0bec-b638-3b37-b731-f53d507dc00e","name":"Australia","type":"Country","type_id":"06dd0ae4-8c74-30bb-b43d-95dcedf961de","ended":"false"}}'
                    )
                ],
                "type": "City",
                "type_gid": "6fd8f29a-3d0a-32fc-980d-ea697b69da78",
            },
        ]
        self._test_index_entity("area", expected)

    def test_index_artist(self):
        expected = [
            {
                "area": "United Kingdom",
                "area_ended": "false",
                "area_gid": "8a754a16-0027-3a29-b6d7-2b40ea0481ed",
                "area_name": "United Kingdom",
                "area_type": "Country",
                "area_type_gid": "06dd0ae4-8c74-30bb-b43d-95dcedf961de",
                "artist": "Test Artist",
                "begin": "2008-01-02",
                "beginarea": "United Kingdom",
                "beginarea_ended": "false",
                "beginarea_gid": "8a754a16-0027-3a29-b6d7-2b40ea0481ed",
                "beginarea_name": "United Kingdom",
                "beginarea_type": "Country",
                "beginarea_type_gid": "06dd0ae4-8c74-30bb-b43d-95dcedf961de",
                "comment": "Yet Another Test Artist",
                "country": "GB",
                "end": "2009-03-04",
                "endarea": "United Kingdom",
                "endarea_ended": "false",
                "endarea_gid": "8a754a16-0027-3a29-b6d7-2b40ea0481ed",
                "endarea_name": "United Kingdom",
                "endarea_type": "Country",
                "endarea_type_gid": "06dd0ae4-8c74-30bb-b43d-95dcedf961de",
                "ended": "true",
                "gender_gid": "36d3d30a-839d-3eda-8cb3-29be4384e4a9",
                "gender_name": "male",
                "mbid": "745c079d-374e-4436-9448-da92dedef3ce",
                "ref_count": 0,
                "sortname": "Artist, Test",
                "type": "Person",
                "type_gid": "b6e035f4-3ce9-331c-97df-83397230b0df",
            },
            {
                "area_ended": "false",
                "artist": "Minimal Artist",
                "beginarea_ended": "false",
                "endarea_ended": "false",
                "ended": "false",
                "mbid": "945c079d-374e-4436-9448-da92dedef3cf",
                "ref_count": 0,
                "sortname": "Minimal Artist",
            },
            {
                "area_ended": "false",
                "artist": "Annotated Artist A",
                "beginarea_ended": "false",
                "endarea_ended": "false",
                "ended": "false",
                "mbid": "dc19b13a-5ca5-44f5-8f0e-0c37a8ab1958",
                "ref_count": 0,
                "sortname": "Annotated Artist A",
            },
            {
                "area_ended": "false",
                "artist": "Annotated Artist B",
                "beginarea_ended": "false",
                "endarea_ended": "false",
                "ended": "false",
                "mbid": "ca4c2228-227c-4904-932a-dff442c091ea",
                "ref_count": 0,
                "sortname": "Annotated Artist B",
            },
        ]
        self._test_index_entity("artist", expected)

    def test_index_editor(self):
        expected = [
            {
                "bio": "ModBot is a bot used by the MusicBrainz Server to perform a variety of automated "
                "functions. \\r+",
                "editor": "ModBot",
                "id": 4,
            },
            {"bio": "biography", "editor": "new_editor", "id": 1},
            {"bio": "second biography", "editor": "Alice", "id": 2},
            {"bio": "donation check test user", "editor": "kuno", "id": 3},
        ]
        self._test_index_entity("editor", expected, key="id")

    def test_index_instrument(self):
        # Klavier/piano is present in the test database by default so account for that
        expected = [
            {
                "comment": "Yet Another Test Instrument",
                "description": "This is a description!",
                "instrument": "Test Instrument",
                "mbid": "745c079d-374e-4436-9448-da92dedef3ce",
                "type": "String instrument",
                "type_gid": "cc00f97f-cf3d-3ae2-9163-041cb1a0d726",
            },
            {
                "alias": "Klavier",
                "alias_json": [
                    (
                        '{"name":"Klavier","sort_name":"Klavier","locale":"de","primary":"primary","type":"Instrument '
                        'name","type_id":"2322fc94-fbf3-3c09-b23c-aa5ec8d14fcd"}'
                    )
                ],
                "instrument": "piano",
                "mbid": "b3eac5f9-7859-4416-ac39-7154e2e8d348",
                "type": "String instrument",
                "type_gid": "cc00f97f-cf3d-3ae2-9163-041cb1a0d726",
            },
            {"instrument": "Minimal Instrument 2", "mbid": "a56d18ae-485f-5547-a559-eba3efef04d0"},
            {"instrument": "Minimal Instrument", "mbid": "945c079d-374e-4436-9448-da92dedef3cf"},
        ]
        self._test_index_entity("instrument", expected)

    def test_index_label(self):
        expected = [
            {
                "area": "United Kingdom",
                "area_ended": "false",
                "area_gid": "8a754a16-0027-3a29-b6d7-2b40ea0481ed",
                "area_name": "United Kingdom",
                "area_type": "Country",
                "area_type_gid": "06dd0ae4-8c74-30bb-b43d-95dcedf961de",
                "begin": "1989-02-03",
                "code": 2070,
                "comment": "Sheffield based electronica label",
                "country": "GB",
                "end": "2008-05-19",
                "ended": "true",
                "label": "Warp Records",
                "mbid": "46f0f4cd-8aab-4b33-b698-f459faf64190",
                "release_count": 0,
                "type": "Production",
                "type_gid": "a2426aab-2dd4-339c-b47d-b4923a241678",
            },
            {
                "area_ended": "false",
                "ended": "false",
                "label": "To Merge",
                "mbid": "f2a9a3c0-72e3-11de-8a39-0800200c9a66",
                "release_count": 0,
            },
            {
                "area": "Soviet Union",
                "area_begindate": "1922",
                "area_enddate": "1991",
                "area_ended": "true",
                "area_gid": "32f90933-b4b4-3248-b98c-e573d5329f57",
                "area_name": "Soviet Union",
                "area_type": "Country",
                "area_type_gid": "06dd0ae4-8c74-30bb-b43d-95dcedf961de",
                "begin": "1953-03-15",
                "country": "SU",
                "end": "1991-11-27",
                "ended": "true",
                "label": "U.S.S.R. Ministry of Culture",
                "mbid": "449ddb7e-4e92-41eb-a683-5bbcc7fd7d4a",
                "release_count": 0,
            },
        ]
        self._test_index_entity("label", expected)

    def test_index_place(self):
        expected = [
            {
                "address": "An Address",
                "alias": "A Test Alias",
                "alias_json": ['{"name":"A Test Alias","sort_name":"A Test Alias"}'],
                "area": "Europe",
                "area_ended": "false",
                "area_gid": "89a675c2-3e37-3518-b83c-418bad59a85a",
                "area_name": "Europe",
                "area_type": "Country",
                "area_type_gid": "06dd0ae4-8c74-30bb-b43d-95dcedf961de",
                "begin": "2013",
                "comment": "A PLACE!",
                "ended": "false",
                "lat": 0.323,
                "long": 1.234,
                "mbid": "df9269dd-0470-4ea2-97e8-c11e46080edd",
                "place": "A Test Place",
                "type": "Venue",
                "type_gid": "cd92781a-a73f-30e8-a430-55d7521338db",
            }
        ]
        self._test_index_entity("place", expected)

    def test_index_recording(self):
        expected = [
            {
                "arid": "945c079d-374e-4436-9448-da92dedef3cf",
                "artist": "Artist",
                "artist_credit_json": '{"id":"949a7fd5-fe73-3e8f-922e-01ff4ca958f7","name_credits":[{"name":"Artist","artist":{"id":"945c079d-374e-4436-9448-da92dedef3cf","name":"Artist","sort_name":"Artist"}}]}',
                "artistname": "Artist",
                "creditname": "Artist",
                "firstreleasedate": "2007",
                "format": "Format",
                "mbid": "54b9d183-7dab-42ba-94a3-7388a66604b8",
                "number": "1",
                "position": 1,
                "primarytype": "Album",
                "recording": "King of the Mountain",
                "reid": "f205627f-b70a-409d-adbe-66289b614e80",
                "release": "Aerial",
                "release_json": [
                    (
                        '{"id":"f205627f-b70a-409d-adbe-66289b614e80","title":"Aerial","medium":{"id":"6e8ede88-4145-4412-8951-9e5ba757ea29","format":"Format","track_count":5,"position":1,"track_offset":0,"track":{"id":"66c2ebff-86a8-4e12-a9a2-1650fb97d9d8","number":"1","title":"King '
                        "of the "
                        'Mountain"}},"medium_count":2,"medium_track_count":5,"release_group":{"id":"7c3218d7-75e0-4e8c-971f-f097b6c308c5","title":"Aerial","primarytype":"Album","primarytype_gid":"f529b476-6e62-324f-b0aa-1f3e33d313fc","calc_type":"Album","calc_type_gid":"f529b476-6e62-324f-b0aa-1f3e33d313fc"}}'
                    )
                ],
                "rgid": "7c3218d7-75e0-4e8c-971f-f097b6c308c5",
                "tid": "66c2ebff-86a8-4e12-a9a2-1650fb97d9d8",
                "tnum": 1,
                "tracks": 5,
                "tracksrelease": 5,
                "video": "f",
            },
            {
                "arid": "945c079d-374e-4436-9448-da92dedef3cf",
                "artist": "Artist",
                "artist_credit_json": '{"id":"949a7fd5-fe73-3e8f-922e-01ff4ca958f7","name_credits":[{"name":"Artist","artist":{"id":"945c079d-374e-4436-9448-da92dedef3cf","name":"Artist","sort_name":"Artist"}}]}',
                "artistname": "Artist",
                "creditname": "Artist",
                "dur": 296160,
                "mbid": "07614140-8bb8-4db9-9dcc-0917c3a8471b",
                "qdur": 148,
                "recording": "Joanni",
                "tracksrelease": 0,
                "video": "f",
            },
            {
                "arid": "945c079d-374e-4436-9448-da92dedef3cf",
                "artist": "Artist",
                "artist_credit_json": '{"id":"949a7fd5-fe73-3e8f-922e-01ff4ca958f7","name_credits":[{"name":"Artist","artist":{"id":"945c079d-374e-4436-9448-da92dedef3cf","name":"Artist","sort_name":"Artist"}}]}',
                "artistname": "Artist",
                "creditname": "Artist",
                "dur": 332613,
                "firstreleasedate": "2007",
                "format": "Format",
                "mbid": "44f52946-0c98-47ba-ba60-964774db56f0",
                "number": "5",
                "position": 1,
                "primarytype": "Album",
                "qdur": 166,
                "recording": "How to Be Invisible",
                "reid": "f205627f-b70a-409d-adbe-66289b614e80",
                "release": "Aerial",
                "release_json": [
                    (
                        '{"id":"f205627f-b70a-409d-adbe-66289b614e80","title":"Aerial","medium":{"id":"6e8ede88-4145-4412-8951-9e5ba757ea29","format":"Format","track_count":5,"position":1,"track_offset":4,"track":{"id":"849dc232-c33a-4611-a6a5-5a0969d63422","length":332613,"number":"5","title":"How '
                        "to Be "
                        'Invisible"}},"medium_count":2,"medium_track_count":5,"release_group":{"id":"7c3218d7-75e0-4e8c-971f-f097b6c308c5","title":"Aerial","primarytype":"Album","primarytype_gid":"f529b476-6e62-324f-b0aa-1f3e33d313fc","calc_type":"Album","calc_type_gid":"f529b476-6e62-324f-b0aa-1f3e33d313fc"}}'
                    )
                ],
                "rgid": "7c3218d7-75e0-4e8c-971f-f097b6c308c5",
                "tid": "849dc232-c33a-4611-a6a5-5a0969d63422",
                "tnum": 5,
                "tracks": 5,
                "tracksrelease": 5,
                "video": "f",
            },
            {
                "arid": "945c079d-374e-4436-9448-da92dedef3cf",
                "artist": "Artist",
                "artist_credit_json": '{"id":"949a7fd5-fe73-3e8f-922e-01ff4ca958f7","name_credits":[{"name":"Artist","artist":{"id":"945c079d-374e-4436-9448-da92dedef3cf","name":"Artist","sort_name":"Artist"}}]}',
                "artistname": "Artist",
                "creditname": "Artist",
                "dur": 358960,
                "firstreleasedate": "2007",
                "format": "Format",
                "mbid": "b1d58a57-a0f3-4db8-aa94-868cdc7bc3bb",
                "number": "4",
                "position": 1,
                "primarytype": "Album",
                "qdur": 179,
                "recording": "Mrs. Bartolozzi",
                "reid": "f205627f-b70a-409d-adbe-66289b614e80",
                "release": "Aerial",
                "release_json": [
                    (
                        '{"id":"f205627f-b70a-409d-adbe-66289b614e80","title":"Aerial","medium":{"id":"6e8ede88-4145-4412-8951-9e5ba757ea29","format":"Format","track_count":5,"position":1,"track_offset":3,"track":{"id":"6c04d03c-4995-43be-8530-215ca911dcbf","length":358960,"number":"4","title":"Mrs. '
                        'Bartolozzi"}},"medium_count":2,"medium_track_count":5,"release_group":{"id":"7c3218d7-75e0-4e8c-971f-f097b6c308c5","title":"Aerial","primarytype":"Album","primarytype_gid":"f529b476-6e62-324f-b0aa-1f3e33d313fc","calc_type":"Album","calc_type_gid":"f529b476-6e62-324f-b0aa-1f3e33d313fc"}}'
                    )
                ],
                "rgid": "7c3218d7-75e0-4e8c-971f-f097b6c308c5",
                "tid": "6c04d03c-4995-43be-8530-215ca911dcbf",
                "tnum": 4,
                "tracks": 5,
                "tracksrelease": 5,
                "video": "f",
            },
            {
                "arid": "945c079d-374e-4436-9448-da92dedef3cf",
                "artist": "Artist",
                "artist_credit_json": '{"id":"949a7fd5-fe73-3e8f-922e-01ff4ca958f7","name_credits":[{"name":"Artist","artist":{"id":"945c079d-374e-4436-9448-da92dedef3cf","name":"Artist","sort_name":"Artist"}}]}',
                "artistname": "Artist",
                "creditname": "Artist",
                "dur": 258839,
                "firstreleasedate": "2007",
                "format": "Format",
                "mbid": "ae674299-2824-4500-9516-653ac1bc6f80",
                "number": "3",
                "position": 1,
                "primarytype": "Album",
                "qdur": 129,
                "recording": "Bertie",
                "reid": "f205627f-b70a-409d-adbe-66289b614e80",
                "release": "Aerial",
                "release_json": [
                    '{"id":"f205627f-b70a-409d-adbe-66289b614e80","title":"Aerial","medium":{"id":"6e8ede88-4145-4412-8951-9e5ba757ea29","format":"Format","track_count":5,"position":1,"track_offset":2,"track":{"id":"f891acda-39d6-4a7f-a9d1-dd87b7c46a0a","length":258839,"number":"3","title":"Bertie"}},"medium_count":2,"medium_track_count":5,"release_group":{"id":"7c3218d7-75e0-4e8c-971f-f097b6c308c5","title":"Aerial","primarytype":"Album","primarytype_gid":"f529b476-6e62-324f-b0aa-1f3e33d313fc","calc_type":"Album","calc_type_gid":"f529b476-6e62-324f-b0aa-1f3e33d313fc"}}'
                ],
                "rgid": "7c3218d7-75e0-4e8c-971f-f097b6c308c5",
                "tid": "f891acda-39d6-4a7f-a9d1-dd87b7c46a0a",
                "tnum": 3,
                "tracks": 5,
                "tracksrelease": 5,
                "video": "f",
            },
            {
                "arid": "945c079d-374e-4436-9448-da92dedef3cf",
                "artist": "Artist",
                "artist_credit_json": '{"id":"949a7fd5-fe73-3e8f-922e-01ff4ca958f7","name_credits":[{"name":"Artist","artist":{"id":"945c079d-374e-4436-9448-da92dedef3cf","name":"Artist","sort_name":"Artist"}}]}',
                "artistname": "Artist",
                "creditname": "Artist",
                "dur": 369680,
                "firstreleasedate": "2007",
                "format": "Format",
                "mbid": "659f405b-b4ee-4033-868a-0daa27784b89",
                "number": "2",
                "position": 1,
                "primarytype": "Album",
                "qdur": 184,
                "recording": "π",
                "reid": "f205627f-b70a-409d-adbe-66289b614e80",
                "release": "Aerial",
                "release_json": [
                    '{"id":"f205627f-b70a-409d-adbe-66289b614e80","title":"Aerial","medium":{"id":"6e8ede88-4145-4412-8951-9e5ba757ea29","format":"Format","track_count":5,"position":1,"track_offset":1,"track":{"id":"b0caa7d1-0d1e-483e-b22b-ec6ab7fada06","length":369680,"number":"2","title":"π"}},"medium_count":2,"medium_track_count":5,"release_group":{"id":"7c3218d7-75e0-4e8c-971f-f097b6c308c5","title":"Aerial","primarytype":"Album","primarytype_gid":"f529b476-6e62-324f-b0aa-1f3e33d313fc","calc_type":"Album","calc_type_gid":"f529b476-6e62-324f-b0aa-1f3e33d313fc"}}'
                ],
                "rgid": "7c3218d7-75e0-4e8c-971f-f097b6c308c5",
                "tid": "b0caa7d1-0d1e-483e-b22b-ec6ab7fada06",
                "tnum": 2,
                "tracks": 5,
                "tracksrelease": 5,
                "video": "f",
            },
        ]
        self._test_index_entity("recording", expected)

    def test_index_release(self):
        expected = [
            {
                "arid": "a9d99e40-72d7-11de-8a39-0800200c9a66",
                "artist": "Name",
                "artist_credit_json": '{"id":"949a7fd5-fe73-3e8f-922e-01ff4ca958f7","name_credits":[{"name":"Name","artist":{"id":"a9d99e40-72d7-11de-8a39-0800200c9a66","name":"Name","sort_name":"Name"}}]}',
                "artistname": "Name",
                "calc_type": "Album",
                "calc_type_gid": "f529b476-6e62-324f-b0aa-1f3e33d313fc",
                "creditname": "Name",
                "mbid": "7a906020-72db-11de-8a39-0800200c9a66",
                "mediums": 0,
                "primarytype": "Album",
                "primarytype_gid": "f529b476-6e62-324f-b0aa-1f3e33d313fc",
                "quality": -1,
                "release": "Release #2",
                "rg_comment": "Comment",
                "rg_name": "Arrival",
                "rgid": "3b4faa80-72d9-11de-8a39-0800200c9a66",
                "tracks": 0,
            },
            {
                "arid": "a9d99e40-72d7-11de-8a39-0800200c9a66",
                "artist": "Name",
                "artist_credit_json": '{"id":"949a7fd5-fe73-3e8f-922e-01ff4ca958f7","name_credits":[{"name":"Name","artist":{"id":"a9d99e40-72d7-11de-8a39-0800200c9a66","name":"Name","sort_name":"Name"}}]}',
                "artistname": "Name",
                "barcode": "731453398122",
                "calc_type": "Album",
                "calc_type_gid": "f529b476-6e62-324f-b0aa-1f3e33d313fc",
                "catno": ["ABC-123-X", "ABC-123"],
                "comment": "Comment",
                "country": "GB",
                "creditname": "Name",
                "date": "2009-05-08",
                "label": "Label",
                "label_info_json": [
                    '{"catalog_number":"ABC-123-X","label":{"id":"00a23bd0-72db-11de-8a39-0800200c9a66","name":"Label"}}',
                    '{"catalog_number":"ABC-123","label":{"id":"00a23bd0-72db-11de-8a39-0800200c9a66","name":"Label"}}',
                ],
                "laid": "00a23bd0-72db-11de-8a39-0800200c9a66",
                "lang": "deu",
                "mbid": "f34c079d-374e-4436-9448-da92dedef3ce",
                "mediums": 0,
                "packaging": "Jewel Case",
                "packaging_gid": "ec27701a-4a22-37f4-bfac-6616e0f9750a",
                "primarytype": "Album",
                "primarytype_gid": "f529b476-6e62-324f-b0aa-1f3e33d313fc",
                "quality": -1,
                "release": "Arrival",
                "release_event_json": [
                    (
                        '{"area":{"id":"8a754a16-0027-3a29-b6d7-2b40ea0481ed","name":"United '
                        'Kingdom","iso_3166_1_codes":["GB"]},"date":"2009-05-08"}'
                    )
                ],
                "rg_comment": "Comment",
                "rg_name": "Arrival",
                "rgid": "3b4faa80-72d9-11de-8a39-0800200c9a66",
                "script": "Ugar",
                "status": "Official",
                "status_gid": "4e304316-386d-3409-af2e-78857eec5cfe",
                "tracks": 0,
            },
            {
                "arid": "7a906020-72db-11de-8a39-0800200c9a66",
                "artist": "Various Artists",
                "artist_credit_json": '{"id":"c44109ce-57d7-3691-84c8-37926e3d41d2","name_credits":[{"name":"Various '
                'Artists","artist":{"id":"7a906020-72db-11de-8a39-0800200c9a66","name":"Various '
                'Artists","sort_name":"Various Artists"}}]}',
                "artistname": "Various Artists",
                "creditname": "Various Artists",
                "mbid": "538aff00-a009-4515-a064-11a6d5a502ee",
                "mediums": 0,
                "quality": -1,
                "release": "Blonde on Blonde",
                "rg_name": "Blonde on Blonde",
                "rgid": "329fb554-2a81-3d8a-8e22-ec2c66810019",
                "tracks": 0,
            },
            {
                "arid": "7a906020-72db-11de-8a39-0800200c9a66",
                "artist": "Various Artists",
                "artist_credit_json": '{"id":"c44109ce-57d7-3691-84c8-37926e3d41d2","name_credits":[{"name":"Various '
                'Artists","artist":{"id":"7a906020-72db-11de-8a39-0800200c9a66","name":"Various '
                'Artists","sort_name":"Various Artists"}}]}',
                "artistname": "Various Artists",
                "creditname": "Various Artists",
                "mbid": "25b6fe30-ff5b-11de-8a39-0800200c9a66",
                "medium_json": [
                    '{"id":"c517968f-afd0-48e6-ab4b-dfdae888ad9d","disc_count":0,"track_count":3}',
                    '{"id":"e517968f-afd0-48e6-ab4b-dfdae888ad9d","disc_count":0,"track_count":3}',
                ],
                "mediumid": [
                    "e517968f-afd0-48e6-ab4b-dfdae888ad9d",
                    "c517968f-afd0-48e6-ab4b-dfdae888ad9d",
                ],
                "mediums": 2,
                "quality": -1,
                "release": "Various Release",
                "rg_name": "Various Release",
                "rgid": "25b6fe30-ff5b-11de-8a39-0800200c9a66",
                "tracks": 6,
                "tracksmedium": [3, 3],
            },
        ]
        self._test_index_entity("release", expected)

    def test_index_release_group(self):
        expected = [
            {
                "arid": "7a906020-72db-11de-8a39-0800200c9a66",
                "artist": "Various Artists",
                "artist_credit_json": '{"id":"c44109ce-57d7-3691-84c8-37926e3d41d2","name_credits":[{"name":"Various '
                'Artists","artist":{"id":"7a906020-72db-11de-8a39-0800200c9a66","name":"Various '
                'Artists","sort_name":"Various Artists"}}]}',
                "artistname": "Various Artists",
                "creditname": "Various Artists",
                "mbid": "25b6fe30-ff5b-11de-8a39-0800200c9a66",
                "reid": "25b6fe30-ff5b-11de-8a39-0800200c9a66",
                "release": "Various Release",
                "release_json": [
                    '{"id":"25b6fe30-ff5b-11de-8a39-0800200c9a66","title":"Various Release"}'
                ],
                "releasegroup": "Various Release",
                "releases": 1,
            },
            {
                "arid": "a9d99e40-72d7-11de-8a39-0800200c9a66",
                "artist": "Name",
                "artist_credit_json": '{"id":"949a7fd5-fe73-3e8f-922e-01ff4ca958f7","name_credits":[{"name":"Name","artist":{"id":"a9d99e40-72d7-11de-8a39-0800200c9a66","name":"Name","sort_name":"1"}}]}',
                "artistname": "Name",
                "calc_type": "Album",
                "calc_type_gid": "f529b476-6e62-324f-b0aa-1f3e33d313fc",
                "comment": "Comment",
                "creditname": "Name",
                "mbid": "7b5d22d0-72d7-11de-8a39-0800200c9a66",
                "primarytype": "Album",
                "primarytype_gid": "f529b476-6e62-324f-b0aa-1f3e33d313fc",
                "reid": "4c767e70-72d8-11de-8a39-0800200c9a66",
                "release": "Release Name",
                "release_json": [
                    '{"id":"4c767e70-72d8-11de-8a39-0800200c9a66","title":"Release Name"}'
                ],
                "releasegroup": "Release Group",
                "releases": 1,
            },
            {
                "arid": "a9d99e40-72d7-11de-8a39-0800200c9a66",
                "artist": "Name",
                "artist_credit_json": '{"id":"949a7fd5-fe73-3e8f-922e-01ff4ca958f7","name_credits":[{"name":"Name","artist":{"id":"a9d99e40-72d7-11de-8a39-0800200c9a66","name":"Name","sort_name":"1"}}]}',
                "artistname": "Name",
                "calc_type": "Album",
                "calc_type_gid": "f529b476-6e62-324f-b0aa-1f3e33d313fc",
                "comment": "Comment",
                "creditname": "Name",
                "mbid": "3b4faa80-72d9-11de-8a39-0800200c9a66",
                "primarytype": "Album",
                "primarytype_gid": "f529b476-6e62-324f-b0aa-1f3e33d313fc",
                "releasegroup": "Release Name",
                "releases": 0,
            },
        ]
        self._test_index_entity("release-group", expected)

    def test_index_series(self):
        expected = [
            {
                "mbid": "dbb23c50-d4e4-11e3-9c1a-0800200c9a66",
                "series": "Dumb Recording Series",
                "type": "Recording series",
                "type_gid": "dd968243-7128-30a2-81f0-79843430a8e2",
            },
            {
                "alias": "Test Recording Series Alias",
                "alias_json": [
                    (
                        '{"name":"Test Recording Series Alias","sort_name":"Test Recording Series '
                        'Alias","type":"Search hint","type_id":"8950366b-5ea3-32f2-bf74-ee482474c18b"}'
                    )
                ],
                "comment": "test comment 1",
                "mbid": "a8749d0c-4a5a-4403-97c5-f6cd018f8e6d",
                "series": "Test Recording Series",
                "type": "Recording series",
                "type_gid": "dd968243-7128-30a2-81f0-79843430a8e2",
            },
            {
                "comment": "test comment 2",
                "mbid": "2e8872b9-2745-4807-a84e-094d425ec267",
                "series": "Test Work Series",
                "type": "Work series",
                "type_gid": "b689f694-6305-3d78-954d-df6759a1877b",
            },
        ]
        self._test_index_entity("series", expected)

    def test_index_tag(self):
        expected = [
            {"id": 1, "tag": "musical"},
            {"id": 2, "tag": "rock"},
            {"id": 3, "tag": "jazz"},
            {"id": 4, "tag": "world music"},
        ]
        self._test_index_entity("tag", expected, key="id")

    def test_index_url(self):
        expected = [
            {"mbid": "9201840b-d810-4e0f-bb75-c791205f5b24", "url": "http://musicbrainz.org/"},
            {"mbid": "9b3c5c67-572a-4822-82a3-bdd3f35cf152", "url": "http://microsoft.com"},
            {
                "mbid": "25d6b63a-12dc-41c9-858a-2f42ae610a7d",
                "rel_json": [
                    (
                        '{"target_type":"artist","direction":"backward","type":"wikipedia","type_id":"29651736-fa6d-48e4-aadc-a557c6add1cb","artist":{"id":"acd58926-4243-40bb-a2e5-c7464b3ce577","name":"Faye '
                        'Wong","sort_name":"Faye Wong"}}'
                    )
                ],
                "relationtype": "wikipedia",
                "targetid": "acd58926-4243-40bb-a2e5-c7464b3ce577",
                "targettype": "artist",
                "url": "http://zh-yue.wikipedia.org/wiki/%E7%8E%8B%E8%8F%B2",
            },
            {
                "mbid": "7bd45cc7-6189-4712-35e1-cdf3632cf1a9",
                "rel_json": [
                    (
                        '{"target_type":"artist","direction":"backward","type":"allmusic","type_id":"6b3e3c85-0002-4f34-aca6-80ace0d7e846","artist":{"id":"acd58926-4243-40bb-a2e5-c7464b3ce577","name":"Faye '
                        'Wong","sort_name":"Faye Wong"}}'
                    )
                ],
                "relationtype": "allmusic",
                "targetid": "acd58926-4243-40bb-a2e5-c7464b3ce577",
                "targettype": "artist",
                "url": "https://www.allmusic.com/artist/faye-wong-mn0000515659",
            },
            {"mbid": "9b3c5c67-572a-4822-82a3-bdd3f35cf153", "url": "http://microsoft.fr"},
        ]
        self._test_index_entity("url", expected)

    def test_index_work(self):
        expected = [
            {
                "comment": "Work",
                "mbid": "105c079d-374e-4436-9448-da92dedef3ce",
                "recording_count": 0,
                "type": "Aria",
                "type_gid": "ae801f48-7a7f-3af6-91c7-456f82dae8a9",
                "work": "Test",
            },
            {
                "comment": "Work",
                "iswc": ["T-500.000.002-0", "T-500.000.001-0"],
                "mbid": "755c079d-374e-4436-9448-da92dedef3ce",
                "recording_count": 0,
                "type": "Aria",
                "type_gid": "ae801f48-7a7f-3af6-91c7-456f82dae8a9",
                "work": "Test",
            },
            {
                "comment": "Work",
                "iswc": "T-000.000.001-0",
                "mbid": "745c079d-374e-4436-9448-da92dedef3ce",
                "recording_count": 0,
                "type": "Aria",
                "type_gid": "ae801f48-7a7f-3af6-91c7-456f82dae8a9",
                "work": "Dancing Queen",
            },
            {
                "mbid": "640b17f5-4aa3-3fb1-8c6c-4792458e8a56",
                "recording": "Blue Lines",
                "recording_count": 2,
                "rel_json": [
                    (
                        '{"target_type":"recording","direction":"backward","type":"performance","type_id":"a3005666-a872-32c3-ad06-98af558e99b0","recording":{"id":"bef81f8f-4bcf-4308-bd66-e57018169a94","title":"Blue '
                        'Lines"}}'
                    ),
                    (
                        '{"target_type":"recording","direction":"backward","type":"performance","type_id":"a3005666-a872-32c3-ad06-98af558e99b0","recording":{"id":"a2383c02-2430-4294-9177-ef799a6eca31","title":"Blue '
                        'Lines"}}'
                    ),
                ],
                "rid": [
                    "bef81f8f-4bcf-4308-bd66-e57018169a94",
                    "a2383c02-2430-4294-9177-ef799a6eca31",
                ],
                "type": "Song",
                "type_gid": "f061270a-2fd6-32f1-a641-f0f8676d14e6",
                "work": "Blue Lines",
            },
            {
                "iswc": "T-000.000.002-0",
                "mbid": "745c079d-374e-4436-9448-da92dedef3cf",
                "recording_count": 0,
                "work": "Test",
            },
        ]
        self._test_index_entity("work", expected)

    def test_index_cdstub(self):
        expected = [
            {
                "added": 946684800,
                "artist": "Test Artist",
                "barcode": "837101029192",
                "comment": "this is a comment",
                "discid": "YfSgiOEayqN77Irs.VNV.UNJ0Zs-",
                "id": 1,
                "title": "Test Stub",
                "tracks": 2,
            }
        ]
        self._test_index_entity("cdstub", expected, key="id")

    def test_index_annotation(self):
        expected = [
            {
                "entity": "745c079d-374e-4436-9448-da92dedef3ce",
                "id": 1,
                "name": "Test Artist",
                "text": "Test annotation 1",
                "type": "artist",
            },
            {
                "entity": "945c079d-374e-4436-9448-da92dedef3cf",
                "id": 2,
                "name": "Minimal Artist",
                "text": "Test annotation 2",
                "type": "artist",
            },
            {
                "entity": "dc19b13a-5ca5-44f5-8f0e-0c37a8ab1958",
                "id": 3,
                "name": "Annotated Artist A",
                "text": "Duplicate annotation",
                "type": "artist",
            },
            {
                "entity": "ca4c2228-227c-4904-932a-dff442c091ea",
                "id": 4,
                "name": "Annotated Artist B",
                "text": "Duplicate annotation",
                "type": "artist",
            },
        ]
        self._test_index_entity("annotation", expected, key="id")

    def test_index_event(self):
        expected = [
            {
                "arid": [
                    "dfeba5ea-c967-4ad2-9cdd-3cffb4320143",
                    "f72a5b32-449f-4090-9a2a-ebbdd8d3c2e5",
                ],
                "artist": ["BBC Concert Orchestra", "Kwamé Ryan"],
                "begin": "2022-09-01",
                "comment": "2022, Prom 60",
                "end": "2022-09-01",
                "ended": "true",
                "event": "BBC Open Music Prom",
                "mbid": "ca1d24c1-1999-46fd-8a95-3d4108df5cb2",
                "pid": "4352063b-a833-421b-a420-e7fb295dece0",
                "place": "Royal Albert Hall",
                "rel_json": [
                    (
                        '{"target_type":"artist","direction":"backward","type":"orchestra","type_id":"9b2d5b96-b4d9-4bce-b056-c369ced25e81","artist":{"id":"dfeba5ea-c967-4ad2-9cdd-3cffb4320143","name":"BBC '
                        'Concert Orchestra","sort_name":"BBC Concert Orchestr"}}'
                    ),
                    (
                        '{"target_type":"artist","direction":"backward","type":"conductor","type_id":"92873f0d-12a7-4fb3-9eac-ff06c38c6a60","artist":{"id":"f72a5b32-449f-4090-9a2a-ebbdd8d3c2e5","name":"Kwamé '
                        'Ryan","sort_name":"Ryan, Kwamé"}}'
                    ),
                    (
                        '{"target_type":"place","direction":"backward","type":"held '
                        'at","type_id":"e2c6f697-07dc-38b1-be0b-83d740165532","place":{"id":"4352063b-a833-421b-a420-e7fb295dece0","name":"Royal '
                        'Albert Hall"}}'
                    ),
                ],
                "time": "19:30:00",
                "type": "Concert",
                "type_gid": "ef55e8d7-3d00-394a-8012-f5506a29ff0b",
            }
        ]
        self._test_index_entity("event", expected)

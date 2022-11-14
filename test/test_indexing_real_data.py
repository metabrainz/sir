import codecs
import os
import unittest
from Queue import Queue
from datetime import datetime

import psycopg2
from sqlalchemy.orm import Session

from sir import querying, util, config
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

    def tearDown(self):
        self.session.close()
        self.transaction.rollback()
        self.connection.close()

    def _test_index_entity(self, entity, expected_messages):
        self.session.execute(codecs.open(
            os.path.join(self.TEST_SQL_FILES_DIR, "{}.sql".format(entity)),
            encoding='utf-8'
        ).read())

        bounds = querying.iter_bounds(
            self.session, SCHEMA[entity].model.id, 100, 0
        )

        queue = Queue()
        index_entity(self.session, entity, bounds[0], queue)

        received = []
        while not queue.empty():
            received.append(queue.get_nowait())
        self.assertItemsEqual(expected_messages, received)

    def test_index_area(self):
        expected = [
            {
                '_store': '<ns0:area-list xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#"><ns0:area id="89a675c2-3e37-3518-b83c-418bad59a85a" type="Country" type-id="06dd0ae4-8c74-30bb-b43d-95dcedf961de"><ns0:name>Europe</ns0:name><ns0:sort-name>Europe</ns0:sort-name><ns0:iso-3166-1-code-list><ns0:iso-3166-1-code>XE</ns0:iso-3166-1-code></ns0:iso-3166-1-code-list><ns0:life-span><ns0:ended>false</ns0:ended></ns0:life-span></ns0:area></ns0:area-list>',
                'area': u'Europe',
                'iso1': u'XE',
                'ended': 'false',
                'mbid': '89a675c2-3e37-3518-b83c-418bad59a85a',
                'type': u'Country'
            },
            {
                '_store': '<ns0:area-list xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#"><ns0:area id="489ce91b-6658-3307-9877-795b68554c98" type="Country" type-id="06dd0ae4-8c74-30bb-b43d-95dcedf961de"><ns0:name>United States</ns0:name><ns0:sort-name>United States</ns0:sort-name><ns0:iso-3166-1-code-list><ns0:iso-3166-1-code>US</ns0:iso-3166-1-code></ns0:iso-3166-1-code-list><ns0:life-span><ns0:ended>false</ns0:ended></ns0:life-span></ns0:area></ns0:area-list>',
                'area': u'United States',
                'iso1': u'US',
                'ended': 'false',
                'mbid': '489ce91b-6658-3307-9877-795b68554c98',
                'type': u'Country'
            },
            {
                '_store': '<ns0:area-list xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#"><ns0:area id="8a754a16-0027-3a29-b6d7-2b40ea0481ed" type="Country" type-id="06dd0ae4-8c74-30bb-b43d-95dcedf961de"><ns0:name>United Kingdom</ns0:name><ns0:sort-name>United Kingdom</ns0:sort-name><ns0:iso-3166-1-code-list><ns0:iso-3166-1-code>GB</ns0:iso-3166-1-code></ns0:iso-3166-1-code-list><ns0:life-span><ns0:ended>false</ns0:ended></ns0:life-span></ns0:area></ns0:area-list>',
                'area': u'United Kingdom',
                'iso1': u'GB',
                'ended': 'false',
                'mbid': '8a754a16-0027-3a29-b6d7-2b40ea0481ed',
                'type': u'Country'
            },
            {
                '_store': '<ns0:area-list xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#"><ns0:area id="2db42837-c832-3c27-b4a3-08198f75693c" type="Country" type-id="06dd0ae4-8c74-30bb-b43d-95dcedf961de"><ns0:name>Japan</ns0:name><ns0:sort-name>Japan</ns0:sort-name><ns0:iso-3166-1-code-list><ns0:iso-3166-1-code>JP</ns0:iso-3166-1-code></ns0:iso-3166-1-code-list><ns0:life-span><ns0:ended>false</ns0:ended></ns0:life-span></ns0:area></ns0:area-list>',
                'area': u'Japan',
                'iso1': u'JP',
                'ended': 'false',
                'mbid': '2db42837-c832-3c27-b4a3-08198f75693c',
                'type': u'Country'
            },
            {
                '_store': '<ns0:area-list xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#"><ns0:area id="85752fda-13c4-31a3-bee5-0e5cb1f51dad" type="Country" type-id="06dd0ae4-8c74-30bb-b43d-95dcedf961de"><ns0:name>Germany</ns0:name><ns0:sort-name>Germany</ns0:sort-name><ns0:iso-3166-1-code-list><ns0:iso-3166-1-code>DE</ns0:iso-3166-1-code></ns0:iso-3166-1-code-list><ns0:life-span><ns0:ended>false</ns0:ended></ns0:life-span></ns0:area></ns0:area-list>',
                'area': u'Germany',
                'iso1': u'DE',
                'ended': 'false',
                'mbid': '85752fda-13c4-31a3-bee5-0e5cb1f51dad',
                'type': u'Country'
            },
            {
                '_store': '<ns0:area-list xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#"><ns0:area id="106e0bec-b638-3b37-b731-f53d507dc00e" type="Country" type-id="06dd0ae4-8c74-30bb-b43d-95dcedf961de"><ns0:name>Australia</ns0:name><ns0:sort-name>Australia</ns0:sort-name><ns0:iso-3166-1-code-list><ns0:iso-3166-1-code>AU</ns0:iso-3166-1-code></ns0:iso-3166-1-code-list><ns0:life-span><ns0:ended>false</ns0:ended></ns0:life-span><ns0:alias-list><ns0:alias sort-name="&#12458;&#12540;&#12473;&#12488;&#12521;&#12522;&#12450;">&#12458;&#12540;&#12473;&#12488;&#12521;&#12522;&#12450;</ns0:alias></ns0:alias-list></ns0:area></ns0:area-list>',
                'sortname': u'\u30aa\u30fc\u30b9\u30c8\u30e9\u30ea\u30a2',
                'ended': 'false',
                'area': u'Australia',
                'iso1': u'AU',
                'alias': u'\u30aa\u30fc\u30b9\u30c8\u30e9\u30ea\u30a2',
                'mbid': '106e0bec-b638-3b37-b731-f53d507dc00e',
                'type': u'Country'
            },
            {
                '_store': '<ns0:area-list xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#"><ns0:area id="3f179da4-83c6-4a28-a627-e46b4a8ff1ed" type="City" type-id="6fd8f29a-3d0a-32fc-980d-ea697b69da78"><ns0:name>Sydney</ns0:name><ns0:sort-name>Sydney</ns0:sort-name><ns0:life-span><ns0:ended>false</ns0:ended></ns0:life-span><ns0:relation-list target-type="area"><ns0:relation type="part of" type-id="de7cc874-8b1b-3a05-8272-f3834c968fb7"><ns0:target>106e0bec-b638-3b37-b731-f53d507dc00e</ns0:target><ns0:direction>backward</ns0:direction><ns0:area id="106e0bec-b638-3b37-b731-f53d507dc00e" type="Country" type-id="06dd0ae4-8c74-30bb-b43d-95dcedf961de"><ns0:name>Australia</ns0:name><ns0:sort-name>Australia</ns0:sort-name><ns0:life-span><ns0:ended>false</ns0:ended></ns0:life-span></ns0:area></ns0:relation></ns0:relation-list></ns0:area></ns0:area-list>',
                'ended': 'false',
                'mbid': '3f179da4-83c6-4a28-a627-e46b4a8ff1ed',
                'type': u'City',
                'area': u'Sydney'
            }
        ]
        self._test_index_entity("area", expected)

    def test_index_artist(self):
        expected = [
            {
                'comment': u'Yet Another Test Artist',
                'begin': '2008-01-02',
                'endarea': u'United Kingdom',
                'end': '2009-03-04',
                'sortname': u'Artist, Test',
                'artist': u'Test Artist',
                'country': u'GB',
                'area': u'United Kingdom',
                'ended': 'true',
                'mbid': '745c079d-374e-4436-9448-da92dedef3ce',
                'gender': u'Male',
                '_store': '<ns0:artist xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="745c079d-374e-4436-9448-da92dedef3ce" type="Person" type-id="b6e035f4-3ce9-331c-97df-83397230b0df"><ns0:name>Test Artist</ns0:name><ns0:sort-name>Artist, Test</ns0:sort-name><ns0:gender id="36d3d30a-839d-3eda-8cb3-29be4384e4a9">male</ns0:gender><ns0:country>GB</ns0:country><ns0:area id="8a754a16-0027-3a29-b6d7-2b40ea0481ed" type="Country" type-id="06dd0ae4-8c74-30bb-b43d-95dcedf961de"><ns0:name>United Kingdom</ns0:name><ns0:sort-name>United Kingdom</ns0:sort-name><ns0:life-span><ns0:ended>false</ns0:ended></ns0:life-span></ns0:area><ns0:begin-area id="8a754a16-0027-3a29-b6d7-2b40ea0481ed" type="Country" type-id="06dd0ae4-8c74-30bb-b43d-95dcedf961de"><ns0:name>United Kingdom</ns0:name><ns0:sort-name>United Kingdom</ns0:sort-name><ns0:life-span><ns0:ended>false</ns0:ended></ns0:life-span></ns0:begin-area><ns0:end-area id="8a754a16-0027-3a29-b6d7-2b40ea0481ed" type="Country" type-id="06dd0ae4-8c74-30bb-b43d-95dcedf961de"><ns0:name>United Kingdom</ns0:name><ns0:sort-name>United Kingdom</ns0:sort-name><ns0:life-span><ns0:ended>false</ns0:ended></ns0:life-span></ns0:end-area><ns0:disambiguation>Yet Another Test Artist</ns0:disambiguation><ns0:life-span><ns0:begin>2008-01-02</ns0:begin><ns0:end>2009-03-04</ns0:end><ns0:ended>true</ns0:ended></ns0:life-span></ns0:artist>',
                'type': u'Person',
                'beginarea': u'United Kingdom'
            },
            {
                'ended': 'false',
                'mbid': 'ca4c2228-227c-4904-932a-dff442c091ea',
                '_store': '<ns0:artist xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="ca4c2228-227c-4904-932a-dff442c091ea"><ns0:name>Annotated Artist B</ns0:name><ns0:sort-name>Annotated Artist B</ns0:sort-name><ns0:life-span><ns0:ended>false</ns0:ended></ns0:life-span></ns0:artist>',
                'sortname': u'Annotated Artist B',
                'artist': u'Annotated Artist B'
            },
            {
                'ended': 'false',
                'mbid': 'dc19b13a-5ca5-44f5-8f0e-0c37a8ab1958',
                '_store': '<ns0:artist xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="dc19b13a-5ca5-44f5-8f0e-0c37a8ab1958"><ns0:name>Annotated Artist A</ns0:name><ns0:sort-name>Annotated Artist A</ns0:sort-name><ns0:life-span><ns0:ended>false</ns0:ended></ns0:life-span></ns0:artist>',
                'sortname': u'Annotated Artist A',
                'artist': u'Annotated Artist A'
            },
            {
                'ended': 'false',
                'mbid': '945c079d-374e-4436-9448-da92dedef3cf',
                '_store': '<ns0:artist xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="945c079d-374e-4436-9448-da92dedef3cf"><ns0:name>Minimal Artist</ns0:name><ns0:sort-name>Minimal Artist</ns0:sort-name><ns0:life-span><ns0:ended>false</ns0:ended></ns0:life-span></ns0:artist>',
                'sortname': u'Minimal Artist',
                'artist': u'Minimal Artist'
            }
        ]
        self._test_index_entity("artist", expected)

    def test_index_editor(self):
        expected = [
            {
                'bio': u'ModBot is a bot used by the MusicBrainz Server to perform a variety of automated functions. \\r+',
                '_store': '<ns0:editor xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="4"><ns0:name>ModBot</ns0:name><ns0:bio>ModBot is a bot used by the MusicBrainz Server to perform a variety of automated functions. \\r+</ns0:bio></ns0:editor>',
                'id': 4, 'editor': u'ModBot'
            },
            {
                'bio': u'biography',
                '_store': '<ns0:editor xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="1"><ns0:name>new_editor</ns0:name><ns0:bio>biography</ns0:bio></ns0:editor>',
                'id': 1,
                'editor': u'new_editor'
            },
            {
                'bio': u'second biography',
                '_store': '<ns0:editor xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="2"><ns0:name>Alice</ns0:name><ns0:bio>second biography</ns0:bio></ns0:editor>',
                'id': 2,
                'editor': u'Alice'
            },
            {
                'bio': u'donation check test user',
                '_store': '<ns0:editor xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="3"><ns0:name>kuno</ns0:name><ns0:bio>donation check test user</ns0:bio></ns0:editor>',
                'id': 3,
                'editor': u'kuno'
            }
        ]
        self._test_index_entity("editor", expected)

    def test_index_instrument(self):
        expected = [
            {
                'comment': u'Yet Another Test Instrument',
                '_store': '<ns0:instrument xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="745c079d-374e-4436-9448-da92dedef3ce" type="String instrument" type-id="cc00f97f-cf3d-3ae2-9163-041cb1a0d726"><ns0:name>Test Instrument</ns0:name><ns0:disambiguation>Yet Another Test Instrument</ns0:disambiguation><ns0:description>This is a description!</ns0:description></ns0:instrument>',
                'description': u'This is a description!',
                'instrument': u'Test Instrument',
                'mbid': '745c079d-374e-4436-9448-da92dedef3ce',
                'type': u'String instrument'
            },
            {
                'instrument': u'Minimal Instrument 2',
                'mbid': 'a56d18ae-485f-5547-a559-eba3efef04d0',
                '_store': '<ns0:instrument xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="a56d18ae-485f-5547-a559-eba3efef04d0"><ns0:name>Minimal Instrument 2</ns0:name></ns0:instrument>'
            },
            {
                'instrument': u'Minimal Instrument',
                'mbid': '945c079d-374e-4436-9448-da92dedef3cf',
                '_store': '<ns0:instrument xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="945c079d-374e-4436-9448-da92dedef3cf"><ns0:name>Minimal Instrument</ns0:name></ns0:instrument>'
            }
        ]
        self._test_index_entity("instrument", expected)

    def test_index_label(self):
        expected = [
            {
                'comment': u'Sheffield based electronica label',
                'begin': '1989-02-03',
                'code': 2070,
                'end': '2008-05-19',
                'area': u'United Kingdom',
                'country': u'GB',
                'label': u'Warp Records',
                'ended': 'true',
                'mbid': '46f0f4cd-8aab-4b33-b698-f459faf64190',
                '_store': '<ns0:label xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="46f0f4cd-8aab-4b33-b698-f459faf64190" type="Production" type-id="a2426aab-2dd4-339c-b47d-b4923a241678"><ns0:name>Warp Records</ns0:name><ns0:sort-name>Warp Records</ns0:sort-name><ns0:label-code>2070</ns0:label-code><ns0:disambiguation>Sheffield based electronica label</ns0:disambiguation><ns0:country>GB</ns0:country><ns0:area id="8a754a16-0027-3a29-b6d7-2b40ea0481ed" type="Country" type-id="06dd0ae4-8c74-30bb-b43d-95dcedf961de"><ns0:name>United Kingdom</ns0:name><ns0:sort-name>United Kingdom</ns0:sort-name><ns0:life-span><ns0:ended>false</ns0:ended></ns0:life-span></ns0:area><ns0:life-span><ns0:begin>1989-02-03</ns0:begin><ns0:end>2008-05-19</ns0:end><ns0:ended>true</ns0:ended></ns0:life-span></ns0:label>',
                'type': u'Production'
            },
            {
                'ended': 'false',
                'mbid': 'f2a9a3c0-72e3-11de-8a39-0800200c9a66',
                '_store': '<ns0:label xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="f2a9a3c0-72e3-11de-8a39-0800200c9a66"><ns0:name>To Merge</ns0:name><ns0:sort-name>To Merge</ns0:sort-name><ns0:life-span><ns0:ended>false</ns0:ended></ns0:life-span></ns0:label>',
                'label': u'To Merge'
            },
            {
                'begin': '1953-03-15',
                'end': '1991-11-27',
                'area': u'Soviet Union',
                'country': u'SU',
                'label': u'U.S.S.R. Ministry of Culture',
                'ended': 'true',
                'mbid': '449ddb7e-4e92-41eb-a683-5bbcc7fd7d4a',
                '_store': '<ns0:label xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="449ddb7e-4e92-41eb-a683-5bbcc7fd7d4a"><ns0:name>U.S.S.R. Ministry of Culture</ns0:name><ns0:sort-name>U.S.S.R. Ministry of Culture</ns0:sort-name><ns0:country>SU</ns0:country><ns0:area id="32f90933-b4b4-3248-b98c-e573d5329f57" type="Country" type-id="06dd0ae4-8c74-30bb-b43d-95dcedf961de"><ns0:name>Soviet Union</ns0:name><ns0:sort-name>Soviet Union</ns0:sort-name><ns0:life-span><ns0:begin>1922</ns0:begin><ns0:end>1991</ns0:end><ns0:ended>true</ns0:ended></ns0:life-span></ns0:area><ns0:life-span><ns0:begin>1953-03-15</ns0:begin><ns0:end>1991-11-27</ns0:end><ns0:ended>true</ns0:ended></ns0:life-span></ns0:label>'
             }
        ]
        self._test_index_entity("label", expected)

    def test_index_place(self):
        expected = [
            {
                'comment': u'A PLACE!',
                'begin': '2013',
                '_store': '<ns0:place xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="df9269dd-0470-4ea2-97e8-c11e46080edd" type="Venue" type-id="cd92781a-a73f-30e8-a430-55d7521338db"><ns0:name>A Test Place</ns0:name><ns0:disambiguation>A PLACE!</ns0:disambiguation><ns0:address>An Address</ns0:address><ns0:coordinates><ns0:latitude>0.323</ns0:latitude><ns0:longitude>1.234</ns0:longitude></ns0:coordinates><ns0:area id="89a675c2-3e37-3518-b83c-418bad59a85a" type="Country" type-id="06dd0ae4-8c74-30bb-b43d-95dcedf961de"><ns0:name>Europe</ns0:name><ns0:sort-name>Europe</ns0:sort-name><ns0:life-span><ns0:ended>false</ns0:ended></ns0:life-span></ns0:area><ns0:life-span><ns0:begin>2013</ns0:begin><ns0:ended>false</ns0:ended></ns0:life-span><ns0:alias-list><ns0:alias sort-name="A Test Alias">A Test Alias</ns0:alias></ns0:alias-list></ns0:place>',
                'area': u'Europe',
                'long': 1.234,
                'alias': u'A Test Alias',
                'mbid': 'df9269dd-0470-4ea2-97e8-c11e46080edd',
                'ended': 'false',
                'address': u'An Address',
                'lat': 0.323,
                'place': u'A Test Place',
                'type': u'Venue'
            }
        ]
        self._test_index_entity("place", expected)

    def test_index_recording(self):
        expected = [
            {
                'primarytype': u'Album',
                'firstreleasedate': '2007',
                '_store': '<ns0:recording xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="54b9d183-7dab-42ba-94a3-7388a66604b8"><ns0:title>King of the Mountain</ns0:title><ns0:artist-credit><ns0:name-credit><ns0:name>Artist</ns0:name><ns0:artist id="945c079d-374e-4436-9448-da92dedef3cf"><ns0:name>Artist</ns0:name><ns0:sort-name>Artist</ns0:sort-name></ns0:artist></ns0:name-credit></ns0:artist-credit><ns0:first-release-date>2007</ns0:first-release-date><ns0:release-list><ns0:release id="f205627f-b70a-409d-adbe-66289b614e80"><ns0:title>Aerial</ns0:title><ns0:release-group id="7c3218d7-75e0-4e8c-971f-f097b6c308c5" type="Album" type-id="f529b476-6e62-324f-b0aa-1f3e33d313fc"><ns0:title>Aerial</ns0:title><ns0:primary-type id="f529b476-6e62-324f-b0aa-1f3e33d313fc">Album</ns0:primary-type></ns0:release-group><ns0:medium-list count="2"><ns0:track-count>5</ns0:track-count><ns0:medium><ns0:position>1</ns0:position><ns0:format>Format</ns0:format><ns0:track-list count="5" offset="0"><ns0:track id="66c2ebff-86a8-4e12-a9a2-1650fb97d9d8"><ns0:number>1</ns0:number><ns0:title>King of the Mountain</ns0:title></ns0:track></ns0:track-list></ns0:medium></ns0:medium-list></ns0:release></ns0:release-list></ns0:recording>',
                'tracks': 5,
                'format': u'Format',
                'creditname': u'Artist',
                'reid': 'f205627f-b70a-409d-adbe-66289b614e80',
                'artist': u'Artist',
                'mbid': '54b9d183-7dab-42ba-94a3-7388a66604b8',
                'arid': '945c079d-374e-4436-9448-da92dedef3cf',
                'number': u'1',
                'recording': u'King of the Mountain',
                'tid': '66c2ebff-86a8-4e12-a9a2-1650fb97d9d8',
                'artistname': u'Artist',
                'video': 'f',
                'rgid': '7c3218d7-75e0-4e8c-971f-f097b6c308c5',
                'tracksrelease': 5,
                'release': u'Aerial',
                'position': 1,
                'tnum': 1
            },
            {
                '_store': '<ns0:recording xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="07614140-8bb8-4db9-9dcc-0917c3a8471b"><ns0:title>Joanni</ns0:title><ns0:length>296160</ns0:length><ns0:artist-credit><ns0:name-credit><ns0:name>Artist</ns0:name><ns0:artist id="945c079d-374e-4436-9448-da92dedef3cf"><ns0:name>Artist</ns0:name><ns0:sort-name>Artist</ns0:sort-name></ns0:artist></ns0:name-credit></ns0:artist-credit></ns0:recording>',
                'qdur': 148,
                'artist': u'Artist',
                'creditname': u'Artist',
                'artistname': u'Artist',
                'arid': '945c079d-374e-4436-9448-da92dedef3cf',
                'recording': u'Joanni',
                'mbid': '07614140-8bb8-4db9-9dcc-0917c3a8471b',
                'video': 'f',
                'dur': 296160
            },
            {
                'tnum': 5,
                'primarytype': u'Album',
                '_store': '<ns0:recording xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="44f52946-0c98-47ba-ba60-964774db56f0"><ns0:title>How to Be Invisible</ns0:title><ns0:length>332613</ns0:length><ns0:artist-credit><ns0:name-credit><ns0:name>Artist</ns0:name><ns0:artist id="945c079d-374e-4436-9448-da92dedef3cf"><ns0:name>Artist</ns0:name><ns0:sort-name>Artist</ns0:sort-name></ns0:artist></ns0:name-credit></ns0:artist-credit><ns0:first-release-date>2007</ns0:first-release-date><ns0:release-list><ns0:release id="f205627f-b70a-409d-adbe-66289b614e80"><ns0:title>Aerial</ns0:title><ns0:release-group id="7c3218d7-75e0-4e8c-971f-f097b6c308c5" type="Album" type-id="f529b476-6e62-324f-b0aa-1f3e33d313fc"><ns0:title>Aerial</ns0:title><ns0:primary-type id="f529b476-6e62-324f-b0aa-1f3e33d313fc">Album</ns0:primary-type></ns0:release-group><ns0:medium-list count="2"><ns0:track-count>5</ns0:track-count><ns0:medium><ns0:position>1</ns0:position><ns0:format>Format</ns0:format><ns0:track-list count="5" offset="4"><ns0:track id="849dc232-c33a-4611-a6a5-5a0969d63422"><ns0:number>5</ns0:number><ns0:title>How to Be Invisible</ns0:title><ns0:length>332613</ns0:length></ns0:track></ns0:track-list></ns0:medium></ns0:medium-list></ns0:release></ns0:release-list></ns0:recording>',
                'qdur': 166,
                'number': u'5',
                'video': 'f',
                'recording': u'How to Be Invisible',
                'creditname': u'Artist',
                'arid': '945c079d-374e-4436-9448-da92dedef3cf',
                'tracksrelease': 5,
                'tid': '849dc232-c33a-4611-a6a5-5a0969d63422',
                'dur': 332613,
                'firstreleasedate': '2007',
                'format': u'Format',
                'rgid': '7c3218d7-75e0-4e8c-971f-f097b6c308c5',
                'artistname': u'Artist', 'artist': u'Artist',
                'tracks': 5,
                'reid': 'f205627f-b70a-409d-adbe-66289b614e80',
                'mbid': '44f52946-0c98-47ba-ba60-964774db56f0',
                'release': u'Aerial',
                'position': 1
            },
            {
                'tnum': 4,
                'primarytype': u'Album',
                '_store': '<ns0:recording xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="b1d58a57-a0f3-4db8-aa94-868cdc7bc3bb"><ns0:title>Mrs. Bartolozzi</ns0:title><ns0:length>358960</ns0:length><ns0:artist-credit><ns0:name-credit><ns0:name>Artist</ns0:name><ns0:artist id="945c079d-374e-4436-9448-da92dedef3cf"><ns0:name>Artist</ns0:name><ns0:sort-name>Artist</ns0:sort-name></ns0:artist></ns0:name-credit></ns0:artist-credit><ns0:first-release-date>2007</ns0:first-release-date><ns0:release-list><ns0:release id="f205627f-b70a-409d-adbe-66289b614e80"><ns0:title>Aerial</ns0:title><ns0:release-group id="7c3218d7-75e0-4e8c-971f-f097b6c308c5" type="Album" type-id="f529b476-6e62-324f-b0aa-1f3e33d313fc"><ns0:title>Aerial</ns0:title><ns0:primary-type id="f529b476-6e62-324f-b0aa-1f3e33d313fc">Album</ns0:primary-type></ns0:release-group><ns0:medium-list count="2"><ns0:track-count>5</ns0:track-count><ns0:medium><ns0:position>1</ns0:position><ns0:format>Format</ns0:format><ns0:track-list count="5" offset="3"><ns0:track id="6c04d03c-4995-43be-8530-215ca911dcbf"><ns0:number>4</ns0:number><ns0:title>Mrs. Bartolozzi</ns0:title><ns0:length>358960</ns0:length></ns0:track></ns0:track-list></ns0:medium></ns0:medium-list></ns0:release></ns0:release-list></ns0:recording>',
                'qdur': 179,
                'number': u'4',
                'video': 'f',
                'recording': u'Mrs. Bartolozzi',
                'creditname': u'Artist',
                'arid': '945c079d-374e-4436-9448-da92dedef3cf',
                'tracksrelease': 5,
                'tid': '6c04d03c-4995-43be-8530-215ca911dcbf',
                'dur': 358960,
                'firstreleasedate': '2007',
                'format': u'Format',
                'rgid': '7c3218d7-75e0-4e8c-971f-f097b6c308c5',
                'artistname': u'Artist',
                'artist': u'Artist',
                'tracks': 5,
                'reid': 'f205627f-b70a-409d-adbe-66289b614e80',
                'mbid': 'b1d58a57-a0f3-4db8-aa94-868cdc7bc3bb',
                'release': u'Aerial',
                'position': 1
            },
            {
                'tnum': 3,
                'primarytype': u'Album',
                '_store': '<ns0:recording xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="ae674299-2824-4500-9516-653ac1bc6f80"><ns0:title>Bertie</ns0:title><ns0:length>258839</ns0:length><ns0:artist-credit><ns0:name-credit><ns0:name>Artist</ns0:name><ns0:artist id="945c079d-374e-4436-9448-da92dedef3cf"><ns0:name>Artist</ns0:name><ns0:sort-name>Artist</ns0:sort-name></ns0:artist></ns0:name-credit></ns0:artist-credit><ns0:first-release-date>2007</ns0:first-release-date><ns0:release-list><ns0:release id="f205627f-b70a-409d-adbe-66289b614e80"><ns0:title>Aerial</ns0:title><ns0:release-group id="7c3218d7-75e0-4e8c-971f-f097b6c308c5" type="Album" type-id="f529b476-6e62-324f-b0aa-1f3e33d313fc"><ns0:title>Aerial</ns0:title><ns0:primary-type id="f529b476-6e62-324f-b0aa-1f3e33d313fc">Album</ns0:primary-type></ns0:release-group><ns0:medium-list count="2"><ns0:track-count>5</ns0:track-count><ns0:medium><ns0:position>1</ns0:position><ns0:format>Format</ns0:format><ns0:track-list count="5" offset="2"><ns0:track id="f891acda-39d6-4a7f-a9d1-dd87b7c46a0a"><ns0:number>3</ns0:number><ns0:title>Bertie</ns0:title><ns0:length>258839</ns0:length></ns0:track></ns0:track-list></ns0:medium></ns0:medium-list></ns0:release></ns0:release-list></ns0:recording>',
                'qdur': 129,
                'number': u'3',
                'video': 'f',
                'recording': u'Bertie',
                'creditname': u'Artist',
                'arid': '945c079d-374e-4436-9448-da92dedef3cf',
                'tracksrelease': 5,
                'tid': 'f891acda-39d6-4a7f-a9d1-dd87b7c46a0a',
                'dur': 258839,
                'firstreleasedate': '2007',
                'format': u'Format',
                'rgid': '7c3218d7-75e0-4e8c-971f-f097b6c308c5',
                'artistname': u'Artist',
                'artist': u'Artist',
                'tracks': 5,
                'reid': 'f205627f-b70a-409d-adbe-66289b614e80',
                'mbid': 'ae674299-2824-4500-9516-653ac1bc6f80',
                'release': u'Aerial',
                'position': 1
            },
            {
                'tnum': 2,
                'primarytype': u'Album',
                '_store': '<ns0:recording xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="659f405b-b4ee-4033-868a-0daa27784b89"><ns0:title>&#960;</ns0:title><ns0:length>369680</ns0:length><ns0:artist-credit><ns0:name-credit><ns0:name>Artist</ns0:name><ns0:artist id="945c079d-374e-4436-9448-da92dedef3cf"><ns0:name>Artist</ns0:name><ns0:sort-name>Artist</ns0:sort-name></ns0:artist></ns0:name-credit></ns0:artist-credit><ns0:first-release-date>2007</ns0:first-release-date><ns0:release-list><ns0:release id="f205627f-b70a-409d-adbe-66289b614e80"><ns0:title>Aerial</ns0:title><ns0:release-group id="7c3218d7-75e0-4e8c-971f-f097b6c308c5" type="Album" type-id="f529b476-6e62-324f-b0aa-1f3e33d313fc"><ns0:title>Aerial</ns0:title><ns0:primary-type id="f529b476-6e62-324f-b0aa-1f3e33d313fc">Album</ns0:primary-type></ns0:release-group><ns0:medium-list count="2"><ns0:track-count>5</ns0:track-count><ns0:medium><ns0:position>1</ns0:position><ns0:format>Format</ns0:format><ns0:track-list count="5" offset="1"><ns0:track id="b0caa7d1-0d1e-483e-b22b-ec6ab7fada06"><ns0:number>2</ns0:number><ns0:title>&#960;</ns0:title><ns0:length>369680</ns0:length></ns0:track></ns0:track-list></ns0:medium></ns0:medium-list></ns0:release></ns0:release-list></ns0:recording>',
                'qdur': 184,
                'number': u'2',
                'video': 'f',
                'recording': u'\u03c0',
                'creditname': u'Artist',
                'arid': '945c079d-374e-4436-9448-da92dedef3cf',
                'tracksrelease': 5,
                'tid': 'b0caa7d1-0d1e-483e-b22b-ec6ab7fada06',
                'dur': 369680,
                'firstreleasedate': '2007',
                'format': u'Format',
                'rgid': '7c3218d7-75e0-4e8c-971f-f097b6c308c5',
                'artistname': u'Artist',
                'artist': u'Artist',
                'tracks': 5,
                'reid': 'f205627f-b70a-409d-adbe-66289b614e80',
                'mbid': '659f405b-b4ee-4033-868a-0daa27784b89',
                'release': u'Aerial',
                'position': 1
            }
        ]
        self._test_index_entity("recording", expected)

    def test_index_release(self):
        expected = [
            {
                'primarytype': u'Album',
                '_store': '<ns0:release xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="7a906020-72db-11de-8a39-0800200c9a66"><ns0:title>Release #2</ns0:title><ns0:artist-credit><ns0:name-credit><ns0:name>Name</ns0:name><ns0:artist id="a9d99e40-72d7-11de-8a39-0800200c9a66"><ns0:name>Name</ns0:name><ns0:sort-name>Name</ns0:sort-name></ns0:artist></ns0:name-credit></ns0:artist-credit><ns0:release-group id="3b4faa80-72d9-11de-8a39-0800200c9a66" type="Album" type-id="f529b476-6e62-324f-b0aa-1f3e33d313fc"><ns0:title>Arrival</ns0:title><ns0:disambiguation>Comment</ns0:disambiguation><ns0:primary-type id="f529b476-6e62-324f-b0aa-1f3e33d313fc">Album</ns0:primary-type></ns0:release-group><ns0:tag-list /></ns0:release>',
                'artist': u'Name',
                'creditname': u'Name',
                'artistname': u'Name',
                'arid': 'a9d99e40-72d7-11de-8a39-0800200c9a66',
                'mbid': '7a906020-72db-11de-8a39-0800200c9a66',
                'rgid': '3b4faa80-72d9-11de-8a39-0800200c9a66',
                'release': u'Release #2',
                'quality': -1
            },
            {
                'comment': u'Comment',
                'lang': u'deu',
                'script': u'Ugar',
                '_store': '<ns0:release xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="f34c079d-374e-4436-9448-da92dedef3ce"><ns0:title>Arrival</ns0:title><ns0:status id="4e304316-386d-3409-af2e-78857eec5cfe">Official</ns0:status><ns0:disambiguation>Comment</ns0:disambiguation><ns0:packaging id="ec27701a-4a22-37f4-bfac-6616e0f9750a">Jewel Case</ns0:packaging><ns0:text-representation><ns0:language>deu</ns0:language><ns0:script>Ugar</ns0:script></ns0:text-representation><ns0:artist-credit><ns0:name-credit><ns0:name>Name</ns0:name><ns0:artist id="a9d99e40-72d7-11de-8a39-0800200c9a66"><ns0:name>Name</ns0:name><ns0:sort-name>Name</ns0:sort-name></ns0:artist></ns0:name-credit></ns0:artist-credit><ns0:release-group id="3b4faa80-72d9-11de-8a39-0800200c9a66" type="Album" type-id="f529b476-6e62-324f-b0aa-1f3e33d313fc"><ns0:title>Arrival</ns0:title><ns0:disambiguation>Comment</ns0:disambiguation><ns0:primary-type id="f529b476-6e62-324f-b0aa-1f3e33d313fc">Album</ns0:primary-type></ns0:release-group><ns0:date>2009-05-08</ns0:date><ns0:country>GB</ns0:country><ns0:release-event-list><ns0:release-event><ns0:date>2009-05-08</ns0:date><ns0:area id="8a754a16-0027-3a29-b6d7-2b40ea0481ed"><ns0:name>United Kingdom</ns0:name><ns0:sort-name>United Kingdom</ns0:sort-name><ns0:iso-3166-1-code-list><ns0:iso-3166-1-code>GB</ns0:iso-3166-1-code></ns0:iso-3166-1-code-list></ns0:area></ns0:release-event></ns0:release-event-list><ns0:barcode>731453398122</ns0:barcode><ns0:label-info-list><ns0:label-info><ns0:catalog-number>ABC-123-X</ns0:catalog-number><ns0:label id="00a23bd0-72db-11de-8a39-0800200c9a66"><ns0:name>Label</ns0:name></ns0:label></ns0:label-info><ns0:label-info><ns0:catalog-number>ABC-123</ns0:catalog-number><ns0:label id="00a23bd0-72db-11de-8a39-0800200c9a66"><ns0:name>Label</ns0:name></ns0:label></ns0:label-info></ns0:label-info-list><ns0:tag-list /></ns0:release>',
                'artist': u'Name',
                'creditname': u'Name',
                'country': u'GB',
                'barcode': u'731453398122',
                'status': u'Official',
                'artistname': u'Name',
                'arid': 'a9d99e40-72d7-11de-8a39-0800200c9a66',
                'label': u'Label',
                'packaging': u'Jewel Case',
                'date': '2009-05-08',
                'mbid': 'f34c079d-374e-4436-9448-da92dedef3ce',
                'catno': set([u'ABC-123', u'ABC-123-X']),
                'rgid': '3b4faa80-72d9-11de-8a39-0800200c9a66',
                'laid': '00a23bd0-72db-11de-8a39-0800200c9a66',
                'release': u'Arrival',
                'quality': -1,
                'primarytype': u'Album'
            },
            {
                '_store': '<ns0:release xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="538aff00-a009-4515-a064-11a6d5a502ee"><ns0:title>Blonde on Blonde</ns0:title><ns0:artist-credit><ns0:name-credit><ns0:name>Various Artists</ns0:name><ns0:artist id="7a906020-72db-11de-8a39-0800200c9a66"><ns0:name>Various Artists</ns0:name><ns0:sort-name>Various Artists</ns0:sort-name></ns0:artist></ns0:name-credit></ns0:artist-credit><ns0:release-group id="329fb554-2a81-3d8a-8e22-ec2c66810019"><ns0:title>Blonde on Blonde</ns0:title></ns0:release-group><ns0:tag-list /></ns0:release>',
                'artist': u'Various Artists',
                'creditname': u'Various Artists',
                'artistname': u'Various Artists',
                'arid': '7a906020-72db-11de-8a39-0800200c9a66',
                'mbid': '538aff00-a009-4515-a064-11a6d5a502ee',
                'rgid': '329fb554-2a81-3d8a-8e22-ec2c66810019',
                'release': u'Blonde on Blonde',
                'quality': -1},
            {
                '_store': '<ns0:release xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="25b6fe30-ff5b-11de-8a39-0800200c9a66"><ns0:title>Various Release</ns0:title><ns0:artist-credit><ns0:name-credit><ns0:name>Various Artists</ns0:name><ns0:artist id="7a906020-72db-11de-8a39-0800200c9a66"><ns0:name>Various Artists</ns0:name><ns0:sort-name>Various Artists</ns0:sort-name></ns0:artist></ns0:name-credit></ns0:artist-credit><ns0:release-group id="25b6fe30-ff5b-11de-8a39-0800200c9a66"><ns0:title>Various Release</ns0:title></ns0:release-group><ns0:medium-list count="1"><ns0:track-count>3</ns0:track-count><ns0:medium><ns0:disc-list count="0" /><ns0:track-list count="3" /></ns0:medium></ns0:medium-list><ns0:tag-list /></ns0:release>',
                'tracks': 3, 'artist': u'Various Artists',
                'creditname': u'Various Artists',
                'artistname': u'Various Artists',
                'arid': '7a906020-72db-11de-8a39-0800200c9a66',
                'tracksmedium': 3,
                'mbid': '25b6fe30-ff5b-11de-8a39-0800200c9a66',
                'rgid': '25b6fe30-ff5b-11de-8a39-0800200c9a66',
                'release': u'Various Release',
                'mediums': 1,
                'quality': -1
            }
        ]
        self._test_index_entity("release", expected)

    def test_index_release_group(self):
        expected = [
            {
                'reid': '25b6fe30-ff5b-11de-8a39-0800200c9a66',
                '_store': '<ns0:release-group xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="25b6fe30-ff5b-11de-8a39-0800200c9a66"><ns0:title>Various Release</ns0:title><ns0:artist-credit><ns0:name-credit><ns0:name>Various Artists</ns0:name><ns0:artist id="7a906020-72db-11de-8a39-0800200c9a66"><ns0:name>Various Artists</ns0:name><ns0:sort-name>Various Artists</ns0:sort-name></ns0:artist></ns0:name-credit></ns0:artist-credit><ns0:release-list count="1"><ns0:release id="25b6fe30-ff5b-11de-8a39-0800200c9a66"><ns0:title>Various Release</ns0:title></ns0:release></ns0:release-list></ns0:release-group>',
                'releases': 1,
                'artist': u'Various Artists',
                'creditname': u'Various Artists',
                'artistname': u'Various Artists',
                'arid': '7a906020-72db-11de-8a39-0800200c9a66',
                'releasegroup': u'Various Release',
                'mbid': '25b6fe30-ff5b-11de-8a39-0800200c9a66',
                'release': u'Various Release'
            },
            {
                'comment': u'Comment',
                'reid': '4c767e70-72d8-11de-8a39-0800200c9a66',
                '_store': '<ns0:release-group xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="7b5d22d0-72d7-11de-8a39-0800200c9a66" type="Album" type-id="f529b476-6e62-324f-b0aa-1f3e33d313fc"><ns0:title>Release Group</ns0:title><ns0:disambiguation>Comment</ns0:disambiguation><ns0:primary-type id="f529b476-6e62-324f-b0aa-1f3e33d313fc">Album</ns0:primary-type><ns0:artist-credit><ns0:name-credit><ns0:name>Name</ns0:name><ns0:artist id="a9d99e40-72d7-11de-8a39-0800200c9a66"><ns0:name>Name</ns0:name><ns0:sort-name>1</ns0:sort-name></ns0:artist></ns0:name-credit></ns0:artist-credit><ns0:release-list count="1"><ns0:release id="4c767e70-72d8-11de-8a39-0800200c9a66"><ns0:title>Release Name</ns0:title></ns0:release></ns0:release-list></ns0:release-group>',
                'releases': 1,
                'artist': u'Name',
                'creditname': u'Name',
                'primarytype': u'Album',
                'artistname': u'Name',
                'arid': 'a9d99e40-72d7-11de-8a39-0800200c9a66',
                'releasegroup': u'Release Group',
                'mbid': '7b5d22d0-72d7-11de-8a39-0800200c9a66',
                'release': u'Release Name'
            },
            {
                'comment': u'Comment',
                'primarytype': u'Album',
                '_store': '<ns0:release-group xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="3b4faa80-72d9-11de-8a39-0800200c9a66" type="Album" type-id="f529b476-6e62-324f-b0aa-1f3e33d313fc"><ns0:title>Release Name</ns0:title><ns0:disambiguation>Comment</ns0:disambiguation><ns0:primary-type id="f529b476-6e62-324f-b0aa-1f3e33d313fc">Album</ns0:primary-type><ns0:artist-credit><ns0:name-credit><ns0:name>Name</ns0:name><ns0:artist id="a9d99e40-72d7-11de-8a39-0800200c9a66"><ns0:name>Name</ns0:name><ns0:sort-name>1</ns0:sort-name></ns0:artist></ns0:name-credit></ns0:artist-credit><ns0:release-list count="0" /></ns0:release-group>',
                'artist': u'Name',
                'creditname': u'Name',
                'artistname': u'Name',
                'arid': 'a9d99e40-72d7-11de-8a39-0800200c9a66',
                'releasegroup': u'Release Name',
                'mbid': '3b4faa80-72d9-11de-8a39-0800200c9a66'
            }
        ]
        self._test_index_entity("release-group", expected)

    def test_index_series(self):
        expected = [
            {
                'series': u'Dumb Recording Series',
                'mbid': 'dbb23c50-d4e4-11e3-9c1a-0800200c9a66',
                'type': u'Recording',
                '_store': '<ns0:series xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="dbb23c50-d4e4-11e3-9c1a-0800200c9a66" type="Recording" type-id="dd968243-7128-30a2-81f0-79843430a8e2"><ns0:name>Dumb Recording Series</ns0:name></ns0:series>'
            },
            {
                'comment': u'test comment 1',
                '_store': '<ns0:series xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="a8749d0c-4a5a-4403-97c5-f6cd018f8e6d" type="Recording" type-id="dd968243-7128-30a2-81f0-79843430a8e2"><ns0:name>Test Recording Series</ns0:name><ns0:disambiguation>test comment 1</ns0:disambiguation><ns0:alias-list><ns0:alias sort-name="Test Recording Series Alias" type="Search hint" type-id="8950366b-5ea3-32f2-bf74-ee482474c18b">Test Recording Series Alias</ns0:alias></ns0:alias-list></ns0:series>',
                'series': u'Test Recording Series',
                'alias': u'Test Recording Series Alias',
                'mbid': 'a8749d0c-4a5a-4403-97c5-f6cd018f8e6d',
                'type': u'Recording'
            },
            {
                'comment': u'test comment 2',
                'series': u'Test Work Series',
                'mbid': '2e8872b9-2745-4807-a84e-094d425ec267',
                'type': u'Work',
                '_store': '<ns0:series xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="2e8872b9-2745-4807-a84e-094d425ec267" type="Work" type-id="b689f694-6305-3d78-954d-df6759a1877b"><ns0:name>Test Work Series</ns0:name><ns0:disambiguation>test comment 2</ns0:disambiguation></ns0:series>'
            }
        ]
        self._test_index_entity("series", expected)

    def test_index_tag(self):
        expected = [
            {
                'tag': u'musical',
                '_store': '<ns0:tag xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#"><ns0:name>musical</ns0:name></ns0:tag>',
                'id': 1
            },
            {
                'tag': u'rock',
                '_store': '<ns0:tag xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#"><ns0:name>rock</ns0:name></ns0:tag>',
                'id': 2
            },
            {
                'tag': u'jazz',
                '_store': '<ns0:tag xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#"><ns0:name>jazz</ns0:name></ns0:tag>',
                'id': 3
            },
            {
                'tag': u'world music',
                '_store': '<ns0:tag xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#"><ns0:name>world music</ns0:name></ns0:tag>',
                'id': 4
            }
        ]
        self._test_index_entity("tag", expected)

    def test_index_url(self):
        expected = [
            {
                'url': u'http://musicbrainz.org/',
                'mbid': '9201840b-d810-4e0f-bb75-c791205f5b24',
                '_store': '<ns0:url xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="9201840b-d810-4e0f-bb75-c791205f5b24"><ns0:resource>http://musicbrainz.org/</ns0:resource></ns0:url>'
            },
            {
                'url': u'http://microsoft.com',
                'mbid': '9b3c5c67-572a-4822-82a3-bdd3f35cf152',
                '_store': '<ns0:url xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="9b3c5c67-572a-4822-82a3-bdd3f35cf152"><ns0:resource>http://microsoft.com</ns0:resource></ns0:url>'
            },
            {
                'targettype': 'artist',
                '_store': '<ns0:url xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="25d6b63a-12dc-41c9-858a-2f42ae610a7d"><ns0:resource>http://zh-yue.wikipedia.org/wiki/%E7%8E%8B%E8%8F%B2</ns0:resource><ns0:relation-list target-type="artist"><ns0:relation type="wikipedia" type-id="29651736-fa6d-48e4-aadc-a557c6add1cb"><ns0:direction>backward</ns0:direction><ns0:artist id="acd58926-4243-40bb-a2e5-c7464b3ce577"><ns0:name>Faye Wong</ns0:name><ns0:sort-name>Faye Wong</ns0:sort-name></ns0:artist></ns0:relation></ns0:relation-list></ns0:url>',
                'url': u'http://zh-yue.wikipedia.org/wiki/%E7%8E%8B%E8%8F%B2',
                'targetid': 'acd58926-4243-40bb-a2e5-c7464b3ce577',
                'mbid': '25d6b63a-12dc-41c9-858a-2f42ae610a7d',
                'relationtype': u'wikipedia'
            },
            {
                'targettype': 'artist',
                '_store': '<ns0:url xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="7bd45cc7-6189-4712-35e1-cdf3632cf1a9"><ns0:resource>https://www.allmusic.com/artist/faye-wong-mn0000515659</ns0:resource><ns0:relation-list target-type="artist"><ns0:relation type="allmusic" type-id="6b3e3c85-0002-4f34-aca6-80ace0d7e846"><ns0:direction>backward</ns0:direction><ns0:artist id="acd58926-4243-40bb-a2e5-c7464b3ce577"><ns0:name>Faye Wong</ns0:name><ns0:sort-name>Faye Wong</ns0:sort-name></ns0:artist></ns0:relation></ns0:relation-list></ns0:url>',
                'url': u'https://www.allmusic.com/artist/faye-wong-mn0000515659',
                'targetid': 'acd58926-4243-40bb-a2e5-c7464b3ce577',
                'mbid': '7bd45cc7-6189-4712-35e1-cdf3632cf1a9',
                'relationtype': u'allmusic'
            },
            {
                'url': u'http://microsoft.fr',
                'mbid': '9b3c5c67-572a-4822-82a3-bdd3f35cf153',
                '_store': '<ns0:url xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="9b3c5c67-572a-4822-82a3-bdd3f35cf153"><ns0:resource>http://microsoft.fr</ns0:resource></ns0:url>'
            }
        ]
        self._test_index_entity("url", expected)

    def test_index_work(self):
        expected = [
            {
                'comment': u'Work',
                '_store': '<ns0:work xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="105c079d-374e-4436-9448-da92dedef3ce" type="Aria" type-id="ae801f48-7a7f-3af6-91c7-456f82dae8a9"><ns0:title>Test</ns0:title><ns0:disambiguation>Work</ns0:disambiguation></ns0:work>',
                'mbid': '105c079d-374e-4436-9448-da92dedef3ce',
                'work': u'Test',
                'type': u'Aria'
            },
            {
                'comment': u'Work',
                '_store': '<ns0:work xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="755c079d-374e-4436-9448-da92dedef3ce" type="Aria" type-id="ae801f48-7a7f-3af6-91c7-456f82dae8a9"><ns0:title>Test</ns0:title><ns0:iswc-list><ns0:iswc>T-500.000.001-0</ns0:iswc><ns0:iswc>T-500.000.002-0</ns0:iswc></ns0:iswc-list><ns0:disambiguation>Work</ns0:disambiguation></ns0:work>',
                'iswc': set([u'T-500.000.002-0', u'T-500.000.001-0']),
                'work': u'Test',
                'mbid': '755c079d-374e-4436-9448-da92dedef3ce',
                'type': u'Aria'
            },
            {
                'comment': u'Work',
                '_store': '<ns0:work xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="745c079d-374e-4436-9448-da92dedef3ce" type="Aria" type-id="ae801f48-7a7f-3af6-91c7-456f82dae8a9"><ns0:title>Dancing Queen</ns0:title><ns0:iswc-list><ns0:iswc>T-000.000.001-0</ns0:iswc></ns0:iswc-list><ns0:disambiguation>Work</ns0:disambiguation></ns0:work>',
                'iswc': u'T-000.000.001-0', 'work': u'Dancing Queen',
                'mbid': '745c079d-374e-4436-9448-da92dedef3ce',
                'type': u'Aria'
            },
            {
                'mbid': '745c079d-374e-4436-9448-da92dedef3cf',
                'work': u'Test',
                '_store': '<ns0:work xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="745c079d-374e-4436-9448-da92dedef3cf"><ns0:title>Test</ns0:title><ns0:iswc-list><ns0:iswc>T-000.000.002-0</ns0:iswc></ns0:iswc-list></ns0:work>',
                'iswc': u'T-000.000.002-0'
            },
            {
                '_store': '<ns0:work xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="640b17f5-4aa3-3fb1-8c6c-4792458e8a56" type="Song" type-id="f061270a-2fd6-32f1-a641-f0f8676d14e6"><ns0:title>Blue Lines</ns0:title><ns0:relation-list target-type="recording"><ns0:relation type="performance" type-id="a3005666-a872-32c3-ad06-98af558e99b0"><ns0:direction>backward</ns0:direction><ns0:recording id="bef81f8f-4bcf-4308-bd66-e57018169a94"><ns0:title>Blue Lines</ns0:title></ns0:recording></ns0:relation><ns0:relation type="performance" type-id="a3005666-a872-32c3-ad06-98af558e99b0"><ns0:direction>backward</ns0:direction><ns0:recording id="a2383c02-2430-4294-9177-ef799a6eca31"><ns0:title>Blue Lines</ns0:title></ns0:recording></ns0:relation></ns0:relation-list></ns0:work>',
                'work': u'Blue Lines',
                'recording_count': 2,
                'recording': u'Blue Lines',
                'mbid': '640b17f5-4aa3-3fb1-8c6c-4792458e8a56',
                'rid': set(['bef81f8f-4bcf-4308-bd66-e57018169a94', 'a2383c02-2430-4294-9177-ef799a6eca31']),
                'type': u'Song'
            }
        ]
        self._test_index_entity("work", expected)

    def test_index_cdstub(self):
        expected = [
            {
                'comment': u'this is a comment',
                'added': datetime(
                    2000, 1, 1, 0, 0,
                    tzinfo=psycopg2.tz.FixedOffsetTimezone(offset=0, name=None)
                ),
                '_store': '<ns0:cdstub xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="YfSgiOEayqN77Irs.VNV.UNJ0Zs-"><ns0:title>Test Stub</ns0:title><ns0:artist>Test Artist</ns0:artist><ns0:barcode>837101029192</ns0:barcode><ns0:disambiguation>this is a comment</ns0:disambiguation><ns0:track-list count="2" /></ns0:cdstub>',
                'discid': u'YfSgiOEayqN77Irs.VNV.UNJ0Zs-',
                'artist': u'Test Artist',
                'barcode': u'837101029192',
                'tracks': 2,
                'title': u'Test Stub',
                'id': 1
            }
        ]
        self._test_index_entity("cdstub", expected)

    def test_index_annotation(self):
        expected = [
            {
                '_store': '<ns0:annotation xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" type="artist"><ns0:entity>745c079d-374e-4436-9448-da92dedef3ce</ns0:entity><ns0:name>Test Artist</ns0:name><ns0:text>Test annotation 1</ns0:text></ns0:annotation>',
                'name': u'Test Artist',
                'text': u'Test annotation 1',
                'entity': '745c079d-374e-4436-9448-da92dedef3ce',
                'type': 'artist',
                'id': 1
            },
            {
                '_store': '<ns0:annotation xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" type="artist"><ns0:entity>945c079d-374e-4436-9448-da92dedef3cf</ns0:entity><ns0:name>Minimal Artist</ns0:name><ns0:text>Test annotation 2</ns0:text></ns0:annotation>',
                'name': u'Minimal Artist',
                'text': u'Test annotation 2',
                'entity': '945c079d-374e-4436-9448-da92dedef3cf',
                'type': 'artist',
                'id': 2
            },
            {
                '_store': '<ns0:annotation xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" type="artist"><ns0:entity>dc19b13a-5ca5-44f5-8f0e-0c37a8ab1958</ns0:entity><ns0:name>Annotated Artist A</ns0:name><ns0:text>Duplicate annotation</ns0:text></ns0:annotation>',
                'name': u'Annotated Artist A',
                'text': u'Duplicate annotation',
                'entity': 'dc19b13a-5ca5-44f5-8f0e-0c37a8ab1958',
                'type': 'artist',
                'id': 3
            },
            {
                '_store': '<ns0:annotation xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" type="artist"><ns0:entity>ca4c2228-227c-4904-932a-dff442c091ea</ns0:entity><ns0:name>Annotated Artist B</ns0:name><ns0:text>Duplicate annotation</ns0:text></ns0:annotation>',
                'name': u'Annotated Artist B',
                'text': u'Duplicate annotation',
                'entity': 'ca4c2228-227c-4904-932a-dff442c091ea',
                'type': 'artist',
                'id': 4
            }
        ]
        self._test_index_entity("annotation", expected)

    def test_index_event(self):
        expected = [
            {
                'comment': u'2022, Prom 60',
                'begin': '2022-09-01',
                'end': '2022-09-01',
                'artist': set([u'BBC Concert Orchestra', u'Kwam\xe9 Ryan']),
                'pid': '4352063b-a833-421b-a420-e7fb295dece0',
                'arid': set([
                    'f72a5b32-449f-4090-9a2a-ebbdd8d3c2e5',
                    'dfeba5ea-c967-4ad2-9cdd-3cffb4320143'
                ]),
                'ended': 'true',
                'mbid': 'ca1d24c1-1999-46fd-8a95-3d4108df5cb2',
                'place': u'Royal Albert Hall',
                '_store': '<ns0:event xmlns:ns0="http://musicbrainz.org/ns/mmd-2.0#" id="ca1d24c1-1999-46fd-8a95-3d4108df5cb2" type="Concert" type-id="ef55e8d7-3d00-394a-8012-f5506a29ff0b"><ns0:name>BBC Open Music Prom</ns0:name><ns0:disambiguation>2022, Prom 60</ns0:disambiguation><ns0:life-span><ns0:begin>2022-09-01</ns0:begin><ns0:end>2022-09-01</ns0:end><ns0:ended>true</ns0:ended></ns0:life-span><ns0:time>19:30:00</ns0:time><ns0:relation-list target-type="artist"><ns0:relation type="orchestra" type-id="9b2d5b96-b4d9-4bce-b056-c369ced25e81"><ns0:direction>backward</ns0:direction><ns0:artist id="dfeba5ea-c967-4ad2-9cdd-3cffb4320143"><ns0:name>BBC Concert Orchestra</ns0:name><ns0:sort-name>BBC Concert Orchestr</ns0:sort-name></ns0:artist></ns0:relation><ns0:relation type="conductor" type-id="92873f0d-12a7-4fb3-9eac-ff06c38c6a60"><ns0:direction>backward</ns0:direction><ns0:artist id="f72a5b32-449f-4090-9a2a-ebbdd8d3c2e5"><ns0:name>Kwam&#233; Ryan</ns0:name><ns0:sort-name>Ryan, Kwam&#233;</ns0:sort-name></ns0:artist></ns0:relation></ns0:relation-list><ns0:relation-list target-type="place"><ns0:relation type="held at" type-id="e2c6f697-07dc-38b1-be0b-83d740165532"><ns0:direction>backward</ns0:direction><ns0:place id="4352063b-a833-421b-a420-e7fb295dece0"><ns0:name>Royal Albert Hall</ns0:name></ns0:place></ns0:relation></ns0:relation-list></ns0:event>',
                'type': u'Concert',
                'event': u'BBC Open Music Prom'
            }
        ]
        self._test_index_entity("event", expected)

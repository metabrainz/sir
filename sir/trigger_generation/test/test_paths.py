import unittest
from sir.trigger_generation.paths import generate_filtered_query
from sir.schema import SCHEMA


class PathsTestCase(unittest.TestCase):

    def test_generate_selection(self):

        def validate_selection(core_name, path, expected_sql, emitted_keys):
            select_sql = str(generate_filtered_query(SCHEMA[core_name].model, path, emitted_keys))
            self.assertEqual(select_sql, expected_sql)
        validate_selection(
            core_name="release-group",
            path="releases",
            emitted_keys={'id': 1,},
            expected_sql='SELECT musicbrainz.release_group.id AS musicbrainz_release_group_id \nFROM musicbrainz.release_group JOIN musicbrainz.release ON musicbrainz.release_group.id = musicbrainz.release.release_group \nWHERE musicbrainz.release.id = :id_1',
        )
        validate_selection(
            core_name="annotation",
            path="releases.release",
            emitted_keys={'id': 1},
            expected_sql='SELECT musicbrainz.annotation.id AS musicbrainz_annotation_id \nFROM musicbrainz.annotation JOIN musicbrainz.release_annotation AS release_annotation_1 ON musicbrainz.annotation.id = release_annotation_1.annotation JOIN musicbrainz.release ON musicbrainz.release.id = release_annotation_1.release \nWHERE musicbrainz.release.id = :id_1',
        )
        validate_selection(
            core_name="release-group",
            path="artist_credit.artists",
            emitted_keys={'artist_credit': 1},
            expected_sql='SELECT musicbrainz.release_group.id AS musicbrainz_release_group_id \nFROM musicbrainz.release_group JOIN musicbrainz.artist_credit AS artist_credit_1 ON artist_credit_1.id = musicbrainz.release_group.artist_credit JOIN musicbrainz.artist_credit_name ON artist_credit_1.id = musicbrainz.artist_credit_name.artist_credit \nWHERE musicbrainz.artist_credit_name.artist_credit = :artist_credit_2',
        )
        validate_selection(
            core_name="recording",
            path="artist_credit.artists",
            emitted_keys={'artist_credit': 1},
            expected_sql='SELECT musicbrainz.recording.id AS musicbrainz_recording_id \nFROM musicbrainz.recording JOIN musicbrainz.artist_credit AS artist_credit_1 ON artist_credit_1.id = musicbrainz.recording.artist_credit JOIN musicbrainz.artist_credit_name ON artist_credit_1.id = musicbrainz.artist_credit_name.artist_credit \nWHERE musicbrainz.artist_credit_name.artist_credit = :artist_credit_2',
        )
        validate_selection(
            core_name="artist",
            path="artist_credit_names",
            emitted_keys={'artist_credit': 1},
            expected_sql='SELECT musicbrainz.artist.id AS musicbrainz_artist_id \nFROM musicbrainz.artist JOIN musicbrainz.artist_credit_name ON musicbrainz.artist.id = musicbrainz.artist_credit_name.artist \nWHERE musicbrainz.artist_credit_name.artist_credit = :artist_credit_1',
        )
        validate_selection(
            core_name="recording",
            path="artist_credit",
            emitted_keys={'id': 1},
            expected_sql='SELECT musicbrainz.recording.id AS musicbrainz_recording_id \nFROM musicbrainz.recording JOIN musicbrainz.artist_credit ON musicbrainz.artist_credit.id = musicbrainz.recording.artist_credit \nWHERE musicbrainz.artist_credit.id = :id_1',
        )
        validate_selection(
            core_name="recording",
            path="tracks.medium.release.mediums",
            emitted_keys={'id': 1},
            expected_sql='SELECT musicbrainz.recording.id AS musicbrainz_recording_id \nFROM musicbrainz.recording JOIN musicbrainz.track AS track_1 ON musicbrainz.recording.id = track_1.recording JOIN musicbrainz.medium AS medium_1 ON medium_1.id = track_1.medium JOIN musicbrainz.release AS release_1 ON release_1.id = medium_1.release JOIN musicbrainz.medium ON release_1.id = musicbrainz.medium.release \nWHERE musicbrainz.medium.id = :id_1',
        )

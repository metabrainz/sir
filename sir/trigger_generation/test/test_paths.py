import unittest
from sir.trigger_generation.paths import generate_query
from sir.schema import SCHEMA


class PathsTestCase(unittest.TestCase):

    def test_generate_selection(self):

        def validate_selection(core_name, path, expected_sql):
            select_sql = str(generate_query(SCHEMA[core_name].model, path))
            self.assertEqual(select_sql, expected_sql)

        validate_selection(
            core_name="release-group",
            path="releases",
            expected_sql='SELECT musicbrainz.release_group.id AS musicbrainz_release_group_id \nFROM musicbrainz.release_group JOIN musicbrainz.release ON musicbrainz.release_group.id = musicbrainz.release.release_group',
        )
        validate_selection(
            core_name="annotation",
            path="releases.release",
            expected_sql='SELECT musicbrainz.annotation.id AS musicbrainz_annotation_id \nFROM musicbrainz.annotation JOIN musicbrainz.release_annotation ON musicbrainz.annotation.id = musicbrainz.release_annotation.annotation JOIN musicbrainz.release ON musicbrainz.release.id = musicbrainz.release_annotation.release',
        )
        validate_selection(
            core_name="release-group",
            path="artist_credit.artists",
            expected_sql='SELECT musicbrainz.release_group.id AS musicbrainz_release_group_id \nFROM musicbrainz.release_group JOIN musicbrainz.artist_credit ON musicbrainz.artist_credit.id = musicbrainz.release_group.artist_credit JOIN musicbrainz.artist_credit_name ON musicbrainz.artist_credit.id = musicbrainz.artist_credit_name.artist_credit',
        )
        validate_selection(
            core_name="recording",
            path="artist_credit.artists",
            expected_sql='SELECT musicbrainz.recording.id AS musicbrainz_recording_id \nFROM musicbrainz.recording JOIN musicbrainz.artist_credit ON musicbrainz.artist_credit.id = musicbrainz.recording.artist_credit JOIN musicbrainz.artist_credit_name ON musicbrainz.artist_credit.id = musicbrainz.artist_credit_name.artist_credit',
        )
        validate_selection(
            core_name="artist",
            path="artist_credit_names",
            expected_sql='SELECT musicbrainz.artist.id AS musicbrainz_artist_id \nFROM musicbrainz.artist JOIN musicbrainz.artist_credit_name ON musicbrainz.artist.id = musicbrainz.artist_credit_name.artist',
        )
        validate_selection(
            core_name="recording",
            path="artist_credit",
            expected_sql='SELECT musicbrainz.recording.id AS musicbrainz_recording_id \nFROM musicbrainz.recording JOIN musicbrainz.artist_credit ON musicbrainz.artist_credit.id = musicbrainz.recording.artist_credit',
        )

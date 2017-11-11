import unittest
from sir.trigger_generation import paths
from sir.schema import SCHEMA


class PathsTestCase(unittest.TestCase):

    def test_generate_selection(self):

        def validate_selection(core_name, path, expected_sql, expected_pk):
            select_sql, last_pk_name = paths.generate_selection(SCHEMA[core_name].model, path)
            self.assertEqual(select_sql, expected_sql)
            self.assertEqual(last_pk_name, expected_pk)

        validate_selection(
            core_name="release-group",
            path="releases",
            expected_sql="SELECT release.release_group FROM musicbrainz.release WHERE release.id IN (:ids)",
            expected_pk="id",
        )
        validate_selection(
            core_name="annotation",
            path="releases.release",
            expected_sql="SELECT release_annotation.annotation FROM musicbrainz.release_annotation WHERE release_annotation.release IN (SELECT release_annotation.release FROM musicbrainz.release_annotation WHERE release_annotation.release IN (:ids))",
            expected_pk="id",
        )
        validate_selection(
            core_name="release-group",
            path="artist_credit.artists",
            expected_sql="SELECT release_group.id FROM musicbrainz.release_group WHERE release_group.artist_credit IN (SELECT artist_credit_name.artist_credit FROM musicbrainz.artist_credit_name WHERE artist_credit_name.artist_credit IN (:ids))",
            expected_pk="artist_credit",
        )
        validate_selection(
            core_name="recording",
            path="artist_credit.artists",
            expected_sql="SELECT recording.id FROM musicbrainz.recording WHERE recording.artist_credit IN (SELECT artist_credit_name.artist_credit FROM musicbrainz.artist_credit_name WHERE artist_credit_name.artist_credit IN (:ids))",
            expected_pk="artist_credit",
        )
        validate_selection(
            core_name="artist",
            path="artist_credit_names",
            expected_sql="SELECT artist_credit_name.artist FROM musicbrainz.artist_credit_name WHERE artist_credit_name.artist_credit IN (:ids)",
            expected_pk="artist_credit",
        )
        validate_selection(
            core_name="recording",
            path="artist_credit",
            expected_sql="SELECT recording.id FROM musicbrainz.recording WHERE recording.artist_credit IN (:ids)",
            expected_pk="id",
        )

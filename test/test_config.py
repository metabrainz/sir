import os
import unittest

from sir import config


class ConfigParserTest(unittest.TestCase):

    def test_interpolation(self):
        os.environ["SKIP"] = "foobar"
        os.environ["PGPASSWORD"] = "dummy password"
        config.read_config()
        self.assertEqual(config.CFG["database"]["host"], "musicbrainz_db")
        self.assertEqual(config.CFG["database"]["password"], "dummy password")
        self.assertEqual(config.CFG["solr"]["uri"], "foobar")

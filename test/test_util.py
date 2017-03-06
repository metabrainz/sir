import mock
import unittest

from test.models import B
from json import dumps
from sir import util
from sir.schema import searchentities


def noop(*args, **kwargs):
    pass


class VersionCheckerTest(unittest.TestCase):
    def setUp(self):
        urlopen = mock.patch("sir.util.urllib2.urlopen")
        urlopenmock = urlopen.start()
        self.addCleanup(urlopen.stop)

        self.read = mock.Mock()
        urlopenmock.return_value.read = self.read

        schema = mock.patch.dict("sir.schema.SCHEMA",
                                 {"testcore":
                                  searchentities.SearchEntity(
                                      B,
                                      [searchentities.SearchField("id", "id")],
                                      1.1,
                                      noop)})
        schema.start()
        self.addCleanup(schema.stop)

        config = mock.patch("sir.util.config.CFG")
        config.return_value = ""
        config.start()
        self.addCleanup(config.stop)

    def test_matching_version(self):
        self.read.return_value = dumps({"version": 1.1})
        util.solr_version_check("testcore")

    def test_solr_version_too_large(self):
        self.read.return_value = dumps({"version": 1.2})
        self.assertRaisesRegexp(util.VersionMismatchException,
                                "^testcore: Expected 1.1, got 1.2",
                                util.solr_version_check,
                                "testcore")

    def test_solr_version_too_small(self):
        self.read.return_value = dumps({"version": 1.0})
        self.assertRaisesRegexp(util.VersionMismatchException,
                                "^testcore: Expected 1.1, got 1.0",
                                util.solr_version_check,
                                "testcore")

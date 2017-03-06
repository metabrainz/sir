import doctest
import mock
import unittest

from test import helpers, models
from collections import defaultdict
from sir.querying import iterate_path_values
from sir.schema.searchentities import defer_everything_but, merge_paths


class DeferEverythingButTest(unittest.TestCase):
    def setUp(self):
        mapper = helpers.Object()
        mapper.iterate_properties = []
        pk1 = helpers.Object()
        pk1.name = "pk1"
        pk2 = helpers.Object()
        pk2.name = "pk2"
        mapper.primary_key = [pk1, pk2]

        self.mapper = mapper

        prop = helpers.Object()
        prop.columns = ""
        self.prop = prop
        self.mapper.iterate_properties.append(prop)

        self.load = mock.Mock()
        self.required_columns = ["key", "key2"]

    def test_plain_column_called(self):
        self.prop.key = "foo"
        load = defer_everything_but(self.mapper, self.load, *self.required_columns)
        load.defer.assert_called_once_with("foo")

    def test_plain_column_not_called(self):
        self.prop.key = "key"
        load = defer_everything_but(self.mapper, self.load, *self.required_columns)
        self.assertFalse(load.defer.called)

    def test_id_column(self):
        self.prop.key = "foo_id"
        load = defer_everything_but(self.mapper, self.load,
                                    *self.required_columns)
        self.assertFalse(load.defer.called)

    def test_position_column(self):
        self.prop.key = "position"
        load = defer_everything_but(self.mapper, self.load,
                                    *self.required_columns)
        self.assertFalse(load.defer.called)

    def test_primary_key_always_loaded(self):
        self.prop.key = "pk1"
        load = defer_everything_but(self.mapper, self.load,
                                    *self.required_columns)
        self.assertFalse(load.defer.called)


class IteratePathValuesTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        c = models.C(id=1)
        c.bs.append(models.B(id=1))
        c.bs.append(models.B(id=2))
        cls.c = c
        cls.c_path = "bs.id"

        b = models.B(id=1)
        b.c = models.C(id=1)
        cls.b = b
        cls.b_path = "c.id"

    def test_one_to_many(self):
        res = list(iterate_path_values(self.c_path, self.c))
        self.assertEqual(res, [1, 2])

    def test_attribute_without_relationship(self):
        res = list(iterate_path_values("id", self.c))
        self.assertEqual(res, [1])

    def test_many_to_one(self):
        res = list(iterate_path_values(self.b_path, self.b))
        self.assertEqual(res, [1])

    def test_non_sqlalchemy_paths(self):
        res = list(iterate_path_values("__tablename__", self.c))
        self.assertEqual(res, [models.C.__tablename__])


class MergePathsTest(unittest.TestCase):
    def test_dotless_path(self):
        paths = [["id"], ["name"]]
        expected = {"id": "", "name": ""}
        self.assertEquals(merge_paths(paths), expected)

    def test_dotted_path(self):
        paths = [["rel.id"], ["rel2.rel3.id"]]
        expected = {
            "rel": defaultdict(set, id=""),
            "rel2": defaultdict(set,
                                rel3=defaultdict(set,
                                                 id=""
                                                 )
                                )
        }
        self.assertEqual(dict(merge_paths(paths)), expected)


def load_tests(loader, tests, ignore):
    from sir import querying
    tests.addTests(doctest.DocTestSuite(querying))
    return tests

import doctest
from unittest import mock, TestCase

from test import models
from collections import defaultdict
from sqlalchemy.orm.properties import RelationshipProperty
from sir.querying import iterate_path_values
from sir.schema.searchentities import defer_everything_but, merge_paths
from sir.schema import generate_update_map, SCHEMA
from sir.trigger_generation.paths import second_last_model_in_path


class DeferEverythingButTest(TestCase):

    @mock.patch("sir.schema.searchentities.defer")
    def test_defer_everything_but(self, mock_defer):
        mapper = models.D.__mapper__
        original_load = mock.Mock()
        required_columns = ["key", "key2"]
        defer_everything_but(
            mapper,
            original_load,
            *required_columns
        )
        original_load.options.assert_called()
        mock_defer.assert_called_once_with(
            mapper.get_property("foo"),
            raiseload=True
        )


class IteratePathValuesTest(TestCase):
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


class MergePathsTest(TestCase):
    def test_dotless_path(self):
        paths = [["id"], ["name"]]
        expected = {"id": "", "name": ""}
        self.assertEqual(merge_paths(paths), expected)

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


class DBTest(TestCase):
    def test_non_composite_fk(self):
        paths, _, models, _ = generate_update_map()
        for table_paths in paths.values():
            for core_name, path in table_paths:
                model, _ = second_last_model_in_path(SCHEMA[core_name].model, path)
                if path:
                    prop_name = path.split(".")[-1]
                    try:
                        prop = getattr(model, prop_name).prop
                    except AttributeError:
                        pass
                    else:
                        if isinstance(prop, RelationshipProperty):
                            if prop.direction.name == 'MANYTOONE':
                                self.assertEqual(len(prop.local_columns), 1)


def load_tests(loader, tests, ignore):
    from sir import querying
    tests.addTests(doctest.DocTestSuite(querying))
    return tests

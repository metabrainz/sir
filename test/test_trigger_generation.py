import unittest

from . import models
from sir.trigger_generation import (unique_split_paths,
                                    walk_path,
                                    OneToManyPathPart,
                                    ManyToOnePathPart,
                                    ColumnPathPart)


class UniqueSplitPathsTest(unittest.TestCase):
    def run_test(self, paths, expected):
        res = list(unique_split_paths(paths))
        self.assertEqual(res, expected)

    def test_not_dotted_paths(self):
        paths = ["a", "b"]
        expected = ["a", "b"]
        self.run_test(paths, expected)

    def test_dotted_paths(self):
        paths = ["a.b.c", "e.f"]
        expected = [
            "a", "a.b", "a.b.c",
            "e", "e.f",
        ]

        self.run_test(paths, expected)

    def test_unique_paths(self):
        paths = ["a.b.c", "a.b.d"]
        expected = [
            "a", "a.b", "a.b.c",
            "a.b.d"
        ]

        self.run_test(paths, expected)


class WalkPathTest(unittest.TestCase):
    def test_many_to_one(self):
        path = "c.bar"
        model = models.B
        result, table = walk_path(model, path)
        self.assertTrue(isinstance(result, ManyToOnePathPart))
        self.assertTrue(isinstance(result.inner, ManyToOnePathPart))
        self.assertTrue(isinstance(result.inner.inner, ColumnPathPart))
        self.assertEqual(result.render(),
        "SELECT id FROM table_b WHERE c = (SELECT id FROM table_c WHERE id"
        " = ({new_or_old}.id))")
        self.assertEqual(table, "table_c")

    def test_many_to_one_and_one_to_many_returns_None(self):
        path = "c.bs"
        model = models.B
        result, table = walk_path(model, path)
        self.assertTrue(result is None)
        self.assertTrue(table is None)

    def test_many_to_one_no_column(self):
        path = "c"
        model = models.B
        result, table = walk_path(model, path)
        self.assertTrue(isinstance(result, ManyToOnePathPart))
        self.assertTrue(isinstance(result.inner, ColumnPathPart))
        self.assertEqual(result.render(),
        "SELECT id FROM table_b WHERE c = ({new_or_old}.id)")
        self.assertEqual(table, "table_b")

    def test_one_to_many(self):
        path = "bs.foo"
        model = models.C
        result, table = walk_path(model, path)
        self.assertTrue(isinstance(result, OneToManyPathPart))
        self.assertTrue(isinstance(result.inner, ManyToOnePathPart))
        self.assertTrue(isinstance(result.inner.inner, ColumnPathPart))
        self.assertEqual(result.render(),
        "SELECT id FROM table_c WHERE id IN (SELECT id FROM table_b WHERE id ="
        " ({new_or_old}.id))")
        self.assertEqual(table, "table_b")

    def test_one_to_many_and_many_to_one_returns_None(self):
        path = "bs.c"
        model = models.C
        result, table = walk_path(model, path)
        self.assertTrue(result is None)
        self.assertTrue(table is None)

    def test_one_to_many_no_column(self):
        path = "bs"
        model = models.C
        result, table = walk_path(model, path)
        self.assertTrue(isinstance(result, OneToManyPathPart))
        self.assertTrue(isinstance(result.inner, ColumnPathPart))
        self.assertEqual(result.render(),
        "SELECT id FROM table_c WHERE id IN "
        "({new_or_old}.c)")
        self.assertEqual(table, "table_b")

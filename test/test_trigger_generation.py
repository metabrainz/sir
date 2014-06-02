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
        path = "c"
        model = models.B
        result, table = walk_path(model, path)
        self.assertTrue(isinstance(result, ManyToOnePathPart))
        self.assertTrue(isinstance(result.inner, ColumnPathPart))
        self.assertEqual(result.render(),
        "SELECT id FROM table_b WHERE c = ({new_or_old}.id)")
        self.assertEqual(table, "table_c")

    def test_many_to_one_column_returns_none(self):
        path = "c.id"
        model = models.B
        result, table = walk_path(model, path)
        self.assertTrue(result is None)
        self.assertTrue(table is None)

    def test_one_to_many(self):
        path = "bs"
        model = models.C
        result, table = walk_path(model, path)
        self.assertTrue(isinstance(result, OneToManyPathPart))
        self.assertTrue(isinstance(result.inner, ColumnPathPart))
        self.assertEqual(result.render(),
        "SELECT id FROM table_c WHERE id IN ({new_or_old}.c)")
        self.assertEqual(table, "table_b")

    def test_one_to_many_column_returns_none(self):
        path = "bs.id"
        model = models.C
        result, table = walk_path(model, path)
        self.assertTrue(result is None)
        self.assertTrue(table is None)

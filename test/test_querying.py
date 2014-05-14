import unittest

from . import models
from collections import defaultdict
from sir.querying import _iterate_path_values, merge_paths


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
        res = list(_iterate_path_values(self.c_path, self.c))
        self.assertEqual(res, [1, 2])

    def test_attribute_without_relationship(self):
        res = list(_iterate_path_values("id", self.c))
        self.assertEqual(res, [1])

    def test_many_to_one(self):
        res = list(_iterate_path_values(self.b_path, self.b))
        self.assertEqual(res, [1])


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
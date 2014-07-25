import unittest

from . import models
from sir.schema.searchentities import SearchEntity as E, SearchField as F


class QueryResultToDictTest(unittest.TestCase):
    def setUp(self):
        self.entity = E(models.B, [
            F("id", "id"),
            F("c_bar", "c.bar"),
            F("c_bar_trans", "c.bar", transformfunc=lambda v:
                v.union(set(["yay"])))
        ],
            1.1
        )
        self.expected = {
            "id": 1,
            "c_bar": "foo",
            "c_bar_trans": set(["foo", "yay"]),
        }
        c = models.C(id=2, bar="foo")
        self.val = models.B(id=1, c=c)

    def test_fields(self):
        res = self.entity.query_result_to_dict(self.val)
        self.assertDictEqual(self.expected, res)

import unittest

from mbdata.types import PartialDate
from sir.wscompat.convert import partialdate_to_string


class PartialDateConverterTest(unittest.TestCase):
    def do(self, input, expected):
        output = partialdate_to_string(input)
        self.assertEqual(output, expected)

    def test_missing_year(self):
        ds = [PartialDate(month=1, day=1),
              PartialDate(day=1),
              PartialDate(month=1),
              PartialDate()]

        for d in ds:
            self.do(d, "")

    def test_valid_partialdates(self):
        ds = [(PartialDate(1), "0001"),
              (PartialDate(1,2), "0001-02"),
              (PartialDate(1,2,3), "0001-02-03")]

        for d, expected in ds:
            self.do(d, expected)

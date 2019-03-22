#!/usr/bin/env python
# coding: utf-8
# Copyright (c) 2014, 2017 Wieland Hoffmann, MetaBrainz Foundation
import unittest

from mbdata.models import MediumFormat
from mbdata.types import PartialDate
from mock import MagicMock
from sir.wscompat.convert import (
    calculate_type,
    convert_format,
    partialdate_to_string,
)


class MediumFormatConverterTest(unittest.TestCase):
    def do(self, input, expected):
        output = convert_format(MediumFormat(name=input)).get_valueOf_()
        self.assertEqual(output, expected)

    def test_medium_formats(self):
        ds = [('3.5" Floppy Disk', '3-5-floppy-disk'),
              ('8cm CD+G', '8cm-cd-g'),
              ('DVDplus (CD side)', 'dvdplus-cd-side'),
              ('Pathé disc', 'pathe-disc')]

        for d, expected in ds:
            self.do(d, expected)


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


class OldTypeCalculatorTest(unittest.TestCase):

    def do(self, primary_type, secondary_types, expected):
        output = calculate_type(primary_type, secondary_types)
        self.assertEqual(output.name, expected)

    def _create_type_object(self, name):
        type_ = MagicMock()
        type_.name = name
        return type_

    def _create_secondary_types(self, secondary_type_list):
        secondary_types = []
        for type_ in secondary_type_list:
            secondary_type = MagicMock()
            secondary_type.secondary_type = self._create_type_object(type_)
            secondary_types.append(secondary_type)
        return secondary_types

    def test_non_album_type(self):
        primary_type_list = ["Random", "ABCDE", "Test"]
        secondary_types = ["Concert", "Remix", "Compilation", "Live"]

        for primary_type in primary_type_list:
            self.do(self._create_type_object(primary_type),
                    self._create_secondary_types(secondary_types),
                    primary_type)

    def test_album_type(self):
        primary_type = self._create_type_object('Album')
        secondary_type_lists = [
            ['Concert', 'Remix', 'Random'],
            ['Random', 'ABCDE'],
            ['Compilation', 'Remix'],
            ['Remix', 'Compilation'],
            ['Live', 'Interview', 'Random', 'Compilation'],
            ['Live', 'Soundtrack', 'Interview']
        ]
        excepted_outputs = ['Remix', 'Album', 'Compilation', 'Compilation',
                            'Compilation', 'Soundtrack']
        for secondary_type_list, excepted_output in zip(secondary_type_lists,
                                                        excepted_outputs):
            secondary_types = self._create_secondary_types(secondary_type_list)
            self.do(primary_type, secondary_types, excepted_output)

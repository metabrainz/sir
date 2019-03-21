import unittest
import xml.etree.ElementTree as ElementTree

from mbdata.types import PartialDate
from mock import MagicMock
from sir.wscompat.convert import (
    convert_name_credit,
    partialdate_to_string,
    calculate_type,
)


def xml_elements_equal(e1, e2):
    if (e1.tag != e2.tag or
            (e1.text or '').strip() != (e2.text or '').strip() or
            (e1.tail or '').strip() != (e2.tail or '').strip() or
            e1.attrib != e2.attrib or
            len(e1) != len(e2)):
        return False
    return all(xml_elements_equal(c1, c2) for c1, c2 in zip(e1, e2))


class NameCreditConverterTest(unittest.TestCase):
    def do(self, input, expected, include_aliases=False):
        output = convert_name_credit(input, include_aliases).to_etree()
        expected_xml = ElementTree.fromstring(expected)
        self.assertTrue(xml_elements_equal(output, expected_xml))

    def _create_artist(self, gid, name, sort_name):
        artist = MagicMock()
        artist.gid = gid
        artist.name = name
        artist.sort_name = sort_name
        artist.comment = None
        return artist

    def _create_credit_name(self, artist, name=None, join_phrase=None):
        credit_name = MagicMock()
        credit_name.artist = artist
        credit_name.name = name
        credit_name.join_phrase = join_phrase
        return credit_name

    def test_credit_name(self):
        artist = self._create_artist(
            gid='b7ffd2af-418f-4be2-bdd1-22f8b48613da',
            name='Nine Inch Nails',
            sort_name='Nine Inch Nails',
        )
        credit_name = self._create_credit_name(artist=artist)
        expected_credit_name = '''
        <name-credit xmlns="http://musicbrainz.org/ns/mmd-2.0#">
            <artist id="b7ffd2af-418f-4be2-bdd1-22f8b48613da">
                <name>Nine Inch Nails</name>
                <sort-name>Nine Inch Nails</sort-name>
            </artist>
        </name-credit>
        '''
        self.do(input=credit_name, expected=expected_credit_name)

    def test_credit_name_with_join_phrase_and_name_credit(self):
        artist = self._create_artist(
            gid='b7ffd2af-418f-4be2-bdd1-22f8b48613da',
            name='Nine Inch Nails',
            sort_name='Nine Inch Nails',
        )
        credit_name = self._create_credit_name(
            artist=artist,
            name='NIN',
            join_phrase=' and friends',
        )
        expected_credit_name = '''
        <name-credit xmlns="http://musicbrainz.org/ns/mmd-2.0#" 
                     joinphrase=" and friends">
            <name>NIN</name>
            <artist id="b7ffd2af-418f-4be2-bdd1-22f8b48613da">
                <name>Nine Inch Nails</name>
                <sort-name>Nine Inch Nails</sort-name>
            </artist>
        </name-credit>
        '''
        self.do(input=credit_name, expected=expected_credit_name)


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
              (PartialDate(1, 2), "0001-02"),
              (PartialDate(1, 2, 3), "0001-02-03")]

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

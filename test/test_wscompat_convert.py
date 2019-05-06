import unittest
import xml.etree.ElementTree as ElementTree

from mbdata.models import (
    Artist,
    ArtistCreditName,
    ArtistISNI,
    LabelISNI,
    ReleaseGroupSecondaryType,
    ReleaseGroupSecondaryTypeJoin,
    ReleasePackaging,
)
from mbdata.types import PartialDate
from sir.wscompat.convert import (
    convert_isni_list,
    convert_name_credit,
    convert_release_packaging,
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


class IsniListConverterTest(unittest.TestCase):
    """Test that ISNI lists are converted correctly."""

    def check_isni_list(self, actual, expected):
        output = convert_isni_list(actual).to_etree()
        expected_xml = ElementTree.fromstring(expected)
        self.assertTrue(xml_elements_equal(output, expected_xml))

    def _create_isni_list(self, isni_class, only_isni_list):
        isni_list = []
        for only_isni in only_isni_list:
            isni = isni_class()
            isni.isni = only_isni
            isni_list.append(isni)
        return isni_list

    def test_artist_isni_list(self):
        artist_isni_list = self._create_isni_list(
            isni_class=ArtistISNI,
            only_isni_list=[u'000000005705334X',
                            u'0000000078243206',
                            u'0000000041815776'],
        )
        expected_artist_isni_list = '''
        <isni-list xmlns="http://musicbrainz.org/ns/mmd-2.0#">
            <isni>000000005705334X</isni>
            <isni>0000000078243206</isni>
            <isni>0000000041815776</isni>
        </isni-list>
        '''
        self.check_isni_list(
            actual=artist_isni_list,
            expected=expected_artist_isni_list,
        )

    def test_label_isni_list(self):
        label_isni_list = self._create_isni_list(
            isni_class=LabelISNI,
            only_isni_list=[u'000000011781560X'],
        )
        expected_label_isni_list = '''
        <isni-list xmlns="http://musicbrainz.org/ns/mmd-2.0#">
            <isni>000000011781560X</isni>
        </isni-list>
        '''
        self.check_isni_list(
            actual=label_isni_list,
            expected=expected_label_isni_list,
        )


class NameCreditConverterTest(unittest.TestCase):
    """Test that name-credit elements are built correctly."""

    def check_name_credit(self, actual, expected, include_aliases=False):
        output = convert_name_credit(actual, include_aliases).to_etree()
        expected_xml = ElementTree.fromstring(expected)
        self.assertTrue(xml_elements_equal(output, expected_xml))

    def _create_artist(self, gid, name, sort_name):
        artist = Artist()
        artist.gid = gid
        artist.name = name
        artist.sort_name = sort_name
        artist.comment = None
        return artist

    def _create_credit_name(self, artist, name=None, join_phrase=None):
        credit_name = ArtistCreditName
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
        self.check_name_credit(actual=credit_name, expected=expected_credit_name)

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
        self.check_name_credit(actual=credit_name, expected=expected_credit_name)


class PartialDateConverterTest(unittest.TestCase):
    """Test that partial dates are converted and/or skipped correctly."""

    def check_partial_dates(self, actual, expected):
        output = partialdate_to_string(actual)
        self.assertEqual(output, expected)

    def test_missing_year(self):
        ds = [PartialDate(month=1, day=1),
              PartialDate(day=1),
              PartialDate(month=1),
              PartialDate()]

        for d in ds:
            self.check_partial_dates(d, "")

    def test_valid_partialdates(self):
        ds = [(PartialDate(1), "0001"),
              (PartialDate(1, 2), "0001-02"),
              (PartialDate(1, 2, 3), "0001-02-03")]

        for d, expected in ds:
            self.check_partial_dates(d, expected)


class OldTypeCalculatorTest(unittest.TestCase):
    """Test the correct legacy type is picked from the RG type list."""

    def check_legacy_type(self, primary_type, secondary_types, expected):
        output = calculate_type(primary_type, secondary_types)
        self.assertEqual(output.name, expected)

    def _create_type_object(self, name):
        type_ = ReleaseGroupSecondaryType()
        type_.name = name
        return type_

    def _create_secondary_types(self, secondary_type_list):
        secondary_types = []
        for type_ in secondary_type_list:
            secondary_type = ReleaseGroupSecondaryTypeJoin()
            secondary_type.secondary_type = self._create_type_object(type_)
            secondary_types.append(secondary_type)
        return secondary_types

    def test_non_album_type(self):
        primary_type_list = ["Random", "ABCDE", "Test"]
        secondary_types = ["Concert", "Remix", "Compilation", "Live"]

        for primary_type in primary_type_list:
            self.check_legacy_type(self._create_type_object(primary_type),
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
            self.check_legacy_type(primary_type, secondary_types, excepted_output)


class ReleasePackagingConverterTest(unittest.TestCase):
    """Test that release packagings are converted correctly."""

    def check_release_packaging(self, actual, expected):
        output = convert_release_packaging(actual).to_etree()
        expected_xml = ElementTree.fromstring(expected)
        self.assertTrue(xml_elements_equal(output, expected_xml))

    def _create_release_packaging(self, gid, name):
        release_packaging = ReleasePackaging
        release_packaging.gid = gid
        release_packaging.name = name
        return release_packaging

    def test_release_packaging(self):
        release_packaging = self._create_release_packaging(
            gid='ec27701a-4a22-37f4-bfac-6616e0f9750a',
            name='Jewel Case',
        )
        expected_release_packaging = '''
        <packaging xmlns="http://musicbrainz.org/ns/mmd-2.0#"
                   id="ec27701a-4a22-37f4-bfac-6616e0f9750a"
        >Jewel Case</packaging>
        '''
        self.check_release_packaging(
            actual=release_packaging,
            expected=expected_release_packaging,
        )

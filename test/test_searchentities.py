import mock
import unittest

from test import models
from xml.etree.ElementTree import Element, tostring
from sir.schema.searchentities import (SearchEntity as E, SearchField as F,
                                       is_composite_column)
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker


class QueryResultToDictTest(unittest.TestCase):
    def setUp(self):
        config_patcher = mock.patch("sir.config.CFG")
        self.addCleanup(config_patcher.stop)
        instance = config_patcher.start()
        instance.getboolean.return_value = True
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

    def test_conversion(self):
        elem = Element("testelem", text="text")
        convmock = mock.Mock()
        convmock.to_etree.return_value = elem
        self.entity.compatconverter = lambda x: convmock

        res = self.entity.query_result_to_dict(self.val)

        self.expected["_store"] = tostring(elem)
        self.assertDictEqual(self.expected, res)
        self.assertEqual(convmock.to_etree.call_count, 1)


class TestIsCompositeColumn(unittest.TestCase):
    def test_composite_column(self):
        self.assertTrue(is_composite_column(models.B, "composite_column"))

    def test_not_sqla_column(self):
        self.assertFalse(is_composite_column(models.B, "__tablename__"))

    def test_sqla_column(self):
        self.assertFalse(is_composite_column(models.B, "c"))


class SearchEntityTest(unittest.TestCase):
    FILTER_MAX = 20

    @staticmethod
    def filter_query(query):
        query = query.filter(models.B.id <= SearchEntityTest.FILTER_MAX)
        return query

    @classmethod
    def setUpClass(cls):
        cls.engine = create_engine("sqlite:///:memory:")
        cls.conn = cls.engine.connect()
        models.Base.metadata.create_all(cls.engine)

    def setUp(self):
        self.trans = self.conn.begin()
        Session = sessionmaker(bind=self.conn)
        self.session = Session()

    def tearDown(self):
        self.session.close()
        self.trans.rollback()

    @classmethod
    def tearDownClass(cls):
        cls.conn.close()

    @mock.patch("sir.config.CFG")
    def test_extraquery(self, mock):
        mock.getboolean.return_value = False
        searchentity_b = E(models.B,
                           [F("id", "id")],
                           1.0,
                           extraquery=self.filter_query)

        # Add some objects
        session = self.session
        session.add_all([models.B(id=i) for i in range(1, 30)])
        session.commit()

        # Retrieve them and make sure we only get 20
        query = searchentity_b.query.with_session(session)
        self.assertEqual(len(query.all()), self.FILTER_MAX)

import unittest
from collections import namedtuple

from sir.amqp.message import (InvalidPendingRowException,
                               Message,
                               _normalize_table_name)


PendingRow = namedtuple('PendingRow', ['seqid', 'xid', 'tablename', 'op', 'olddata', 'newdata'])


class NormalizeTableNameTest(unittest.TestCase):

    def test_schema_qualified(self):
        self.assertEqual(_normalize_table_name('"musicbrainz"."artist"'), "artist")

    def test_unqualified(self):
        self.assertEqual(_normalize_table_name("artist"), "artist")

    def test_schema_qualified_no_quotes(self):
        self.assertEqual(_normalize_table_name("musicbrainz.artist"), "artist")


class MessageFromPendingRowTest(unittest.TestCase):

    def test_insert(self):
        row = PendingRow(
            seqid=1, xid=100,
            tablename='"musicbrainz"."artist"',
            op='i',
            olddata=None,
            newdata={"id": 42, "gid": "abc-123", "name": "Test Artist"},
        )
        msg = Message.from_pending_row(row)
        self.assertEqual(msg.table_name, "artist")
        self.assertEqual(msg.operation, "insert")
        self.assertEqual(msg.columns["id"], 42)
        self.assertEqual(msg.columns["gid"], "abc-123")
        self.assertEqual(msg.seqid, 1)
        self.assertEqual(msg.xid, 100)

    def test_update(self):
        row = PendingRow(
            seqid=2, xid=101,
            tablename='"musicbrainz"."artist"',
            op='u',
            olddata={"id": 42, "name": "Old Name"},
            newdata={"id": 42, "name": "New Name"},
        )
        msg = Message.from_pending_row(row)
        self.assertEqual(msg.table_name, "artist")
        self.assertEqual(msg.operation, "update")
        self.assertEqual(msg.columns["name"], "New Name")

    def test_delete(self):
        row = PendingRow(
            seqid=3, xid=102,
            tablename='"musicbrainz"."artist"',
            op='d',
            olddata={"id": 42, "gid": "abc-123", "name": "Deleted"},
            newdata=None,
        )
        msg = Message.from_pending_row(row)
        self.assertEqual(msg.table_name, "artist")
        self.assertEqual(msg.operation, "delete")
        self.assertEqual(msg.columns["gid"], "abc-123")

    def test_columns_are_passed_through(self):
        """psycopg2 deserializes JSON columns into dicts automatically."""
        row = PendingRow(
            seqid=4, xid=103,
            tablename='"musicbrainz"."artist"',
            op='i',
            olddata=None,
            newdata={"id": 42, "name": "Test"},
        )
        msg = Message.from_pending_row(row)
        self.assertEqual(msg.columns["id"], 42)
        self.assertEqual(msg.columns["name"], "Test")

    def test_unknown_op_raises(self):
        row = PendingRow(
            seqid=5, xid=104,
            tablename='"musicbrainz"."artist"',
            op='x',
            olddata=None,
            newdata={"id": 1},
        )
        self.assertRaises(InvalidPendingRowException, Message.from_pending_row, row)

    def test_delete_without_olddata_raises(self):
        row = PendingRow(
            seqid=6, xid=105,
            tablename='"musicbrainz"."artist"',
            op='d',
            olddata=None,
            newdata=None,
        )
        self.assertRaises(InvalidPendingRowException, Message.from_pending_row, row)

    def test_insert_without_newdata_raises(self):
        row = PendingRow(
            seqid=7, xid=106,
            tablename='"musicbrainz"."artist"',
            op='i',
            olddata=None,
            newdata=None,
        )
        self.assertRaises(InvalidPendingRowException, Message.from_pending_row, row)

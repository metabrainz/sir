#!/usr/bin/env python
# Copyright (c) 2014 Wieland Hoffmann, MetaBrainz Foundation
# License: MIT, see LICENSE for details
"""
This module contains functions and classes to parse and represent the content
of a pending_data row from dbmirror2.
"""

OP_TO_OPERATION = {
    "i": "insert",
    "u": "update",
    "d": "delete",
}


def _normalize_table_name(tablename):
    """
    Strip the schema prefix from a dbmirror2 table name.

    dbmirror2 stores schema-qualified names like ``"musicbrainz"."artist"``.
    The update_map uses unqualified names like ``artist``.

    :param str tablename: Schema-qualified table name from dbmirror2.
    :rtype: str
    """
    # Remove surrounding quotes and take the last part after the dot
    parts = tablename.replace('"', '').split(".")
    return parts[-1]


class Message(object):
    """
    A parsed message from a ``sir.pending_data`` row.
    """

    def __init__(self, table_name, columns, operation, seqid, xid,
                 changed_columns=None):
        """
        :param str table_name: Unqualified table name.
        :param dict columns: Dictionary mapping column names to their values.
        :param str operation: One of ``insert``, ``update``, ``delete``.
        :param int seqid: Sequence ID from pending_data.
        :param int xid: Transaction ID from pending_data.
        :param set changed_columns: For updates, the set of columns whose
            values actually changed. None for inserts/deletes.
        """
        self.table_name = table_name
        self.columns = columns
        self.operation = operation
        self.seqid = seqid
        self.xid = xid
        self.changed_columns = changed_columns

    @classmethod
    def from_pending_row(cls, row):
        """
        Parse a row from ``sir.pending_data``.

        :param row: A database row with columns: seqid, xid, tablename, op,
                    olddata, newdata.
        :rtype: :class:`Message`
        """
        table_name = _normalize_table_name(row.tablename)
        operation = OP_TO_OPERATION.get(row.op)
        if operation is None:
            raise InvalidPendingRowException(
                "Unknown operation: %s" % row.op)

        if operation == "delete":
            if row.olddata is None:
                raise InvalidPendingRowException(
                    "olddata is NULL for delete operation (seqid=%s)" % row.seqid)
            data = row.olddata
        else:
            if row.newdata is None:
                raise InvalidPendingRowException(
                    "newdata is NULL for %s operation (seqid=%s)" % (operation, row.seqid))
            data = row.newdata

        changed_columns = None
        if operation == "update" and row.olddata and row.newdata:
            changed_columns = {
                col for col in row.newdata
                if col not in row.olddata or row.newdata[col] != row.olddata[col]
            }

        return cls(table_name, data, operation, row.seqid, row.xid,
                   changed_columns)


class InvalidPendingRowException(ValueError):
    """
    Exception indicating an error with the content of a pending_data row.
    """
    pass

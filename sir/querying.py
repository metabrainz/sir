# Copyright (c) 2014 Lukas Lalinsky, Wieland Hoffmann
# License: MIT, see LICENSE for details
import logging


from sqlalchemy import func
from sqlalchemy.orm.interfaces import ONETOMANY, MANYTOONE
from sqlalchemy.orm.properties import RelationshipProperty

logger = logging.getLogger("sir")


def _iterate_path_values(path, obj):
    if obj is None:
        return

    if '.' in path:
        pathelem, rest = path.split('.', 1)
    else:
        pathelem, rest = path, None

    prop = getattr(obj.__class__, pathelem).property
    if isinstance(prop, RelationshipProperty):
        if prop.direction == ONETOMANY:
            for sub_obj in getattr(obj, pathelem):
                for val in _iterate_path_values(rest, sub_obj):
                    yield val
        elif prop.direction == MANYTOONE:
            for val in _iterate_path_values(rest, getattr(obj, pathelem)):
                yield val
    else:
        yield getattr(obj, pathelem)


def iter_bounds(db_session, column, batch_size, importlimit):
    """
    Return a list of (lower bound, upper bound) tuples which contain row ids to
    iterate through a table in batches of ``batch_size``. If ``importlimit`` is
    greater than zero, return only enough tuples to contain ``importlimit``
    rows. The second element of the last tuple in the returned list may be
    ``None``. This happens if the last batch will contain less than
    ``batch_size`` rows.

    :param sqlalchemy.orm.session.Session db_session:
    :param sqlalchemy.Column column:
    :param int batch_size:
    :param int importlimit:
    :rtype: [(int, int)]
    """
    q = db_session.query(
        column,
        func.row_number().
        over(order_by=column).
        label('rownum')
    ).\
        from_self(column)

    if batch_size > 1:
        q = q.filter("rownum %% %d=1" % batch_size)

    if importlimit:
        q = q.filter("rownum <= %d" % (importlimit))

    intervals = [id for id in q]
    bounds = []

    while intervals:
        start = intervals.pop(0)[0]
        if intervals:
            end = intervals[0][0]
        elif importlimit:
            # If there's an importlimit, just add a noop bound. This way,
            # :func:`sir.indexing.index_entity` doesn't require any
            # information about the limit
            end = start
        else:
            end = None
        bounds.append((start, end))

    return bounds

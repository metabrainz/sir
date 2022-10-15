# Copyright (c) 2014, 2015 Lukas Lalinsky, Wieland Hoffmann
# License: MIT, see LICENSE for details
import logging


from sqlalchemy import func, text
from sqlalchemy.orm.attributes import InstrumentedAttribute
from sqlalchemy.orm.interfaces import ONETOMANY, MANYTOONE
from sqlalchemy.orm.properties import RelationshipProperty
from sqlalchemy.ext.hybrid import HYBRID_PROPERTY


logger = logging.getLogger("sir")


def iterate_path_values(path, obj):
    """
    Return an iterator over all values for `path` on `obj`, an instance of
    a :ref:`declarative <sqla:declarative_toplevel>` class by first splitting
    the path into its elements by splitting it on the dots, resulting in a list
    of path elements. Then, for each element, a call to :func:`getattr` is made
    - the arguments will be the current model (which initially is the **model**
    assigned to the :class:`~sir.schema.searchentities.SearchEntity`) and the
    current path element. After doing this, there are two cases:

    1. The path element is not the last one in the path. In this case, the
       :func:`getattr` call returns one or more objects of another model which
       will replace the current one.

    2. The path element is the last one in the path. In this case, the value
       returned by the :func:`getattr` call will be returned and added to the
       list of values for this field.

    .. warning::

        Hybrid attributes like @hybrid_property are currently not supported.

    To give an example, lets presume the object we're starting with is an
    instance of :class:`~mbdata.models.Artist` and the path is
    "begin_area.name". The first :func:`getattr` call will be::

      getattr(obj, "begin_area")

    which returns an :class:`~mbdata.models.Area` object, on which the call::

      getattr(obj, "name")

    will return the final value::

        >>> from mbdata.models import Artist, Area
        >>> artist = Artist(name="Johan de Meij")
        >>> area = Area(name="Netherlands")
        >>> artist.begin_area = area
        >>> list(iterate_path_values("begin_area.name", artist))
        ['Netherlands']

    One-to-many relationships will of course be handled as well::

        >>> from mbdata.models import Recording, ISRC
        >>> recording = Recording(name="Fortuna Imperatrix Mundi: O Fortuna")
        >>> recording.isrcs.append(ISRC(isrc="DEF056730100"))
        >>> recording.isrcs.append(ISRC(isrc="DEF056730101"))
        >>> list(iterate_path_values("isrcs.isrc", recording))
        ['DEF056730100', 'DEF056730101']

    """
    if obj is None:
        return

    if '.' in path:
        pathelem, rest = path.split('.', 1)
    else:
        pathelem, rest = path, None

    column = getattr(obj.__class__, pathelem)
    if isinstance(column, InstrumentedAttribute):
        prop = column.property
        if isinstance(column.property, RelationshipProperty):
            if prop.direction == ONETOMANY:
                for sub_obj in getattr(obj, pathelem):
                    for val in iterate_path_values(rest, sub_obj):
                        yield val
            elif prop.direction == MANYTOONE:
                for val in iterate_path_values(rest, getattr(obj, pathelem)):
                    yield val
        else:
            yield getattr(obj, pathelem)
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
        q = q.filter(text("rownum % :batch_size=1").bindparams(batch_size=batch_size))

    if importlimit:
        q = q.filter(text("rownum <= :import_limit").bindparams(import_limit=importlimit))

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

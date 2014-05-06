# Copyright (c) 2014 Lukas Lalinsky, Wieland Hoffmann
# License: MIT, see LICENSE for details
import logging


from . import config
from sqlalchemy import func
from sqlalchemy.orm import Load
from sqlalchemy.orm.interfaces import ONETOMANY, MANYTOONE
from sqlalchemy.orm.properties import RelationshipProperty
from sqlalchemy.orm.query import Query

logger = logging.getLogger("sir")


def build_entity_query(entity):
    """Builds a :class:`sqla:sqlalchemy.orm.query.Query` object for ``entity``
       (an instance of :class:`sir.schema.searchentities.SearchEntity`) that eagerly loads the
       values of all search fields.

       :param sir.schema.searchentities.SearchEntity entity:
       :rtype: :class:`sqla:sqlalchemy.orm.query.Query`
    """
    model = entity.model
    q = Query(model)
    for field in entity.fields:
        # Walk `field.path` and apply loading strategies to each element
        for path in field.paths:
            model = entity.model
            load = Load(model)
            for pathelem in path.split('.'):
                prop = getattr(model, pathelem).property
                if isinstance(prop, RelationshipProperty):
                    if prop.direction == ONETOMANY:
                        load = load.subqueryload(pathelem)
                    elif prop.direction == MANYTOONE:
                        load = load.joinedload(pathelem)
                    else:
                        load = load.defaultload(pathelem)
                    # Get the mapper class of the current element of the path so
                    # the next iteration can access it.
                    model = prop.mapper.class_
            q = q.options(load)
    return q


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


def max_id_of(entity, db_session):
    """
    Returns the maximum id of all rows in the table of ``entity``.

    :param sir.schema.searchentities.SearchEntity entity:
    :param sqlalchemy.orm.scoping.scoped_session db_session:
    """
    model = entity.model
    session = db_session()
    val = session.query(func.max(model.id)).scalar()
    db_session.remove()
    return val


class QueryIterator(object):
    """
    Iterator over a :class:`sqla:sqlalchemy.orm.query.Query` object.
    """
    def __init__(self, query, num_rows, model):
        """
        :param sqlalchemy.orm.query.Query query:
        :param int num_rows: The total number of rows in the table
        :param model:
        """
        self.model = model
        self.num_rows = num_rows
        self.query = query
        self.query_batch_size = config.CFG.getint("sir", "query_batch_size")

        try:
            self.importlimit = config.CFG.getint("sir", "importlimit")
        except NoOptionError, exc:
            self.importlimit = 0

    def __iter__(self):
        lower_bound = 0
        for upper_bound in xrange(lower_bound + self.query_batch_size,
                                  self.num_rows + self.query_batch_size + 1,
                                  self.query_batch_size or self.num_rows):
            query = self.query.filter(self.model.id.between(lower_bound, upper_bound))
            for row in query:
                yield row
            if upper_bound >= self.importlimit:
                break

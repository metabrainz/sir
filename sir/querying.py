import logging


from sqlalchemy.orm import Load
from sqlalchemy.orm.properties import RelationshipProperty
from sqlalchemy.orm.interfaces import ONETOMANY, MANYTOONE


logger = logging.getLogger("sir")


def build_entity_query(session, entity):
    """Builds a :class:`sqla:sqlalchemy.orm.query.Query` object for ``entity``
       (an instance of :class:`SearchEntity`) that eagerly loads the
       values of all search fields.

       :param sqlalchemy.orm.session.Session session:
       :param sir.schema.searchentities.SearchEntity entity:
       :rtype: :class:`sqla:sqlalchemy.orm.query.Query`
    """
    model = entity.model
    q = session.query(model)
    q = q.filter(model.id < 1000)
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

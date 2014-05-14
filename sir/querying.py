# Copyright (c) 2014 Lukas Lalinsky, Wieland Hoffmann
# License: MIT, see LICENSE for details
import logging


from collections import defaultdict
from sqlalchemy import func
from sqlalchemy.orm import class_mapper, Load
from sqlalchemy.orm.interfaces import ONETOMANY, MANYTOONE
from sqlalchemy.orm.properties import RelationshipProperty
from sqlalchemy.orm.query import Query

logger = logging.getLogger("sir")


def merge_paths(field_paths):
    """
    Given a list of paths as ``field_paths``, return a dict that, for each
    level of the path, includes a dictionary whose keys are the columns to load
    and the values are other dictionaries of the described structure.


    :param field_paths:
    :type field_paths: [str]
    :rtype: dict
    """
    paths = defaultdict(set)
    for path_list in field_paths:
        for path in path_list:
            path_length = path.count(".")
            current_path_dict = paths
            for i, pathelem in enumerate(path.split(".")):
                # Build a new dict for the next level, if there is one
                if i >= path_length:
                    # If not, still add the current element as a key so its
                    # column gets loaded
                    current_path_dict[pathelem] = ""
                    break

                if pathelem in current_path_dict:
                    new_path_dict = current_path_dict[pathelem]
                else:
                    new_path_dict = defaultdict(set)
                current_path_dict[pathelem] = new_path_dict
                current_path_dict = new_path_dict
    return paths


def _defer_everything_but(mapper, load, *columns):
    for prop in mapper.iterate_properties:
        if hasattr(prop, "columns"):
            key = prop.key
            if key not in columns and key[:-3] not in columns and \
               key[-3:] != "_id" and key != "position":
               # We need the _id columns for subqueries and joins
               # Position is needed because sqla automatically orders by
               # artist_credit_name.position
                logger.debug("Deferring %s on %s", key, mapper)
                load.defer(key)
    return load


def build_entity_query(entity):
    """
    Builds a :class:`sqla:sqlalchemy.orm.query.Query` object for ``entity``
    (an instance of :class:`sir.schema.searchentities.SearchEntity`) that
    eagerly loads the values of all search fields.

   :param sir.schema.searchentities.SearchEntity entity:
   :rtype: :class:`sqla:sqlalchemy.orm.query.Query`
    """
    root_model = entity.model
    query = Query(root_model)
    paths = [field.paths for field in entity.fields]
    merged_paths = merge_paths(paths)

    for field_paths in paths:
        for path in field_paths:
            current_merged_path = merged_paths
            model = root_model
            load = Load(model)
            split_path = path.split(".")
            for pathelem in split_path:
                current_merged_path = current_merged_path[pathelem]
                column = getattr(model, pathelem)
                prop = column.property
                
                if isinstance(prop, RelationshipProperty):
                    pk = column.mapper.primary_key[0].name
                    if prop.direction == ONETOMANY:
                        load = load.subqueryload(pathelem)
                    elif prop.direction == MANYTOONE:
                        load = load.joinedload(pathelem)
                    else:
                        load = load.defaultload(pathelem)
                    required_columns = current_merged_path.keys()
                    required_columns.append(pk)
                    # Get the mapper class of the current element of the path so
                    # the next iteration can access it.
                    model = prop.mapper.class_

                    logger.debug("Loading only %s on %s",
                                 required_columns,
                                 model)
                    load = _defer_everything_but(class_mapper(model),
                                                 load,
                                                 *required_columns)
            query = query.options(load)
    return query


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
    session.close()
    return val

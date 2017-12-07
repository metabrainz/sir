# Copyright (c) Wieland Hoffmann
# License: MIT, see LICENSE for details
from sqlalchemy.orm.query import Query
from sqlalchemy.orm.attributes import InstrumentedAttribute
from sqlalchemy.orm.properties import ColumnProperty, RelationshipProperty
from sqlalchemy.orm.descriptor_props import CompositeProperty


def generate_query(model, path, filters=None):
    query = Query(model.id)
    if path:
        query = query.join(*path.split("."))
    if filters is not None:
        if isinstance(filters, list):
            query = query.filter(*filters)
        else:
            query = query.filter(filters)
    return query


def unique_split_paths(paths):
    """
    For each path in ``paths``, yield each of its continuous subpaths.
    If a subpath appears in multiple paths, it will be yielded only once.

    :param [str] paths:
    :rtype: iterator over str
    """
    seen_paths = set()
    for path in paths:
        splits = path.split(".")
        split_length = len(splits)
        for i in xrange(1, split_length + 1):
            join = ".".join(splits[:i])
            if join not in seen_paths:
                seen_paths.add(join)
                yield join


def last_model_in_path(model, path):
    """
    Walk ``path`` beginning at ``model`` and return the last model in the path.

    :param model: A :ref:`declarative <sqla:declarative_toplevel>` class.
    :param str path: The path itself.
    """
    # TODO(roman): Check if old comments in this function are still relevant
    current_model = model

    for i, path_elem in enumerate(path.split(".")):
        column = getattr(current_model, path_elem)

        # If this is not a column managed by SQLAlchemy, ignore it
        # TODO(roman): Document when this might happen
        if not isinstance(column, InstrumentedAttribute):
            # Let's assume some other path also covers this table
            return None

        prop = column.property  # Current property in the path

        if isinstance(prop, RelationshipProperty):
            current_model = prop.mapper.class_

        elif isinstance(prop, ColumnProperty) or isinstance(prop, CompositeProperty):
            # We're not interested in columns (or a collection or them) because
            # the relationship handling takes care of selections on primary keys
            # etc.
            return None

    return current_model


def second_last_model_in_path(model, path):
    """
    Walk ``path`` beginning at ``model`` and return the second last model
    in the path.

    We generate SQL queries with the second last model in path, to determine
    rows that need to be updated when an entity is deleted. Since those rows
    will be related to the deleted entity by a foreign key.

    Example: If `area_alias` if deleted, `place` needs to be updated via the path
    `area.aliases`. We can determine the ids of `place` table that need to be udpated,
    by determining the `area` rows that were affected by the `area_alias` delete.

    :param model: A :ref:`declarative <sqla:declarative_toplevel>` class.
    :param str path: The path itself.
    """
    if path is None:
        return (None, None)
    current_model = model
    new_path = ".".join(path.split(".")[:-1])
    if new_path == "":
        return (current_model, "")
    else:
        return (last_model_in_path(model, new_path), new_path)

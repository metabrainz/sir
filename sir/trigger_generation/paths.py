# Copyright (c) 2015, 2017 Wieland Hoffmann, MetaBrainz Foundation
# License: MIT, see LICENSE for details
import mbdata
from sqlalchemy.orm import class_mapper, aliased
from sqlalchemy.orm.query import Query
from sqlalchemy.orm.properties import ColumnProperty, RelationshipProperty
from sqlalchemy.orm.descriptor_props import CompositeProperty


def generate_query(model, path, filters=None):
    """
    Generate a SELECT query to fetch `model` ids along the path with given
    `filters` on the last model in `path`.
    :param model: A :ref:`declarative <sqla:declarative_toplevel>` class.
    :param path:
    :param [sqlalchemy.sql.expression.BinaryExpression] filters:
    :rtype: A :ref:`sqlalchemy.orm.query.Query` object
    """

    # We start with the query selecting the ids of the models we want to return.
    query = Query(model.id)
    if path:
        # In case path is not blank, we need to alias the model id while joining
        # to prevent referencing the same table again.
        query = (Query(aliased(model).id))
        # The below is a fix in case the same table is joined
        # multiple times. In that case, we alias everything except
        # the last path and then filter on the last path.
        path_list = path.split(".")
        last_path = path_list[-1]
        path_list = path_list[:-1]
        if path_list:
            query = query.join(*path_list, aliased=True)
        # The last path is purposfully left out from being aliased to make it easier
        # to contrunct filter conditions.
        query = query.join(last_path, from_joinpoint=True)
    if filters is not None:
        if isinstance(filters, list):
            query = query.filter(*filters)
        else:
            query = query.filter(filters)
    return query


def generate_filtered_query(model, path, emitted_keys):
    """
    Generate a query filtered on the primary key of the last model
    in path.
    :param model: A :ref:`declarative <sqla:declarative_toplevel>` class.
    :param str path:
    :param dict emitted_keys: A `dict` containing the key value
                              pairs emitted from the trigger.
    :rtype: A :ref:`sqlalchemy.orm.query.Query` object
    """
    last_model = class_mapper(last_model_in_path(model, path))
    filters = []
    if last_model:
        primary_keys = [(pk, pk.name) for pk in last_model.mapper.primary_key]
        filters = [pk.__eq__(emitted_keys[pk_name])
                   for pk, pk_name in primary_keys if pk_name in emitted_keys]

    if not filters:
        return None
    else:
        return generate_query(model, path, filters)


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
        if isinstance(column, (str, mbdata.models.Base)):
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

# Copyright (c) Wieland Hoffmann
# License: MIT, see LICENSE for details
from ..schema import SCHEMA
from .types import *
from functools import partial
from logging import getLogger
from sqlalchemy.orm import class_mapper
from sqlalchemy.orm.interfaces import ONETOMANY, MANYTOONE
from sqlalchemy.orm.properties import ColumnProperty, RelationshipProperty


logger = getLogger("sir")


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


def walk_path(model, path):
    """
    Walk ``path`` beginning at ``model`` and return a
    :class:`~sir.trigger_generation.PathPart` object representing a selection
    along that path. Also return the name of the last table seen while
    following ``path``

    :param model: A :ref:`declarative <sqla:declarative_toplevel>` class.
    :param str path:
    """
    current_model = model
    path_length = path.count(".")
    path_part = None
    outermost_path_part = None
    innermost_table_name = None

    for i, path_elem in enumerate(path.split(".")):
        column = getattr(current_model, path_elem)
        prop = column.property

        if isinstance(prop, RelationshipProperty):
            mapper = class_mapper(current_model)
            pk = mapper.primary_key[0].name
            tablename = mapper.mapped_table.name
            innermost_table_name = prop.table.name

            if prop.direction == ONETOMANY:
                new_path_part = OneToManyPathPart(tablename, pk)
                if i == path_length:
                        remote_column = list(prop.remote_side)[0].name
                        inner = ColumnPathPart("", remote_column)
                        new_path_part.inner = inner
            elif prop.direction == MANYTOONE:
                new_path_part = ManyToOnePathPart(tablename, pk,
                                                  column.key)

            current_model = prop.mapper.class_

        elif isinstance(prop, ColumnProperty):
            # We're not interested in columns because the relationship handling
            # takes care of selections on primary keys etc.
            return None, None

        if path_part is None:
            path_part = new_path_part
            outermost_path_part = path_part
        else:
            path_part.inner = new_path_part
            path_part = new_path_part

    if path_part.inner is None:
        # The path ended in a relationship property
        path_part.inner = ColumnPathPart("", "id")

    return outermost_path_part, innermost_table_name


def write_triggers_to_file(triggerfile, generators, entityname, table, path, select):
    """
    Write deletion, insertion and update triggers to ``triggerfile``.

    :param file triggerfile:
    :param generators:
    :type generators: [TriggerGenerator]
    :param str entityname:
    :param str table:
    :param str path:
    :param str select:
    """
    for generator in generators:
        gen = generator(entityname, table, path, select)
        triggerfile.write(gen.function)
        triggerfile.write(gen.trigger)


def write_direct_triggers(triggerfile, entityname, model):
    """
    :param file triggerfile:
    :param str entityname:
    :param model: A :ref:`declarative <sqla:declarative_toplevel>` class.
    """
    id_select = "SELECT id FROM {table} WHERE {pk} = {{new_or_old}}.{pk}"
    mapper = class_mapper(model)
    pk = mapper.primary_key[0].name
    tablename = mapper.mapped_table.name

    write_triggers_to_file(triggerfile,
                           generators=(GIDDeleteTriggerGenerator,
                                       InsertTriggerGenerator,
                                       UpdateTriggerGenerator),
                           entityname=entityname,
                           table=tablename,
                           path="direct",
                           select=id_select.format(pk=pk, table=tablename))


def generate_triggers(args):
    """
    The entry point for this module. This function gets called from
    :func:`~sir.__main__.main`.
    """
    filename = args["filename"]
    with open(filename, "w") as triggerfile:
        triggerfile.write("-- Automatically generated, do not edit\n")
        triggerfile.write("\set ON_ERROR_STOP 1\n")
        triggerfile.write("BEGIN;\n")
        for entityname, e in SCHEMA.iteritems():
            writer = partial(write_triggers_to_file,
                             generators=(DeleteTriggerGenerator,
                                         InsertTriggerGenerator,
                                         UpdateTriggerGenerator),
                             triggerfile=triggerfile,
                             entityname=entityname)
            paths = unique_split_paths([path for field in e.fields for path in
                                        field.paths])

            write_direct_triggers(triggerfile, entityname, e.model)

            for path in paths:
                select, table = walk_path(e.model, path)
                if select is not None:
                    select = select.render()
                    writer(table=table, path=path, select=select)
        triggerfile.write("COMMIT;\n")

# Copyright (c) Wieland Hoffmann
# License: MIT, see LICENSE for details
from sir.schema import SCHEMA
from sir.trigger_generation.types import *
from enumerate_skip import enumerate_skip
from logging import getLogger

from sqlalchemy.orm import class_mapper
from sqlalchemy.orm.attributes import InstrumentedAttribute
from sqlalchemy.orm.interfaces import ONETOMANY, MANYTOONE
from sqlalchemy.orm.properties import ColumnProperty, RelationshipProperty
from sqlalchemy.orm.descriptor_props import CompositeProperty

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
    following ``path``.

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

        # If this is not a column managed by SQLAlchemy, ignore it
        # TODO(roman): Document when this might happen
        if not isinstance(column, InstrumentedAttribute):
            # Let's assume some other path also covers this table
            return None, None

        prop = column.property  # Current property in the path

        if isinstance(prop, RelationshipProperty):
            # Mapper defines correlation of model class attributes to database table columns
            mapper = class_mapper(current_model)
            pk = mapper.primary_key[0].name
            table_name = mapper.mapped_table.name

            innermost_table_name = prop.table.name

            if prop.direction == ONETOMANY:
                new_path_part = OneToManyPathPart(table_name, pk_name=pk)
                if i == path_length:
                    remote_side = list(prop.remote_side)[0]
                    remote_column = remote_side.name
                    new_path_part.inner = ColumnPathPart("", remote_column)
                    innermost_table_name = remote_side.table.name
            elif prop.direction == MANYTOONE:
                new_path_part = ManyToOnePathPart(table_name, pk_name=pk, fk_name=column.key)

            current_model = prop.mapper.class_

        elif (isinstance(prop, ColumnProperty) or
              isinstance(prop, CompositeProperty)):
            # We're not interested in columns (or a collection or them) because
            # the relationship handling takes care of selections on primary keys
            # etc.
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


def write_triggers_to_file(generators, trigger_file, function_file, **generator_args):
    """Write SQL for creation of triggers (for deletion, insertion, and updates) and
    associated functions into files.

    :param list generators: A set of generator classes (based on``TriggerGenerator``)
                            to use for creating SQL statements.
    :param file trigger_file: File into which commands for creating triggers will be written.
    :param file function_file: File into which commands for creating trigger functions
                               will be written.
    """
    for generator in generators:
        gen = generator(**generator_args)
        function_file.write(gen.function)
        trigger_file.write(gen.trigger)


def write_direct_triggers(trigger_file, function_file, model, **generator_args):
    """
    :param file trigger_file: File where triggers will be written.
    :param file function_file: File where functions will be written.
    :param model: A :ref:`declarative <sqla:declarative_toplevel>` class.
    """
    id_select = "SELECT {table}.id FROM {table} WHERE {table}.{pk} = {{new_or_old}}.{pk}"
    mapper = class_mapper(model)
    pk = mapper.primary_key[0].name
    table_name = mapper.mapped_table.name

    write_triggers_to_file(
        trigger_file=trigger_file,
        function_file=function_file,
        generators=[
            InsertTriggerGenerator,
            UpdateTriggerGenerator,
            GIDDeleteTriggerGenerator,
        ],
        table_name=table_name,
        path="direct",
        select=id_select.format(pk=pk, table=table_name),
        index_table=table_name,
        index=0,
        **generator_args
    )


def write_header(f):
    """Write an SQL "header" into a file.

    Adds a note about editing, sets command line options, and begins a
    transaction. Should be written at the beginning of each SQL script.

    :param file f: File to write the header into.
    """
    f.write("-- Automatically generated, do not edit\n")
    f.write("\set ON_ERROR_STOP 1\n")
    f.write("BEGIN;\n\n")


def write_footer(f):
    """Write an SQL "footer" into a file.

    Adds a statement to commit a transaction. Should be written at the end of
    each SQL script that wrote a header (see `write_header` function).

    :param file f: File to write the footer into.
    """
    f.write("COMMIT;\n")


def generate_triggers(args):
    """
    This is the entry point for this trigger_generation module. This function
    gets called from :func:`~sir.__main__.main`.
    """
    trigger_filename = args["trigger_file"]
    function_filename = args["function_file"]
    broker_id = args["broker_id"]
    with open(trigger_filename, "w") as triggerfile,\
         open(function_filename, "w") as functionfile:
        write_header(triggerfile)
        write_header(functionfile)
        for entity_name, e in SCHEMA.iteritems():

            # Writing "direct" triggers for the entity's table. So the "artist"
            # table for the artist entity, "recording" for recording, etc.
            write_direct_triggers(
                trigger_file=triggerfile,
                function_file=functionfile,
                prefix=entity_name,
                model=e.model,
                broker_id=broker_id,
            )

            # Write triggers for all tables associated with an entity.
            entity_table_name = class_mapper(e.model).mapped_table.name
            paths = unique_split_paths([path for field in e.fields
                                             for path in field.paths])
            it = enumerate_skip(paths, start=1)
            for i, path in it:  # The index is used as a suffix in function and trigger names to guarantee uniqueness
                path_name = path
                select, trigger_table = walk_path(e.model, path)
                if select is not None:
                    select = select.render()
                    write_triggers_to_file(
                        trigger_file=triggerfile,
                        function_file=functionfile,
                        generators=[
                            InsertTriggerGenerator,
                            UpdateTriggerGenerator,
                            DeleteTriggerGenerator,
                        ],
                        prefix=entity_name,
                        table_name=trigger_table,
                        path=path_name,
                        select=select,
                        index_table=entity_table_name,
                        index=i,
                        broker_id=broker_id,
                    )
                else:
                    it.skip()  # not incrementing the index
        write_footer(triggerfile)
        write_footer(functionfile)

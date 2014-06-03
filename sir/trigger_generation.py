# Copyright (c) Wieland Hoffmann
# License: MIT, see LICENSE for details
from .schema import SCHEMA
from functools import partial
from logging import getLogger
from sqlalchemy.orm import class_mapper
from sqlalchemy.orm.interfaces import ONETOMANY, MANYTOONE
from sqlalchemy.orm.properties import ColumnProperty, RelationshipProperty


logger = getLogger("sir")


class PathPart(object):
    """
    A class representing part of a selection along a path across tables. Its
    subclasses can be used to construct SELECT statements programmatically,
    knowing only the relationship between the tables.

    Calling :func:`~sir.trigger_generation.PathPart.render` on the outermost
    :class:`PathPart` in a chain will return a SELECT statement for the
    :attr:`pkname` attribute on the table :attr:`tablename` along the complete
    chain.

    >>> outer = ManyToOnePathPart("table_1", "id", "table_2_id")
    >>> inner = ColumnPathPart("table_2", "id")
    >>> outer.inner = inner
    >>> outer.render()
    'SELECT id FROM table_1 WHERE table_2_id = ({new_or_old}.id)'
    """
    def __init__(self, tablename, pkname, inner=None):
        """
        :param str tablename: The name of the table
        :param str pkname: The primary key of the table
        :param sir.trigger_generation.PathPart inner:
        """
        self.tablename = tablename
        self.pkname = pkname
        self.inner = inner

    def render():
        """
        Render the selection represented by this object and its inner object into a
        string.

        :rtype: str
        """
        raise NotImplementedError


class OneToManyPathPart(PathPart):
    """
    A :class:`~sir.trigger_generation.PathPart` subclass used to represent a
    selection across a one-to-many relationship between two
    tables.
    """
    def render(self):
        return "SELECT {pk} FROM {table} WHERE {pk} IN ({inner})".\
            format(pk=self.pkname, table=self.tablename,
                   inner=self.inner.render())


class ManyToOnePathPart(PathPart):
    """
    A :class:`~sir.trigger_generation.PathPart` subclass used to represent a
    selection across a many-to-one relationship between two
    tables.
    """
    def __init__(self, tablename, pkname, fkname, inner=None):
        PathPart.__init__(self, tablename, pkname, inner)
        self.fkname = fkname

    def render(self):
        return "SELECT {pk} FROM {table} WHERE {fk} = ({inner})".\
            format(pk=self.pkname, table=self.tablename,
                   inner=self.inner.render(), fk=self.fkname)


class ColumnPathPart(PathPart):
    """
    A :class:`~sir.trigger_generation.PathPart` subclass used to represent the
    selection of the primary key column of the innermost SELECT statement in
    the chain.
    """
    def render(self):
        return "{{new_or_old}}.{pkname}".format(pkname=self.pkname)


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


class TriggerGenerator(object):
    """
    A class to generate triggers and a corresponding function for a specific
    operation (DELETE/INSERT/UPDATE).
    """
    id_replacement = None

    #: The operation
    op = None

    #: Whether to execute the trigger BEFORE or AFTER :attr:`op`
    beforeafter = "AFTER"

    def __init__(self, prefix, tablename, path, select):
        """
        :param str prefix: A prefix for the trigger name
        :param str tablename: The table on which to generate the trigger
        :param str path: The path for which to generate the trigger
        :param str select: A SELECT statement to be embedded in the function
        """
        self.prefix = prefix
        self.tablename = tablename
        self.path = path
        select = select.format(new_or_old=self.id_replacement)
        self.select = select

    @property
    def triggername(self):
        """
        The name of this trigger.

        :rtype: str
        """
        return "search_" + self.prefix + "_" + self.op + "_" +\
               self.path.replace(".", "_")

    @property
    def trigger(self):
        """
        The ``CREATE TRIGGER`` statement for this trigger.

        :rtype: str
        """
        trigger = \
"""
CREATE TRIGGER {triggername} {beforeafter} {op} ON {tablename}
    FOR EACH ROW EXECUTE PROCEDURE {triggername}();
""".format(triggername=self.triggername, tablename=self.tablename,
           op=self.op.upper(), beforeafter=self.beforeafter)
        return trigger


    @property
    def function(self):
        """
        The ``CREATE FUNCTION`` statement for this trigger.

        :rtype: str
        """
        func = \
"""
CREATE OR REPLACE FUNCTION {triggername}() RETURNS trigger
    AS $$
BEGIN
    FOR row IN {select} LOOP
        PERFORM amqp.publish(1, EXCHANGE, ROUTING_KEY, row.id);
    END LOOP;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
""".\
            format(triggername=self.triggername, select=self.select)
        return func


class DeleteTriggerGenerator(TriggerGenerator):
    """
    A trigger generator for DELETE operations.
    """
    op = "delete"
    id_replacement = "OLD"
    beforeafter = "BEFORE"


class GIDDeleteTriggerGenerator(DeleteTriggerGenerator):
    """
    Like :class:`~sir.trigger_generation.DeleteTriggerGenerator` but replaces
    the first ``SELECT id`` with ``SELECT gid``.
    """
    def __init__(self, *args, **kwargs):
        super(GIDDeleteTriggerGenerator, self).__init__(*args, **kwargs)
        self.select = self.select.replace("SELECT id", "SELECT gid")

    @property
    def function(self):
        """
        The ``CREATE FUNCTION`` statement for this trigger.

        :rtype: str
        """
        func = \
"""
CREATE OR REPLACE FUNCTION {triggername}() RETURNS trigger
    AS $$
BEGIN
    FOR row IN {select} LOOP
        PERFORM amqp.publish(1, EXCHANGE, ROUTING_KEY, row.gid);
    END LOOP;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
""".\
            format(triggername=self.triggername, select=self.select)
        return func


class InsertTriggerGenerator(TriggerGenerator):
    """
    A trigger generator for INSERT operations.
    """
    op = "insert"
    id_replacement = "NEW"


class UpdateTriggerGenerator(TriggerGenerator):
    """
    A trigger generator for UPDATE operations.
    """
    # TODO: WHEN
    op = "update"
    id_replacement = "NEW"


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

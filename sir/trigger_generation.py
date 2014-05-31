# Copyright (c) Wieland Hoffmann
# License: MIT, see LICENSE for details
from .schema import SCHEMA
from logging import getLogger
from sqlalchemy.orm import class_mapper
from sqlalchemy.orm.interfaces import ONETOMANY, MANYTOONE
from sqlalchemy.orm.properties import ColumnProperty, RelationshipProperty


logger = getLogger("sir")


class PathPart(object):
    def __init__(self, tablename, pkname, inner=None):
        self.tablename = tablename
        self.pkname = pkname
        self.inner = inner

    def render():
        raise NotImplementedError


class OneToManyPathPart(PathPart):
    def render(self):
        #if isinstance(self.inner, ColumnPathPart):
            #return self.inner.render()
        return "SELECT {pk} FROM {table} WHERE {pk} IN ({inner})".\
            format(pk=self.pkname, table=self.tablename,
                   inner=self.inner.render())


class ManyToOnePathPart(PathPart):
    def __init__(self, tablename, pkname, fkname, inner=None):
        PathPart.__init__(self, tablename, pkname, inner)
        self.fkname = fkname

    def render(self):
        #if isinstance(self.inner, ColumnPathPart):
            #return self.inner.render()
        return "SELECT {pk} FROM {table} WHERE {fk} = ({inner})".\
            format(pk=self.pkname, table=self.tablename,
                   inner=self.inner.render(), fk=self.fkname)


class ColumnPathPart(PathPart):
    def render(self):
        return "{{new_or_old_id}}"


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
            innermost_table_name = tablename

            if prop.direction == ONETOMANY:
                if i == path_length and isinstance(path_part,
                                        ManyToOnePathPart):
                    # The previous many-to-one relationship already contains
                    # the selection on the PK of this table because it has a
                    # foreign key
                    return None, None
                new_path_part = OneToManyPathPart(tablename, pk)
            elif prop.direction == MANYTOONE:
                if i == path_length and isinstance(path_part,
                                        OneToManyPathPart):
                    # The previous one-to-many relationship already contains
                    # the selection on the PK of this table
                    return None, None
                new_path_part = ManyToOnePathPart(tablename, pk,
                                                  column.key)

            current_model = prop.mapper.class_

        elif isinstance(prop, ColumnProperty):
            # We're at the last element of a path, which is a simple column.
            # We need to replace the ``inner`` attribute of the current
            # ```path_part`` with a selection on the primary key.
            mapper = class_mapper(current_model)
            innermost_table_name = mapper.mapped_table.name
            new_path_part = ManyToOnePathPart(mapper.mapped_table.name,
                                           mapper.primary_key[0].name,
                                           path_elem)
        if path_part is None:
            path_part = new_path_part
            outermost_path_part = path_part
        else:
            path_part.inner = new_path_part
            path_part = new_path_part

    if path_part.inner is None:
        # The path ended in a relationship property
        path_part.inner = ColumnPathPart("", "")

    return outermost_path_part, innermost_table_name


class TriggerGenerator(object):
    """
    A class to generate triggers and a corresponding function for a specific
    operation (DELETE/INSERT/UPDATE).
    """
    id_replacement = None

    #: The operation
    op = None

    def __init__(self, tablename, path, select):
        """
        :param str tablename: The table on which to generate the trigger
        :param str path: The path for which to generate the trigger
        :param str select: A SELECT statement to be embedded in the function
        """
        self.tablename = tablename
        self.path = path
        select = select.replace("{{new_or_old_id}}", self.id_replacement)
        self.select = select

    @property
    def triggername(self):
        """
        The name of this trigger.

        :rtype: str
        """
        return "search_" + self.tablename + "_" + self.op + "_" +\
               self.path.replace(".", "_")

    @property
    def trigger(self):
        """
        The ``CREATE TRIGGER`` statement for this trigger.

        :rtype: str
        """
        trigger = \
"""
CREATE TRIGGER {triggername} AFTER {op} ON {tablename}
    FOR EACH ROW EXECUTE PROCEDURE {triggername}();
""".format(triggername=self.triggername, tablename=self.tablename, op=self.op.upper())
        return trigger


    @property
    def function(self):
        """
        The ``CREATE FUNCTION`` statement for this trigger.

        :rtype: str
        """
        func = \
"""
CREATE OR REPLACE FUNCTION {triggername}() RETURNS trigger AS $$
BEGIN
    FOR row IN {select} LOOP
        PERFORM amqp.publish(BROKER_ID, EXCHANGE, ROUTING_KEY, row.id);
    END LOOP;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
        """.format(triggername=self.triggername, select=self.select)
        return func


class DeletionTriggerGenerator(TriggerGenerator):
    # TODO: SELECT the gid, making further selects unnecessary
    # TODO: If the path doesn't contain a dot and the column is different from
    # gid/id, don't generate a trigger because the gid/id column are enough
    # information for a deletion
    op = "delete"
    id_replacement = "OLD.id"

    @property
    def trigger(self):
        """
        The ``CREATE TRIGGER`` statement for this trigger.

        :rtype: str
        """
        trigger = \
"""
CREATE TRIGGER {triggername} BEFORE {op} ON {tablename}
    FOR EACH ROW EXECUTE PROCEDURE {triggername}();
""".format(triggername=self.triggername, tablename=self.tablename, op=self.op.upper())
        return trigger


class InsertTriggerGenerator(TriggerGenerator):
    op = "insert"
    id_replacement = "NEW.id"


class UpdateTriggerGenerator(TriggerGenerator):
    # TODO: WHEN
    op = "update"
    id_replacement = "NEW.id"


def generate_triggers(args):
    # filename = args["filename"]
    e = SCHEMA["release"]
    paths = unique_split_paths([path for field in e.fields for path in
                                field.paths])
    for path in paths:
        select, table = walk_path(e.model, path)
        # TODO: The column of the innermost select statement has to be `id` in
        # the WHERE clause
        # because the trigger functions can access NEW.id or OLD.id
        if select is not None:
            select = select.render()
            gen = DeletionTriggerGenerator(table, path, select)
            print gen.function
            print gen.trigger

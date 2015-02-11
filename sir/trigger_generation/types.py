# Copyright (c) Wieland Hoffmann
# License: MIT, see LICENSE for details


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
    'SELECT table_1.id FROM table_1 WHERE table_1.table_2_id IN ({new_or_old}.id)'
    """  # noqa
    def __init__(self, tablename, pkname, inner=None):
        """
        :param str tablename: The name of the table
        :param str pkname: The primary key of the table
        :param sir.trigger_generation.types.PathPart inner:
        """
        self.tablename = tablename
        self.pkname = pkname
        self.inner = inner

    def render():
        """
        Render the selection represented by this object and its inner object
        into a string.

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
        return "SELECT {table}.{pk} FROM {table} WHERE {table}.{pk} IN "\
            "({inner})".format(pk=self.pkname, table=self.tablename,
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
        return "SELECT {table}.{pk} FROM {table} WHERE {table}.{fk} IN "\
            "({inner})". format(pk=self.pkname, table=self.tablename,
                                inner=self.inner.render(), fk=self.fkname)


class ColumnPathPart(PathPart):
    """
    A :class:`~sir.trigger_generation.PathPart` subclass used to represent the
    selection of the primary key column of the innermost SELECT statement in
    the chain.
    """
    def render(self):
        return "{{new_or_old}}.{pkname}".format(pkname=self.pkname)


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

    #: The routing key to be used for the message sent via AMQP
    routing_key = None

    def __init__(self, prefix, tablename, path, select, indextable, index):
        """
        :param str prefix: A prefix for the trigger name
        :param str tablename: The table on which to generate the trigger
        :param str path: The path for which to generate the trigger
        :param str select: A SELECT statement to be embedded in the function
        :param str indextable: The table with entities that need to be
                               reindexed
        :param int index: To allow for multiple triggers and functions on a
                          single entity type, we suffix each of them with an
                          index to avoid name collissions.
        """
        self.prefix = prefix.replace("-", "_")
        self.tablename = tablename
        self.path = path
        select = select.format(new_or_old=self.id_replacement)
        self.select = select
        self.indextable = indextable
        self.index = index

    @property
    def triggername(self):
        """
        The name of this trigger.

        :rtype: str
        """
        return "search_" + self.prefix + "_" + self.op + "_" + str(self.index)

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
COMMENT ON TRIGGER {triggername} IS 'The path for this trigger is {path}';
""".format(triggername=self.triggername, tablename=self.tablename,
           op=self.op.upper(), beforeafter=self.beforeafter, path=self.path)
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
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM ({select}) AS tmp;
    PERFORM amqp.publish(1, 'search', '{routing_key}', '{tablename} ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION {triggername}() IS 'The path for this function is {path}';
""".\
            format(triggername=self.triggername, select=self.select,
                   routing_key=self.routing_key, tablename=self.indextable,
                   path=self.path)
        return func


class DeleteTriggerGenerator(TriggerGenerator):
    """
    A trigger generator for DELETE operations.
    """
    op = "delete"
    id_replacement = "OLD"
    beforeafter = "BEFORE"
    routing_key = "update"


class GIDDeleteTriggerGenerator(DeleteTriggerGenerator):
    """
    Like :class:`~sir.trigger_generation.DeleteTriggerGenerator` but replaces
    the first ``SELECT id`` with ``SELECT gid``.

    """
    routing_key = "delete"

    def __init__(self, *args, **kwargs):
        super(GIDDeleteTriggerGenerator, self).__init__(*args, **kwargs)
        self.select = self.select.replace(
            "SELECT {tablename}.id".format(tablename=self.tablename),
            "SELECT {tablename}.gid AS id".format(tablename=self.tablename))

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
DECLARE
    gids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO gids FROM ({select}) AS tmp;
    PERFORM amqp.publish(1, 'search', '{routing_key}', '{tablename} ' || gids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION {triggername}() IS 'The path for this function is {path}';
""".\
            format(triggername=self.triggername, select=self.select,
                   routing_key=self.routing_key, tablename=self.tablename,
                   path=self.path)
        return func


class InsertTriggerGenerator(TriggerGenerator):
    """
    A trigger generator for INSERT operations.
    """
    op = "insert"
    id_replacement = "NEW"
    routing_key = "index"


class UpdateTriggerGenerator(TriggerGenerator):
    """
    A trigger generator for UPDATE operations.
    """
    # TODO: WHEN
    op = "update"
    id_replacement = "NEW"
    routing_key = "update"

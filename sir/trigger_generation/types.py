# Copyright (c) Wieland Hoffmann
# License: MIT, see LICENSE for details
import textwrap


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

    For example, if the path is "areas.area" and the target table is
    "annotation", then the resulting SQL query will be the following:
    ```
    SELECT annotation.id
      FROM annotation
     WHERE annotation.id IN (
        SELECT area_annotation.area
          FROM area_annotation
         WHERE area_annotation.area IN ({new_or_old}.id)
    )
    ```

    If the path is just "area", then for the "annotation" table the resulting
    query will be the following:
    ```
    SELECT annotation.id
      FROM annotation
     WHERE annotation.id IN ({new_or_old}.annotation)
    ```
    """  # noqa
    def __init__(self, table_name, pk_name, inner=None):
        """
        :param str table_name: The name of the table.
        :param str pk_name: The primary key of the table.
        :param PathPart inner: Path that will be included in
        """
        self.table_name = table_name
        self.pk_name = pk_name
        self.inner = inner

    def render(self):
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
        return "SELECT {table}.{pk} FROM {table} WHERE {table}.{pk} IN ({inner})".format(
            pk=self.pk_name,
            table=self.table_name,
            inner=self.inner.render(),
        )


class ManyToOnePathPart(PathPart):
    """
    A :class:`~sir.trigger_generation.PathPart` subclass used to represent a
    selection across a many-to-one relationship between two
    tables.
    """
    def __init__(self, table_name, pk_name, fkname, inner=None):
        PathPart.__init__(self, table_name, pk_name, inner)
        self.fkname = fkname

    def render(self):
        return "SELECT {table}.{pk} FROM {table} WHERE {table}.{fk} IN ({inner})".format(
            pk=self.pk_name,
            table=self.table_name,
            inner=self.inner.render(),
            fk=self.fkname,
        )


class ColumnPathPart(PathPart):
    """
    A :class:`~sir.trigger_generation.PathPart` subclass used to represent the
    selection of the primary key column of the innermost SELECT statement in
    the chain.
    """
    def render(self):
        return "{{new_or_old}}.{pk_name}".format(pk_name=self.pk_name)


class TriggerGenerator(object):
    """
    A class to generate triggers and a corresponding function for a specific
    operation (DELETE/INSERT/UPDATE).
    """
    id_replacement = None

    #: The operation (insert, update, or delete)
    op = None

    #: Whether to execute the trigger BEFORE or AFTER :attr:`op`. Typically
    # BEFORE is used for SELECT and UPDATE queries, AFTER for DELETE queries.
    before_or_after = "AFTER"

    #: The routing key to be used for the message sent via AMQP
    routing_key = None

    def __init__(self, prefix, table_name, path, select, index_table, index, broker_id=1):
        """
        :param str prefix: A prefix for the trigger name.
        :param str table_name: The table on which to generate the trigger.
        :param str path: The path for which the trigger will be generated.
                         It is used to describe triggers and functions in a
                         comment.
        :param str select: A SELECT statement to be embedded in the function.
        :param str index_table: The table with entities that need to be
                                reindexed.
        :param int index: To allow for multiple triggers and functions on a
                          single entity type, we suffix each of them with an
                          index to avoid name collisions.
        :param int broker_id: ID of the AMQP broker row in a database.
        """
        self.prefix = prefix.replace("-", "_")
        self.table_name = table_name
        self.path = path
        select = select.format(new_or_old=self.id_replacement)
        self.select = select
        self.index_table = index_table
        self.index = index
        self.broker_id = broker_id

    @property
    def trigger_name(self):
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
        return textwrap.dedent("""\
            CREATE TRIGGER {trigger_name} {before_or_after} {op} ON {table_name}
                FOR EACH ROW EXECUTE PROCEDURE {trigger_name}();
            COMMENT ON TRIGGER {trigger_name} ON {table_name} IS 'The path for this trigger is {path}';\n
        """).format(
            trigger_name=self.trigger_name,
            table_name=self.table_name,
            op=self.op.upper(),
            before_or_after=self.before_or_after,
            path=self.path,
        )

    @property
    def function(self):
        """
        The ``CREATE FUNCTION`` statement for this trigger.

        :rtype: str
        """
        return textwrap.dedent("""\
            CREATE OR REPLACE FUNCTION {trigger_name}() RETURNS trigger
                AS $$
            DECLARE
                ids TEXT;
            BEGIN
                SELECT string_agg(tmp.id::text, ' ') INTO ids FROM ({select}) AS tmp;
                PERFORM amqp.publish({broker_id}, 'search', '{routing_key}', '{table_name} ' || ids);
                RETURN NULL;
            END;
            $$ LANGUAGE plpgsql;
            COMMENT ON FUNCTION {trigger_name}() IS 'The path for this function is {path}';\n
        """).format(
                trigger_name=self.trigger_name,
                select=self.select,
                broker_id=self.broker_id,
                routing_key=self.routing_key,
                table_name=self.index_table,
                path=self.path,
            )


class DeleteTriggerGenerator(TriggerGenerator):
    """
    A trigger generator for DELETE operations.
    """
    op = "delete"
    id_replacement = "OLD"
    before_or_after = "BEFORE"
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
            "SELECT {table_name}.id".format(table_name=self.table_name),
            "SELECT {table_name}.gid AS id".format(table_name=self.table_name))

    @property
    def function(self):
        """
        The ``CREATE FUNCTION`` statement for this trigger.

        :rtype: str
        """
        return textwrap.dedent("""\
            CREATE OR REPLACE FUNCTION {trigger_name}() RETURNS trigger
                AS $$
            DECLARE
                gids TEXT;
            BEGIN
                SELECT string_agg(tmp.id::text, ' ') INTO gids FROM ({select}) AS tmp;
                PERFORM amqp.publish({broker_id}, 'search', '{routing_key}', '{table_name} ' || gids);
                RETURN NULL;
            END;
            $$ LANGUAGE plpgsql;
            COMMENT ON FUNCTION {trigger_name}() IS 'The path for this function is {path}';\n
        """).format(
            trigger_name=self.trigger_name,
            select=self.select,
            broker_id=self.broker_id,
            routing_key=self.routing_key,
            table_name=self.table_name,
            path=self.path,
        )


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
    op = "update"
    id_replacement = "NEW"
    routing_key = "update"

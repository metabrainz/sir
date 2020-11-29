# Copyright (c) Wieland Hoffmann
# License: MIT, see LICENSE for details
import textwrap

MSG_JSON_TABLE_NAME_KEY = "_table"
MSG_JSON_OPERATION_TYPE = "_operation"


class TriggerGenerator(object):
    """
    Base generator class for triggers and corresponding function that would go
    into the MusicBrainz database.
    """
    #: The operation (`INSERT`, `UPDATE`, or `DELETE`)
    op = None

    # See https://www.postgresql.org/docs/current/static/plpgsql-trigger.html
    # Either `OLD` or `NEW` depending on the operation.
    record_variable = None

    #: Whether to execute the trigger BEFORE or AFTER :attr:`op`. Typically
    # BEFORE is used for SELECT and UPDATE queries, AFTER for DELETE queries.
    before_or_after = "AFTER"

    # The routing key to be used for the message sent via AMQP
    # (`update`, `delete`, or `index`)
    routing_key = None

    def __init__(self, table_name, pk_columns, fk_columns, broker_id=1, **kwargs):
        """
        :param str table_name: The table on which to generate the trigger.
        :param pk_columns: List of primary key column names for a table that
                           this trigger is being generated for.
        :param int broker_id: ID of the AMQP broker row in a database.
        """
        self.table_name = table_name
        self.reference_columns = list(set(pk_columns + fk_columns))
        self.fk_columns = fk_columns
        self.reference_columns.sort()
        self.broker_id = broker_id

    def trigger(self):
        """
        The ``CREATE TRIGGER`` statement for this trigger.

        :rtype: str
        """
        return textwrap.dedent("""\
            CREATE TRIGGER {trigger_name} {before_or_after} {op} ON {schema}.{table_name}
                FOR EACH ROW EXECUTE PROCEDURE {trigger_name}();\n
        """).format(
            trigger_name=self.trigger_name,
            schema="musicbrainz",
            table_name=self.table_name,
            op=self.op.upper(),
            before_or_after=self.before_or_after.upper(),
        )

    def function(self):
        """
        The ``CREATE FUNCTION`` statement for this trigger.

        https://www.postgresql.org/docs/9.0/static/plpgsql-structure.html

        We use https://github.com/omniti-labs/pg_amqp to publish messages to
        an AMQP broker.

        :rtype: str
        """
        return textwrap.dedent("""\
            CREATE OR REPLACE FUNCTION {trigger_name}() RETURNS trigger
                AS $$
            BEGIN
                PERFORM amqp.publish({broker_id}, 'search', '{routing_key}', ({message}));
                RETURN {return_value};
            END;
            $$ LANGUAGE plpgsql;\n
        """).format(
            trigger_name=self.trigger_name,
            broker_id=self.broker_id,
            routing_key=self.routing_key,
            message=self.message,
            return_value=self.record_variable,
        )

    @property
    def trigger_name(self):
        """
        The name of this trigger and its function.

        :rtype: str
        """
        return ("search_" + self.table_name + "_" + self.op).lower()

    @property
    def selection(self):
        raise NotImplementedError

    @property
    def message(self):
        return """
            WITH keys({column_keys}) AS ({select})
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{{{table_name_key}}}', '"{table_name}"'),
                             '{{{operation_type}}}', '"{operation}"')::text FROM keys
        """.format(
                table_name=self.table_name,
                column_keys=", ".join(self.reference_columns),
                select=self.selection,
                table_name_key=MSG_JSON_TABLE_NAME_KEY,  # Assuming that no PK columns have the same name
                operation_type=MSG_JSON_OPERATION_TYPE,
                operation=self.op
            )


class InsertTriggerGenerator(TriggerGenerator):
    """
    A trigger generator for INSERT operations.
    """
    op = "insert"
    record_variable = "NEW"
    before_or_after = "AFTER"
    routing_key = "index"

    @property
    def selection(self):
        return "SELECT {columns}".format(
            columns=", ".join(["{rec}.{col}".format(col=c, rec=self.record_variable)
                               for c in self.reference_columns]),
        )


class UpdateTriggerGenerator(TriggerGenerator):
    """
    A trigger generator for UPDATE operations.
    """
    op = "update"
    record_variable = "NEW"
    before_or_after = "AFTER"
    routing_key = "update"

    def __init__(self, **gen_args):
        super(UpdateTriggerGenerator, self).__init__(**gen_args)
        self.update_columns = gen_args.get("update_columns", None)

    @property
    def selection(self):
        return "SELECT {columns}".format(
            columns=", ".join(["{rec}.{col}".format(col=c, rec=self.record_variable)
                               for c in self.reference_columns]),
        )

    def trigger(self):
        """
        The ``CREATE TRIGGER`` statement for this trigger.

        :rtype: str
        """

        if not self.update_columns:
            return super().triger()

        # Consider FK columns in update triggers to make sure triggers are fired
        # in case any FK of related tables are changed
        all_columns = sorted(set(self.fk_columns + list(self.update_columns)))
        operation = "UPDATE OF %s" % ", ".join(all_columns)
        old = ", ".join(['OLD.{column}'.format(column=column) for column in all_columns])
        new = ", ".join(['NEW.{column}'.format(column=column) for column in all_columns])
        when = "({old}) IS DISTINCT FROM ({new})".format(old=old, new=new)

        return textwrap.dedent("""\
            CREATE TRIGGER {trigger_name} {before_or_after} {op} ON {schema}.{table_name}
                FOR EACH ROW
                WHEN ({when})
                EXECUTE PROCEDURE {trigger_name}();\n
        """).format(
            trigger_name=self.trigger_name,
            schema="musicbrainz",
            table_name=self.table_name,
            op=operation,
            before_or_after=self.before_or_after.upper(),
            when=when
        )


class DeleteTriggerGenerator(TriggerGenerator):
    """
    A trigger generator for DELETE operations.
    """
    op = "delete"
    record_variable = "OLD"
    before_or_after = "BEFORE"
    routing_key = "delete"

    @property
    def selection(self):
        return "SELECT {columns}".format(
            columns=", ".join(["{rec}.{col}".format(col=c, rec=self.record_variable)
                               for c in self.reference_columns]),
        )


class GIDDeleteTriggerGenerator(DeleteTriggerGenerator):
    """
    This trigger generator produces DELETE statements that selects just `gid`
    row and ignores primary keys.

    It should be used for entity tables themselves (in "direct" triggers) for
    tables like "artist", "release_group", "recording", and the rest.
    """

    def __init__(self, *args, **kwargs):
        super(GIDDeleteTriggerGenerator, self).__init__(*args, **kwargs)
        self.reference_columns += ["gid"]


class ReferencedDeleteTriggerGenerator(DeleteTriggerGenerator):
    """
    A trigger generator for DELETE operations for tables which are referenced
    in `SearchEntity` tables. Delete operations in such tables cause the main
    `SearchEntity` tables to be updated.
    """
    routing_key = "update"

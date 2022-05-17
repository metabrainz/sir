# Copyright (c) Wieland Hoffmann
# License: MIT, see LICENSE for details
import textwrap

MSG_JSON_TABLE_NAME_KEY = "_table"
MSG_JSON_OPERATION_TYPE = "_operation"

SIR_SCHEMA = 'sir'
SIR_MESSAGE_TABLE_NAME = 'message'

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

    def __init__(self, table_name, pk_columns, fk_columns, **kwargs):
        """
        :param str table_name: The table on which to generate the trigger.
        :param pk_columns: List of primary key column names for a table that
                           this trigger is being generated for.
        """
        self.table_name = table_name
        self.reference_columns = list(set(pk_columns + fk_columns))
        self.fk_columns = fk_columns
        self.reference_columns.sort()

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

        :rtype: str
        """

        return textwrap.dedent("""\
            CREATE OR REPLACE FUNCTION {trigger_name}() RETURNS trigger
                AS $$
            BEGIN
                INSERT INTO {schema}.{table_name} (exchange, routing_key, message) VALUES ('search', '{routing_key}', ({message}));
                RETURN {return_value};
            END;
            $$ LANGUAGE plpgsql;\n
        """).format(
            schema=SIR_SCHEMA,
            table_name=SIR_MESSAGE_TABLE_NAME,
            trigger_name=self.trigger_name,
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
                             '{{{operation_type}}}', '"{operation}"') FROM keys
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
            return super().trigger()

        # Consider FK columns in update triggers to make sure triggers are fired
        # in case any FK of related tables are changed
        all_columns = sorted(set(self.fk_columns + list(self.update_columns)))
        operation = "UPDATE OF %s" % ", ".join(all_columns)
        # Compare all columns but 'coordinates' because its data type 'point'
        # has no comparison operator '=' (only '=~') to use with 'DISTINCT'.
        try:
            all_columns.remove('coordinates');
        except ValueError as e:
            pass
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

    def function(self):
        """
        The ``CREATE FUNCTION`` statement for this trigger.

        https://www.postgresql.org/docs/9.0/static/plpgsql-structure.html

        :rtype: str
        """
        update_condition = ""
        end_update_condition = ""
        # Consider FK columns in update triggers to make sure triggers are fired
        # in case any FK of related tables are changed
        if self.update_columns:
            all_columns = set(self.fk_columns + list(self.update_columns))
            update_condition = "IF %s THEN" % " OR ".join([("OLD.%s <> NEW.%s" % (column, column)) for column in sorted(all_columns)])
            end_update_condition = "END IF;"

        return textwrap.dedent("""\
            CREATE OR REPLACE FUNCTION {trigger_name}() RETURNS trigger
                AS $$
            BEGIN
                {update_condition}
                    INSERT INTO {schema}.{table_name} (exchange, routing_key, message) VALUES ('search', '{routing_key}', ({message}));
                {end_update_condition}
                RETURN {return_value};
            END;
            $$ LANGUAGE plpgsql;\n
        """).format(
            schema=SIR_SCHEMA,
            table_name=SIR_MESSAGE_TABLE_NAME,
            trigger_name=self.trigger_name,
            routing_key=self.routing_key,
            message=self.message,
            return_value=self.record_variable,
            update_condition=update_condition,
            end_update_condition=end_update_condition
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


class SirMessageTableGenerator(object):
    """
    A create generator for database update message.
    """
    def create(self):
        """
        The ``CREATE TABLE`` statement for the sir.message table.

        :rtype: str
        """
        return textwrap.dedent("""\
            CREATE SCHEMA {schema};
            CREATE TABLE {schema}.{message_table_name} (
                id                  serial      PRIMARY KEY,
                exchange            varchar(40) NOT NULL,
                routing_key         varchar(40) NOT NULL,
                message             jsonb       NOT NULL,
                created             timestamptz DEFAULT current_timestamp
            );\n
        """).format(
            schema=SIR_SCHEMA,
            message_table_name=SIR_MESSAGE_TABLE_NAME
        )


class InsertAMQPTriggerGenerator(object):
    """
    A trigger generator for AMQP operations.
    """
    #: The operation
    op = 'INSERT'

    def __init__(self, broker_id=1, **kwargs):
        """
        :param int broker_id: ID of the AMQP broker row in a database.
        """
        self.broker_id = broker_id

    def trigger(self):
        """
        The ``CREATE TRIGGER`` statement for this trigger.

        :rtype: str
        """
        return textwrap.dedent("""\
            CREATE TRIGGER {trigger_name} BEFORE {op} ON {schema}.{table_name}
                FOR EACH ROW EXECUTE PROCEDURE {trigger_name}();\n
        """).format(
            op=self.op.upper(),
            trigger_name=self.trigger_name,
            schema=SIR_SCHEMA,
            table_name=SIR_MESSAGE_TABLE_NAME
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
                PERFORM amqp.publish({broker_id}, NEW.exchange, NEW.routing_key, NEW.message::text);
                RETURN NULL;
            END;
            $$ LANGUAGE plpgsql;\n
        """).format(
            trigger_name=self.trigger_name,
            broker_id=self.broker_id
        )

    @property
    def trigger_name(self):
        """
        The name of this trigger and its function.

        :rtype: str
        """
        return ("search_" + SIR_MESSAGE_TABLE_NAME + "_" + self.op).lower()

    @property
    def selection(self):
        raise NotImplementedError

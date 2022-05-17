# Copyright (c) Wieland Hoffmann
# License: MIT, see LICENSE for details
from sir.schema import SCHEMA, generate_update_map
from sir.trigger_generation.paths import unique_split_paths, last_model_in_path
from sir.trigger_generation import sql_generator
from sqlalchemy.orm import class_mapper
import collections

column_map = generate_update_map()[1]


def generate_func(args):
    """
    This is the entry point for this trigger_generation module. This function
    gets called from :func:`~sir.__main__.main`.
    """
    generate(
        trigger_filename=args["trigger_file"],
        function_filename=args["function_file"],
        create_sir_message_table_filename=args["create_sir_message_table_file"],
        amqp_trigger_filename=args["amqp_trigger_file"],
        amqp_function_filename=args["amqp_function_file"],
        broker_id=args["broker_id"],
        entities = args["entity_type"] or SCHEMA.keys()
    )


def generate(trigger_filename, function_filename, create_sir_message_table_filename, \
    amqp_trigger_filename, amqp_function_filename, broker_id, entities):
    """Generates SQL queries that create and remove triggers for the MusicBrainz database.

    Generation works in the following way:

        1. Determine which tables need to have triggers on them:
            * Entity tables themselves
            * Tables in every path of entity's fields

        2. Generates SQL to create a sir_message table

        3. Generate triggers (for inserts, updates, and deletions) for each table (model in mbdata):
            3.1. Get a list of PKs
            3.2. Write triggers that send messages into the sir_message table ("search.index"
                 for INSERT and UPDATE queries, "search.delete" for DELETE queries):

                    <table name>, PKs{<PK row name>, <PK value>}

        4. Generate triggers (for inserts) for the sir_message table:
            4.1. Write trigger that sends new messages into the appropriate RabbitMQ queues
                 ("search.index" queue for "search.index" messages, "search.delete" queue
                 for "search.delete" messages)

        4. Write generated triggers into SQL scripts to be run on the MusicBrainz database

    Since table might have multiple primary keys, we need to explicitly specify their row names and values.
    """
    with open(trigger_filename,  "w") as triggerfile, \
         open(function_filename, "w") as functionfile, \
         open(create_sir_message_table_filename, "w") as create_sir_message_tablefile, \
         open(amqp_trigger_filename,  "w") as amqp_triggerfile, \
         open(amqp_function_filename, "w") as amqp_functionfile:

        # Write mbdata tables' triggers and functions
        write_header(triggerfile)
        write_header(functionfile)
        for table_name, table_info in get_trigger_tables(entities).items():
            write_triggers(
                trigger_file=triggerfile,
                function_file=functionfile,
                model=table_info["model"],
                is_direct=table_info["is_direct"],
                has_gid=table_info.get('has_gid', False)
            )
        write_footer(triggerfile)
        write_footer(functionfile)

        # Write create message table SQL
        write_header(create_sir_message_tablefile)
        write_create_sir_message_table(
            message_table_file=create_sir_message_tablefile
        )
        write_footer(create_sir_message_tablefile)

        # Write AMQP trigger and function
        write_header(amqp_triggerfile)
        write_header(amqp_functionfile)
        write_amqp_triggers(
            amqp_trigger_file=amqp_triggerfile,
            amqp_function_file=amqp_functionfile,
            broker_id=broker_id,
        )
        write_footer(amqp_triggerfile)
        write_footer(amqp_functionfile)


def get_trigger_tables(entities):
    """Determines which tables need to have triggers set on them.

    Returns a dictionary of table names (key) with a dictionary (value) that
    provides additional information about a table:

        * list of primary keys for each table.
        * whether it's an entity table

    :param [str] entities Which entity types to index if not all.
    """
    tables = collections.OrderedDict()  # mapping of table names to their models and their "kind" (direct or not)
    for entity in [SCHEMA[name] for name in entities]:
        # Entity table itself
        mapped_class = class_mapper(entity.model)
        tables[mapped_class.mapped_table.name] = {
            "model": entity.model,
            "is_direct": True,
            "has_gid": mapped_class.has_property('gid'),
        }
        # Tables that contain the referenced column
        # TODO(roman): maybe come up with a better description above
        for path in unique_split_paths([path for field in entity.fields
                                             for path in field.paths if field.trigger]):
            model = last_model_in_path(entity.model, path)
            if model is not None:
                table_name = class_mapper(model).mapped_table.name
                if table_name not in tables:
                    tables[table_name] = {
                        "model": model,
                        "is_direct": False,
                    }

    return tables


def write_triggers(trigger_file, function_file, model, is_direct, has_gid, **generator_args):
    """
    :param str file trigger_file: File where triggers will be written.
    :param str file function_file: File where functions will be written.
    :param model: A :ref:`declarative <sqla:declarative_toplevel>` class.
    :param bool is_direct: Whether this is an entity table or not.
    """
    # Mapper defines correlation of model class attributes to database table columns
    mapper = class_mapper(model)
    table_name = mapper.mapped_table.name
    fk_columns = [list(r.local_columns)[0].name for r in mapper.relationships
                  if r.direction.name == 'MANYTOONE']
    if is_direct:
        if has_gid:
            delete_trigger_generator = sql_generator.GIDDeleteTriggerGenerator
        else:
            delete_trigger_generator = sql_generator.DeleteTriggerGenerator
    else:
        delete_trigger_generator = sql_generator.ReferencedDeleteTriggerGenerator
    update_columns = None
    if table_name in column_map:
        update_columns = column_map[table_name]
    write_triggers_to_file(
        trigger_file=trigger_file,
        function_file=function_file,
        generators=[
            sql_generator.InsertTriggerGenerator,
            sql_generator.UpdateTriggerGenerator,
            delete_trigger_generator,
        ],
        table_name=table_name,
        pk_columns=[pk.name for pk in mapper.primary_key],
        fk_columns=fk_columns,
        update_columns=update_columns,
        **generator_args
    )


def write_create_sir_message_table(message_table_file):
    """
    :param str sir_message table file message_table_file: File where sir_message create table is written.
    """
    message_table_file.write(sql_generator.SirMessageTableGenerator().create())


def write_amqp_triggers(amqp_trigger_file, amqp_function_file, **generator_args):
    """
    :param str AMQP file trigger_file: File where AMQP triggers will be written.
    :param str AMQP file function_file: File where AMQP functions will be written.
    """
    write_triggers_to_file(
        trigger_file=amqp_trigger_file,
        function_file=amqp_function_file,
        generators=[
            sql_generator.InsertAMQPTriggerGenerator,
        ],
        **generator_args
    )


def write_triggers_to_file(generators, trigger_file, function_file, **generator_args):
    """Write SQL for creation of triggers (for deletion, insertion, and updates) and
    associated functions into files.

    :param list generators: A set of generator classes (based on``TriggerGenerator``)
                            to use for creating SQL statements.
    :param file trigger_file: File into which commands for creating triggers will be written.
    :param file function_file: File into which commands for creating trigger functions
                               will be written.
    """
    for gen in generators:
        gen_obj = gen(**generator_args)
        function_file.write(gen_obj.function())
        trigger_file.write(gen_obj.trigger())


def write_header(f):
    """Write an SQL "header" into a file.

    Adds a note about editing, sets command line options, and begins a
    transaction. Should be written at the beginning of each SQL script.

    :param file f: File to write the header into.
    """
    f.write("-- Automatically generated, do not edit!\n")
    f.write("\set ON_ERROR_STOP 1\n")
    f.write("BEGIN;\n\n")


def write_footer(f):
    """Write an SQL "footer" into a file.

    Adds a statement to commit a transaction. Should be written at the end of
    each SQL script that wrote a header (see `write_header` function).

    :param file f: File to write the footer into.
    """
    f.write("COMMIT;\n")

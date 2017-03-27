# Copyright (c) Wieland Hoffmann
# License: MIT, see LICENSE for details
from sir.schema import SCHEMA
from sir.trigger_generation.paths import unique_split_paths, walk_path
from sir.trigger_generation import sql_generator
from sqlalchemy.orm import class_mapper
import collections


def generate(trigger_filename, function_filename, broker_id):
    """Generates SQL queries that create and remove triggers for the MusicBrainz database.

    Generation works in the following way:

        1. Determine which tables need to have triggers on them:
            * Entity tables themselves
            * Tables in every path of entity's fields

        2. Generate triggers (for inserts, updates, and deletions) for each table (model in mbdata):
            2.1. Get a list of PKs
            2.2. Write triggers that would send messages into appropriate RabbitMQ queues ("search.index"
                 queue for INSERT and UPDATE queries, "search.delete" for DELETE queries):

                    <table name>, PKs{<PK row name>, <PK value>}

        3. Write generated triggers into SQL scripts to be run on the MusicBrainz database

    Since table might have multiple primary keys, we need to explicitly specify their row names and values.
    """
    with open(trigger_filename,  "w") as triggerfile, \
         open(function_filename, "w") as functionfile:

        write_header(triggerfile)
        write_header(functionfile)

        for table_name, table_info in get_trigger_tables().items():
            write_triggers(
                trigger_file=triggerfile,
                function_file=functionfile,
                model=table_info["model"],
                is_direct=table_info["is_direct"],
                broker_id=broker_id,
            )
        write_footer(triggerfile)
        write_footer(functionfile)


def get_trigger_tables():
    """Determines which tables need to have triggers set on them.

    Returns a dictionary of table names (key) with a dictionary (value) that
    provides additional information about a table:

        * list of primary keys for each table.
        * whether it's an entity table
    """
    tables = collections.OrderedDict()  # mapping of table names to their models and their "kind" (direct or not)
    for _, entity in SCHEMA.items():
        # Entity table itself
        tables[class_mapper(entity.model).mapped_table.name] = {
            "model": entity.model,
            "is_direct": True,
        }

        # Tables that contain the referenced column
        # TODO(roman): maybe come up with a better description above
        for path in unique_split_paths([path for field in entity.fields
                                             for path in field.paths]):
            model = walk_path(entity.model, path)
            if model is not None:
                table_name = class_mapper(model).mapped_table.name
                if table_name not in tables:
                    tables[table_name] = {
                        "model": model,
                        "is_direct": False,
                    }

    return tables


def write_triggers(trigger_file, function_file, model, is_direct, **generator_args):
    """
    :param str file trigger_file: File where triggers will be written.
    :param str file function_file: File where functions will be written.
    :param model: A :ref:`declarative <sqla:declarative_toplevel>` class.
    :param bool is_direct: Whether this is an entity table or not.
    """
    # Mapper defines correlation of model class attributes to database table columns
    mapper = class_mapper(model)
    table_name = mapper.mapped_table.name

    if is_direct:
        delete_trigger_generator = sql_generator.GIDDeleteTriggerGenerator
    else:
        delete_trigger_generator = sql_generator.DeleteTriggerGenerator

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

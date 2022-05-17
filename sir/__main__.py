from __future__ import absolute_import
# Copyright (c) 2014, 2015, 2019 Wieland Hoffmann, MetaBrainz Foundation
# License: MIT, see LICENSE for details
import argparse
import logging
import multiprocessing
import ConfigParser

from . import config, init_sentry_sdk
from .amqp.extension_generation import generate_extension
from .amqp.handler import watch
from .amqp.publisher import publish
from .amqp.setup import setup_rabbitmq
from .indexing import reindex
from .schema import SCHEMA
from .trigger_generation import generate_func


logger = logging.getLogger("sir")


def main():

    parser = argparse.ArgumentParser(prog="sir")
    parser.add_argument("-d", "--debug", action="store_true")
    parser.add_argument("--sqltimings", action="store_true")
    subparsers = parser.add_subparsers()

    reindex_parser = subparsers.add_parser("reindex",
                                           help="Reindexes all or a single "
                                           "entity type")
    reindex_parser.set_defaults(func=reindex)
    reindex_parser.add_argument('--entity-type', action='append',
                                help="Which entity types to index.",
                                choices=SCHEMA.keys())

    generate_trigger_parser = subparsers.add_parser("triggers",
                                                    help="Generate triggers")
    generate_trigger_parser.set_defaults(func=generate_func)
    generate_trigger_parser.add_argument('-t', '--trigger-file',
                                         action="store",
                                         default="sql/CreateTriggers.sql",
                                         help="The filename to save the "
                                         "triggers into")
    generate_trigger_parser.add_argument('-f', '--function-file',
                                         action="store",
                                         default="sql/CreateFunctions.sql",
                                         help="The filename to save the "
                                         "functions into")
    generate_trigger_parser.add_argument('-c', '--create-sir-message-table-file',
                                         action="store",
                                         default="sql/CreateSirMessageTable.sql",
                                         help="The filename to save the "
                                         "message table create SQL into")
    generate_trigger_parser.add_argument('-a', '--amqp-trigger-file',
                                         action="store",
                                         default="sql/CreateAMQPTrigger.sql",
                                         help="The filename to save the "
                                         "change table AMQP trigger into")
    generate_trigger_parser.add_argument('-m', '--amqp-function-file',
                                         action="store",
                                         default="sql/CreateAMQPFunction.sql",
                                         help="The filename to save the "
                                         "change table AMQP function into")
    generate_trigger_parser.add_argument('-bid', '--broker-id',
                                         action="store",
                                         default="1",
                                         help="ID of the AMQP broker row "
                                         "in the database.")
    generate_trigger_parser.add_argument('--entity-type', action='append',
                                         help="Which entity types to index.",
                                         choices=SCHEMA.keys())

    generate_extension_parser = subparsers.add_parser("extension",
                                                      help="Generate extension")
    generate_extension_parser.set_defaults(func=generate_extension)
    generate_extension_parser.add_argument('-e', '--extension-file',
                                           action="store",
                                           default="sql/CreateExtension.sql",
                                           help="The filename to save the "
                                           "extension into")

    amqp_setup_parser = subparsers.add_parser("amqp_setup",
                                              help="Set up AMQP exchanges and "
                                              "queues")
    amqp_setup_parser.set_defaults(func=setup_rabbitmq)

    amqp_watch_parser = subparsers.add_parser("amqp_watch",
                                              help="Watch AMQP queues for "
                                              "changes")
    amqp_watch_parser.add_argument('--entity-type', action='append',
                                   help="Which entity types to watch.",
                                   choices=SCHEMA.keys())

    amqp_watch_parser.set_defaults(func=watch)
    
    amqp_publish_parser = subparsers.add_parser("amqp_publish",
                                              help="Publish SIR messages to AMQP queues")
    amqp_publish_parser.set_defaults(func=publish)

    args = parser.parse_args()
    if args.debug:
        logger.setLevel(logging.DEBUG)
    else:
        logger.setLevel(logging.INFO)

    loghandler = logging.StreamHandler()
    if args.debug:
        formatter = logging.Formatter(fmt="%(processName)s %(asctime)s  "
                                      "%(levelname)s: %(message)s")
    else:
        formatter = logging.Formatter(fmt="%(asctime)s: %(message)s")
    loghandler.setFormatter(formatter)
    logger.addHandler(loghandler)

    mplogger = multiprocessing.get_logger()
    mplogger.setLevel(logging.ERROR)
    mplogger.addHandler(loghandler)

    if args.sqltimings:
        from sqlalchemy import event
        from sqlalchemy.engine import Engine
        import time

        sqltimelogger = logging.getLogger("sqltimer")
        sqltimelogger.setLevel(logging.DEBUG)
        sqltimelogger.addHandler(loghandler)

        @event.listens_for(Engine, "before_cursor_execute")
        def before_cursor_execute(conn, cursor, statement,
                                  parameters, context, executemany):
            conn.info.setdefault('query_start_time', []).append(time.time())
            sqltimelogger.debug("Start Query: %s", statement)
            sqltimelogger.debug("With Parameters: %s", parameters)

        @event.listens_for(Engine, "after_cursor_execute")
        def after_cursor_execute(conn, cursor, statement,
                                 parameters, context, executemany):
            total = time.time() - conn.info['query_start_time'].pop(-1)
            sqltimelogger.debug("Query Complete!")
            sqltimelogger.debug("Total Time: %f", total)

    config.read_config()
    try:
        init_sentry_sdk(config.CFG.get("sentry", "dsn"))
    except ConfigParser.Error as e:
        logger.info("Skipping sentry initialization. Configuration issue: %s", e)
    func = args.func
    args = vars(args)
    func(args)


if __name__ == '__main__':
    main()

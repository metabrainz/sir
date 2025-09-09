# Copyright (c) 2014, 2015, 2019 Wieland Hoffmann, MetaBrainz Foundation
# License: MIT, see LICENSE for details
import argparse
import logging
import multiprocessing
import configparser
from pathlib import Path

from . import config, init_sentry_sdk
from .amqp.handler import watch
from .indexing import reindex
from .schema import SCHEMA

SQL_DIR = Path(__file__).resolve().parent.parent / "sql"


logger = logging.getLogger("sir")


def _run_sql_files(file_names):
    """Execute a list of SQL files against the configured database."""
    from .util import engine as create_engine
    from sqlalchemy import text

    eng = create_engine()
    for name in file_names:
        path = SQL_DIR / name
        sql = path.read_text()
        # Strip psql meta-commands (\set, \unset) that aren't valid SQL
        lines = [line for line in sql.splitlines()
                 if not line.strip().startswith("\\")]
        clean_sql = "\n".join(lines)
        logger.info("Executing %s", name)
        with eng.connect() as conn:
            conn.execute(text(clean_sql))
            conn.commit()
        logger.info("Done: %s", name)


def setup_sql(args):
    """Create sir schema, tables, functions, and triggers."""
    _run_sql_files([
        "CreateTables2.sql",
        "CreateFunctions2.sql",
        "CreateTriggers2.sql",
    ])


def drop_sql(args):
    """Drop sir triggers, functions, tables, and schema."""
    _run_sql_files([
        "DropTriggers2.sql",
        "DropFunctions2.sql",
        "DropTables2.sql",
    ])


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

    live_parser = subparsers.add_parser(
        "live",
        help="Poll for database changes and update the search index"
    )
    live_parser.add_argument(
        '--entity-type',
        action='append',
        help="Which entity types to watch.",
        choices=SCHEMA.keys()
    )

    live_parser.set_defaults(func=watch)

    setup_parser = subparsers.add_parser(
        "setup",
        help="Create sir schema, tables, functions, and triggers in the database"
    )
    setup_parser.set_defaults(func=setup_sql)

    drop_parser = subparsers.add_parser(
        "drop",
        help="Drop sir triggers, functions, tables, and schema from the database"
    )
    drop_parser.set_defaults(func=drop_sql)

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
    except configparser.Error as e:
        logger.info("Skipping sentry initialization. Configuration issue: %s", e)
    func = args.func
    args = vars(args)
    func(args)


if __name__ == '__main__':
    main()

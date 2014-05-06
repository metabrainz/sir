# Copyright (c) 2014 Wieland Hoffmann
# License: MIT, see LICENSE for details
import argparse
import logging


from . import config
from .indexing import reindex
from .schema import SCHEMA


logger = logging.getLogger("sir")


def watch(args):
    raise NotImplementedError


def main():
    loghandler = logging.StreamHandler()
    formatter = logging.Formatter(fmt="%(threadName)s %(asctime)s  %(levelname)s: %(message)s")
    loghandler.setFormatter(formatter)
    logger.addHandler(loghandler)

    futureslogger = logging.getLogger("concurrent.futures")
    futureslogger.addHandler(loghandler)

    parser = argparse.ArgumentParser()
    parser.add_argument("-d", "--debug", action="store_true")
    subparsers = parser.add_subparsers()

    reindex_parser = subparsers.add_parser("reindex", help="Reindexes all or a single entity type")
    reindex_parser.set_defaults(func=reindex)
    reindex_parser.add_argument('--entities', action='append', help="""Which
        entity types to index.

        Available are: %s""" % (", ".join(SCHEMA.keys())))

    watch_parser = subparsers.add_parser("watch", help="Watches for incoming messages on an AMQP queue")
    watch_parser.set_defaults(func=watch)

    args = parser.parse_args()
    if args.debug:
        logger.setLevel(logging.DEBUG)
        logging.getLogger("sqlalchemy.engine").setLevel(logging.DEBUG)
    else:
        logger.setLevel(logging.INFO)
    config.read_config()
    func = args.func
    args = vars(args)
    func(args["entities"])

if __name__ == '__main__':
    main()
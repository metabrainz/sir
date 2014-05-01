import argparse
import logging
import solr


from . import indexing, querying, util
from .schema import SCHEMA


logger = logging.getLogger("sir")


def reindex(args):
    known_entities = SCHEMA.keys()
    if args['entities'] is not None:
        entities = []
        for e in args['entities']:
            entities.extend(e.split(','))
        unknown_entities = set(entities) - set(known_entities)
        if unknown_entities:
            raise ValueError("{0} are unkown entity types".format(unknown_entities))
    else:
        entities = known_entities

    try:
        db_uri, solr_uri = util.read_config()
    except ConfigParser.Error, e:
        logger.error("%s - please configure this application in the file config.ini", e.message)
        return

    db_session = util.db_session(db_uri, args["debug"])

    for e in entities:
        query = querying.build_entity_query(db_session, SCHEMA[e])
        uri = solr_uri + "/" + e
        s = solr.Solr(uri)
        indexing.index_entity(s, query, SCHEMA[e])


def watch(args):
    raise NotImplementedError


def main():
    logger.addHandler(logging.StreamHandler())

    parser = argparse.ArgumentParser()
    parser.add_argument("-d", "--debug", action="store_true")
    subparsers = parser.add_subparsers()

    reindex_parser = subparsers.add_parser("reindex", help="Reindexes all or a single entity type")
    reindex_parser.set_defaults(func=reindex)
    reindex_parser.add_argument('--entities', action='append', help='The entities to reindex' )

    watch_parser = subparsers.add_parser("watch", help="Watches for incoming messages on an AMQP queue")
    watch_parser.set_defaults(func=watch)

    args = parser.parse_args()
    if args.debug:
        logger.setLevel(logging.DEBUG)
    else:
        logger.setLevel(logging.INFO)
    args.func(vars(args))

if __name__ == '__main__':
    main()
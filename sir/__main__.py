import argparse
import logging


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
    print(entities)


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
    args.func(vars(args))

if __name__ == '__main__':
    main()
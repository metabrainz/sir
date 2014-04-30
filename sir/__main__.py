import argparse


from .schema import SCHEMA


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
    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers()

    reindex_parser = subparsers.add_parser("reindex", help="Reindexes all or a single entity type")
    reindex_parser.set_defaults(func=reindex)
    reindex_parser.add_argument('--entities', action='append', help='The entities to reindex' )

    watch_parser = subparsers.add_parser("watch", help="Watches for incoming messages on an AMQP queue")
    watch_parser.set_defaults(func=watch)

    args = parser.parse_args()
    args.func(vars(args))

if __name__ == '__main__':
    main()
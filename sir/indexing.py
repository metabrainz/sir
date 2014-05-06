# Copyright (c) 2014 Lukas Lalinsky, Wieland Hoffmann
# License: MIT, see LICENSE for details
import futures


from . import config, querying, util
from .schema import SCHEMA
from collections import defaultdict, namedtuple
from ConfigParser import Error, NoOptionError
from functools import partial
from logging import getLogger
from urllib2 import URLError


logger = getLogger("sir")


def _future_callback(future):
    logger.info("Result: %s, Exception: %s", future.result(), future.exception())


def reindex(entities, debug=False):
    """
    Reindexes all entity types in ``entities``.

    :param entities:
    :type entities: A list of :class:`sir.schema.searchentities.SearchEntity`
                    objects
    :param bool debug:
    """
    known_entities = SCHEMA.keys()
    if entities is not None:
        _entities = []
        for e in entities:
            _entities.extend(e.split(','))
        unknown_entities = set(_entities) - set(known_entities)
        if unknown_entities:
            raise ValueError("{0} are unkown entity types".format(unknown_entities))
    else:
        _entities = known_entities

    try:
        db_uri = config.CFG.get("database", "uri")
    except Error, e:
        logger.error("%s - please configure this application in the file config.ini", e.message)
        return

    db_session = util.db_session(db_uri, debug)

    with futures.ThreadPoolExecutor(max_workers=config.CFG.getint("sir", "import_threads")) as executor:
        for e in entities:
                future = executor.submit(index_entity, db_session=db_session,
                                         entity_name=e)
                future.add_done_callback(_future_callback)


def index_entity(db_session, entity_name):
    """
    Indexes a single entity type.

    :param sqlalchemy.orm.scoping.scoped_session db_session:
    :param sqlalchemy.orm.query.Query query:
    :param str entity_name:
    :raises solr.SolrException:
    """
    search_entity = SCHEMA[entity_name]
    session = db_session()
    query = querying.build_entity_query(search_entity)
    query = query.with_session(session)

    num_rows = querying.max_id_of(search_entity, db_session)

    batch_size = config.CFG.getint("solr", "batch_size")

    solr_uri = config.CFG.get("solr", "uri")
    solr_connection = util.solr_connection(solr_uri, entity_name)

    data = []
    try:
        for row in queryingQueryIterator(query, num_rows, search_entity.model) :
            data.append(query_result_to_dict(search_entity, row))
            if len(data) == batch_size:
                solr_connection.add_many(data)
                logger.debug("Sent %i records to %s", len(data),
                            solr_connection.url)
                data = []
        if len(data) > 0:
            # There's some left-over data that's not large enough for a
            # complete batch.
            solr_connection.add_many(data)
            logger.debug("Sent %i records to %s", len(data),
                        solr_connection.url)
    finally:
        db_session.remove()


def query_result_to_dict(entity, obj):
    """
    Converts the result of single ``query`` result into a dictionary via the
    field specification of ``entity``.

    :param sir.schema.searchentities.SearchEntity entity:
    :param obj: A :ref:`declarative <sqla:declarative_toplevel>` object.
    """
    data = {}
    for field in entity.fields:
        fieldname = field.name
        tempvals = set()
        for path in field.paths:
            for val in querying._iterate_path_values(path, obj):
                tempvals.add(val)
        if field.transformfunc is not None:
            tempvals = field.transformfunc(tempvals)
        if isinstance(tempvals, set) and len(tempvals) == 1:
            tempvals = tempvals.pop()
        logger.debug("Field %s: %s", fieldname, tempvals)
        data[fieldname] = tempvals
    return data

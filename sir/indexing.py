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


def _future_callback(info, future):
    logger.info("Done: %s: %s, %s", info, future.result(), future.exception())


_FutureInfo = namedtuple("_FutureInfo", "entity lower upper")


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
        solr_uri = config.CFG.get("solr", "uri")
    except Error, e:
        logger.error("%s - please configure this application in the file config.ini", e.message)
        return

    db_session = util.db_session(db_uri, debug)

    query_batch_size = config.CFG.getint("sir", "query_batch_size")
    entity_to_index_func = defaultdict(list)
    for e in _entities:
        try:
            solr_connection = util.solr_connection(solr_uri, e)
        except URLError, e:
            logger.error("Establishing a connection to Solr at %s failed: %s",
                         solr_uri, e.reason)
            return

        search_entity = SCHEMA[e]
        query = querying.build_entity_query(search_entity)

        num_rows = querying.max_id_of(search_entity, db_session)
        model = search_entity.model

        try:
            importlimit = config.CFG.getint("sir", "importlimit")
        except NoOptionError, exc:
            importlimit = 0

        if importlimit > 0:
            logger.info("Applying a limit of %i", importlimit)
            query = query.filter(model.id < importlimit)

        lower_bound = 0
        for upper_bound in xrange(lower_bound + query_batch_size,
                                  num_rows + query_batch_size + 1,
                                  query_batch_size or num_rows):
            logger.debug("Adding a Query for %s from %i to %i", e, lower_bound,
                         upper_bound)
            new_query = query.filter(model.id.between(lower_bound, upper_bound))
            info = _FutureInfo(e, lower_bound, upper_bound)
            lower_bound = upper_bound + 1
            entity_to_index_func[e].append((partial(index_entity,
                                           solr_connection=solr_connection,
                                           query=new_query),
                                           info))
            if importlimit and upper_bound >= importlimit:
                break

    with futures.ThreadPoolExecutor(max_workers=config.CFG.getint("sir", "import_threads")) as executor:
        for e, v in entity_to_index_func.iteritems():
            for f, info in v:
                future = executor.submit(f, db_session=db_session, search_entity=SCHEMA[e])
                future.add_done_callback(partial(_future_callback, info))


def index_entity(db_session, solr_connection, query, search_entity):
    """
    Indexes a single entity type.

    :param sqlalchemy.orm.scoping.scoped_session db_session:
    :param solr.Solr solr_connection:
    :param sqlalchemy.orm.query.Query query:
    :param sir.schema.searchentities.SearchEntity search_entity:
    :raises solr.SolrException:
    """
    session = db_session()
    query = query.with_session(session)
    data = []
    batch_size = config.CFG.getint("solr", "batch_size")
    try:
        for row in query:
            data.append(query_result_to_dict(search_entity, row))
            if len(data) == batch_size:
                solr_connection.add_many(data)
                logger.info("Sent %i records to %s", len(data),
                            solr_connection.url)
                data = []
        if len(data) > 0:
            # There's some left-over data that's not large enough for a
            # complete batch.
            solr_connection.add_many(data)
            logger.info("Sent %i records to %s", len(data),
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

# Copyright (c) 2014 Lukas Lalinsky, Wieland Hoffmann
# License: MIT, see LICENSE for details
import multiprocessing


from . import config, querying, util
from .schema import SCHEMA
from ConfigParser import Error, NoOptionError
from functools import partial
from logging import getLogger
from solr import SolrException
from sqlalchemy import and_


logger = getLogger("sir")


STOP = None


def reindex(entities):
    """
    Reindexes all entity types in ``entities``.

    :param entities: The entities to index.
    :type entities: [str]
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
        logger.info("Checking whether the versions of the Solr cores are "
                    "supported")
        util.check_solr_cores_version(_entities)
    except util.VersionMismatchException as exc:
        logger.error(exc)
        return

    _multiprocessed_import(_entities)


def _multiprocessed_import(entities):
    """
    Does the real work to import all ``entities`` in multiple processes via the
    :mod:`multiprocessing` module.

    :param entities:
    :type entities: [str]
    """
    try:
        solr_uri = config.CFG.get("solr", "uri")
    except Error, e:
        logger.error("%s - please configure this application in the file config.ini", e.message)
        return

    query_batch_size = config.CFG.getint("sir", "query_batch_size")
    try:
        importlimit = config.CFG.getint("sir", "importlimit")
    except NoOptionError:
        importlimit = 0

    max_processes = config.CFG.getint("sir", "import_threads")
    solr_batch_size = config.CFG.getint("solr", "batch_size")

    db_uri = config.CFG.get("database", "uri")
    db_session = util.db_session(db_uri)

    # Only allow one task per child to prevent the process consuming too much
    # memory
    pool = multiprocessing.Pool(max_processes, maxtasksperchild=1)
    index_function_args = []
    for e in entities:
        manager = multiprocessing.Manager()
        entity_data_queue = manager.Queue()

        solr_connection = util.solr_connection(solr_uri, e)
        process_function = partial(queue_to_solr,
                                   entity_data_queue,
                                   solr_batch_size,
                                   solr_connection)

        solr_process = multiprocessing.Process(name="solr", target=process_function)
        solr_process.start()
        logger.info("The queue workers PID is %i", solr_process.pid)

        for bounds in querying.iter_bounds(db_session(), SCHEMA[e].model.id,
                                           query_batch_size, importlimit):
            args = (e, db_uri, bounds, entity_data_queue)
            index_function_args.append(args)

        try:
            results = pool.imap(_index_entity_process_wrapper,
                                index_function_args)
            for r in results:
                pass
        except (KeyboardInterrupt, Exception) as exc:
            logger.error(exc)
        else:
            logger.info("Importing %s successful!", e)
        pool.terminate()
        pool.join()
        entity_data_queue.put(STOP)
        solr_process.join()


def _index_entity_process_wrapper(args):
    """
    Calls :func:`sir.indexing.index_entity` with ``args`` unpacked.
    If a :exc:`KeyboardInterrupt` happens while this functions runs, the
    exception will be **returned**, **not** (re-)raised.

    See http://jessenoller.com/2009/01/08/multiprocessingpool-and-keyboardinterrupt/
    for reasons why.

    :rtype: None or an Exception
    """
    try:
        return index_entity(*args)
    except (KeyboardInterrupt) as exc:
        return exc


def index_entity(entity_name, db_uri, bounds, data_queue):
    """
    Retrieve rows for a single entity type identified by ``entity_name``,
    convert them to a dict with :func:`sir.indexing.query_result_to_dict` and
    put the dicts into ``queue``.

    :param str entity_name:
    :param str db_uri:
    :param bounds:
    :type bounds: (int, int)
    :param Queue.Queue data_queue:
    """
    search_entity = SCHEMA[entity_name]
    model = search_entity.model
    logger.info("Indexing %s %s", model, bounds)
    lower_bound, upper_bound = bounds
    if upper_bound is not None:
        condition = and_(model.id >= lower_bound, model.id < upper_bound)
    else:
        condition = model.id >= lower_bound
    row_converter = partial(query_result_to_dict, search_entity)

    session = util.db_session(db_uri)()
    query = querying.build_entity_query(search_entity).\
        filter(condition).\
        with_session(session)
    try:
        map(lambda row: data_queue.put(row_converter(row)), query)
    finally:
        logger.info("Retrieved all %s records in %s", model, bounds)
        session.commit()
        session.close()


def queue_to_solr(queue, batch_size, solr_connection):
    """
    Read :class:`dict` objects from ``queue`` and send them to the Solr server
    behind ``solr_connection`` in batches of ``batch_size``.

    :param multiprocessing.Queue queue:
    :param int batch_size:
    :param solr.Solr solr_connection:
    """
    data = []
    try:
        for item in iter(queue.get, None):
            data.append(item)
            if len(data) >= batch_size:
                try:
                    solr_connection.add_many(data)
                except SolrException as exc:
                    if exc.httpcode == 400:
                        logger.info("""Received a Bad Request response form Solr,
                        continuing anyway""")
                    else:
                        logger.error(exc)
                        break
                else:
                    logger.debug("Sent data to Solr")
                data = []
    except Exception:
        raise
    else:
        logger.info("%s: Sending remaining data & stopping", solr_connection)
        solr_connection.add_many(data)
        logger.info("Committing changes to Solr")
        solr_connection.commit()


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

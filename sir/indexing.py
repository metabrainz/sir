# Copyright (c) 2014, 2015 Lukas Lalinsky, Wieland Hoffmann
# License: MIT, see LICENSE for details
import multiprocessing

from . import config, querying, util, get_sentry
from .schema import SCHEMA
from ConfigParser import NoOptionError
from functools import partial
from logging import getLogger
from solr import SolrException
from sqlalchemy import and_
from .util import SIR_EXIT

__all__ = ["reindex", "index_entity", "queue_to_solr", "send_data_to_solr",
           "_multiprocessed_import", "_index_entity_process_wrapper", "live_index",
           "live_index_entity"]


logger = getLogger("sir")

PROCESS_FLAG = True
STOP = None


def reindex(args):
    """
    Reindexes all entity types in args["entity_type"].

    If no types are specified, all known entities will be reindexed.

    :param args: A dictionary with a key named ``entities``.
    :type args: dict
    """
    entities = args["entity_type"]
    known_entities = SCHEMA.keys()
    if entities is None:
        entities = known_entities

    try:
        logger.info("Checking whether the versions of the Solr cores are "
                    "supported")
        util.check_solr_cores_version(entities)
    except util.VersionMismatchException as exc:
        logger.error(exc)
        return

    _multiprocessed_import(entities)


def live_index(entities):
    """
     Reindex all documents in``entities`` in multiple processes via the
    :mod:`multiprocessing` module.

    :param entities:
    :type entities: dict(set(int))
    """
    logger.debug(entities)

    # Checking for PROCESS_FLAG before proceeding in case the parent process
    # was terminated and this flag was turned off in the parent signal handler.
    if not PROCESS_FLAG:
        logger.info('Process Flag is off, terminating.')
        return
    _multiprocessed_import(entities.keys(), live=True, entities=entities)


def _multiprocessed_import(entity_names, live=False, entities=None):
    """
    Does the real work to import all entities with ``entity_name`` in multiple
    processes via the :mod:`multiprocessing` module.

    When ``live`` is True, it means, we are live indexing documents with ids in the
    ``entities`` dict, otherwise it reindexes the entire table for entities in
    ``entity_names``.

    :param entity_names:
    :type entity_names: [str]
    :param bool live:
    :param entities:
    :type entities: dict(set(int))
    """
    query_batch_size = config.CFG.getint("sir", "query_batch_size")
    try:
        importlimit = config.CFG.getint("sir", "importlimit")
    except NoOptionError:
        importlimit = 0

    max_processes = config.CFG.getint("sir", "import_threads")
    solr_batch_size = config.CFG.getint("solr", "batch_size")

    db_session = util.db_session()

    # Only allow one task per child to prevent the process consuming too much
    # memory
    pool = multiprocessing.Pool(max_processes, maxtasksperchild=1)
    for e in entity_names:
        index_function_args = []
        # `entities` will be None when reindexing the entire DB
        entity_id_list = list(entities.get(e, set())) if entities else None
        manager = multiprocessing.Manager()
        entity_data_queue = manager.Queue()
        db_uri = config.CFG.get("database", "uri")

        solr_connection = util.solr_connection(e)
        process_function = partial(queue_to_solr,
                                   entity_data_queue,
                                   solr_batch_size,
                                   solr_connection)

        solr_process = multiprocessing.Process(name="solr",
                                               target=process_function)
        solr_process.start()
        logger.info("The queue workers PID is %i", solr_process.pid)
        indexer = partial(_index_entity_process_wrapper, live=live)
        if live:
            if entity_id_list:
                for i in range(0, len(entity_id_list), query_batch_size):
                    index_function_args.append((e, db_uri,
                                                entity_id_list[i:i + query_batch_size],
                                                entity_data_queue))
        else:
            with util.db_session_ctx(db_session) as session:
                for bounds in querying.iter_bounds(session, SCHEMA[e].model.id,
                                                   query_batch_size, importlimit):
                    args = (e, db_uri, bounds, entity_data_queue)
                    index_function_args.append(args)

        try:
            results = pool.imap(indexer,
                                index_function_args)
            for r in results:
                if not PROCESS_FLAG:
                    raise SIR_EXIT
        except SIR_EXIT:
            logger.info('Killing all worker processes.')
            entity_data_queue.put(STOP)
            solr_process.join()
            pool.terminate()
            pool.join()
            raise
        except Exception as exc:
            logger.exception(exc)
        else:
            logger.info("Importing %s successful!", e)
        entity_data_queue.put(STOP)
        solr_process.join()
    pool.terminate()
    pool.join()


def _index_entity_process_wrapper(args, live=False):
    """
    Calls :func:`sir.indexing.index_entity` with ``args`` unpacked.

    :param bool live:

    :rtype: None or an Exception
    """
    try:
        if live:
            return live_index_entity(*args)
        return index_entity(*args)
    except Exception:
        raise


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
    model = SCHEMA[entity_name].model
    logger.info("Indexing %s %s", model, bounds)
    lower_bound, upper_bound = bounds
    if upper_bound is not None:
        condition = and_(model.id >= lower_bound, model.id < upper_bound)
    else:
        condition = model.id >= lower_bound
    _query_database(entity_name, db_uri, condition, data_queue)


def live_index_entity(entity_name, db_uri, ids, data_queue):
    """
    Retrieve rows for a single entity type identified by ``entity_name``,
    convert them to a dict with :func:`sir.indexing.query_result_to_dict` and
    put the dicts into ``queue``.

    :param str entity_name:
    :param str db_uri:
    :param ids:
    :param Queue.Queue data_queue:
    """
    if not PROCESS_FLAG:
        return
    condition = and_(SCHEMA[entity_name].model.id.in_(ids))
    logger.info("Indexing %s new rows for entity %s", len(ids), entity_name)
    _query_database(entity_name, db_uri, condition, data_queue)


def _query_database(entity_name, db_uri, condition, data_queue):
    """
    Retrieve rows for a single entity type identified by ``entity_name``,
    convert them to a dict with :func:`sir.indexing.query_result_to_dict` and
    put the dicts into ``queue``.

    :param str entity_name:
    :param str db_uri:
    :param condition:
    :param Queue.Queue data_queue:
    """
    search_entity = SCHEMA[entity_name]
    model = search_entity.model
    row_converter = search_entity.query_result_to_dict
    with util.db_session_ctx(util.db_session()) as session:
        query = search_entity.query.filter(condition).with_session(session)
        total_records = 0
        for row in query:
            if not PROCESS_FLAG:
                return
            data_queue.put(row_converter(row))
            total_records += 1
        logger.info("Retrieved %s records in %s", total_records, model)


def queue_to_solr(queue, batch_size, solr_connection):
    """
    Read :class:`dict` objects from ``queue`` and send them to the Solr server
    behind ``solr_connection`` in batches of ``batch_size``.

    :param multiprocessing.Queue queue:
    :param int batch_size:
    :param solr.Solr solr_connection:
    """
    data = []
    for item in iter(queue.get, None):
        if not PROCESS_FLAG:
            return
        data.append(item)
        if len(data) >= batch_size:
            try:
                send_data_to_solr(solr_connection, data)
            except SolrException as exc:
                get_sentry().captureException()
                if exc.httpcode == 400:
                    pass
                else:
                    break
            else:
                logger.debug("Sent data to Solr")
            data = []

    if not PROCESS_FLAG:
        return
    logger.info("%s: Sending remaining data & stopping", solr_connection)
    solr_connection.add_many(data)
    logger.info("Committing changes to Solr")
    solr_connection.commit()


def send_data_to_solr(solr_connection, data):
    """
    Sends ``data`` through ``solr_connection``.

    :param solr.Solr solr_connection:
    :param [dict] data:
    :raises: :class:`solr:solr.SolrException`
    """
    try:
        solr_connection.add_many(data)
        logger.debug("Done sending data to Solr")
    except SolrException as exc:
        get_sentry().captureException(extra={"data": data})
        if exc.httpcode == 400:
            logger.warning("Received a Bad Request response from Solr, " +
                           "continuing anyway")
        else:
            logger.error(exc)
            raise
    else:
        logger.debug("Sent data to Solr")

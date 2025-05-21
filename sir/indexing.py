# Copyright (c) 2014, 2015, 2017 Lukas Lalinsky, Wieland Hoffmann, MetaBrainz Foundation
# License: MIT, see LICENSE for details
import multiprocessing
import signal

import sentry_sdk

from . import config, querying, util
from .schema import SCHEMA
from configparser import NoOptionError
from functools import partial
from logging import getLogger, DEBUG, INFO
from sqlalchemy import and_
from sqlalchemy.orm import Session
from .util import SIR_EXIT
from ctypes import c_bool

__all__ = ["reindex", "index_entity", "queue_to_solr", "send_data_to_solr",
           "_multiprocessed_import", "_index_entity_process_wrapper", "live_index",
           "live_index_entity"]


logger = getLogger("sir")

PROCESS_FLAG = multiprocessing.Value(c_bool, True)
FAILED = multiprocessing.Value(c_bool, False)
STOP = None


def reindex(args):
    """
    Reindexes all entity types in args["entity_type"].

    If no types are specified, all known entities will be reindexed.

    :param args: A dictionary with a key named ``entities``.
    :type args: dict
    """

    # Checking for PROCESS_FLAG before proceeding in case the parent process
    # was terminated and this flag was turned off in the parent signal handler.
    if not PROCESS_FLAG.value:
        logger.info('Process Flag is off, terminating.')
        return

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
    if not PROCESS_FLAG.value:
        logger.info('Process Flag is off, terminating.')
        return
    # Reset failed before each import
    FAILED.value = False
    _multiprocessed_import(entities.keys(), live=True, entities=entities)
    if FAILED.value:
        raise Exception('Post to Solr failed. Requeueing all pending messages for retry.')


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
    try:
        max_solr_processes = config.CFG.getint("sir", "solr_threads")
    except NoOptionError:
        max_solr_processes = max_processes
    solr_batch_size = config.CFG.getint("solr", "batch_size")

    db_session = util.db_session()

    # Only allow one task per child to prevent the process consuming too much
    # memory
    pool = multiprocessing.Pool(max_processes, maxtasksperchild=1)
    for e in entity_names:
        logger.log(DEBUG if live else INFO, "Importing %s...", e)
        index_function_args = []
        # `entities` will be None when reindexing the entire DB
        entity_id_list = list(entities.get(e, set())) if entities else None
        manager = multiprocessing.Manager()
        entity_data_queue = manager.Queue()

        process_function = partial(queue_to_solr,
                                   entity_data_queue,
                                   solr_batch_size,
                                   e)
        solr_processes = []
        for i in range(max_solr_processes):
            p = multiprocessing.Process(target=process_function, name="Solr-" + str(i))
            p.start()
            solr_processes.append(p)
        indexer = partial(_index_entity_process_wrapper, live=live)
        if live:
            if entity_id_list:
                for i in range(0, len(entity_id_list), query_batch_size):
                    index_function_args.append((e,
                                                entity_id_list[i:i + query_batch_size],
                                                entity_data_queue))
        else:
            with util.db_session_ctx(db_session) as session:
                for bounds in querying.iter_bounds(session, SCHEMA[e].model,
                                                   query_batch_size, importlimit):
                    args = (e, bounds, entity_data_queue)
                    index_function_args.append(args)

        try:
            results = pool.imap(indexer,
                                index_function_args)
            for r in results:
                if not PROCESS_FLAG.value:
                    raise SIR_EXIT
        except SIR_EXIT:
            logger.info('Killing all worker processes.')
            entity_data_queue.put(STOP)
            for p in solr_processes:
                p.terminate()
                p.join()
            pool.terminate()
            pool.join()
            raise
        except Exception as exc:
            logger.error("Failed to import %s.", e)
            logger.exception(exc)
            pool.terminate()
        else:
            logger.log(DEBUG if live else INFO, "Successfully imported %s!", e)
        entity_data_queue.put(STOP)
        for p in solr_processes:
            p.join()
    pool.close()
    pool.join()


def _index_entity_process_wrapper(args, live=False):
    """
    Calls :func:`sir.indexing.index_entity` with ``args`` unpacked.

    :param bool live:

    :rtype: None or an Exception
    """

    # Restoring the default SIGTERM handler so the pool can actually terminate
    # its workers
    signal.signal(signal.SIGTERM, signal.SIG_DFL)

    config.read_config()

    try:
        session = Session(util.engine())
        if live:
            return live_index_entity(session, *args)
        return index_entity(session, *args)
    except Exception as exc:
        logger.error("Failed to import %s with id in bounds %s",
                     args[0],
                     args[1])
        logger.exception(exc)
        raise


def index_entity(session, entity_name, bounds, data_queue):
    """
    Retrieve rows for a single entity type identified by ``entity_name``,
    convert them to a dict with :func:`sir.indexing.query_result_to_dict` and
    put the dicts into ``queue``.

    :param sqlalchemy.orm.Session session:
    :param str entity_name:
    :param bounds:
    :type bounds: (int, int)
    :param Queue.Queue data_queue:
    """
    model = SCHEMA[entity_name].model
    logger.debug("Importing %s %s", model, bounds)
    lower_bound, upper_bound = bounds
    if upper_bound is not None:
        condition = and_(model.id >= lower_bound, model.id < upper_bound)
    else:
        condition = model.id >= lower_bound
    _query_database(session, entity_name, condition, data_queue)


def live_index_entity(session, entity_name, ids, data_queue):
    """
    Retrieve rows for a single entity type identified by ``entity_name``,
    convert them to a dict with :func:`sir.indexing.query_result_to_dict` and
    put the dicts into ``queue``.

    :param sqlalchemy.orm.Session session:
    :param str entity_name:
    :param [int] ids:
    :param Queue.Queue data_queue:
    """
    if not PROCESS_FLAG.value:
        return
    condition = and_(SCHEMA[entity_name].model.id.in_(ids))
    logger.debug("Importing %s new rows for entity %s", len(ids), entity_name)
    _query_database(session, entity_name, condition, data_queue)


def _query_database(session, entity_name, condition, data_queue):
    """
    Retrieve rows for a single entity type identified by ``entity_name``,
    convert them to a dict with :func:`sir.indexing.query_result_to_dict` and
    put the dicts into ``data_queue``.

    Rows that contain unsupported control character are just skipped
    with log info. It is not considered as an indexing error, since
    it should not be in the MusicBrainz database to start with.

    :param str entity_name:
    :param sqlalchemy.sql.expression.BinaryExpression condition:
    :param Queue.Queue data_queue:
    """
    search_entity = SCHEMA[entity_name]
    model = search_entity.model
    row_converter = search_entity.query_result_to_dict

    with session:
        query = search_entity.query.filter(condition).with_session(session)
        total_records = 0
        for row in query:
            if not PROCESS_FLAG.value:
                return
            try:
                data_queue.put(row_converter(row))
            except ValueError:
                logger.info("Skipping %s with id %s. "
                            "The most likely cause of this is an "
                            "unsupported control character in the "
                            "data.",
                            entity_name,
                            row.id)
            except Exception as exc:
                logger.error("Failed to import %s with id %s",
                             entity_name,
                             row.id)
                logger.exception(exc)
                raise
            else:
                total_records += 1
        logger.debug("Retrieved %s records in %s", total_records, model)


def queue_to_solr(queue, batch_size, entity_name):
    """
    Read :class:`dict` objects from ``queue`` and send them to the Solr server
    behind ``solr_connection`` in batches of ``batch_size``.

    :param multiprocessing.Queue queue:
    :param int batch_size:
    :param str entity_name:
    """

    # Restoring the default SIGTERM handler so the Solr process can actually
    # be terminated on calling terminate.
    signal.signal(signal.SIGTERM, signal.SIG_DFL)

    config.read_config()
    solr_connection = util.solr_connection(entity_name)

    data = []
    count = 0
    while True:
        item = queue.get()
        if not PROCESS_FLAG.value or item is STOP:
            break
        data.append(item)
        if len(data) >= batch_size:
            send_data_to_solr(solr_connection, data)
            count += len(data)
            logger.debug("Sent %d new documents. Total: %d", len(data), count)
            data = []

    queue.put(STOP)
    if not PROCESS_FLAG.value:
        return
    logger.debug("%s: Sending remaining data & stopping", solr_connection)
    send_data_to_solr(solr_connection, data)
    logger.debug("Committing changes to Solr")
    solr_connection.commit()


def send_data_to_solr(solr_connection, data):
    """
    Sends ``data`` through ``solr_connection``.

    :param solr.Solr solr_connection:
    :param [dict] data:
    :raises: :class:`solr:solr.SolrException`
    """
    with sentry_sdk.new_scope() as scope:
        scope.set_extra("data", data)
        try:
            solr_connection.add(data)
            logger.debug("Done sending data to Solr")
        except Exception as e:
            logger.error("Error while submitting data to Solr:", exc_info=True)
            sentry_sdk.capture_exception(e)
            FAILED.value = True
        else:
            logger.debug("Sent data to Solr")

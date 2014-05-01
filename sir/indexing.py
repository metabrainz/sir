from . import config, querying
from logging import getLogger


logger = getLogger("sir")


def index_entity(db_session, solr_connection, query, search_entity):
    """
    Indexes a single entity type.

    :param sqlalchemy.orm.scoping.scoped_session db_session_maker:
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
                data = []
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
        logger.debug("Field: %s", field.name)
        fieldname = field.name
        tempvals = set()
        for path in field.paths:
            logger.debug("Path: %s", path)
            for val in querying._iterate_path_values(path, obj):
                tempvals.add(val)
        logger.debug("Values: %s", tempvals)
        if field.transformfunc is not None:
            tempvals = field.transformfunc(tempvals)
            logger.debug("Values after applying transformfunc: %s", tempvals)
        if isinstance(tempvals, set) and len(tempvals) == 1:
            tempvals = tempvals.pop()
        data[fieldname] = tempvals
    return data

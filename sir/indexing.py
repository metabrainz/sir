from . import querying
from logging import getLogger


logger = getLogger("sir")


def index_entity(solr_connection, query, search_entity):
    """
    Indexes a single entity type.

    :param solr.Solr solr_connection:
    :param sqlalchemy.orm.query.Query query:
    :param sir.schema.searchentities.SearchEntity search_entity:
    """
    for row in query:
        data = query_result_to_dict(search_entity, row)
        logger.info("Sending a document to solr: %s", data)
        solr_connection.add(data)


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
        if len(tempvals) == 1:
            tempvals = tempvals.pop()
        if field.transformfunc is not None:
            tempvals = field.transformfunc(tempvals)
        data[fieldname] = tempvals
    return data

# Copyright (c) 2014 Wieland Hoffmann
# License: MIT, see LICENSE for details
import logging
import solr
import urllib2

from sqlalchemy import create_engine
from sqlalchemy.orm import scoped_session, sessionmaker


logger = logging.getLogger("sir")


def db_session(db_uri, debug):
    """
    Creates a new :class:`sqla:sqlalchemy.orm.scoping.scoped_session`.

    :param str db_uri: A :ref:`database URL <sqla:database_urls>` for
                       SQLAlchemy.
    :param bool debug: This is passed directly to
                       :func:`sqla:sqlalchemy.create_engine` in its ``echo``
                       parameter.

    :rtype: :class:`sqla:sqlalchemy.orm.scoping.scoped_session`
    """
    e = create_engine(db_uri, echo=debug)
    S = sessionmaker(bind=e)
    return scoped_session(S)


def solr_connection(solr_uri, core):
    """
    Creates a :class:`solr:solr.Solr` connection for the core ``core`` at the
    Solr server listening on ``solr_uri``.

    :param str solr_uri:
    :param str core:
    :raises urllib2.URLError: if a ping to the cores ping handler doesn't
                              succeed
    :rtype: :class:`solr:solr.Solr`
    """
    core_uri = solr_uri + "/" + core
    ping_uri = core_uri + "/admin/ping"

    logger.debug("Pinging %s", ping_uri)
    urllib2.urlopen(ping_uri)

    logger.debug("Connection to the Solr core at %s", core_uri)
    return solr.Solr(core_uri)
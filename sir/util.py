# Copyright (c) 2014 Wieland Hoffmann
# License: MIT, see LICENSE for details
from __future__ import absolute_import

import amqp
import logging
import solr
import urllib2

from . import config
from .schema import SCHEMA
from contextlib import contextmanager
from functools import partial
from json import loads
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker


logger = logging.getLogger("sir")


class VersionMismatchException(Exception):
    def __init__(self, core, expected, actual):
        self.core = core
        self.expected = expected
        self.actual = actual

    def __str__(self):
        return "%s: Expected %1.1f, got %1.1f" % (self.core,
                                                  self.expected,
                                                  self.actual)


def db_session():
    """
    Creates a new :class:`sqla:sqlalchemy.orm.session.sessionmaker`.

    :param str db_uri: A :ref:`database URL <sqla:database_urls>` for
                       SQLAlchemy.

    :rtype: :class:`sqla:sqlalchemy.orm.session.sessionmaker`
    """
    db_uri = config.CFG.get("database", "uri")
    e = create_engine(db_uri, server_side_cursors=False)
    S = sessionmaker(bind=e)
    return S


@contextmanager
def db_session_ctx(Session):
    """
    A context manager yielding a database session.

    :param sqlalchemy.orm.session.sessionmaker Session:
    """
    session = Session()
    try:
        yield session
        session.commit()
    except:
        session.rollback()
        raise
    finally:
        session.close()


def solr_connection(core):
    """
    Creates a :class:`solr:solr.Solr` connection for the core ``core``.

    :param str core:
    :raises urllib2.URLError: if a ping to the cores ping handler doesn't
                              succeed
    :rtype: :class:`solr:solr.Solr`
    """
    solr_uri = config.CFG.get("solr", "uri")
    core_uri = solr_uri + "/" + core
    ping_uri = core_uri + "/admin/ping"

    logger.info("Setting up a connection to %s", solr_uri)
    logger.debug("Pinging %s", ping_uri)
    urllib2.urlopen(ping_uri)

    logger.debug("Connection to the Solr core at %s", core_uri)
    return solr.Solr(core_uri)


def solr_version_check(core):
    """
    Checks that the version of the Solr core ``core`` matches the one in the
    schema.

    :param str core:
    :raises urllib2.URLError: If the Solr core can't be reached
    :raises sir.util.VersionMismatchException: If the version in Solr is
                                               different from the supported one
    """
    expected_version = SCHEMA[core].version
    solr_uri = config.CFG.get("solr", "uri")
    u = urllib2.urlopen("%s/%s/schema/version" % (solr_uri, core))
    content = loads(u.read())
    seen_version = content["version"]
    if not seen_version == expected_version:
        raise VersionMismatchException(core, expected_version, seen_version)
    logger.debug("%s: version %1.1f matches %1.1f", core, expected_version,
                 seen_version)


def check_solr_cores_version(cores):
    """
    Checks multiple Solr cores for version compatibility

    :param [str] cores: The names of the cores
    :raises sir.util.VersionMismatchException: If the version in Solr is
                                               different from the supported one
    """
    map(solr_version_check, cores)


def create_amqp_connection():
    # type: () -> amqp.Connection
    """
    Creates a connection to an AMQP server.

    :rtype: :class:`amqp:amqp.connection.Connection`
    """
    cget = partial(config.CFG.get, "rabbitmq")
    return amqp.Connection(
        host=cget("host"),
        userid=cget("user"),
        password=cget("password"),
        virtual_host=cget("vhost"),
    )

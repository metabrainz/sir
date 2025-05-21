# Copyright (c) 2014 Wieland Hoffmann
# License: MIT, see LICENSE for details


import amqp
import logging
import pysolr
import urllib.request, urllib.error, urllib.parse

import requests
from requests.adapters import HTTPAdapter
from urllib3 import Retry

from . import config
from .schema import SCHEMA
from contextlib import contextmanager
from functools import partial
from json import loads
from sqlalchemy import create_engine
from sqlalchemy.engine.url import URL
from sqlalchemy.orm import sessionmaker


logger = logging.getLogger("sir")


class SIR_EXIT(Exception):
    pass


class VersionMismatchException(Exception):
    def __init__(self, core, expected, actual):
        self.core = core
        self.expected = expected
        self.actual = actual

    def __str__(self):
        return "%s: Expected %1.1f, got %1.1f" % (self.core,
                                                  self.expected,
                                                  self.actual)


def engine():
    """
    Create a new :class:`sqla:sqlalchemy.engine.Engine`.

    :rtype: :class:`sqla:sqlalchemy.engine.Engine`
    """
    cget = partial(config.CFG.get, "database")
    cdict = {"username": cget("user")}
    for key in ["password", "host", "port"]:
        cdict[key] = cget(key)
    cdict["database"] = cget("dbname")
    return create_engine(
        URL.create("postgresql", **cdict),
        server_side_cursors=False
    )


def db_session():
    """
    Creates a new :class:`sqla:sqlalchemy.orm.session.sessionmaker`.

    :rtype: :class:`sqla:sqlalchemy.orm.session.sessionmaker`
    """
    return sessionmaker(bind=engine())


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


def get_requests_session():
    """ Configure a requests session for enforcing common retry strategy. """
    retry_strategy = Retry(
        total=config.CFG.getint("solr", "retries", fallback=3),
        status_forcelist=[429, 500, 502, 503, 504],
        allowed_methods=["HEAD", "GET", "OPTIONS"],
        backoff_factor=config.CFG.getint("solr", "backoff_factor", fallback=1),
    )
    adapter = HTTPAdapter(max_retries=retry_strategy)
    http = requests.Session()
    http.mount("https://", adapter)
    http.mount("http://", adapter)
    return http


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

    session = requests.Session()

    logger.debug("Setting up a connection to %s", solr_uri)
    logger.debug("Pinging %s", ping_uri)
    response = session.get(ping_uri)
    response.raise_for_status()

    logger.debug("Connection to the Solr core at %s", core_uri)
    return pysolr.Solr(core_uri, session=session)


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
    u = urllib.request.urlopen("%s/%s/schema/version" % (solr_uri, core))
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
    list(map(solr_version_check, cores))


def create_amqp_connection():
    # type: () -> amqp.Connection
    """
    Creates a connection to an AMQP server.

    :rtype: :class:`amqp:amqp.connection.Connection`
    """
    cget = partial(config.CFG.get, "rabbitmq")
    conn = amqp.Connection(
        host=cget("host"),
        userid=cget("user"),
        password=cget("password"),
        virtual_host=cget("vhost"),
    )
    conn.connect()
    return conn

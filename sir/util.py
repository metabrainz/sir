import ConfigParser

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker


def read_config():
    config = ConfigParser.SafeConfigParser()
    config.read(["config.ini"])

    db_uri = config.get("database", "uri")
    solr_uri = config.get("solr", "uri")

    return db_uri, solr_uri


def db_session(db_uri, debug):
    e = create_engine(db_uri, echo=debug)
    S = sessionmaker(bind=e)
    session = S()
    return session
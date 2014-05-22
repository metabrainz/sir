# Copyright (c) 2014 Lukas Lalinsky, Wieland Hoffmann
# License: MIT, see LICENSE for details
from .modelext import TmpRelease, TmpTrack
from logging import getLogger
from mbdata.models import (Medium, MediumFormat, Release, ReleaseGroup,
                           ReleaseGroupPrimaryType,
                           ReleasePackaging, ReleaseStatus, Language, Script, Track)
from sqlalchemy import func, insert, inspect
from sqlalchemy.orm.query import Query


logger = getLogger("sir")


class SearchField(object):
    """Represents a searchable field."""
    def __init__(self, name, paths, transformfunc=None):
        """
        :param str name: The name of the field
        :param str path: A dot-delimited path (or a list of them) along which
                         the value of this field can be found, beginning at
                         an instance of the model class this field is bound to.
        :param method transformfunc: An optional function to transform the value
                         before sending it to Solr.
        """
        self.name = name
        if not isinstance(paths, list):
            paths = [paths]
        self.paths = paths
        self.transformfunc = transformfunc


class SearchEntity(object):
    can_use_processes = True

    """An an entity with searchable fields."""
    def __init__(self, model, fields, version):
        """
        :param model: A :ref:`declarative <sqla:declarative_toplevel>` class.
        :param list fields: A list of :class:`SearchField` objects.
        :param float version: The supported schema version of this entity.
        """
        self.model = model
        self.fields = fields
        self.version = version

    @staticmethod
    def prepare(db_session):
        """
        Perform any steps necessary in the database for indexing this entity.

        :param sqlalchemy.orm.session.Session session:
        """
        pass


class RecordingEntity(SearchEntity):
    can_use_processes = False

    @staticmethod
    def prepare(db_session):
        TmpTrack.metadata.create_all(db_session.connection())
        tmptable = inspect(TmpTrack).mapped_table

        q = Query([Track.gid,
                   Track.id,
                   Track.recording_id,
                   Track.length,
                   Track.name,
                   Track.position,
                   Track.number,
                   Medium.track_count,
                   Medium.release_id,
                   Medium.position,
                   MediumFormat.name]).\
            join(Medium).\
            outerjoin(MediumFormat)

        ins = insert(TmpTrack).from_select(tmptable.columns,
                                           q.selectable)
        logger.info("Creating the temporary tmp_track table")
        db_session.execute(ins)
        logger.info("Done!")

        columns = [Release.artist_credit_id,
                   Release.barcode,
                   Release.comment,
                   Release.gid,
                   ReleaseGroup.gid,
                   ReleaseGroup.id,
                   ReleaseGroupPrimaryType.name,
                   Release.id,
                   Language.iso_code_2t,
                   Language.iso_code_3,
                   Release.name,
                   ReleasePackaging.name,
                   Release.quality,
                   Script.name,
                   ReleaseStatus.name,
                   ]

        query_columns = [func.sum(Medium.track_count)]
        query_columns.extend(columns)
        q = Query(query_columns).\
            outerjoin(Release).\
            outerjoin(Language).\
            outerjoin(ReleasePackaging).\
            outerjoin(Script).\
            outerjoin(ReleaseStatus).\
            join(Medium).\
            join(ReleaseGroup).\
            outerjoin(ReleaseGroupPrimaryType).\
            group_by(*columns)

        tmptable = inspect(TmpRelease).mapped_table
        ins = insert(TmpRelease).from_select(tmptable.columns, q.selectable)
        logger.info("Creating the temporary tmp_release table")
        db_session.execute(ins)
        logger.info("Done!")

# Copyright (c) 2014 Lukas Lalinsky, Wieland Hoffmann
# License: MIT, see LICENSE for details
from .modelext import TmpTrack
from mbdata.models import Medium, MediumFormat, Track
from sqlalchemy import insert, select
from sqlalchemy import inspect


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
        medium_table = inspect(Medium).mapped_table
        medium_formats_table = inspect(MediumFormat).mapped_table
        track_table = inspect(Track).mapped_table
        tmptable = inspect(TmpTrack).mapped_table

        TmpTrack.metadata.create_all(db_session.connection())

        s = select([Track.gid,
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
            select_from(track_table.join(medium_table).
                        outerjoin(medium_formats_table))

        ins = insert(TmpTrack).from_select(tmptable.columns,
                                           s)
        # db_session.execute(ins)

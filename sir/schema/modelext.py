# Copyright (c) 2014 Lukas Lalinsky, Wieland Hoffmann
# License: MIT, see LICENSE for details
from mbdata.models import Area, Artist, Base, Label, Recording, ReleaseGroup, Work
from mbdata.types import PartialDate
from sqlalchemy import exc as sa_exc, Column, Integer, SMALLINT, String
from sqlalchemy.dialects.postgres import UUID
from sqlalchemy.orm import composite, relationship
from warnings import simplefilter

# Ignore SQLAlchemys warnings that we're overriding some attributes
simplefilter(action="ignore", category=sa_exc.SAWarning)


class TmpArtistCredit(Base):
    __tablename__ = 'tmp_artist_credit'
    __table_args__ = {'prefixes': ['TEMPORARY']}

    artist_credit_id = Column(Integer, primary_key=True)
    artist_credit_name_position = Column(Integer, primary_key=True)
    artist_credit_name_join_phrase = Column(String)
    artist_gid = Column(UUID)
    artist_comment = Column(String)
    artist_name = Column(String)
    artist_credit_name = Column(String)
    artist_sort_name = Column(String)


class TmpRelease(Base):
    __tablename__ = 'tmp_release'
    __table_args__ = {'prefixes': ['TEMPORARY']}

    release_track_count = Column(Integer)
    release_artist_credit = Column(Integer)
    release_barcode = Column(String)
    release_comment = Column(String)
    release_gid = Column(UUID)
    release_group_gid = Column(UUID)
    release_group_id = Column(Integer)
    release_group_type_name = Column(String)
    release_id = Column(Integer, primary_key=True)
    release_language_2t = Column(String)
    release_language_3 = Column(String)
    release_name = Column(String)
    release_packaging = Column(String)
    release_quality = Column(String)
    release_script = Column(String)
    release_status = Column(String)


class TmpReleaseEvent(Base):
    __tablename__ = 'tmp_release_event'
    __table_args__ = {'prefixes': ['TEMPORARY']}

    release_id = Column(Integer, primary_key=True)
    release_country = Column(String, primary_key=True)
    release_date_year = Column(SMALLINT)
    release_date_month = Column(SMALLINT)
    release_date_day = Column(SMALLINT)
    area_gid = Column(UUID)
    area_name = Column(UUID)

    release_date = composite(PartialDate, release_date_year,
                             release_date_month, release_date_day)


class TmpTrack(Base):
    __tablename__ = 'tmp_track'
    __table_args__ = {'prefixes': ['TEMPORARY']}

    track_gid = Column(UUID, nullable=False)
    track_id = Column(Integer, primary_key=True)
    recording_id = Column(Integer)
    track_length = Column(Integer)
    track_name = Column(String)
    track_position = Column(Integer)
    track_number = Column(String)
    medium_track_count = Column(Integer)
    release_id = Column(Integer)
    medium_position = Column(Integer)
    medium_format_name = Column(String)

    tmp_release = relationship("TmpRelease",
        primaryjoin="TmpRelease.release_id == TmpTrack.release_id",
        foreign_keys=release_id,
        remote_side=TmpRelease.release_id)


class CustomArea(Area):
    aliases = relationship("AreaAlias")


class CustomArtist(Artist):
    aliases = relationship("ArtistAlias")
    area = relationship('CustomArea', foreign_keys=[Artist.area_id])
    begin_area = relationship('CustomArea', foreign_keys=[Artist.begin_area_id])
    end_area = relationship('CustomArea', foreign_keys=[Artist.end_area_id])


class CustomLabel(Label):
    aliases = relationship("LabelAlias")


class CustomRecording(Recording):
    tracks = relationship("Track")
    tmp_tracks = relationship("TmpTrack",
                    primaryjoin="TmpTrack.recording_id == Recording.id",
                    foreign_keys=Recording.id,
                    remote_side=TmpTrack.recording_id)


class CustomReleaseGroup(ReleaseGroup):
    releases = relationship("Release")


class CustomWork(Work):
    aliases = relationship("WorkAlias")
    artist_links = relationship("LinkArtistWork")
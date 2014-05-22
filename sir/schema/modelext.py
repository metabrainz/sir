# Copyright (c) 2014 Lukas Lalinsky, Wieland Hoffmann
# License: MIT, see LICENSE for details
from mbdata.models import Area, Artist, Base, Label, Recording, ReleaseGroup, Work
from sqlalchemy import exc as sa_exc, Column, Integer, String
from sqlalchemy.dialects.postgres import UUID
from sqlalchemy.orm import relationship
from warnings import simplefilter

# Ignore SQLAlchemys warnings that we're overriding some attributes
simplefilter(action="ignore", category=sa_exc.SAWarning)


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
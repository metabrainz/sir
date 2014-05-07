# Copyright (c) 2014 Lukas Lalinsky, Wieland Hoffmann
# License: MIT, see LICENSE for details
from mbdata.models import Area, Artist, Recording, ReleaseGroup
from sqlalchemy.orm import relationship


class CustomArea(Area):
    aliases = relationship("AreaAlias")


class CustomArtist(Artist):
    aliases = relationship("ArtistAlias")
    area = relationship('CustomArea', foreign_keys=[Artist.area_id])
    begin_area = relationship('CustomArea', foreign_keys=[Artist.begin_area_id])
    end_area = relationship('CustomArea', foreign_keys=[Artist.end_area_id])


class CustomRecording(Recording):
    tracks = relationship("Track")


class CustomReleaseGroup(ReleaseGroup):
    releases = relationship("Release")
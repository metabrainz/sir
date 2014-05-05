# Copyright (c) 2014 Lukas Lalinsky, Wieland Hoffmann
# License: MIT, see LICENSE for details
from mbdata import models
from sqlalchemy.orm import relationship


class CustomArea(models.Area):
    aliases = relationship("AreaAlias")


class CustomArtist(models.Artist):
    aliases = relationship("ArtistAlias")
    area = relationship('CustomArea', foreign_keys=[models.Artist.area_id])
    begin_area = relationship('CustomArea', foreign_keys=[models.Artist.begin_area_id])
    end_area = relationship('CustomArea', foreign_keys=[models.Artist.end_area_id])


class CustomRecording(models.Recording):
    tracks = relationship("Track")


class CustomReleaseGroup(models.ReleaseGroup):
    releases = relationship("Release")
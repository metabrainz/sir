# Copyright (c) 2014 Lukas Lalinsky, Wieland Hoffmann
# License: MIT, see LICENSE for details
from mbdata.models import Area, Artist, Label, LinkAttribute, Recording, ReleaseGroup, Work
from sqlalchemy import exc as sa_exc
from sqlalchemy.orm import relationship
from warnings import simplefilter

# Ignore SQLAlchemys warnings that we're overriding some attributes
simplefilter(action="ignore", category=sa_exc.SAWarning)


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


class CustomReleaseGroup(ReleaseGroup):
    releases = relationship("Release")


class CustomWork(Work):
    aliases = relationship("WorkAlias")
    artist_links = relationship("LinkArtistWork")


class CustomLinkAttribute(LinkAttribute):
    link = relationship('Link', foreign_keys=[LinkAttribute.link_id], innerjoin=True,
                        backref="attributes")

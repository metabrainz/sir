# Copyright (c) 2014 Lukas Lalinsky, Wieland Hoffmann
# License: MIT, see LICENSE for details
from mbdata.models import Area, Artist, ArtistAlias, Label, LinkAttribute, MediumCDTOC, Recording, ReleaseGroup, ReleaseTag, Work
from sqlalchemy import exc as sa_exc
from sqlalchemy.orm import relationship
from warnings import simplefilter

# Ignore SQLAlchemys warnings that we're overriding some attributes
simplefilter(action="ignore", category=sa_exc.SAWarning)


class CustomArea(Area):
    aliases = relationship("AreaAlias")


class CustomArtist(Artist):
    area = relationship('CustomArea', foreign_keys=[Artist.area_id])
    begin_area = relationship('CustomArea', foreign_keys=[Artist.begin_area_id])
    end_area = relationship('CustomArea', foreign_keys=[Artist.end_area_id])
    tags = relationship('ArtistTag')


class CustomArtistAlias(ArtistAlias):
    artist = relationship('Artist', foreign_keys=[ArtistAlias.artist_id], innerjoin=True, backref="aliases")


class CustomLabel(Label):
    aliases = relationship("LabelAlias")


class CustomMediumCDToc(MediumCDTOC):
    medium = relationship('Medium', foreign_keys=[MediumCDTOC.medium_id], innerjoin=True, backref="cdtocs")


class CustomRecording(Recording):
    tags = relationship("RecordingTag")
    tracks = relationship("Track")


class CustomReleaseGroup(ReleaseGroup):
    releases = relationship("Release")
    tags = relationship("ReleaseGroupTag")

class CustomReleaseTag(ReleaseTag):
    release = relationship('Release', foreign_keys=[ReleaseTag.release_id], innerjoin=True, backref="tags")

class CustomWork(Work):
    aliases = relationship("WorkAlias")
    artist_links = relationship("LinkArtistWork")


class CustomLinkAttribute(LinkAttribute):
    link = relationship('Link', foreign_keys=[LinkAttribute.link_id], innerjoin=True,
                        backref="attributes")

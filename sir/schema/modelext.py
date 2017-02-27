# Copyright (c) 2014, 2015 Lukas Lalinsky, Wieland Hoffmann
# License: MIT, see LICENSE for details
from mbdata.models import (Annotation, Area, Artist, ArtistAlias, Event,
                           Instrument, Label, LinkAttribute, LinkAttributeType,
                           MediumCDTOC, Place, Recording, Release, ReleaseGroup,
                           ReleaseRaw, ReleaseTag, Series, Work)
from sqlalchemy import exc as sa_exc
from sqlalchemy.orm import relationship
from warnings import simplefilter

# Ignore SQLAlchemy's warnings that we're overriding some attributes
simplefilter(action="ignore", category=sa_exc.SAWarning)


class CustomAnnotation(Annotation):
    areas = relationship("AreaAnnotation")
    artists = relationship("ArtistAnnotation")
    events = relationship("EventAnnotation")
    instruments = relationship("InstrumentAnnotation")
    labels = relationship("LabelAnnotation")
    places = relationship("PlaceAnnotation")
    recordings = relationship("RecordingAnnotation")
    releases = relationship("ReleaseAnnotation")
    release_groups = relationship("ReleaseGroupAnnotation")
    series = relationship("SeriesAnnotation")
    works = relationship("WorkAnnotation")


class CustomArea(Area):
    aliases = relationship("AreaAlias")
    area_links = relationship("LinkAreaArea",
                              primaryjoin="Area.id == LinkAreaArea.entity1_id")


class CustomArtist(Artist):
    area = relationship('CustomArea', foreign_keys=[Artist.area_id])
    begin_area = relationship('CustomArea',
                              foreign_keys=[Artist.begin_area_id])
    end_area = relationship('CustomArea', foreign_keys=[Artist.end_area_id])
    tags = relationship('ArtistTag')
    artist_credit_names = relationship("ArtistCreditName", innerjoin=True)


class CustomArtistAlias(ArtistAlias):
    artist = relationship('Artist', foreign_keys=[ArtistAlias.artist_id],
                          innerjoin=True, backref="aliases")


class CustomEvent(Event):
    # still need to allow searching with place/area/artist aliases
    aliases = relationship("EventAlias")
    place_links = relationship("LinkEventPlace")
    area_links = relationship("LinkAreaEvent")
    artist_links = relationship("LinkArtistEvent")
    tags = relationship("EventTag")


class CustomInstrument(Instrument):
    aliases = relationship("InstrumentAlias")
    tags = relationship("InstrumentTag")


class CustomLabel(Label):
    aliases = relationship("LabelAlias")
    area = relationship("CustomArea", foreign_keys=[Label.area_id])
    tags = relationship("LabelTag")


class CustomMediumCDToc(MediumCDTOC):
    medium = relationship('Medium', foreign_keys=[MediumCDTOC.medium_id],
                          innerjoin=True, backref="cdtocs")


class CustomPlace(Place):
    area = relationship("CustomArea", foreign_keys=[Place.area_id])
    aliases = relationship("PlaceAlias")


class CustomRecording(Recording):
    tags = relationship("RecordingTag")
    tracks = relationship("Track")


class CustomReleaseGroup(ReleaseGroup):
    releases = relationship("Release")
    tags = relationship("ReleaseGroupTag")


class CustomRelease(Release):
    asin = relationship("ReleaseMeta")


class CustomReleaseRaw(ReleaseRaw):
    discids = relationship("CDTOCRaw")


class CustomReleaseTag(ReleaseTag):
    release = relationship('Release', foreign_keys=[ReleaseTag.release_id],
                           innerjoin=True, backref="tags")


class CustomSeries(Series):
    aliases = relationship("SeriesAlias")
    link_attribute_type = relationship("LinkAttributeType",
                                       primaryjoin="\
                                       CustomSeries.ordering_attribute ==\
                                       LinkAttributeType.id",
                                       foreign_keys=Series.ordering_attribute,
                                       remote_side=LinkAttributeType.id)
    tags = relationship("SeriesTag")


class CustomWork(Work):
    aliases = relationship("WorkAlias")
    artist_links = relationship("LinkArtistWork")
    tags = relationship("WorkTag")

# class CustomURL(URL):
#    relationtype
#    targetid
#    targettype


class CustomLinkAttribute(LinkAttribute):
    link = relationship('Link',
                        foreign_keys=[LinkAttribute.link_id], innerjoin=True,
                        backref="attributes")

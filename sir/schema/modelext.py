# Copyright (c) 2014, 2015 Lukas Lalinsky, Wieland Hoffmann
# License: MIT, see LICENSE for details
"""
This module wraps models from mbdata package and adds missing relationships
that are used in SIR.
"""
from mbdata.models import (Annotation, Area, Artist, ArtistAlias, Event,
                           Instrument, Label, LinkAttribute, LinkAttributeType,
                           LinkRecordingWork, Medium, MediumCDTOC, Place, Recording, Release,
                           ReleaseGroup, ReleaseLabel, ReleaseRaw, ReleaseTag, Series,
                           Work, URL)
from sqlalchemy import exc as sa_exc, func, select
from sqlalchemy.orm import relationship, column_property
from sqlalchemy.sql.expression import and_
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
    tags = relationship("AreaTag")
    place_count = column_property(select([func.count(Place.id)]).where(Place.area_id == Area.id))
    label_count = column_property(select([func.count(Label.id)]).where(Label.area_id == Area.id))
    artist_count = column_property(select([func.count(Artist.id)]).where(Artist.area_id == Area.id))


class CustomArtist(Artist):
    area = relationship('CustomArea', foreign_keys=[Artist.area_id])
    begin_area = relationship('CustomArea',
                              foreign_keys=[Artist.begin_area_id])
    end_area = relationship('CustomArea', foreign_keys=[Artist.end_area_id])
    tags = relationship('ArtistTag')
    artist_credit_names = relationship("ArtistCreditName", innerjoin=True)
    primary_aliases = column_property(select(
        [func.array_agg(ArtistAlias.name)]).where(
            and_(ArtistAlias.artist_id == Artist.id,
                 ArtistAlias.primary_for_locale == True)))


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
    release_count = column_property(select([func.count(ReleaseLabel.id)]).where(ReleaseLabel.label_id == Label.id))


class CustomMediumCDToc(MediumCDTOC):
    medium = relationship('Medium', foreign_keys=[MediumCDTOC.medium_id],
                          innerjoin=True, backref="cdtocs")


class CustomPlace(Place):
    area = relationship("CustomArea", foreign_keys=[Place.area_id])
    aliases = relationship("PlaceAlias")


class CustomRecording(Recording):
    aliases = relationship("RecordingAlias")
    first_release_date = relationship("RecordingFirstReleaseDate")
    tags = relationship("RecordingTag")
    tracks = relationship("Track")


class CustomReleaseGroup(ReleaseGroup):
    aliases = relationship("ReleaseGroupAlias")
    first_release_date = relationship("ReleaseGroupMeta")
    releases = relationship("Release")
    tags = relationship("ReleaseGroupTag")
    release_count = column_property(select([func.count(Release.id)]).where(Release.release_group_id == ReleaseGroup.id))


class CustomRelease(Release):
    aliases = relationship("ReleaseAlias")
    asin = relationship("ReleaseMeta")
    medium_count = column_property(select([func.count(Medium.id)]).where(Medium.release_id == Release.id))


class CustomReleaseRaw(ReleaseRaw):
    discids = relationship("CDTOCRaw")


class CustomReleaseTag(ReleaseTag):
    release = relationship('Release', foreign_keys=[ReleaseTag.release_id],
                           innerjoin=True, backref="tags")


class CustomSeries(Series):
    aliases = relationship("SeriesAlias")
    tags = relationship("SeriesTag")


class CustomWork(Work):
    aliases = relationship("WorkAlias")
    artist_links = relationship("LinkArtistWork")
    tags = relationship("WorkTag")
    languages = relationship("WorkLanguage")
    recording_links = relationship("LinkRecordingWork")
    recording_count = column_property(select([func.count(LinkRecordingWork.id)]).where(LinkRecordingWork.work_id == Work.id))


class CustomURL(URL):
    artist_links = relationship("LinkArtistURL")
    release_links = relationship("LinkReleaseURL")


class CustomLinkAttribute(LinkAttribute):
    link = relationship('Link',
                        foreign_keys=[LinkAttribute.link_id], innerjoin=True,
                        backref="attributes")

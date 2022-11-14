# Copyright (c) 2014, 2015 Lukas Lalinsky, Wieland Hoffmann
# License: MIT, see LICENSE for details
"""
This module wraps models from mbdata package and adds missing relationships
that are used in SIR.
"""
from mbdata.models import (Annotation, Area, Artist, ArtistAlias, Event,
                           Instrument, Label, LinkAttribute,
                           LinkRecordingWork, Medium, MediumCDTOC, Place, Recording, Release,
                           ReleaseGroup, ReleaseLabel, ReleaseRaw, ReleaseTag, Series,
                           Work, URL)
from sqlalchemy import func, select
from sqlalchemy.orm import relationship, column_property
from sqlalchemy.sql.expression import and_


class CustomAnnotation(Annotation):
    areas = relationship("AreaAnnotation", viewonly=True)
    artists = relationship("ArtistAnnotation", viewonly=True)
    events = relationship("EventAnnotation", viewonly=True)
    instruments = relationship("InstrumentAnnotation", viewonly=True)
    labels = relationship("LabelAnnotation", viewonly=True)
    places = relationship("PlaceAnnotation", viewonly=True)
    recordings = relationship("RecordingAnnotation", viewonly=True)
    releases = relationship("ReleaseAnnotation", viewonly=True)
    release_groups = relationship("ReleaseGroupAnnotation", viewonly=True)
    series = relationship("SeriesAnnotation", viewonly=True)
    works = relationship("WorkAnnotation", viewonly=True)


class CustomArea(Area):
    aliases = relationship("AreaAlias", viewonly=True)
    area_links = relationship(
        "LinkAreaArea",
        primaryjoin="Area.id == LinkAreaArea.entity1_id",
        viewonly=True
    )
    tags = relationship("AreaTag", viewonly=True)
    place_count = column_property(
        select([func.count(Place.id)]).
        where(Place.area_id == Area.id).
        scalar_subquery()
    )
    label_count = column_property(
        select([func.count(Label.id)]).
        where(Label.area_id == Area.id).
        scalar_subquery()
    )
    artist_count = column_property(
        select([func.count(Artist.id)]).
        where(Artist.area_id == Area.id).
        scalar_subquery()
    )


class CustomArtist(Artist):
    area = relationship('CustomArea', foreign_keys=[Artist.area_id])
    begin_area = relationship('CustomArea',
                              foreign_keys=[Artist.begin_area_id])
    end_area = relationship('CustomArea', foreign_keys=[Artist.end_area_id])
    tags = relationship('ArtistTag', viewonly=True)
    artist_credit_names = relationship("ArtistCreditName", innerjoin=True,
                                       viewonly=True)
    primary_aliases = column_property(
        select([func.array_agg(ArtistAlias.name)]).
        where(and_(
            ArtistAlias.artist_id == Artist.id,
            ArtistAlias.primary_for_locale == True
        )).
        scalar_subquery()
    )


class CustomArtistAlias(ArtistAlias):
    artist = relationship('Artist', foreign_keys=[ArtistAlias.artist_id],
                          innerjoin=True, backref="aliases", viewonly=True)


class CustomEvent(Event):
    # still need to allow searching with place/area/artist aliases
    aliases = relationship("EventAlias", viewonly=True)
    place_links = relationship("LinkEventPlace", viewonly=True)
    area_links = relationship("LinkAreaEvent", viewonly=True)
    artist_links = relationship("LinkArtistEvent", viewonly=True)
    tags = relationship("EventTag", viewonly=True)


class CustomInstrument(Instrument):
    aliases = relationship("InstrumentAlias", viewonly=True)
    tags = relationship("InstrumentTag", viewonly=True)


class CustomLabel(Label):
    aliases = relationship("LabelAlias", viewonly=True)
    area = relationship("CustomArea", foreign_keys=[Label.area_id])
    tags = relationship("LabelTag", viewonly=True)
    release_count = column_property(
        select([func.count(ReleaseLabel.id)]).
        where(ReleaseLabel.label_id == Label.id).
        scalar_subquery()
    )


class CustomMediumCDToc(MediumCDTOC):
    medium = relationship('Medium', foreign_keys=[MediumCDTOC.medium_id],
                          innerjoin=True, backref="cdtocs", viewonly=True)


class CustomPlace(Place):
    area = relationship("CustomArea", foreign_keys=[Place.area_id])
    aliases = relationship("PlaceAlias", viewonly=True)


class CustomRecording(Recording):
    aliases = relationship("RecordingAlias", viewonly=True)
    first_release_date = relationship("RecordingFirstReleaseDate", viewonly=True)
    tags = relationship("RecordingTag", viewonly=True)


class CustomReleaseGroup(ReleaseGroup):
    aliases = relationship("ReleaseGroupAlias", viewonly=True)
    first_release_date = relationship("ReleaseGroupMeta", viewonly=True)
    releases = relationship("Release", viewonly=True)
    tags = relationship("ReleaseGroupTag", viewonly=True)
    release_count = column_property(
        select([func.count(Release.id)]).
        where(Release.release_group_id == ReleaseGroup.id).
        scalar_subquery()
    )


class CustomRelease(Release):
    aliases = relationship("ReleaseAlias", viewonly=True)
    asin = relationship("ReleaseMeta", viewonly=True)
    medium_count = column_property(
        select([func.count(Medium.id)]).
        where(Medium.release_id == Release.id).
        scalar_subquery()
    )


class CustomReleaseRaw(ReleaseRaw):
    discids = relationship("CDTOCRaw", viewonly=True)


class CustomReleaseTag(ReleaseTag):
    release = relationship('Release', foreign_keys=[ReleaseTag.release_id],
                           innerjoin=True, backref="tags", viewonly=True)


class CustomSeries(Series):
    aliases = relationship("SeriesAlias", viewonly=True)
    tags = relationship("SeriesTag", viewonly=True)


class CustomWork(Work):
    aliases = relationship("WorkAlias", viewonly=True)
    artist_links = relationship("LinkArtistWork", viewonly=True)
    tags = relationship("WorkTag", viewonly=True)
    languages = relationship("WorkLanguage", viewonly=True)
    recording_links = relationship("LinkRecordingWork", viewonly=True)


class CustomURL(URL):
    artist_links = relationship("LinkArtistURL", viewonly=True)
    release_links = relationship("LinkReleaseURL", viewonly=True)


class CustomLinkAttribute(LinkAttribute):
    link = relationship('Link',
                        foreign_keys=[LinkAttribute.link_id], innerjoin=True,
                        backref="attributes", viewonly=True)

# Copyright (c) 2014, 2015 Wieland Hoffmann
# License: MIT, see LICENSE for details
from . import modelext
from . import transformfuncs as tfs
from .searchentities import SearchEntity as E, SearchField as F
from ..wscompat import convert
from mbdata import models


SearchAnnotation = E(modelext.CustomAnnotation, [
    F("id", "id"),
    F("entity", ["areas.area.gid", "artists.artist.gid", "events.event.gid",
                 "instruments.instrument.gid", "labels.label.gid",
                 "places.place.gid", "recordings.recording.gid",
                 "releases.release.gid", "release_groups.release_group.gid",
                 "series.series.gid", "works.work.gid"]),
    F("name", ["areas.area.name", "artists.artist.name", "events.event.name",
               "instruments.instrument.name", "labels.label.name",
               "places.place.name", "recordings.recording.name",
               "releases.release.name", "release_groups.release_group.name",
               "series.series.name", "works.work.name"]),
    F("text", "text"),
    F("type", ["areas.__tablename__", "artists.__tablename__",
               "events.__tablename__", "instruments.__tablename__",
               "labels.__tablename__", "places.__tablename__",
               "recordings.__tablename__", "releases.__tablename__",
               "release_groups.__tablename__", "series.__tablename__",
               "works.__tablename__"],
      transformfunc=tfs.annotation_type)
],
    1.2,
    convert.convert_annotation,
)


SearchArea = E(modelext.CustomArea, [
    F("mbid", "gid"),
    F("area", "name"),
    F("alias", "aliases.name"),
    F("comment", "comment"),
    F("begin", "begin_date", transformfunc=tfs.index_partialdate_to_string),
    F("end", "end_date", transformfunc=tfs.index_partialdate_to_string),
    F("ended", "ended", transformfunc=tfs.ended_to_string),
    F("iso1", "iso_3166_1_codes.code"),
    F("iso2", "iso_3166_2_codes.code"),
    F("iso3", "iso_3166_3_codes.code"),
    F("type", "type.name")
],
    1.2,
    convert.convert_area,
    extrapaths=["aliases.type.name", "aliases.type.id", "aliases.sort_name",
                "aliases.locale", "aliases.primary_for_locale",
                "aliases.begin_date", "aliases.end_date",
                "area_links.area0.name",
                "area_links.area0.gid",
                "area_links.area0.begin_date",
                "area_links.area0.end_date",
                "area_links.area0.type.name",
                "area_links.link.link_type.name",
                "area_links.link.link_type.gid",
                ]
)


SearchCDStub = E(modelext.CustomReleaseRaw, [
    F("id", "id"),
    F("title", "title"),
    F("artist", "artist"),
    F("comment", "comment"),
    F("barcode", "barcode"),
    F("tracks", "discids.track_count"),
    F("discid", "discids.discid")
],
    1.2,
    convert.convert_cdstub
)

SearchLabel = E(modelext.CustomLabel, [
    F("mbid", "gid"),
    F("label", "name"),
    F("alias", "aliases.name"),
    F("area", ["area.name", "area.aliases.name"]),
    F("country", "area.iso_3166_1_codes.code"),
    F("begin", "begin_date", transformfunc=tfs.index_partialdate_to_string),
    F("end", "end_date", transformfunc=tfs.index_partialdate_to_string),
    F("ended", "ended", transformfunc=tfs.ended_to_string),

    F("code", "label_code"),
    F("comment", "comment"),
    F("ipi", "ipis.ipi"),
    F("tag", "tags.tag.name"),
    F("type", "type.name")
],
    1.2,
    convert.convert_label,
    extrapaths=["aliases.type.name", "aliases.type.id", "aliases.sort_name",
                "aliases.locale", "aliases.primary_for_locale",
                "aliases.begin_date", "aliases.end_date"
                "area.gid"
                ]
)


SearchPlace = E(modelext.CustomPlace, [
    F("mbid", "gid"),
    F("address", "address"),
    F("alias", "aliases.name"),
    F("area", ["area.name", "area.aliases.name"]),
    F("begin", "begin_date", transformfunc=tfs.index_partialdate_to_string),
    F("comment", "comment"),
    F("end", "end_date", transformfunc=tfs.index_partialdate_to_string),
    F("ended", "ended", transformfunc=tfs.ended_to_string),
    F("lat", "coordinates", transformfunc=tfs.lat),
    F("long", "coordinates", transformfunc=tfs.long),
    F("place", "name"),
    F("type", "type.name")
],
    1.2,
    convert.convert_place,
    extrapaths=["aliases.type.name", "aliases.type.id", "aliases.sort_name",
                "aliases.locale", "aliases.primary_for_locale",
                "aliases.begin_date", "aliases.end_date"
                "area.gid"]
)


SearchRecording = E(modelext.CustomRecording, [
    F("arid", "artist_credit.artists.artist.gid"),
    F("artist", "artist_credit.name"),
    F("artistname", "artist_credit.artists.artist.name"),
    F("comment", "comment"),
    F("country", "tracks.medium.release.country_dates.country.area.name"),
    F("creditname", "artist_credit.artists.name"),
    F("date", "tracks.medium.release.country_dates.date",
      transformfunc=tfs.index_partialdate_to_string),
    F("dur", "length"),
    F("format", "tracks.medium.format.name"),
    F("isrc", "isrcs.isrc"),
    F("mbid", "gid"),
    F("number", "tracks.number"),
    F("position", "tracks.medium.position"),
    F("primarytype", "tracks.medium.release.release_group.type.name"),
    F("qdur", "length", transformfunc=tfs.qdur),
    F("recording", "name"),
    F("reid", "tracks.medium.release.gid"),
    F("release", "tracks.medium.release.name"),
    F("rgid", "tracks.medium.release.release_group.gid"),
    F("secondarytype",
      "tracks.medium.release.release_group.secondary_types.secondary_type."
      "name"),
    F("status", "tracks.medium.release.status.name"),
    F("tag", "tags.tag.name"),
    F("tid", "tracks.gid"),
    F("tnum", "tracks.position"),
    F("tracks", "tracks.medium.track_count"),
    F("tracksrelease", "tracks.medium.release.mediums.track_count",
        transformfunc=sum),
    F("video", "video")
],
    1.2,
    convert.convert_recording,
    extrapaths=["artist_credit.artists.artist.aliases.begin_date",
                "artist_credit.artists.artist.aliases.end_date",
                "artist_credit.artists.artist.aliases.locale",
                "artist_credit.artists.artist.aliases.name",
                "artist_credit.artists.artist.aliases.primary_for_locale",
                "artist_credit.artists.artist.aliases.sort_name",
                "artist_credit.artists.artist.aliases.type.id",
                "artist_credit.artists.artist.aliases.type.name",
                "artist_credit.artists.artist.comment",
                "artist_credit.artists.artist.gid",
                "artist_credit.artists.artist.name",
                "artist_credit.artists.artist.sort_name",
                "artist_credit.artists.join_phrase",
                "artist_credit.artists.name",
                "artist_credit.name",
                "tags.count",
                "tags.tag.name",
                "tracks.length",
                "tracks.medium.cdtocs.id",
                "tracks.medium.release.artist_credit.artists.artist.aliases."
                "begin_date",
                "tracks.medium.release.artist_credit.artists.artist.aliases."
                "end_date",
                "tracks.medium.release.artist_credit.artists.artist.aliases."
                "locale",
                "tracks.medium.release.artist_credit.artists.artist.aliases."
                "name",
                "tracks.medium.release.artist_credit.artists.artist.aliases."
                "primary_for_locale",
                "tracks.medium.release.artist_credit.artists.artist.aliases."
                "sort_name",
                "tracks.medium.release.artist_credit.artists.artist.aliases."
                "type.id",
                "tracks.medium.release.artist_credit.artists.artist.aliases."
                "type.name",
                "tracks.medium.release.artist_credit.artists.artist.comment",
                "tracks.medium.release.artist_credit.artists.artist.gid",
                "tracks.medium.release.artist_credit.artists.artist.name",
                "tracks.medium.release.artist_credit.artists.artist.sort_name",
                "tracks.medium.release.artist_credit.artists.join_phrase",
                "tracks.medium.release.artist_credit.artists.name",
                "tracks.medium.release.artist_credit.name",
                "tracks.medium.release.comment",
                "tracks.medium.release.country_dates.country.area.gid",
                "tracks.medium.release.country_dates.country.area."
                "iso_3166_1_codes.code",
                "tracks.medium.release.country_dates.country.area.name",
                "tracks.medium.release.country_dates.date_day",
                "tracks.medium.release.country_dates.date_month",
                "tracks.medium.release.country_dates.date_year",
                "tracks.medium.release.release_group.comment",
                "tracks.medium.release.release_group.name",
                "tracks.name"]
)


SearchRelease = E(models.Release, [
    F("mbid", "gid"),
    F("release", "name"),
    F("arid", "artist_credit.artists.artist.gid"),
    F("artist", "artist_credit.name"),
    F("artistname", "artist_credit.artists.artist.name"),
    F("creditname", "artist_credit.artists.name"),
    F("country", "country_dates.country.area.name"),
    F("date", "country_dates.date",
      transformfunc=tfs.index_partialdate_to_string),
    F("barcode", "barcode"),
    F("catno", "labels.catalog_number"),
    F("comment", "comment"),
    F("discids", "mediums.cdtocs.id", transformfunc=len),
    F("format", "mediums.format.name"),
    F("laid", "labels.label.gid"),
    F("label", "labels.label.name"),
    F("lang", "language.name"),
    F("mediums", "mediums.id", transformfunc=len),
    F("primarytype", "release_group.type.name"),
    F("rgid", "release_group.gid"),
    F("script", "script.iso_code"),
    F("secondarytype", "release_group.secondary_types.secondary_type.name"),
    F("status", "status.name"),
    F("tracks", "mediums.track_count",
      transformfunc=sum),
    F("tracksmedium", "mediums.track_count"),
    F("tag", "tags.tag.name")
],
    1.2,
    convert.convert_release,
    extrapaths=["artist_credit.artists.join_phrase",
                "artist_credit.artists.artist.aliases.begin_date",
                "artist_credit.artists.artist.aliases.end_date",
                "artist_credit.artists.artist.aliases.locale",
                "artist_credit.artists.artist.aliases.name",
                "artist_credit.artists.artist.aliases.primary_for_locale",
                "artist_credit.artists.artist.aliases.sort_name",
                "artist_credit.artists.artist.aliases.type.id",
                "artist_credit.artists.artist.aliases.type.name",
                "artist_credit.artists.artist.gid",
                "artist_credit.artists.artist.sort_name",
                "country_dates.country.area.gid",
                "country_dates.country.area.name",
                "country_dates.country.area.iso_3166_1_codes.code",
                "country_dates.date_day",
                "country_dates.date_month",
                "country_dates.date_year",
                "mediums.cdtocs.id",
                "packaging.name",
                "release_group.comment",
                "release_group.name",
                "language.iso_code_3",
                "tags.count"]
)


SearchReleaseGroup = E(modelext.CustomReleaseGroup, [
    F("mbid", "gid"),
    F("releasegroup", "name"),
    F("arid", "artist_credit.artists.artist.gid"),
    F("artist", "artist_credit.name"),
    F("artistname", "artist_credit.artists.artist.name"),
    F("creditname", "artist_credit.artists.name"),
    F("release", "releases.name"),
    F("reid", "releases.gid"),
    F("releases", "releases.gid", transformfunc=len),
    F("status", "releases.status.name"),
    F("comment", "comment"),
    F("tag", "tags.tag.name"),
    F("primarytype", "type.name"),
    F("secondarytype", "secondary_types.secondary_type.name")
],
    1.2,
    convert.convert_release_group,
    extrapaths=["artist_credit.artists.join_phrase",
                "artist_credit.artists.artist.aliases.begin_date",
                "artist_credit.artists.artist.aliases.end_date",
                "artist_credit.artists.artist.aliases.locale",
                "artist_credit.artists.artist.aliases.name",
                "artist_credit.artists.artist.aliases.primary_for_locale",
                "artist_credit.artists.artist.aliases.sort_name",
                "artist_credit.artists.artist.aliases.type.id",
                "artist_credit.artists.artist.aliases.type.name",
                "artist_credit.artists.artist.gid",
                "artist_credit.artists.artist.sort_name",
                "artist_credit.artists.artist.comment",
                "tags.count"
                ]
)

SearchArtist = E(modelext.CustomArtist, [
    F("mbid", "gid"),
    F("artist", "name"),
    F("sortname", "sort_name"),
    F("alias", "aliases.name"),

    F("begin", "begin_date", transformfunc=tfs.index_partialdate_to_string),
    F("end", "end_date", transformfunc=tfs.index_partialdate_to_string),
    F("ended", "ended", transformfunc=tfs.ended_to_string),

    F("area", ["area.name", "area.aliases.name"]),
    F("beginarea", ["begin_area.name", "begin_area.aliases.name"]),
    F("country", "area.iso_3166_1_codes.code"),
    F("endarea", ["end_area.name", "end_area.aliases.name"]),

    F("comment", "comment"),
    F("gender", "gender.name"),
    F("ipi", "ipis.ipi"),
    F("tag", "tags.tag.name"),
    F("type", "type.name")
],
    1.2,
    convert.convert_artist,
    extrapaths=["tags.count",
                "aliases.type.name", "aliases.type.id", "aliases.sort_name",
                "aliases.locale", "aliases.primary_for_locale",
                "aliases.begin_date", "aliases.end_date",
                "begin_area.gid", "area.gid", "end_area.gid"]
)


SearchTag = E(models.Tag, [
    F("id", "id"),
    F("tag", "name")
],
    1.2,
    convert.convert_standalone_tag
)


SearchWork = E(modelext.CustomWork, [
    F("mbid", "gid"),
    F("work", "name"),
    F("alias", "aliases.name"),
    F("arid", "artist_links.artist.gid"),
    F("artist", "artist_links.artist.name"),
    F("comment", "comment"),
    F("iswc", "iswcs.iswc"),
    F("lang", "language.iso_code_3"),
    F("tag", "tags.tag.name"),
    F("type", "type.name")
],
    1.2,
    convert.convert_work,
    extrapaths=["aliases.type.name", "aliases.type.id",
                "aliases.sort_name", "aliases.locale",
                "aliases.primary_for_locale",
                "artist_links.link.link_type.name",
                "artist_links.link.attributes.attribute_type.name"]
)


SCHEMA = {
    "annotation": SearchAnnotation,
    "artist": SearchArtist,
    "area": SearchArea,
    "cdstub": SearchCDStub,
    "label": SearchLabel,
    "place": SearchPlace,
    "recording": SearchRecording,
    "release": SearchRelease,
    "release-group": SearchReleaseGroup,
    "tag": SearchTag,
    "work": SearchWork,
}

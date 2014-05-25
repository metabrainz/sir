# Copyright (c) 2014 Wieland Hoffmann
# License: MIT, see LICENSE for details
from . import modelext
from .searchentities import (SearchEntity as E,
                             SearchField as F,
                             RecordingEntity)
from mbdata import models


SearchLabel = E(modelext.CustomLabel, [
    F("mbid", "gid"),
    F("label", "name"),
    F("alias", "aliases.name"),
    F("area", "area.name"),
    #F("begin", "begin_data"),
    #F("end", "end_date")
    F("comment", "comment"),
    F("ipi", "ipis.ipi"),
    F("type", "type.name")
],
    1.1
)


SearchRecordingReindex = RecordingEntity(modelext.CustomRecording, [
    # F("date", "tracks.medium.release.country_dates.country.date"),
    F("arid", "tmp_artist_credit.artist_gid"),
    # TODO
    F("artist", "tmp_artist_credit.artist_name"),
    F("artistname", "tmp_artist_credit.artist_name"),
    F("comment", "comment"),
    # F("country", "tmp_releaseevent.country_area_name"),
    F("creditname", "tmp_artist_credit.artist_credit_name"),
    F("dur", "length"),
    F("format", "tmp_tracks.medium_format_name"),
    F("isrc", "isrcs.isrc"),
    F("mbid", "gid"),
    F("number", "tmp_tracks.track_number"),
    F("position", "tmp_tracks.medium_position"),
    F("primarytype", "tmp_tracks.tmp_release.release_group_type_name"),
    F("recording", "name"),
    F("reid", "tmp_tracks.tmp_release.release_gid"),
    F("release", "tmp_tracks.tmp_release.release_name"),
    F("rgid", "tmp_tracks.tmp_release.release_group_gid"),
    # F("secondarytype",
    #   "tracks.medium.release.release_group.secondary_types.secondary_type.name"),
    F("status", "tmp_tracks.tmp_release.release_status"),
    F("tid", "tmp_tracks.track_gid"),
    F("tnum", "tmp_tracks.track_position"),
    F("tracks", "tmp_tracks.medium_track_count"),
    F("tracksrelease", "tmp_tracks.tmp_release.release_track_count"),
    F("video", "video")
],
    1.1
)


SearchRelease = E(models.Release, [
    F("mbid", "gid"),
    F("release", "name"),
    F("arid", "artist_credit.artists.artist.gid"),
    F("country", "country_dates.country.area.name"),
    #F("data", "country_dates.date")
    F("comment", "comment"),
    F("lang", "language.name"),
    F("script", "script.name")
],
    1.1
)


SearchReleaseGroup = E(modelext.CustomReleaseGroup, [
    F("mbid", "gid"),
    F("release-group", "name"),
    # F("release", "releases.name"),
    F("reid", "releases.gid"),
    F("releases", "releases.gid", transformfunc=len),
    F("credit-name", "artist_credit.artists.artist.name")
],
    1.1
)

SearchArtist = E(modelext.CustomArtist, [
    F("mbid", "gid"),
    F("name", "name"),
    F("alias", "aliases.name"),
    F("area", ["area.name", "area.aliases.name"]),
    F("beginarea", ["begin_area.name", "begin_area.aliases.name"]),
    F("endarea", ["end_area.name", "end_area.aliases.name"]),
    F("comment", "comment"),
    F("ipi", "ipis.ipi"),
    F("type", "type.name")
],
    1.1
)


SearchWork = E(modelext.CustomWork, [
    F("mbid", "gid"),
    F("name", "name"),
    F("alias", "aliases.name"),
    F("arid", "artist_links.artist.gid"),
    F("artist", "artist_links.artist.name"),
    F("comment", "comment"),
    F("iswc", "iswcs.iswc"),
    F("language", "language.name"),
],
    1.1
)


SCHEMA = {
    "artist": SearchArtist,
    "label": SearchLabel,
    "recording": SearchRecordingReindex,
    "release": SearchRelease,
    "release-group": SearchReleaseGroup,
    "work": SearchWork,
}

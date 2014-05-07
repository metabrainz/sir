# Copyright (c) 2014 Wieland Hoffmann
# License: MIT, see LICENSE for details
from . import modelext
from .searchentities import SearchEntity as E, SearchField as F


SearchRecording = E(modelext.CustomRecording, [
    # F("date", "tracks.medium.release.country_dates.country.date"),
    F("arid", "artist_credit.artists.artist.gid"),
    F("artist", "artist_credit.name"),
    F("artistname", "artist_credit.artists.artist.name"),
    F("comment", "comment"),
    F("country", "tracks.medium.release.country_dates.country.area.name"),
    F("creditname", "artist_credit.artists.name"),
    F("dur", "length"),
    F("format", "tracks.medium.format.name"),
    F("isrc", "isrcs.isrc"),
    F("mbid", "gid"),
    F("number", "tracks.number"),
    F("position", "tracks.medium.position"),
    F("primarytype", "tracks.medium.release.release_group.type.name"),
    F("recording", "name"),
    F("reid", "tracks.medium.release.gid"),
    F("release", "tracks.medium.release.name"),
    F("rgid", "tracks.medium.release.release_group.gid"),
    F("secondarytype",
      "tracks.medium.release.release_group.secondary_types.secondary_type.name"),
    F("status", "tracks.medium.release.status.name"),
    F("tid", "tracks.gid"),
    F("tnum", "tracks.position"),
    F("tracks", "tracks.medium.track_count"),
    F("tracksrelease", "tracks.medium.release.mediums.track_count",
        transformfunc=lambda values: reduce(lambda x, y: x+y, values, 0)),
    F("video", "video")
])

SearchReleaseGroup = E(modelext.CustomReleaseGroup, [
    F("mbid", "gid"),
    F("release-group", "name"),
    # F("release", "releases.name"),
    F("reid", "releases.gid"),
    F("releases", "releases.gid", transformfunc=len),
    F("credit-name", "artist_credit.artists.artist.name")
])

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
    ])


SCHEMA = {
    "artist": SearchArtist,
    "recording": SearchRecording,
    "release-group": SearchReleaseGroup
}

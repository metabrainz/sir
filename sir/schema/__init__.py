# Copyright (c) 2014 Wieland Hoffmann
# License: MIT, see LICENSE for details
from mbdata import models
from . import modelext
from .searchentities import SearchEntity as E, SearchField as F


SearchRecording = E(modelext.CustomRecording, [
    F("mbid", "gid"),
    F("recording", "name"),
    F("arid", "artist_credit.artists.artist.gid"),
    # F("artistname", ["artist_credit.name",
    #                            "artist_credit.artists.artist.name"]),
    F("reid", "tracks.medium.release.gid"),
    F("release", "tracks.medium.release.name"),
    F("comment", "comment"),
    F("dur", "length"),
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


SCHEMA = {
    "recording": SearchRecording,
    "release-group": SearchReleaseGroup
}

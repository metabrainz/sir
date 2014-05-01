from mbdata import models
from . import modelext
from .searchentities import SearchEntity, SearchField


SearchRecording = SearchEntity(modelext.CustomRecording, [
    SearchField("mbid", "gid"),
    SearchField("recording", "name"),
    SearchField("arid", "artist_credit.artists.artist.gid"),
    # SearchField("artistname", ["artist_credit.name",
    #                            "artist_credit.artists.artist.name"]),
    SearchField("reid", "tracks.medium.release.gid"),
    SearchField("release", "tracks.medium.release.name"),
    SearchField("comment", "comment"),
    SearchField("dur", "length"),
    SearchField("video", "video")
    ])

SearchReleaseGroup = SearchEntity(modelext.CustomReleaseGroup, [
    SearchField("mbid", "gid"),
    SearchField("release", "releases.name"),
    SearchField("releases", "releases.gid", transformfunc=lambda values:len(values))
    ])


SCHEMA = {
    "recording": SearchRecording,
    "release-group": SearchReleaseGroup
}
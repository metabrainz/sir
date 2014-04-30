from mbdata import models
from .modelext import CustomReleaseGroup
from .searchentities import SearchEntity, SearchField


SearchRecording = SearchEntity(models.Recording, [
    SearchField("mbid", "gid"),
    SearchField("name", "name"),
    SearchField("artist", ["artist_credit.artists.name", "artist_credit.name"])
    ])

SearchReleaseGroup = SearchEntity(CustomReleaseGroup, [
    SearchField("release", "releases.name"),
    SearchField("releases", "releases.gid", transformfunc=lambda values:set([len(values)]))
    ])


SCHEMA = {
    "recording": SearchRecording,
    "release-group": SearchReleaseGroup
}
from mbdata import models
from .searchentities import SearchEntity, SearchField


SearchRecording = SearchEntity(models.Recording, [
    SearchField("mbid", "gid"),
    SearchField("name", "name"),
    SearchField("artist", "artist_credit.artists.name")
    ])


SCHEMA = {
    "recording": SearchRecording
}
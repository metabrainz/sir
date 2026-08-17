# Copyright (c) 2014, 2015 Wieland Hoffmann
# License: MIT, see LICENSE for details
from functools import lru_cache

import orjson

from sir.wscompat.convert import calculate_type, partialdate_to_string

ANNOTATION_TABLE_TO_ENTITYTYPE = {
    "area_annotation": "area",
    "artist_annotation": "artist",
    "event_annotation": "event",
    "instrument_annotation": "instrument",
    "label_annotation": "label",
    "place_annotation": "place",
    "recording_annotation": "recording",
    "release_annotation": "release",
    "release_group_annotation": "release-group",
    "series_annotation": "series",
    "work_annotation": "work",
}

URL_LINK_TABLE_TO_ENTITYTYPE = {
    "l_area_url": "area",
    "l_artist_url": "artist",
    "l_event_url": "event",
    "l_instrument_url": "instrument",
    "l_label_url": "label",
    "l_place_url": "place",
    "l_recording_url": "recording",
    "l_release_url": "release",
    "l_release_group_url": "release-group",
    "l_series_url": "series",
    "l_url_work": "work",
    "l_url_url": "url",
}


def fill_none(values):
    # When a field is not applicable - for eg. when a release doesn't have a barcode
    # as opposed to it being unknown it is known but it is `[none]`. `[none]` is stored
    # in the DB as an empty string, so doing this allows us to search for releases with
    # `[none]` type barcode via the syntax `barcode:none`
    if "" in values:
        return values.append("none")
    return values


def integer_count_all(records):
    return int(len(records))


def integer_sum(values):
    return int(sum(values))


def ended_to_string(ended):
    """
    :param ended:
    :type ended: set(bool)
    :rtype str:
    """
    if len(ended) and ended.pop():
        return "true"
    return "false"


def index_partialdate_to_string(dates):
    if len(dates):
        d = dates.pop()
        return partialdate_to_string(d)
    return None


def index_partialdatelist_to_string(date_list):
    for idx in range(len(date_list)):
        date_list[idx] = partialdate_to_string(date_list[idx])
    return date_list

def index_time_to_string(times):
    if len(times):
        return times.pop().strftime("%H:%M:%S")
    return None


def _alias_dict(alias) -> dict:
    alias_dict = {"name": alias.name}
    if alias.sort_name:
        alias_dict["sort_name"] = alias.sort_name
    if alias.locale:
        alias_dict["locale"] = alias.locale
    if alias.primary_for_locale:
        alias_dict["primary"] = "primary"
    begin_date = partialdate_to_string(alias.begin_date)
    if begin_date:
        alias_dict["begin_date"] = begin_date
    end_date = partialdate_to_string(alias.end_date)
    if end_date:
        alias_dict["end_date"] = end_date
    if alias.type is not None:
        alias_dict["type"] = alias.type.name
        alias_dict["type_id"] = str(alias.type.gid)
    return alias_dict


def aliases_to_json(artist):
    return [orjson.dumps(_alias_dict(a)).decode("utf-8") for a in artist.aliases]


def area_relations_to_json(area) -> str:
    relations = []
    for link in area.area_links:
        parent = link.entity0
        parent_dict = {"id": str(parent.gid), "name": parent.name}
        if parent.type is not None:
            parent_dict["type"] = parent.type.name
            parent_dict["type_id"] = str(parent.type.gid)
        begin_date = partialdate_to_string(parent.begin_date)
        if begin_date:
            parent_dict["begin_date"] = begin_date
        end_date = partialdate_to_string(parent.end_date)
        if end_date:
            parent_dict["end_date"] = end_date
        parent_dict["ended"] = "true" if parent.ended else "false"

        data = {
            "direction": "backward",
            "type": link.link.link_type.name,
            "type_id": str(link.link.link_type.gid),
            "target": str(parent.gid),
            "area": parent_dict,
        }
        relations.append(orjson.dumps(data).decode("utf-8"))
    return relations


def url_relations_to_json(url):
    relations = []
    for link in url.artist_links:
        artist = link.artist
        artist_dict = {"id": str(artist.gid), "name": artist.name}
        if artist.comment:
            artist_dict["disambiguation"] = artist.comment
        if artist.sort_name is not None:
            artist_dict["sort_name"] = artist.sort_name
        relations.append(
            orjson.dumps(
                {
                    "target_type": "artist",
                    "direction": "backward",
                    "type": link.link.link_type.name,
                    "type_id": str(link.link.link_type.gid),
                    "artist": artist_dict,
                }
            ).decode("utf-8")
        )
    for link in url.release_links:
        release = link.release
        release_dict = {"id": str(release.gid), "title": release.name}
        if release.comment:
            release_dict["disambiguation"] = release.comment
        relations.append(
            orjson.dumps(
                {
                    "target_type": "release",
                    "direction": "backward",
                    "type": link.link.link_type.name,
                    "type_id": str(link.link.link_type.gid),
                    "release": release_dict,
                }
            ).decode("utf-8")
        )
    return relations


def work_relations_to_json(work):
    relations = []
    for link in work.artist_links:
        artist = link.artist
        artist_dict = {"id": str(artist.gid), "name": artist.name}
        if artist.comment:
            artist_dict["disambiguation"] = artist.comment
        if artist.sort_name is not None:
            artist_dict["sort_name"] = artist.sort_name
        relations.append(
            orjson.dumps(
                {
                    "target_type": "artist",
                    "direction": "backward",
                    "type": link.link.link_type.name,
                    "type_id": str(link.link.link_type.gid),
                    "artist": artist_dict,
                }
            ).decode("utf-8")
        )
    for link in work.recording_links:
        recording = link.recording
        recording_dict = {"id": str(recording.gid), "title": recording.name}
        if recording.video:
            recording_dict["video"] = True
        relations.append(
            orjson.dumps(
                {
                    "target_type": "recording",
                    "direction": "backward",
                    "type": link.link.link_type.name,
                    "type_id": str(link.link.link_type.gid),
                    "recording": recording_dict,
                }
            ).decode("utf-8")
        )
    return relations


def event_relations_to_json(event):
    relations = []
    for link in event.area_links:
        area = link.area
        relations.append(
            orjson.dumps(
                {
                    "target_type": "area",
                    "type": link.link.link_type.name,
                    "direction": "backward",
                    "type_id": str(link.link.link_type.gid),
                    "area": {"id": str(area.gid), "name": area.name},
                }
            ).decode("utf-8")
        )
    for link in event.artist_links:
        artist = link.artist
        artist_dict = {"id": str(artist.gid), "name": artist.name}
        if artist.comment:
            artist_dict["disambiguation"] = artist.comment
        if artist.sort_name is not None:
            artist_dict["sort_name"] = artist.sort_name
        relations.append(
            orjson.dumps(
                {
                    "target_type": "artist",
                    "direction": "backward",
                    "type": link.link.link_type.name,
                    "type_id": str(link.link.link_type.gid),
                    "artist": artist_dict,
                }
            ).decode("utf-8")
        )
    for link in event.place_links:
        place = link.place
        relations.append(
            orjson.dumps(
                {
                    "target_type": "place",
                    "direction": "backward",
                    "type": link.link.link_type.name,
                    "type_id": str(link.link.link_type.gid),
                    "place": {"id": str(place.gid), "name": place.name},
                }
            ).decode("utf-8")
        )
    return relations


def _release_event_dict(country_date):
    area = country_date.country.area
    return {
        "area": {
            "id": str(area.gid),
            "name": area.name,
            "iso_3166_1_codes": [c.code for c in area.iso_3166_1_codes],
        },
        "date": partialdate_to_string(country_date.date),
    }


def _medium_from_track_dict(track):
    medium = track.medium
    medium_dict = {"id": str(medium.gid)}
    if medium.format is not None:
        medium_dict["format"] = medium.format.name
    medium_dict["track_count"] = medium.track_count

    medium_dict["position"] = medium.position
    medium_dict["track_offset"] = track.position - 1

    track_dict = {"id": str(track.gid)}
    if track.length is not None:
        track_dict["length"] = track.length
    track_dict["number"] = track.number
    track_dict["title"] = track.name

    medium_dict["track"] = track_dict
    return medium_dict


def _release_group_for_release_dict(release_group):
    release_group_dict = {"id": str(release_group.gid), "title": release_group.name}
    if release_group.type is not None:
        release_group_dict["primarytype"] = release_group.type.name
        release_group_dict["primarytype_gid"] = str(release_group.type.gid)
        calc_type = calculate_type(release_group.type, release_group.secondary_types)
        release_group_dict["calc_type"] = calc_type.name
        release_group_dict["calc_type_gid"] = str(calc_type.gid)
    if release_group.secondary_types:
        release_group_dict["secondarytype"] = [
            t.secondary_type.name for t in release_group.secondary_types
        ]
        release_group_dict["secondarytype_gid"] = [
            str(t.secondary_type.gid) for t in release_group.secondary_types
        ]
    if release_group.comment:
        release_group_dict["disambiguation"] = release_group.comment
    return release_group_dict

@lru_cache(maxsize=5000)
def _artist_credit_dict(artist_credit, include_aliases):
    name_credits = []
    for nc in artist_credit.artists:
        artist = nc.artist
        artist_dict = {"id": str(artist.gid), "name": artist.name}
        if artist.comment:
            artist_dict["disambiguation"] = artist.comment
        if artist.sort_name is not None:
            artist_dict["sort_name"] = artist.sort_name

        if include_aliases and artist.aliases:
            artist_dict["aliases"] = [_alias_dict(a) for a in artist.aliases]

        credit = {"name": nc.name, "artist": artist_dict}
        if nc.join_phrase != "":
            credit["joinphrase"] = nc.join_phrase
        name_credits.append(credit)

    return {"id": str(artist_credit.gid), "name_credits": name_credits}


def recording_artist_credit_to_json(recording):
    return orjson.dumps(_artist_credit_dict(recording.artist_credit, True)).decode("utf-8")


def recording_releases_to_json(recording):
    recording_credit = _artist_credit_dict(recording.artist_credit, True)
    releases = []
    for track in recording.tracks:
        release = track.medium.release
        release_dict = {"id": str(release.gid), "title": release.name}

        release_credit = _artist_credit_dict(release.artist_credit, False)
        if release_credit != recording_credit:
            release_dict["artist_credit"] = release_credit

        if release.comment:
            release_dict["disambiguation"] = release.comment

        if release.country_dates:
            release_dict["release_events"] = [
                _release_event_dict(cd) for cd in release.country_dates
            ]

        release_dict["medium"] = _medium_from_track_dict(track)
        release_dict["medium_count"] = len(release.mediums)
        release_dict["medium_track_count"] = sum(int(m.track_count) for m in release.mediums)

        release_dict["release_group"] = _release_group_for_release_dict(release.release_group)

        if release.status is not None:
            release_dict["status"] = release.status.name
            release_dict["status_id"] = str(release.status.gid)

        releases.append(orjson.dumps(release_dict).decode("utf-8"))
    return releases


def release_artist_credit_to_json(release):
    return orjson.dumps(_artist_credit_dict(release.artist_credit, False)).decode("utf-8")


def _release_event_dict(country_date):
    area = country_date.country.area
    return {
        "area": {
            "id": str(area.gid),
            "name": area.name,
            "iso_3166_1_codes": [c.code for c in area.iso_3166_1_codes],
        },
        "date": partialdate_to_string(country_date.date),
    }


def release_events_to_json(release):
    return [orjson.dumps(_release_event_dict(cd)).decode("utf-8") for cd in release.country_dates]


def release_label_info_to_json(release):
    label_infos = []
    for release_label in release.labels:
        label_info = {}
        if release_label.catalog_number:
            label_info["catalog_number"] = release_label.catalog_number
        if release_label.label is not None:
            label_info["label"] = {
                "id": str(release_label.label.gid),
                "name": release_label.label.name,
            }
        label_infos.append(orjson.dumps(label_info).decode("utf-8"))
    return label_infos


def release_mediums_to_json(release):
    mediums = []
    for medium in release.mediums:
        medium_dict = {"id": str(medium.gid)}
        if medium.format is not None:
            medium_dict["format"] = medium.format.name
        medium_dict["disc_count"] = len(medium.cdtocs)
        medium_dict["track_count"] = medium.track_count
        mediums.append(orjson.dumps(medium_dict).decode("utf-8"))
    return mediums


def release_barcode_none(release):
    return "true" if release.barcode == "" else None


def release_calc_type(release):
    return release_group_calc_type(release.release_group)


def release_calc_type_gid(release):
    return release_group_calc_type_gid(release.release_group)


def release_group_calc_type(release_group):
    if release_group.type is None:
        return None
    return calculate_type(release_group.type, release_group.secondary_types).name


def release_group_calc_type_gid(release_group):
    if release_group.type is None:
        return None
    return str(calculate_type(release_group.type, release_group.secondary_types).gid)


def release_group_artist_credit_to_json(release_group):
    return orjson.dumps(
        _artist_credit_dict(release_group.artist_credit, True)
    ).decode("utf-8")


def release_group_releases_to_json(release_group):
    releases = []
    for release in release_group.releases:
        release_dict = {"id": str(release.gid), "title": release.name}
        if release.status is not None:
            release_dict["status"] = release.status.name
            release_dict["status_id"] = str(release.status.gid)
        releases.append(orjson.dumps(release_dict).decode("utf-8"))
    return releases


def qdur(durations):
    if len(durations):
        return durations.pop() // 2000
    return None


def lat(points):
    if len(points):
        return points.pop()[0]


def long(points):
    if len(points):
        return points.pop()[1]


def annotation_type(entities):
    if len(entities):
        first_entity_table = entities.pop()
        return ANNOTATION_TABLE_TO_ENTITYTYPE[first_entity_table]


def boolean(values):
    """
    :type values: set
    """
    value = values.pop()
    if value:
        return "t"
    else:
        return "f"


def url_type(values):
    types = set(URL_LINK_TABLE_TO_ENTITYTYPE[value] for value in values)
    return types


def uuid_list_to_str_list(values):
    return [str(x) for x in values]


def datetime_to_timestamp(values):
    if values:
        return int(values.pop().timestamp())


def str_list_to_lowercase(values: list[str]) -> list:
    return [string.lower() for string in values]

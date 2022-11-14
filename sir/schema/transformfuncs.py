# Copyright (c) 2014, 2015 Wieland Hoffmann
# License: MIT, see LICENSE for details
from sir.wscompat.convert import partialdate_to_string


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
    "work_annotation": "work"
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
    "l_url_url": "url"
}


def fill_none(values):
    # When a field is not applicable - for eg. when a release doesn't have a barcode
    # as opposed to it being unknown it is known but it is `[none]`. `[none]` is stored
    # in the DB as an empty string, so doing this allows us to search for releases with
    # `[none]` type barcode via the syntax `barcode:none`
    if "" in values:
        return values.add('none')
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

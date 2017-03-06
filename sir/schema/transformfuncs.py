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
    "release_group_annotation": "releasegroup",
    "series_annotation": "series",
    "work_annotation": "work"
}


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
        return durations.pop() / 2000
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

# Copyright (c) 2014 Wieland Hoffmann
# License: MIT, see LICENSE for details
from ..wscompat.convert import partialdate_to_string


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

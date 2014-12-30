# Copyright (c) 2014 Wieland Hoffmann
# License: MIT, see LICENSE for details


def ended_to_string(ended):
    """
    :param ended:
    :type ended: set(bool)
    :rtype str:
    """
    if len(ended) and ended.pop():
        return "true"
    return "false"

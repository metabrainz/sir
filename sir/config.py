# Copyright (c) 2014 Wieland Hoffmann
# License: MIT, see LICENSE for details
import ConfigParser

#: A :class:`ConfigParser.SafeConfigParser` instance holding the configuration
#: data.
CFG = None


def read_config():
    """
    Read config files from all possible locations and set
    :const:`sir.config.CFG` to a :class:`ConfigParser.SafeConfigParser`
    instance.
    """
    config = ConfigParser.SafeConfigParser()
    config.read(["config.ini"])
    global CFG
    CFG = config

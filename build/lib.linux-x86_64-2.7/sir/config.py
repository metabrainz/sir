# Copyright (c) 2014 Wieland Hoffmann
# License: MIT, see LICENSE for details
import ConfigParser

#: A :class:`ConfigParser.SafeConfigParser` instance holding the configuration
#: data.
CFG = None


class ConfigError(Exception):
    pass


def read_config():
    """
    Read config files from all possible locations and set
    :const:`sir.config.CFG` to a :class:`ConfigParser.SafeConfigParser`
    instance.
    """
    config = ConfigParser.SafeConfigParser()
    read_files = config.read(["config.ini"])
    if not read_files:
        raise ConfigError("No configuration file could be found")
    global CFG
    CFG = config

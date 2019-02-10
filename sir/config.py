# Copyright (c) 2014 Wieland Hoffmann
# License: MIT, see LICENSE for details
import ConfigParser
import os.path

#: A :class:`SafeExpandingConfigParser` instance holding the configuration
#: data.
CFG = None  # type: SafeExpandingConfigParser


class SafeExpandingConfigParser(ConfigParser.SafeConfigParser, object):
    def _interpolate(self, section, option, rawval, vars):
        return os.path.expandvars(super(SafeExpandingConfigParser,
            self)._interpolate(section, option, rawval, vars))


class ConfigError(Exception):
    pass


def read_config():
    """
    Read config files from all possible locations and set
    :const:`sir.config.CFG` to a :class:`SafeExpandingConfigParser`
    instance.
    """
    config = SafeExpandingConfigParser()
    read_files = config.read([os.path.join(
        os.path.dirname(os.path.realpath(__file__)),
        "..", "config.ini"
    )])
    if not read_files:
        raise ConfigError("No configuration file could be found")
    global CFG
    CFG = config

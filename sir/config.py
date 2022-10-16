# Copyright (c) 2014 Wieland Hoffmann
# License: MIT, see LICENSE for details
from configparser import ConfigParser, ExtendedInterpolation
import os.path

#: A :class:`ConfigParser` instance holding the configuration data.
CFG = None  # type: ConfigParser


class EnvironmentInterpolation(ExtendedInterpolation):
    def before_read(self, parser, section, option, value):
        value = super().before_read(parser, section, option, value)
        return os.path.expandvars(value)


class ConfigError(Exception):
    pass


def read_config():
    """
    Read config files from all possible locations and set
    :const:`sir.config.CFG` to a :class:`SafeExpandingConfigParser`
    instance.
    """
    config = ConfigParser(interpolation=EnvironmentInterpolation())
    read_files = config.read([os.path.join(
        os.path.dirname(os.path.realpath(__file__)),
        "..", "config.ini"
    )])
    if not read_files:
        raise ConfigError("No configuration file could be found")
    global CFG
    CFG = config

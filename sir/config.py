import ConfigParser


CFG = None


def read_config():
    """
    Read config files from all possible locations and set
    :data:`sir.config.CFG` to a :class:`ConfigParser.SafeConfigParser`
    instance.
    """
    config = ConfigParser.SafeConfigParser()
    config.read(["config.ini"])
    global CFG
    CFG = config

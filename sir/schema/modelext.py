# Copyright (c) 2014 Lukas Lalinsky, Wieland Hoffmann
# License: MIT, see LICENSE for details
from mbdata import models
from sqlalchemy.orm import relationship


class CustomRecording(models.Recording):
    tracks = relationship("Track")


class CustomReleaseGroup(models.ReleaseGroup):
    releases = relationship("Release")

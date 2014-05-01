from mbdata import models
from sqlalchemy.orm import relationship


class CustomRecording(models.Recording):
    tracks = relationship("Track")


class CustomReleaseGroup(models.ReleaseGroup):
    releases = relationship("Release")

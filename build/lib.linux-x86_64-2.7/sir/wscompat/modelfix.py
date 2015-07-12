# Copyright (c) Wieland Hoffmann
# License: MIT, see LICENSE for details
from functools import wraps
from mbrng import models


def fix():
    def _patched_to_etree(f):
        @wraps(f)
        def wrapper(self, *args, **kwargs):
            elem = f(self, *args, **kwargs)
            elem.text = self.gds_format_string(self.get_valueOf_())
            return elem
        return wrapper

    models.alias.to_etree = _patched_to_etree(models.alias.to_etree)

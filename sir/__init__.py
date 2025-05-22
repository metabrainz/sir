from importlib.metadata import version, PackageNotFoundError

try:
    __version__ = version("sir")
except PackageNotFoundError:
    pass

import sentry_sdk


def init_sentry_sdk(dsn):
    # ignore_errors is not yet stabilized, see
    # https://github.com/getsentry/sentry-python/issues/149
    sentry_sdk.init(dsn=dsn, ignore_errors=[KeyboardInterrupt])

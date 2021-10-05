try:
    # Version is required only for generating the documentation
    from .version import __version__  # noqa
except ImportError:
    __version__ = None

import sentry_sdk


def init_sentry_sdk(dsn):
    # ignore_errors is not yet stabilized, see
    # https://github.com/getsentry/sentry-python/issues/149
    sentry_sdk.init(dsn=dsn, ignore_errors=[KeyboardInterrupt])

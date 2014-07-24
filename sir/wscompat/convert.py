# Copyright (c) Wieland Hoffmann
# License: MIT, see LICENSE for details
from mbrng import models


def convert_alias(obj):
    """
    :type obj: :class:`mbdata.models.WorkAlias`
    """
    alias = models.alias()
    alias.set_locale(obj.locale)
    alias.set_sort_name(obj.sort_name)
    alias.content_ = obj.name
    if obj.type is not None:
        alias.set_type(obj.type.name)
    if obj.primary_for_locale:
        alias.set_primary("primary")
    return alias


def convert_alias_list(obj):
    """
    :type obj: [:class:`mbdata.models.WorkAlias`]
    """
    alias_list = models.alias_list()
    map(lambda a: alias_list.add_alias(convert_alias(a)), obj)
    return alias_list


def convert_artist(artist):
    pass


def convert_label(label):
    pass


def convert_recording(recording):
    pass


def convert_release(release):
    pass


def convert_release_group(release_group):
    pass


def convert_work(obj):
    """
    :type obj: :class:`sir.schema.modelext.CustomWork`
    """
    work = models.work()
    work.set_alias_list(convert_alias_list(obj.aliases))
    work.set_id(obj.gid)
    work.set_title(obj.name)
    if obj.language is not None:
        work.set_language(obj.language.name)
    return work

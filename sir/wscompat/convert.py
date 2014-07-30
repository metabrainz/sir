# Copyright (c) Wieland Hoffmann
# License: MIT, see LICENSE for details
from .modelfix import fix
from mbrng import models

fix()


def convert_alias(obj):
    """
    :type obj: :class:`mbdata.models.WorkAlias`
    """
    alias = models.alias()
    alias.set_locale(obj.locale)
    alias.set_sort_name(obj.sort_name)
    alias.set_valueOf_(obj.name)
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


def convert_attribute(obj):
    """
    :type obj: :class:`mbdata.models.LinkAttribute`
    """
    attribute = models.attributeType()
    attribute.value = obj.attribute_type.name
    return attribute


def convert_artist_work_relation(obj):
    """
    :type obj: :class:`mbdata.models.LinkArtistWork`
    """
    relation = models.relation()
    relation.set_direction("backward")
    relation.set_type(obj.link.link_type.name)

    artist = models.artist()
    artist.set_id(obj.artist.gid)
    artist.set_name(obj.artist.name)
    if obj.artist.sort_name is not None:
        artist.set_sort_name(obj.artist.sort_name)
    relation.set_artist(artist)

    if len(obj.link.attributes) > 0:
        attribute_list = models.attribute_listType()
        map(lambda a: attribute_list.add_attribute(convert_attribute(a)),
            obj.link.attributes)
        relation.set_attribute_list(attribute_list)

    return relation


def convert_artist_work_relation_list(obj):
    """
    :type obj: [:class:`mbdata.models.LinkArtistWork`]
    """
    relation_list = models.relation_list(target_type="artist")
    map(lambda r: relation_list.add_relation(convert_artist_work_relation(r)), obj)
    return relation_list


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
    work.add_relation_list(convert_artist_work_relation_list(obj.artist_links))
    work.set_id(obj.gid)
    work.set_title(obj.name)
    if obj.language is not None:
        work.set_language(obj.language.name)
    return work

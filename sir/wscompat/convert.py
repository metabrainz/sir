# Copyright (c) Wieland Hoffmann
# License: MIT, see LICENSE for details
from .modelfix import fix
from mbrng import models

fix()


def partialdate_to_string(obj):
    """
    :type obj: :class:`mbdata.types.PartialDate`
    """
    args = []
    formatstring = ""

    if obj.year is not None and obj.year != 0:
        formatstring += "%04d"
        args.append(obj.year)

        if obj.month is not None and obj.month != 0:
            formatstring += "-%02d"
            args.append(obj.month)

            if obj.day is not None and obj.day != 0:
                formatstring += "-%02d"
                args.append(obj.day)

    return formatstring % tuple(args)

def convert_area_inner(obj):
    """
    :type obj: :class:`mbdata.models.Area`
    """
    area = models.def_area_element_inner()
    area.set_id(obj.gid)
    area.set_name(obj.name)
    area.set_sort_name(obj.name)
    return area


def convert_alias(obj, has_sort_name=True):
    """
    :type obj: :class:`mbdata.models.WorkAlias`
    """
    alias = models.alias()
    alias.set_locale(obj.locale)
    if has_sort_name:
        alias.set_sort_name(obj.sort_name)
    else:
        alias.set_sort_name(obj.name)
    alias.set_valueOf_(obj.name)
    if obj.type is not None:
        alias.set_type(obj.type.name)
    if obj.primary_for_locale:
        alias.set_primary("primary")
    if obj.begin_date is not None:
        alias.set_begin_date(partialdate_to_string(obj.begin_date))
    if obj.end_date is not None:
        alias.set_end_date(partialdate_to_string(obj.end_date))
    return alias


def convert_tag(obj):
    """
    :type obj: :class:`mbdata.models.ArtistTag`
    """
    tag = models.tag()
    tag.set_count(obj.count)
    tag.set_name(obj.tag.name)
    return tag


def convert_alias_list(obj, has_sort_name=True):
    """
    :type obj: [:class:`mbdata.models.WorkAlias`]
    """
    alias_list = models.alias_list()
    map(lambda a: alias_list.add_alias(convert_alias(a, has_sort_name)), obj)
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


def convert_ipi_list(obj):
    """
    :type obj: [:class:`mbdata.models.ArtistIPI`]
    """
    ipi_list = models.ipi_list()
    map(lambda i: ipi_list.add_ipi(i.ipi), obj)
    return ipi_list


def convert_tag_list(obj):
    """
    :type obj: [:class:`mbdata.models.ArtistTag`]
    """
    tag_list = models.tag_list()
    map(lambda t: tag_list.add_tag(convert_tag(t)), obj)
    return tag_list


def convert_artist(obj):
    """
    :type obj: :class:`sir.schema.modelext.CustomArtist`
    """
    artist = models.artist()

    if obj.comment is not None:
        artist.set_disambiguation(obj.comment)

    artist.set_id(obj.gid)
    artist.set_name(obj.name)
    artist.set_sort_name(obj.sort_name)

    if artist.gender is not None:
        artist.set_gender(artist.gender.name)

    if obj.type is not None:
        artist.set_type(obj.type.name)

    if obj.begin_area is not None:
        artist.set_begin_area(convert_area_inner(obj.begin_area))

    if obj.area is not None:
        artist.set_area(convert_area_inner(obj.area))
        if len(obj.area.iso_3166_1_codes) > 0:
            artist.set_country(obj.area.iso_3166_1_codes[0].code)

    if obj.end_area is not None:
        artist.set_end_area(convert_area_inner(obj.end_area))

    lifespan = models.life_span()

    if obj.begin_date is not None:
        lifespan.set_begin(partialdate_to_string(obj.begin_date))

    if obj.end_date is not None:
        lifespan.set_end(partialdate_to_string(obj.end_date))

    if obj.ended:
        lifespan.set_ended("true")
    else:
        lifespan.set_ended("false")

    artist.set_life_span(lifespan)

    if len(obj.aliases) > 0:
        artist.set_alias_list(convert_alias_list(obj.aliases))

    if len(obj.ipis) > 0:
        artist.set_ipi_list(convert_ipi_list(obj.ipis))

    if len(obj.tags) > 0:
        artist.set_tag_list(convert_tag_list(obj.tags))

    return artist


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
    if len(obj.aliases) > 0:
        work.set_alias_list(convert_alias_list(obj.aliases))
    if len(obj.artist_links) > 0:
        work.add_relation_list(convert_artist_work_relation_list(obj.artist_links))
    work.set_id(obj.gid)
    work.set_title(obj.name)
    if obj.language is not None:
        work.set_language(obj.language.name)
    return work

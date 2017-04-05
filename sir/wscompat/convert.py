# Copyright (c) Wieland Hoffmann
# License: MIT, see LICENSE for details
from sir.wscompat.modelfix import fix
try:
    # Python 3
    from functools import lru_cache
except ImportError:
    from backports.functools_lru_cache import lru_cache
from mbrng import models

fix()

#: Constant for a missing barcode
BARCODE_NONE = "none"

#: Constant for unknown barcode values
BARCODE_UNKOWN = "-"


#: Time format string
TIME_FORMAT = "%H:%M:%S"


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


def datetime_to_string(obj):
    """
    :type obj: :class:`datetime.time`
    """
    return obj.strftime(TIME_FORMAT)


def convert_iso_3166_1_code_list(obj):
    """
    :type obj: :class:`[mbdata.models.ISO31661]`
    """
    l = models.iso_3166_1_code_list()
    [l.add_iso_3166_1_code(c.code) for c in obj]
    return l


def convert_iso_3166_2_code_list(obj):
    """
    :type obj: :class:`[mbdata.models.ISO31662]`
    """
    l = models.iso_3166_2_code_list()
    [l.add_iso_3166_2_code(c.code) for c in obj]
    return l


def convert_iso_3166_3_code_list(obj):
    """
    :type obj: :class:`[mbdata.models.ISO31663]`
    """
    l = models.iso_3166_3_code_list()
    [l.add_iso_3166_3_code(c.code) for c in obj]
    return l


@lru_cache()
def convert_area_inner(obj):
    """
    :type obj: :class:`mbdata.models.Area`
    """
    area = models.def_area_element_inner(id=obj.gid, name=obj.name,
                                         sort_name=obj.name)

    if obj.type is not None:
        area.set_type(obj.type.name)

    return area


@lru_cache()
def convert_area_for_release_event(obj):
    """
    :type obj: :class:`mbdata.models.Area`
    """
    area = models.def_area_element_inner(id=obj.gid, name=obj.name,
                                         sort_name=obj.name,
                                         iso_3166_1_code_list=convert_iso_3166_1_code_list(obj.iso_3166_1_codes))  # noqa
    return area


def convert_area_relation(obj):
    """
    :type obj: :class:`mbdata.models.LinkAreaArea`
    """
    relation = models.relation(direction="backward",
                               target=models.target(valueOf_=obj.area0.gid),
                               type_=obj.link.link_type.name,
                               type_id=obj.link.link_type.gid,
                               area=convert_area_inner(obj.area0))

    return relation


def convert_area_relation_list(obj):
    """
    :type obj: :class:`[mbdata.models.LinkAreaArea]`
    """
    relations = models.relation_list(target_type="area")
    [relations.add_relation(convert_area_relation(a)) for a in obj]
    return relations


def convert_name_credit(obj, include_aliases=True):
    """
    :type obj: :class:`mbdata.models.ArtistCreditName`
    """
    nc = models.name_credit(name=obj.name,
                            artist=convert_artist_simple(obj.artist,
                                                         include_aliases))
    if obj.join_phrase != "":
        nc.set_joinphrase(obj.join_phrase)
    return nc


@lru_cache(maxsize=5000)
def convert_artist_credit(obj, include_aliases=True):
    """
    :type obj: :class:`mbdata.models.ArtistCredit`
    """
    ac = models.artist_credit()
    [ac.add_name_credit(convert_name_credit(nc, include_aliases)) for nc in
     obj.artists]
    return ac


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
    if obj.begin_date_year is not None:
        converted_date = partialdate_to_string(obj.begin_date)
        if converted_date != "":
            alias.set_begin_date(converted_date)
    if obj.end_date_year is not None:
        converted_date = partialdate_to_string(obj.end_date)
        if converted_date != "":
            alias.set_end_date(converted_date)
    return alias


def convert_alias_list(obj):
    """
    :type obj: :class:`[mbdata.models.WorkAlias]`
    """
    alias_list = models.alias_list()
    [alias_list.add_alias(convert_alias(a)) for a in obj]
    return alias_list


def convert_coordinates(obj):
    """
    :type obj: :class:`mbdata.types.Point`
    """
    coords = models.coordinates(latitude=str(obj[0]), longitude=str(obj[1]))
    return coords


def convert_tag(obj):
    """
    :type obj: :class:`mbdata.models.ArtistTag`
    """
    tag = models.tag(count=obj.count, name=obj.tag.name)
    return tag


def convert_attribute(obj):
    """
    :type obj: :class:`mbdata.models.LinkAttribute`
    """
    attribute = models.attributeType()
    attribute.value = obj.attribute_type.name
    return attribute


@lru_cache()
def convert_artist_simple(obj, include_aliases=True):
    """
    :type obj: :class:`sir.schema.modelext.CustomArtist`
    """
    artist = models.artist(id=obj.gid, name=obj.name)
    if obj.comment is not None and obj.comment != "":
        artist.set_disambiguation(obj.comment)
    if obj.sort_name is not None:
        artist.set_sort_name(obj.sort_name)
    if include_aliases and len(obj.aliases) > 0:
        artist.set_alias_list(convert_alias_list(obj.aliases))

    return artist


def convert_artist_work_relation(obj):
    """
    :type obj: :class:`mbdata.models.LinkArtistWork`
    """
    relation = models.relation(direction="backward",
                               type_=obj.link.link_type.name)

    artist = convert_artist_simple(obj.artist)
    relation.set_artist(artist)

    if len(obj.link.attributes) > 0:
        attribute_list = models.attribute_listType()
        (attribute_list.add_attribute(convert_attribute(a)) for a in
         obj.link.attributes)
        relation.set_attribute_list(attribute_list)

    return relation


def convert_artist_work_relation_list(obj):
    """
    :type obj: :class:`[mbdata.models.LinkArtistWork]`
    """
    relation_list = models.relation_list(target_type="artist")
    [relation_list.add_relation(convert_artist_work_relation(r)) for r in obj]
    return relation_list


def convert_ipi_list(obj):
    """
    :type obj: :class:`[mbdata.models.ArtistIPI]`
    """
    ipi_list = models.ipi_list()
    [ipi_list.add_ipi(i.ipi) for i in obj]
    return ipi_list


def convert_isrc(obj):
    """
    :type obj: :class:`mbdata.models.ISRC`
    """
    isrc = models.isrc()
    isrc.set_id(obj.isrc)
    return isrc


def convert_isrc_list(obj):
    """
    :type obj: :class:`[mbdata.models.ISRC]`
    """
    isrc_list = models.isrc_list()
    [isrc_list.add_isrc(convert_isrc(i)) for i in obj]
    return isrc_list


def convert_label_info(obj):
    """
    :type obj: :class:`mbdata.models.ReleaseLabel`
    """
    li = models.label_info()
    if obj.catalog_number is not None and obj.catalog_number != "":
        li.set_catalog_number(obj.catalog_number)
    if obj.label is not None:
        label = models.label()
        label.set_id(obj.label.gid)
        label.set_name(obj.label.name)
        li.set_label(label)
    return li


def convert_label_info_list(obj):
    """
    :type obj: :class:`[mbdata.models.ReleaseLabel]`
    """
    lil = models.label_info_list(count=len(obj))
    [lil.add_label_info(convert_label_info(li)) for li in obj]
    return lil


def convert_life_span(begin_date, end_date, ended):
    lifespan = models.life_span()

    if begin_date.year is not None:
        lifespan.set_begin(partialdate_to_string(begin_date))

    if end_date.year is not None:
        lifespan.set_end(partialdate_to_string(end_date))

    if ended:
        lifespan.set_ended("true")
    else:
        lifespan.set_ended("false")

    return lifespan


def convert_medium(obj):
    """
    :type obj: :class:`mbdata.models.Medium`
    """
    m = models.medium()

    if obj.format is not None:
        m.set_format(obj.format.name)

    dl = models.disc_list(count=len(obj.cdtocs))
    m.set_disc_list(dl)

    tl = models.track_listType6(count=obj.track_count)
    m.set_track_list(tl)

    return m


def convert_medium_from_track(obj):
    """
    :type obj: :class:`mbdata.models.Track`
    """
    medium = obj.medium
    m = convert_medium(medium)

    m.set_position(medium.position)

    track = models.def_track_data(id=obj.gid, length=obj.length,
                                  number=obj.number, title=obj.name)

    tl = m.track_list
    tl.set_offset(obj.position - 1)
    tl.add_track(track)

    m.set_track_list(tl)

    return m


def convert_medium_list(obj):
    """
    :type obj: :class:`[mbdata.models.Medium]`
    """
    ml = models.medium_list(count=len(obj))
    [ml.add_medium(convert_medium(m)) for m in obj]

    tracks = 0
    for medium in obj:
        tracks += int(medium.track_count)
    ml.set_track_count(tracks)

    return ml


def convert_medium_list_from_track(obj):
    """
    :type obj: :class:`mbdata.models.Track`
    """
    ml = models.medium_list(count=len(obj.medium.release.mediums))
    ml.add_medium(convert_medium_from_track(obj))

    tracks = 0
    for medium in obj.medium.release.mediums:
        tracks += int(medium.track_count)
    ml.set_track_count(tracks)

    return ml


def convert_place(obj):
    """
    :type obj: :class:`mbdata.models.Place`
    """
    place = models.place(id=obj.gid, name=obj.name)

    if obj.address:
        place.set_address(obj.address)

    if len(obj.aliases) > 0:
        place.set_alias_list(convert_alias_list(obj.aliases))

    if obj.area is not None:
        place.set_area(convert_area_inner(obj.area))

    if obj.comment:
        place.set_disambiguation(obj.comment)

    if obj.coordinates is not None:
        place.set_coordinates(convert_coordinates(obj.coordinates))

    lifespan = convert_life_span(obj.begin_date, obj.end_date, obj.ended)
    place.set_life_span(lifespan)

    if obj.type is not None:
        place.set_type(obj.type.name)

    return place


def convert_release_event(obj):
    """
    :type obj: :class:`mbdata.models.ReleaseCountry`
    """
    re = models.release_event(area=convert_area_for_release_event(obj.country.area),  # noqa
                              date=partialdate_to_string(obj.date))
    return re


def convert_release_event_list(obj):
    """
    :type obj: :class:`[mbdata.models.CountryDates]`
    """
    rel = models.release_event_list(count=len(obj))
    [rel.add_release_event(convert_release_event(re)) for re in obj]
    return rel


def convert_release_from_track(obj):
    """
    :type obj: :class:`mbdata.models.Track`
    """
    medium = obj.medium
    rel = medium.release
    release = models.release(id=rel.gid, title=rel.name)

    # The lucene search server skips this if the release artist credit is the
    # same as the recording artist credit, but we've already built it so just
    # set it
    release.set_artist_credit(convert_artist_credit(rel.artist_credit,
                                                    include_aliases=True))

    if rel.comment is not None and rel.comment != "":
        release.set_disambiguation(rel.comment)

    if len(rel.country_dates) > 0:
        release.set_release_event_list(
            convert_release_event_list(rel.country_dates))
        first_release = release.release_event_list.release_event[0]

        if first_release.date is not None:
            release.set_date(first_release.date)

        if (first_release.area is not None and
            first_release.area.iso_3166_1_code_list is not None and
            len(first_release.area.iso_3166_1_code_list.iso_3166_1_code) > 0):
            release.set_country(
                first_release.area.iso_3166_1_code_list.iso_3166_1_code[0])

    release.set_medium_list(convert_medium_list_from_track(obj))

    release.set_release_group(
        convert_release_group_for_release(rel.release_group))

    if rel.status is not None:
        release.set_status(rel.status.name)

    return release


def convert_release_group_for_release(obj):
    """
    :type obj: :class:`mbdata.models.ReleaseGroup`
    """
    rg = models.release_group(id=obj.gid, title=obj.name)

    if obj.type is not None:
        rg.set_primary_type(obj.type.name)
        rg.set_type(obj.type.name)

    if len(obj.secondary_types) > 0:
        rg.set_secondary_type_list(
            convert_secondary_type_list(obj.secondary_types))

    if obj.comment is not None:
        rg.set_disambiguation(obj.comment)

    return rg


def convert_release_group_simple(obj):
    """
    :type obj: :class:`mbdata.models.ReleaseGroup`
    """
    rg = models.release_group(id=obj.gid, title=obj.name)

    if obj.type is not None:
        rg.set_primary_type(obj.type.name)
        rg.set_type(obj.type.name)

    if len(obj.secondary_types) > 0:
        rg.set_secondary_type_list(
            convert_secondary_type_list(obj.secondary_types))

    rg.set_release_list(convert_release_list_for_release_groups(obj.releases))

    if obj.comment is not None:
        rg.set_disambiguation(obj.comment)

    return rg


def convert_release_list_for_recordings(obj):
    """
    :type obj: :class:`[mbdata.models.Track]`
    """
    release_list = models.release_list()
    [release_list.add_release(convert_release_from_track(t)) for t in obj]
    return release_list


def convert_release_list_for_release_groups(obj):
    """
    :type obj: :class:`[mbdata.models.Release]`
    """
    release_list = models.release_list(count=len(obj))
    for r in obj:
        release = models.release()
        release.set_id(r.gid)
        release.set_title(r.name)
        if r.status is not None:
            release.set_status(r.status.name)

        release_list.add_release(release)
    return release_list


def convert_secondary_type(obj):
    """
    :type obj: :class:`mbdata.models.ReleaseGroupSecondaryTypeJoin`
    """
    return obj.secondary_type.name


def convert_secondary_type_list(obj):
    """
    :type obj: :class:`[mbdata.models.ReleaseGroupSecondaryType]`
    """
    type_list = models.secondary_type_list()
    [type_list.add_secondary_type(convert_secondary_type(t)) for t in obj]


def convert_tag_list(obj):
    """
    :type obj: :class:`[mbdata.models.ArtistTag]`
    """
    tag_list = models.tag_list(count=len(obj))
    [tag_list.add_tag(convert_tag(t)) for t in obj]
    return tag_list


def convert_annotation(obj):
    """
    :type obj: :class:`mbdata.models.Annotation`
    """
    annotation = models.annotation()
    return annotation


def convert_area(obj):
    """
    :type obj: :class:`mbdata.models.Area`
    """
    arealist = models.area_list()
    area = models.def_area_element_inner(id=obj.gid, name=obj.name,
                                         sort_name=obj.name)

    if len(obj.aliases) > 0:
        area.set_alias_list(convert_alias_list(obj.aliases))

    if obj.comment:
        area.set_disambiguation(obj.comment)

    if obj.type is not None:
        area.set_type(obj.type.name)

    lifespan = convert_life_span(obj.begin_date, obj.end_date, obj.ended)
    area.set_life_span(lifespan)

    if len(obj.iso_3166_1_codes):
        area.set_iso_3166_1_code_list(
            convert_iso_3166_1_code_list(obj.iso_3166_1_codes))
    if len(obj.iso_3166_2_codes):
        area.set_iso_3166_2_code_list(
            convert_iso_3166_2_code_list(obj.iso_3166_2_codes))
    if len(obj.iso_3166_3_codes):
        area.set_iso_3166_3_code_list(
            convert_iso_3166_3_code_list(obj.iso_3166_3_codes))
    if len(obj.area_links):
        area.add_relation_list(convert_area_relation_list(obj.area_links))
    # DefAreaElementInner are XMLRootElements, so store each area in a 1-element
    # arealist
    arealist.add_area(area)
    return arealist


def convert_artist(obj):
    """
    :type obj: :class:`sir.schema.modelext.CustomArtist`
    """
    artist = models.artist(id=obj.gid, name=obj.name,
                           sort_name=obj.sort_name)

    if obj.comment is not None:
        artist.set_disambiguation(obj.comment)

    if obj.gender is not None:
        artist.set_gender(obj.gender.name.lower())

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

    lifespan = convert_life_span(obj.begin_date, obj.end_date, obj.ended)
    artist.set_life_span(lifespan)

    if len(obj.aliases) > 0:
        artist.set_alias_list(convert_alias_list(obj.aliases))

    if len(obj.ipis) > 0:
        artist.set_ipi_list(convert_ipi_list(obj.ipis))

    if len(obj.tags) > 0:
        artist.set_tag_list(convert_tag_list(obj.tags))

    return artist


def convert_cdstub(obj):
    """
    :type obj: :class:`sir.schema.modelext.CustomReleaseRaw`
    """
    cdstub = models.cdstub()
    if obj.artist is not None:
        cdstub.set_artist(obj.artist)
    else:
        cdstub.set_artist("")

    cdstub.set_title(obj.title)

    toc = obj.discids[0]
    cdstub.set_id(toc.discid)

    tracklist = models.track_listType()
    tracklist.count = toc.track_count
    cdstub.set_track_list(tracklist)

    if obj.barcode:
        cdstub.set_barcode(obj.barcode)

    if obj.comment:
        cdstub.set_comment(obj.comment)

    return cdstub


def convert_editor(obj):
    """
    :type obj: :class:`mbdata.models.Editor`
    """
    editor = models.editor(id=obj.id, name=obj.name)

    if obj.bio:
        editor.set_bio(obj.bio)

    return editor


def convert_event(obj):
    """
    :type obj: :class:`sir.schema.modelext.CustomEvent`
    """
    event = models.event(id=obj.gid, name=obj.name)

    if obj.comment:
        event.set_disambiguation(obj.comment)

    if obj.type is not None:
        event.set_type(obj.type.name)

    lifespan = convert_life_span(obj.begin_date, obj.end_date, obj.ended)
    if lifespan.get_begin() is not None or lifespan.get_end() is not None:
        event.set_life_span(lifespan)

    if obj.time is not None:
        event.set_time(datetime_to_string(obj.time))

    return event


def convert_instrument(obj):
    """
    :type obj: :class:`sir.schema.modelext.CustomInstrument`
    """
    instrument = models.instrument(id=obj.gid, name=obj.name)

    if obj.comment:
        instrument.set_disambiguation(obj.comment)

    if obj.description:
        instrument.set_description(obj.description)

    if obj.type is not None:
        instrument.set_type(obj.type.name)

    if len(obj.aliases) > 0:
        instrument.set_alias_list(convert_alias_list(obj.aliases))

    return instrument


def convert_label(obj):
    """
    :type obj: :class:`sir.schema.modelext.CustomLabel`
    """
    label = models.label(id=obj.gid, name=obj.name, sort_name=obj.name)

    if obj.type is not None:
        label.set_type(obj.type.name)

    if obj.area is not None:
        label.set_area(convert_area_inner(obj.area))
        if len(obj.area.iso_3166_1_codes) > 0:
            label.set_country(obj.area.iso_3166_1_codes[0].code)

    if obj.label_code > 0:
        label.set_label_code(obj.label_code)

    if len(obj.aliases) > 0:
        label.set_alias_list(
            convert_alias_list(obj.aliases))

    if len(obj.ipis) > 0:
        label.set_ipi_list(convert_ipi_list(obj.ipis))

    lifespan = convert_life_span(obj.begin_date, obj.end_date, obj.ended)
    label.set_life_span(lifespan)

    if len(obj.tags) > 0:
        label.set_tag_list(convert_tag_list(obj.tags))

    return label


def convert_recording(obj):
    """
    :type obj: :class:`sir.schema.modelext.CustomRecording`
    """
    recording = models.recording(id=obj.gid, title=obj.name,
                                 artist_credit=convert_artist_credit(obj.artist_credit))  # noqa

    if obj.comment is not None and obj.comment != "":
        recording.set_disambiguation(obj.comment)

    recording.set_length(obj.length)

    if len(obj.isrcs) > 0:
        recording.set_isrc_list(convert_isrc_list(obj.isrcs))

    if len(obj.tags) > 0:
        recording.set_tag_list(convert_tag_list(obj.tags))

    if len(obj.tracks) > 0:
        recording.set_release_list(
            convert_release_list_for_recordings(obj.tracks))

    if obj.video:
        recording.set_video("true")

    return recording


def convert_release(obj):
    """
    :type obj: :class:`mbdata.models.Release`
    """
    release = models.release(id=obj.gid, title=obj.name,
                             artist_credit=convert_artist_credit(obj.artist_credit))  # noqa

    if obj.barcode is not None:
        if obj.barcode != "":
            release.set_barcode(obj.barcode)
        else:
            release.set_barcode(BARCODE_NONE)
    else:
        release.set_barcode(BARCODE_UNKOWN)

    if obj.comment is not None and obj.comment != "":
        release.set_disambiguation(obj.comment)

    if obj.packaging is not None:
        release.set_packaging(obj.packaging.name)

    if len(obj.country_dates) > 0:
        release.set_release_event_list(
            convert_release_event_list(obj.country_dates))
        first_release = release.release_event_list.release_event[0]

        if first_release.date is not None:
            release.set_date(first_release.date)

        if (first_release.area is not None and
            first_release.area.iso_3166_1_code_list is not None and
            len(first_release.area.iso_3166_1_code_list.iso_3166_1_code) > 0):
            release.set_country(
                first_release.area.iso_3166_1_code_list.iso_3166_1_code[0])

    if len(obj.labels) > 0:
        release.set_label_info_list(convert_label_info_list(obj.labels))

    if len(obj.mediums) > 0:
        release.set_medium_list(convert_medium_list(obj.mediums))

    release.set_release_group(
        convert_release_group_for_release(obj.release_group))

    if obj.status is not None:
        release.set_status(obj.status.name)

    if obj.tags is not None:
        release.set_tag_list(convert_tag_list(obj.tags))

    tr = None
    if obj.language is not None:
        tr = models.text_representation()
        tr.set_language(obj.language.iso_code_3)

    if obj.script is not None:
        if tr is None:
            tr = models.text_representation()
        tr.set_script(obj.script.iso_code)

    if tr is not None:
        release.set_text_representation(tr)

    return release


def convert_release_group(obj):
    """
    :type obj: :class:`sir.schema.modelext.CustomReleaseGroup`
    """
    rg = models.release_group(artist_credit=convert_artist_credit(obj.artist_credit),  # noqa
                              release_list=convert_release_list_for_release_groups(obj.releases),  # noqa
                              id=obj.gid, title=obj.name)
    if obj.comment is not None:
        rg.set_disambiguation(obj.comment)
    if obj.type is not None:
        rg.set_primary_type(obj.type.name)
        rg.set_type(obj.type.name)

    if len(obj.secondary_types) > 0:
        rg.set_secondary_type_list(
            convert_secondary_type_list(obj.secondary_types))

    if len(obj.tags) > 0:
        rg.set_tag_list(convert_tag_list(obj.tags))

    return rg


def convert_series(obj):
    """
    :param obj: :class:`mbdata.models.Series
    """
    series = models.series(id=obj.gid, name=obj.name)

    if obj.comment is not None and obj.comment != "":
        series.set_disambiguation(obj.comment)

    if len(obj.aliases) > 0:
        series.set_alias_list(convert_alias_list(obj.aliases))

    if len(obj.tags) > 0:
        series.set_tag_list(convert_tag_list(obj.tags))

    return series


def convert_standalone_tag(obj):
    """
    Converts a standalone tag - one that does not have a `count` attribute

    :type obj: :class:`mbdata_models.Tag`
    """
    tag = models.tag()
    tag.set_name(obj.name)
    return tag


def convert_url(obj):
    """
    :type obj: :class`mbdata_models.URL`
    """
    url = models.url(id=obj.gid, resource=obj.url)
    # obj does not seem to have any links set, so we can't include any
    # relation lists at this time
    return url


def convert_work(obj):
    """
    :type obj: :class:`sir.schema.modelext.CustomWork`
    """
    work = models.work(id=obj.gid, title=obj.name)
    if len(obj.aliases) > 0:
        work.set_alias_list(convert_alias_list(obj.aliases))
    if len(obj.artist_links) > 0:
        work.add_relation_list(
            convert_artist_work_relation_list(obj.artist_links))
    if obj.language is not None:
        work.set_language(obj.language.iso_code_3)
    return work

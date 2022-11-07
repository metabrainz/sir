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

#: Time format string
TIME_FORMAT = "%H:%M:%S"

#: Fallback order for determining release group type
SECONDARY_TYPE_ORDER = ['Compilation',
                        'Remix',
                        'Soundtrack',
                        'Live',
                        'Spokenword',
                        'Interview']


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


@lru_cache()
def _calculate_type_helper(primary_type, secondary_types):
    """
    :type primary_type: :class:`mbdata.models.ReleaseGroupPrimaryType`
    :type secondary_types: :class:`(mbdata.models.ReleaseGroupSecondaryType)`
    """

    if primary_type.name == 'Album':
        if secondary_types:
            secondary_type_list = dict((obj.secondary_type.name, obj.secondary_type)
                                   for obj in secondary_types)
            # The first type in the ordered secondary type list
            # is returned as the result
            for type_ in SECONDARY_TYPE_ORDER:
                if type_ in secondary_type_list:
                    return secondary_type_list[type_]
    # If primary type is not 'Album' or
    # the secondary type list is empty or does not have
    # values from the predetermined secondary order list
    # return the primary type
    return primary_type


def calculate_type(primary_type, secondary_types):
    """
    :type primary_type: :class:`mbdata.models.ReleaseGroupPrimaryType`
    :type secondary_types: :class:`[mbdata.models.ReleaseGroupSecondaryType]`
    """
    return _calculate_type_helper(primary_type, tuple(secondary_types))


def convert_relation(obj, direction="backward", **kwargs):
    relation = models.relation(direction=direction,
                               type_id=obj.link.link_type.gid,
                               type_=obj.link.link_type.name,
                               **kwargs)

    if len(obj.link.attributes) > 0:
        attribute_list = models.attribute_listType()
        (attribute_list.add_attribute(convert_attribute(a)) for a in
         obj.link.attributes)
        relation.set_attribute_list(attribute_list)

    return relation


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
        area.set_type_id(obj.type.gid)

    lifespan = convert_life_span(obj.begin_date, obj.end_date, obj.ended)
    area.set_life_span(lifespan)

    return area


def convert_area_simple(obj):
    """
    :type obj: :class:`mbdata.models.Area`
    """
    area = models.def_area_element_inner(id=obj.gid, name=obj.name)
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
    relation = convert_relation(obj,
                                target=models.target(valueOf_=obj.area0.gid),
                                area=convert_area_inner(obj.area0))

    return relation


def convert_event_area_relation(obj):
    """
    :type obj: :class:`mbdata.models.LinkAreaEvent`
    """
    relation = convert_relation(obj)
    area = convert_area_simple(obj.area)
    relation.set_area(area)
    return relation


def convert_area_relation_list(obj):
    """
    :type obj: :class:`[mbdata.models.LinkAreaArea]`
    """
    relations = models.relation_list(target_type="area")
    [relations.add_relation(convert_area_relation(a)) for a in obj]
    return relations


def convert_event_area_relation_list(obj):
    """
    :type obj: :class:`[mbdata.models.LinkAreaEvent]`
    """
    relations = models.relation_list(target_type="area")
    [relations.add_relation(convert_event_area_relation(a)) for a in obj]
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
        alias.set_type_id(obj.type.gid)
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
    attribute.set_valueOf_(obj.attribute_type.name)
    attribute.set_type_id(obj.attribute_type.gid)
    return attribute


@lru_cache()
def convert_artist_simple(obj, include_aliases=True):
    """
    :type obj: :class:`sir.schema.modelext.CustomArtist`
    """
    artist = models.artist(id=obj.gid, name=obj.name)
    if obj.comment:
        artist.set_disambiguation(obj.comment)
    if obj.sort_name is not None:
        artist.set_sort_name(obj.sort_name)
    if include_aliases and len(obj.aliases) > 0:
        artist.set_alias_list(convert_alias_list(obj.aliases))

    return artist


def convert_artist_relation(obj):
    """
    :type obj: :class:`mbdata.models.LinkArtistWork` or
               :class:`mbdata.models.LinkArtistEvent`
    """
    relation = convert_relation(obj)
    artist = convert_artist_simple(obj.artist, include_aliases=False)
    relation.set_artist(artist)
    return relation


def convert_artist_relation_list(obj):
    """
    :type obj: :class:`[mbdata.models.LinkArtistWork]` or
               :class:`[mbdata.models.LinkArtistEvent]`
    """
    relation_list = models.relation_list(target_type="artist")
    [relation_list.add_relation(convert_artist_relation(r)) for r in obj]
    return relation_list


def convert_recording_simple(obj):
    """
    :type obj: :class:`sir.schema.modelext.CustomRecording`
    """
    recording = models.recording(id=obj.gid, title=obj.name)
    if obj.video:
        recording.set_video("true")
    return recording


def convert_recording_work_relation(obj):
    """
    :type obj: :class:`mbdata.models.LinkRecordingWork`
    """
    relation = convert_relation(obj)
    recording = convert_recording_simple(obj.recording)
    relation.set_recording(recording)
    return relation


def convert_recording_work_relation_list(obj):
    """
    :type obj: :class:`[mbdata.models.LinkRecordingWork]`
    """
    relation_list = models.relation_list(target_type="recording")
    [relation_list.add_relation(convert_recording_work_relation(r)) for r in obj]
    return relation_list


def convert_ipi_list(obj):
    """
    :type obj: :class:`[mbdata.models.ArtistIPI]` or
               :class:`[mbdata.models.LabelIPI]`
    """
    ipi_list = models.ipi_list()
    [ipi_list.add_ipi(i.ipi) for i in obj]
    return ipi_list


def convert_isni_list(obj):
    """
    :type obj: :class:`[mbdata.models.ArtistISNI]` or
               :class:`[mbdata.models.LabelISNI]`
    """
    isni_list = models.isni_list()
    [isni_list.add_isni(i.isni) for i in obj]
    return isni_list


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


def convert_iswc_list(obj):
    """
    :type obj: :class:`[mbdata.models.ISWC]`
    """
    iswc_list = models.iswc_list()
    iswcs = [i.iswc for i in obj]
    iswc_list.set_iswc(iswcs)
    return iswc_list


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
    lil = models.label_info_list()
    [lil.add_label_info(convert_label_info(li)) for li in obj]
    return lil


def convert_language(obj):
    """
    :type obj: :class:`[mbdata.models.Language]`
    """
    language = models.languageType()
    language.set_valueOf_(obj.iso_code_3)
    return language


def convert_language_list(obj):
    """
    :type obj: :class:`[mbdata.models.WorkLanguage]`
    """
    language_list = models.language_list()
    languages = [convert_language(work_language.language) for work_language in obj]
    language_list.set_language(languages)
    return language_list


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


def convert_medium(obj, disc_list=True):
    """
    :type obj: :class:`mbdata.models.Medium`
    """
    m = models.medium()

    if obj.format is not None:
        m.set_format(convert_format(obj.format))

    if disc_list:
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
    m = convert_medium(medium, disc_list=False)

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
    ml = models.medium_list()
    [ml.add_medium(convert_medium(m)) for m in obj]
    ml.set_count(len(obj))
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
        place.set_type_id(obj.type.gid)

    return place


def convert_place_simple(obj):
    """
    :type obj: :class:`mbdata.models.Place`
    """
    place = models.place(id=obj.gid, name=obj.name)
    return place


def convert_place_relation(obj):
    """
    :type obj: :class:`mbdata.models.LinkEventPlace`
    """
    relation = convert_relation(obj)
    place = convert_place_simple(obj.place)
    relation.set_place(place)
    return relation


def convert_place_relation_list(obj):
    """
    :type obj: :class:`[mbdata.models.LinkEventPlace]`
    """
    relation_list = models.relation_list(target_type="place")
    [relation_list.add_relation(convert_place_relation(p)) for p in obj]
    return relation_list


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
    rel = models.release_event_list()
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
                                                    include_aliases=False))

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
        release.set_status(convert_release_status(rel.status))

    return release


def convert_release_group_for_release(obj):
    """
    :type obj: :class:`mbdata.models.ReleaseGroup`
    """
    rg = models.release_group(id=obj.gid, title=obj.name)

    if obj.type is not None:
        rg.set_primary_type(convert_release_group_primary_type(obj.type))
        type_ = calculate_type(obj.type, obj.secondary_types)
        rg.set_type(type_.name)
        rg.set_type_id(type_.gid)

    if len(obj.secondary_types) > 0:
        rg.set_secondary_type_list(
            convert_secondary_type_list(obj.secondary_types))

    if obj.comment:
        rg.set_disambiguation(obj.comment)

    return rg


def convert_release_group_simple(obj):
    """
    :type obj: :class:`mbdata.models.ReleaseGroup`
    """
    rg = models.release_group(id=obj.gid, title=obj.name)

    if obj.type is not None:
        rg.set_primary_type(convert_release_group_primary_type(obj.type))
        type_ = calculate_type(obj.type, obj.secondary_types)
        rg.set_type(type_.name)
        rg.set_type_id(type_.gid)

    if len(obj.secondary_types) > 0:
        rg.set_secondary_type_list(
            convert_secondary_type_list(obj.secondary_types))

    rg.set_release_list(convert_release_list_for_release_groups(obj.releases))

    if obj.comment:
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
            release.set_status(convert_release_status(r.status))

        release_list.add_release(release)
    return release_list


def convert_secondary_type(obj):
    """
    :type obj: :class:`mbdata.models.ReleaseGroupSecondaryTypeJoin`
    """
    secondary_type = models.secondary_type(valueOf_=obj.secondary_type.name)
    secondary_type.set_id(obj.secondary_type.gid)
    return secondary_type


def convert_secondary_type_list(obj):
    """
    :type obj: :class:`[mbdata.models.ReleaseGroupSecondaryType]`
    """
    type_list = models.secondary_type_list()
    [type_list.add_secondary_type(convert_secondary_type(t)) for t in obj]
    return type_list


def convert_tag_list(obj):
    """
    :type obj: :class:`[mbdata.models.ArtistTag]`
    """
    tag_list = models.tag_list()
    [tag_list.add_tag(convert_tag(t)) for t in obj]
    return tag_list


def convert_one_annotation(obj, type_, entity):
    """
    :type obj: :class:`mbdata.models.Annotation`
    """
    return models.annotation(type_, entity.gid, entity.name, obj.text)


def convert_annotation(obj):
    """
    :type obj: :class:`mbdata.models.Annotation`
    """
    l = []

    for a in obj.areas:
        l.append(convert_one_annotation(obj, 'area',         a.area))
    for a in obj.artists:
        l.append(convert_one_annotation(obj, 'artist',       a.artist))
    for a in obj.events:
        l.append(convert_one_annotation(obj, 'event',        a.event))
    for a in obj.instruments:
        l.append(convert_one_annotation(obj, 'instrument',   a.instrument))
    for a in obj.labels:
        l.append(convert_one_annotation(obj, 'label',        a.label))
    for a in obj.places:
        l.append(convert_one_annotation(obj, 'place',        a.place))
    for a in obj.recordings:
        l.append(convert_one_annotation(obj, 'recording',    a.recording))
    for a in obj.releases:
        l.append(convert_one_annotation(obj, 'release',      a.release))
    for a in obj.release_groups:
        l.append(convert_one_annotation(obj, 'release-group', a.release_group))
    for a in obj.series:
        l.append(convert_one_annotation(obj, 'series',       a.series))
    for a in obj.works:
        l.append(convert_one_annotation(obj, 'work',         a.work))

    # sanity checks - we should have gathered a single annotation object
    if len(l) == 0:
        raise ValueError("no annotations found; is there a new annotatable entity?")
    elif len(l) > 1:
        raise ValueError("found too many annotations (" + len(l) + " > 1)")

    return l[0]


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
        area.set_type_id(obj.type.gid)

    lifespan = convert_life_span(obj.begin_date, obj.end_date, obj.ended)
    area.set_life_span(lifespan)

    if obj.tags:
        area.set_tag_list(convert_tag_list(obj.tags))
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

    if obj.comment:
        artist.set_disambiguation(obj.comment)

    if obj.gender is not None:
        artist.set_gender(convert_gender(obj.gender))

    if obj.type is not None:
        artist.set_type(obj.type.name)
        artist.set_type_id(obj.type.gid)

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

    if len(obj.isnis) > 0:
        artist.set_isni_list(convert_isni_list(obj.isnis))

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

    if obj.barcode is not None:
        cdstub.set_barcode(obj.barcode)

    if obj.comment:
        cdstub.set_disambiguation(obj.comment)

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
        event.set_type_id(obj.type.gid)

    lifespan = convert_life_span(obj.begin_date, obj.end_date, obj.ended)
    if lifespan.get_begin() is not None or lifespan.get_end() is not None:
        event.set_life_span(lifespan)

    if obj.time is not None:
        event.set_time(datetime_to_string(obj.time))

    if obj.area_links:
        event.add_relation_list(convert_event_area_relation_list(obj.area_links))

    if obj.artist_links:
        event.add_relation_list(convert_artist_relation_list(obj.artist_links))

    if obj.place_links:
        event.add_relation_list(convert_place_relation_list(obj.place_links))

    if obj.aliases:
        event.set_alias_list(convert_alias_list(obj.aliases))

    if obj.tags:
        event.set_tag_list(convert_tag_list(obj.tags))

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
        instrument.set_type_id(obj.type.gid)

    if len(obj.aliases) > 0:
        instrument.set_alias_list(convert_alias_list(obj.aliases))

    if len(obj.tags) > 0:
        instrument.set_tag_list(convert_tag_list(obj.tags))

    return instrument


def convert_label(obj):
    """
    :type obj: :class:`sir.schema.modelext.CustomLabel`
    """
    label = models.label(id=obj.gid, name=obj.name, sort_name=obj.name)

    if obj.type is not None:
        label.set_type(obj.type.name)
        label.set_type_id(obj.type.gid)

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

    if len(obj.isnis) > 0:
        label.set_isni_list(convert_isni_list(obj.isnis))

    if obj.comment:
        label.set_disambiguation(obj.comment)

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

    if obj.comment:
        recording.set_disambiguation(obj.comment)

    if obj.first_release_date and len(obj.first_release_date) > 0\
            and obj.first_release_date[0].date:
        recording.set_first_release_date(
            partialdate_to_string(obj.first_release_date[0].date)
        )

    recording.set_length(obj.length)

    if len(obj.isrcs) > 0:
        recording.set_isrc_list(convert_isrc_list(obj.isrcs))

    if len(obj.tags) > 0:
        recording.set_tag_list(convert_tag_list(obj.tags))

    if len(obj.tracks) > 0:
        recording.set_release_list(
            convert_release_list_for_recordings(obj.tracks))
        for release in recording.release_list.release:
            if release.artist_credit == recording.artist_credit:
                release.set_artist_credit(None)

    if obj.video:
        recording.set_video("true")

    return recording


def convert_release(obj):
    """
    :type obj: :class:`mbdata.models.Release`
    """
    release = models.release(id=obj.gid, title=obj.name,
                             artist_credit=convert_artist_credit(obj.artist_credit,
                             include_aliases=False))

    if obj.barcode is not None:
        release.set_barcode(obj.barcode)

    if obj.comment:
        release.set_disambiguation(obj.comment)

    if obj.packaging is not None:
        release.set_packaging(convert_release_packaging(obj.packaging))

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
        release.set_status(convert_release_status(obj.status))

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

    if obj.asin and len(obj.asin) > 0 and obj.asin[0].amazon_asin:
        release.set_asin(obj.asin[0].amazon_asin)

    return release


def convert_release_group(obj):
    """
    :type obj: :class:`sir.schema.modelext.CustomReleaseGroup`
    """
    rg = models.release_group(artist_credit=convert_artist_credit(obj.artist_credit),  # noqa
                              release_list=convert_release_list_for_release_groups(obj.releases),  # noqa
                              id=obj.gid, title=obj.name)
    if obj.comment:
        rg.set_disambiguation(obj.comment)

    if obj.first_release_date and len(obj.first_release_date) > 0\
            and obj.first_release_date[0].first_release_date:
        rg.set_first_release_date(
            partialdate_to_string(obj.first_release_date[0].first_release_date)
        )

    if obj.type is not None:
        rg.set_primary_type(convert_release_group_primary_type(obj.type))
        type_ = calculate_type(obj.type, obj.secondary_types)
        rg.set_type(type_.name)
        rg.set_type_id(type_.gid)

    if len(obj.secondary_types) > 0:
        rg.set_secondary_type_list(
            convert_secondary_type_list(obj.secondary_types))

    if len(obj.tags) > 0:
        rg.set_tag_list(convert_tag_list(obj.tags))

    return rg


def convert_release_relation(obj):
    relation = convert_relation(obj)
    release_obj = obj.release
    release = models.release(id=release_obj.gid, title=release_obj.name)
    if release_obj.comment:
        release.set_disambiguation(release_obj.comment)
    relation.set_release(release)
    return relation


def convert_release_relation_list(obj):
    relation_list = models.relation_list(target_type="release")
    [relation_list.add_relation(convert_release_relation(r)) for r in obj]
    return relation_list


def convert_series(obj):
    """
    :param obj: :class:`mbdata.models.Series
    """
    series = models.series(id=obj.gid, name=obj.name)

    if obj.comment:
        series.set_disambiguation(obj.comment)

    if len(obj.aliases) > 0:
        series.set_alias_list(convert_alias_list(obj.aliases))

    if len(obj.tags) > 0:
        series.set_tag_list(convert_tag_list(obj.tags))

    if obj.type:
        series.set_type(obj.type.name)
        series.set_type_id(obj.type.gid)

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
    if obj.artist_links:
        url.add_relation_list(convert_artist_relation_list(obj.artist_links))
    if obj.release_links:
        url.add_relation_list(convert_release_relation_list(obj.release_links))
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
            convert_artist_relation_list(obj.artist_links))
    if obj.comment:
        work.set_disambiguation(obj.comment)
    if obj.recording_links:
        work.add_relation_list(
            convert_recording_work_relation_list(obj.recording_links))
    if obj.languages:
        work.set_language_list(convert_language_list(obj.languages))
        if len(obj.languages) == 1:
            work.set_language(obj.languages[0].language.iso_code_3)
        elif len(obj.languages) > 1:
            work.set_language('mul')
    if obj.type:
        work.set_type(obj.type.name)
        work.set_type_id(obj.type.gid)
    if obj.iswcs:
        work.set_iswc_list(convert_iswc_list(obj.iswcs))

    return work


def convert_release_group_primary_type(obj):
    """
    :type obj: :class:`mbdata.models.ReleaseGroupPrimaryType`
    """
    return models.primary_type(valueOf_=obj.name, id=obj.gid)


def convert_release_packaging(obj):
    """
    :type obj: :class:`mbdata.models.ReleasePackaging`
    """
    return models.packaging(valueOf_=obj.name, id=obj.gid)


def convert_release_status(obj):
    """
    :type obj: :class:`mbdata.models.ReleaseStatus`
    """
    return models.status(valueOf_=obj.name, id=obj.gid)


def convert_gender(obj):
    """
    :type obj: :class:`mbdata.models.Gender`
    """
    return models.gender(valueOf_=obj.name.lower(), id=obj.gid)


def convert_format(obj):
    return models.format(valueOf_=obj.name)

-- Automatically generated, do not edit!
\set ON_ERROR_STOP 1
BEGIN;

CREATE TRIGGER search_annotation_insert AFTER INSERT ON musicbrainz.annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_insert();

CREATE TRIGGER search_annotation_update AFTER UPDATE OF editor, id, text ON musicbrainz.annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_update();

CREATE TRIGGER search_annotation_delete BEFORE DELETE ON musicbrainz.annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_delete();

CREATE TRIGGER search_area_annotation_insert AFTER INSERT ON musicbrainz.area_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_area_annotation_insert();

CREATE TRIGGER search_area_annotation_update AFTER UPDATE OF annotation, area ON musicbrainz.area_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_area_annotation_update();

CREATE TRIGGER search_area_annotation_delete BEFORE DELETE ON musicbrainz.area_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_area_annotation_delete();

CREATE TRIGGER search_area_insert AFTER INSERT ON musicbrainz.area
    FOR EACH ROW EXECUTE PROCEDURE search_area_insert();

CREATE TRIGGER search_area_update AFTER UPDATE OF begin_date_day, begin_date_month, begin_date_year, comment, end_date_day, end_date_month, end_date_year, ended, gid, name, type ON musicbrainz.area
    FOR EACH ROW EXECUTE PROCEDURE search_area_update();

CREATE TRIGGER search_area_delete BEFORE DELETE ON musicbrainz.area
    FOR EACH ROW EXECUTE PROCEDURE search_area_delete();

CREATE TRIGGER search_artist_annotation_insert AFTER INSERT ON musicbrainz.artist_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_artist_annotation_insert();

CREATE TRIGGER search_artist_annotation_update AFTER UPDATE OF annotation, artist ON musicbrainz.artist_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_artist_annotation_update();

CREATE TRIGGER search_artist_annotation_delete BEFORE DELETE ON musicbrainz.artist_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_artist_annotation_delete();

CREATE TRIGGER search_artist_insert AFTER INSERT ON musicbrainz.artist
    FOR EACH ROW EXECUTE PROCEDURE search_artist_insert();

CREATE TRIGGER search_artist_update AFTER UPDATE OF area, begin_area, begin_date_day, begin_date_month, begin_date_year, comment, end_area, end_date_day, end_date_month, end_date_year, ended, gender, gid, name, sort_name, type ON musicbrainz.artist
    FOR EACH ROW EXECUTE PROCEDURE search_artist_update();

CREATE TRIGGER search_artist_delete BEFORE DELETE ON musicbrainz.artist
    FOR EACH ROW EXECUTE PROCEDURE search_artist_delete();

CREATE TRIGGER search_event_annotation_insert AFTER INSERT ON musicbrainz.event_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_event_annotation_insert();

CREATE TRIGGER search_event_annotation_update AFTER UPDATE OF annotation, event ON musicbrainz.event_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_event_annotation_update();

CREATE TRIGGER search_event_annotation_delete BEFORE DELETE ON musicbrainz.event_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_event_annotation_delete();

CREATE TRIGGER search_event_insert AFTER INSERT ON musicbrainz.event
    FOR EACH ROW EXECUTE PROCEDURE search_event_insert();

CREATE TRIGGER search_event_update AFTER UPDATE OF begin_date_day, begin_date_month, begin_date_year, comment, end_date_day, end_date_month, end_date_year, ended, gid, name, time, type ON musicbrainz.event
    FOR EACH ROW EXECUTE PROCEDURE search_event_update();

CREATE TRIGGER search_event_delete BEFORE DELETE ON musicbrainz.event
    FOR EACH ROW EXECUTE PROCEDURE search_event_delete();

CREATE TRIGGER search_instrument_annotation_insert AFTER INSERT ON musicbrainz.instrument_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_annotation_insert();

CREATE TRIGGER search_instrument_annotation_update AFTER UPDATE OF annotation, instrument ON musicbrainz.instrument_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_annotation_update();

CREATE TRIGGER search_instrument_annotation_delete BEFORE DELETE ON musicbrainz.instrument_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_annotation_delete();

CREATE TRIGGER search_instrument_insert AFTER INSERT ON musicbrainz.instrument
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_insert();

CREATE TRIGGER search_instrument_update AFTER UPDATE OF comment, description, gid, name, type ON musicbrainz.instrument
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_update();

CREATE TRIGGER search_instrument_delete BEFORE DELETE ON musicbrainz.instrument
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_delete();

CREATE TRIGGER search_label_annotation_insert AFTER INSERT ON musicbrainz.label_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_label_annotation_insert();

CREATE TRIGGER search_label_annotation_update AFTER UPDATE OF annotation, label ON musicbrainz.label_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_label_annotation_update();

CREATE TRIGGER search_label_annotation_delete BEFORE DELETE ON musicbrainz.label_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_label_annotation_delete();

CREATE TRIGGER search_label_insert AFTER INSERT ON musicbrainz.label
    FOR EACH ROW EXECUTE PROCEDURE search_label_insert();

CREATE TRIGGER search_label_update AFTER UPDATE OF area, begin_date_day, begin_date_month, begin_date_year, comment, end_date_day, end_date_month, end_date_year, ended, gid, label_code, name, type ON musicbrainz.label
    FOR EACH ROW EXECUTE PROCEDURE search_label_update();

CREATE TRIGGER search_label_delete BEFORE DELETE ON musicbrainz.label
    FOR EACH ROW EXECUTE PROCEDURE search_label_delete();

CREATE TRIGGER search_place_annotation_insert AFTER INSERT ON musicbrainz.place_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_place_annotation_insert();

CREATE TRIGGER search_place_annotation_update AFTER UPDATE OF annotation, place ON musicbrainz.place_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_place_annotation_update();

CREATE TRIGGER search_place_annotation_delete BEFORE DELETE ON musicbrainz.place_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_place_annotation_delete();

CREATE TRIGGER search_place_insert AFTER INSERT ON musicbrainz.place
    FOR EACH ROW EXECUTE PROCEDURE search_place_insert();

CREATE TRIGGER search_place_update AFTER UPDATE OF address, area, begin_date_day, begin_date_month, begin_date_year, comment, coordinates, end_date_day, end_date_month, end_date_year, ended, gid, name, type ON musicbrainz.place
    FOR EACH ROW EXECUTE PROCEDURE search_place_update();

CREATE TRIGGER search_place_delete BEFORE DELETE ON musicbrainz.place
    FOR EACH ROW EXECUTE PROCEDURE search_place_delete();

CREATE TRIGGER search_recording_annotation_insert AFTER INSERT ON musicbrainz.recording_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_recording_annotation_insert();

CREATE TRIGGER search_recording_annotation_update AFTER UPDATE OF annotation, recording ON musicbrainz.recording_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_recording_annotation_update();

CREATE TRIGGER search_recording_annotation_delete BEFORE DELETE ON musicbrainz.recording_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_recording_annotation_delete();

CREATE TRIGGER search_recording_insert AFTER INSERT ON musicbrainz.recording
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert();

CREATE TRIGGER search_recording_update AFTER UPDATE OF artist_credit, comment, gid, length, name, video ON musicbrainz.recording
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update();

CREATE TRIGGER search_recording_delete BEFORE DELETE ON musicbrainz.recording
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete();

CREATE TRIGGER search_release_annotation_insert AFTER INSERT ON musicbrainz.release_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_release_annotation_insert();

CREATE TRIGGER search_release_annotation_update AFTER UPDATE OF annotation, release ON musicbrainz.release_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_release_annotation_update();

CREATE TRIGGER search_release_annotation_delete BEFORE DELETE ON musicbrainz.release_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_release_annotation_delete();

CREATE TRIGGER search_release_insert AFTER INSERT ON musicbrainz.release
    FOR EACH ROW EXECUTE PROCEDURE search_release_insert();

CREATE TRIGGER search_release_update AFTER UPDATE OF artist_credit, barcode, comment, gid, language, name, packaging, quality, release_group, script, status ON musicbrainz.release
    FOR EACH ROW EXECUTE PROCEDURE search_release_update();

CREATE TRIGGER search_release_delete BEFORE DELETE ON musicbrainz.release
    FOR EACH ROW EXECUTE PROCEDURE search_release_delete();

CREATE TRIGGER search_release_group_annotation_insert AFTER INSERT ON musicbrainz.release_group_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_annotation_insert();

CREATE TRIGGER search_release_group_annotation_update AFTER UPDATE OF annotation, release_group ON musicbrainz.release_group_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_annotation_update();

CREATE TRIGGER search_release_group_annotation_delete BEFORE DELETE ON musicbrainz.release_group_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_annotation_delete();

CREATE TRIGGER search_release_group_insert AFTER INSERT ON musicbrainz.release_group
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_insert();

CREATE TRIGGER search_release_group_update AFTER UPDATE OF artist_credit, comment, gid, name, type ON musicbrainz.release_group
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_update();

CREATE TRIGGER search_release_group_delete BEFORE DELETE ON musicbrainz.release_group
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_delete();

CREATE TRIGGER search_series_annotation_insert AFTER INSERT ON musicbrainz.series_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_series_annotation_insert();

CREATE TRIGGER search_series_annotation_update AFTER UPDATE OF annotation, series ON musicbrainz.series_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_series_annotation_update();

CREATE TRIGGER search_series_annotation_delete BEFORE DELETE ON musicbrainz.series_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_series_annotation_delete();

CREATE TRIGGER search_series_insert AFTER INSERT ON musicbrainz.series
    FOR EACH ROW EXECUTE PROCEDURE search_series_insert();

CREATE TRIGGER search_series_update AFTER UPDATE OF comment, gid, name, ordering_attribute, ordering_type, type ON musicbrainz.series
    FOR EACH ROW EXECUTE PROCEDURE search_series_update();

CREATE TRIGGER search_series_delete BEFORE DELETE ON musicbrainz.series
    FOR EACH ROW EXECUTE PROCEDURE search_series_delete();

CREATE TRIGGER search_work_annotation_insert AFTER INSERT ON musicbrainz.work_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_work_annotation_insert();

CREATE TRIGGER search_work_annotation_update AFTER UPDATE OF annotation, work ON musicbrainz.work_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_work_annotation_update();

CREATE TRIGGER search_work_annotation_delete BEFORE DELETE ON musicbrainz.work_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_work_annotation_delete();

CREATE TRIGGER search_work_insert AFTER INSERT ON musicbrainz.work
    FOR EACH ROW EXECUTE PROCEDURE search_work_insert();

CREATE TRIGGER search_work_update AFTER UPDATE OF comment, gid, name, type ON musicbrainz.work
    FOR EACH ROW EXECUTE PROCEDURE search_work_update();

CREATE TRIGGER search_work_delete BEFORE DELETE ON musicbrainz.work
    FOR EACH ROW EXECUTE PROCEDURE search_work_delete();

CREATE TRIGGER search_area_alias_insert AFTER INSERT ON musicbrainz.area_alias
    FOR EACH ROW EXECUTE PROCEDURE search_area_alias_insert();

CREATE TRIGGER search_area_alias_update AFTER UPDATE OF area, begin_date_day, begin_date_month, begin_date_year, end_date_day, end_date_month, end_date_year, locale, name, primary_for_locale, sort_name, type ON musicbrainz.area_alias
    FOR EACH ROW EXECUTE PROCEDURE search_area_alias_update();

CREATE TRIGGER search_area_alias_delete BEFORE DELETE ON musicbrainz.area_alias
    FOR EACH ROW EXECUTE PROCEDURE search_area_alias_delete();

CREATE TRIGGER search_iso_3166_1_insert AFTER INSERT ON musicbrainz.iso_3166_1
    FOR EACH ROW EXECUTE PROCEDURE search_iso_3166_1_insert();

CREATE TRIGGER search_iso_3166_1_update AFTER UPDATE OF area, code ON musicbrainz.iso_3166_1
    FOR EACH ROW EXECUTE PROCEDURE search_iso_3166_1_update();

CREATE TRIGGER search_iso_3166_1_delete BEFORE DELETE ON musicbrainz.iso_3166_1
    FOR EACH ROW EXECUTE PROCEDURE search_iso_3166_1_delete();

CREATE TRIGGER search_iso_3166_2_insert AFTER INSERT ON musicbrainz.iso_3166_2
    FOR EACH ROW EXECUTE PROCEDURE search_iso_3166_2_insert();

CREATE TRIGGER search_iso_3166_2_update AFTER UPDATE OF area, code ON musicbrainz.iso_3166_2
    FOR EACH ROW EXECUTE PROCEDURE search_iso_3166_2_update();

CREATE TRIGGER search_iso_3166_2_delete BEFORE DELETE ON musicbrainz.iso_3166_2
    FOR EACH ROW EXECUTE PROCEDURE search_iso_3166_2_delete();

CREATE TRIGGER search_iso_3166_3_insert AFTER INSERT ON musicbrainz.iso_3166_3
    FOR EACH ROW EXECUTE PROCEDURE search_iso_3166_3_insert();

CREATE TRIGGER search_iso_3166_3_update AFTER UPDATE OF area, code ON musicbrainz.iso_3166_3
    FOR EACH ROW EXECUTE PROCEDURE search_iso_3166_3_update();

CREATE TRIGGER search_iso_3166_3_delete BEFORE DELETE ON musicbrainz.iso_3166_3
    FOR EACH ROW EXECUTE PROCEDURE search_iso_3166_3_delete();

CREATE TRIGGER search_area_tag_insert AFTER INSERT ON musicbrainz.area_tag
    FOR EACH ROW EXECUTE PROCEDURE search_area_tag_insert();

CREATE TRIGGER search_area_tag_update AFTER UPDATE OF area, count, tag ON musicbrainz.area_tag
    FOR EACH ROW EXECUTE PROCEDURE search_area_tag_update();

CREATE TRIGGER search_area_tag_delete BEFORE DELETE ON musicbrainz.area_tag
    FOR EACH ROW EXECUTE PROCEDURE search_area_tag_delete();

CREATE TRIGGER search_tag_insert AFTER INSERT ON musicbrainz.tag
    FOR EACH ROW EXECUTE PROCEDURE search_tag_insert();

CREATE TRIGGER search_tag_update AFTER UPDATE OF id, name ON musicbrainz.tag
    FOR EACH ROW EXECUTE PROCEDURE search_tag_update();

CREATE TRIGGER search_tag_delete BEFORE DELETE ON musicbrainz.tag
    FOR EACH ROW EXECUTE PROCEDURE search_tag_delete();

CREATE TRIGGER search_area_type_insert AFTER INSERT ON musicbrainz.area_type
    FOR EACH ROW EXECUTE PROCEDURE search_area_type_insert();

CREATE TRIGGER search_area_type_update AFTER UPDATE OF gid, id, name ON musicbrainz.area_type
    FOR EACH ROW EXECUTE PROCEDURE search_area_type_update();

CREATE TRIGGER search_area_type_delete BEFORE DELETE ON musicbrainz.area_type
    FOR EACH ROW EXECUTE PROCEDURE search_area_type_delete();

CREATE TRIGGER search_artist_alias_insert AFTER INSERT ON musicbrainz.artist_alias
    FOR EACH ROW EXECUTE PROCEDURE search_artist_alias_insert();

CREATE TRIGGER search_artist_alias_update AFTER UPDATE OF artist, begin_date_day, begin_date_month, begin_date_year, end_date_day, end_date_month, end_date_year, locale, name, primary_for_locale, sort_name, type ON musicbrainz.artist_alias
    FOR EACH ROW EXECUTE PROCEDURE search_artist_alias_update();

CREATE TRIGGER search_artist_alias_delete BEFORE DELETE ON musicbrainz.artist_alias
    FOR EACH ROW EXECUTE PROCEDURE search_artist_alias_delete();

CREATE TRIGGER search_gender_insert AFTER INSERT ON musicbrainz.gender
    FOR EACH ROW EXECUTE PROCEDURE search_gender_insert();

CREATE TRIGGER search_gender_update AFTER UPDATE OF name ON musicbrainz.gender
    FOR EACH ROW EXECUTE PROCEDURE search_gender_update();

CREATE TRIGGER search_gender_delete BEFORE DELETE ON musicbrainz.gender
    FOR EACH ROW EXECUTE PROCEDURE search_gender_delete();

CREATE TRIGGER search_artist_ipi_insert AFTER INSERT ON musicbrainz.artist_ipi
    FOR EACH ROW EXECUTE PROCEDURE search_artist_ipi_insert();

CREATE TRIGGER search_artist_ipi_update AFTER UPDATE OF artist, ipi ON musicbrainz.artist_ipi
    FOR EACH ROW EXECUTE PROCEDURE search_artist_ipi_update();

CREATE TRIGGER search_artist_ipi_delete BEFORE DELETE ON musicbrainz.artist_ipi
    FOR EACH ROW EXECUTE PROCEDURE search_artist_ipi_delete();

CREATE TRIGGER search_artist_isni_insert AFTER INSERT ON musicbrainz.artist_isni
    FOR EACH ROW EXECUTE PROCEDURE search_artist_isni_insert();

CREATE TRIGGER search_artist_isni_update AFTER UPDATE OF artist, isni ON musicbrainz.artist_isni
    FOR EACH ROW EXECUTE PROCEDURE search_artist_isni_update();

CREATE TRIGGER search_artist_isni_delete BEFORE DELETE ON musicbrainz.artist_isni
    FOR EACH ROW EXECUTE PROCEDURE search_artist_isni_delete();

CREATE TRIGGER search_artist_tag_insert AFTER INSERT ON musicbrainz.artist_tag
    FOR EACH ROW EXECUTE PROCEDURE search_artist_tag_insert();

CREATE TRIGGER search_artist_tag_update AFTER UPDATE OF artist, count, tag ON musicbrainz.artist_tag
    FOR EACH ROW EXECUTE PROCEDURE search_artist_tag_update();

CREATE TRIGGER search_artist_tag_delete BEFORE DELETE ON musicbrainz.artist_tag
    FOR EACH ROW EXECUTE PROCEDURE search_artist_tag_delete();

CREATE TRIGGER search_artist_type_insert AFTER INSERT ON musicbrainz.artist_type
    FOR EACH ROW EXECUTE PROCEDURE search_artist_type_insert();

CREATE TRIGGER search_artist_type_update AFTER UPDATE OF gid, name ON musicbrainz.artist_type
    FOR EACH ROW EXECUTE PROCEDURE search_artist_type_update();

CREATE TRIGGER search_artist_type_delete BEFORE DELETE ON musicbrainz.artist_type
    FOR EACH ROW EXECUTE PROCEDURE search_artist_type_delete();

CREATE TRIGGER search_release_raw_insert AFTER INSERT ON musicbrainz.release_raw
    FOR EACH ROW EXECUTE PROCEDURE search_release_raw_insert();

CREATE TRIGGER search_release_raw_update AFTER UPDATE OF added, artist, barcode, comment, id, title ON musicbrainz.release_raw
    FOR EACH ROW EXECUTE PROCEDURE search_release_raw_update();

CREATE TRIGGER search_release_raw_delete BEFORE DELETE ON musicbrainz.release_raw
    FOR EACH ROW EXECUTE PROCEDURE search_release_raw_delete();

CREATE TRIGGER search_cdtoc_raw_insert AFTER INSERT ON musicbrainz.cdtoc_raw
    FOR EACH ROW EXECUTE PROCEDURE search_cdtoc_raw_insert();

CREATE TRIGGER search_cdtoc_raw_update AFTER UPDATE OF discid, release, track_count ON musicbrainz.cdtoc_raw
    FOR EACH ROW EXECUTE PROCEDURE search_cdtoc_raw_update();

CREATE TRIGGER search_cdtoc_raw_delete BEFORE DELETE ON musicbrainz.cdtoc_raw
    FOR EACH ROW EXECUTE PROCEDURE search_cdtoc_raw_delete();

CREATE TRIGGER search_editor_insert AFTER INSERT ON musicbrainz.editor
    FOR EACH ROW EXECUTE PROCEDURE search_editor_insert();

CREATE TRIGGER search_editor_update AFTER UPDATE OF area, bio, gender, id, name ON musicbrainz.editor
    FOR EACH ROW EXECUTE PROCEDURE search_editor_update();

CREATE TRIGGER search_editor_delete BEFORE DELETE ON musicbrainz.editor
    FOR EACH ROW EXECUTE PROCEDURE search_editor_delete();

CREATE TRIGGER search_event_alias_insert AFTER INSERT ON musicbrainz.event_alias
    FOR EACH ROW EXECUTE PROCEDURE search_event_alias_insert();

CREATE TRIGGER search_event_alias_update AFTER UPDATE OF begin_date_day, begin_date_month, begin_date_year, end_date_day, end_date_month, end_date_year, event, locale, name, primary_for_locale, sort_name, type ON musicbrainz.event_alias
    FOR EACH ROW EXECUTE PROCEDURE search_event_alias_update();

CREATE TRIGGER search_event_alias_delete BEFORE DELETE ON musicbrainz.event_alias
    FOR EACH ROW EXECUTE PROCEDURE search_event_alias_delete();

CREATE TRIGGER search_l_area_event_insert AFTER INSERT ON musicbrainz.l_area_event
    FOR EACH ROW EXECUTE PROCEDURE search_l_area_event_insert();

CREATE TRIGGER search_l_area_event_update AFTER UPDATE OF entity0, entity1, link ON musicbrainz.l_area_event
    FOR EACH ROW EXECUTE PROCEDURE search_l_area_event_update();

CREATE TRIGGER search_l_area_event_delete BEFORE DELETE ON musicbrainz.l_area_event
    FOR EACH ROW EXECUTE PROCEDURE search_l_area_event_delete();

CREATE TRIGGER search_l_artist_event_insert AFTER INSERT ON musicbrainz.l_artist_event
    FOR EACH ROW EXECUTE PROCEDURE search_l_artist_event_insert();

CREATE TRIGGER search_l_artist_event_update AFTER UPDATE OF entity0, entity1, link ON musicbrainz.l_artist_event
    FOR EACH ROW EXECUTE PROCEDURE search_l_artist_event_update();

CREATE TRIGGER search_l_artist_event_delete BEFORE DELETE ON musicbrainz.l_artist_event
    FOR EACH ROW EXECUTE PROCEDURE search_l_artist_event_delete();

CREATE TRIGGER search_l_event_place_insert AFTER INSERT ON musicbrainz.l_event_place
    FOR EACH ROW EXECUTE PROCEDURE search_l_event_place_insert();

CREATE TRIGGER search_l_event_place_update AFTER UPDATE OF entity0, entity1, link ON musicbrainz.l_event_place
    FOR EACH ROW EXECUTE PROCEDURE search_l_event_place_update();

CREATE TRIGGER search_l_event_place_delete BEFORE DELETE ON musicbrainz.l_event_place
    FOR EACH ROW EXECUTE PROCEDURE search_l_event_place_delete();

CREATE TRIGGER search_event_tag_insert AFTER INSERT ON musicbrainz.event_tag
    FOR EACH ROW EXECUTE PROCEDURE search_event_tag_insert();

CREATE TRIGGER search_event_tag_update AFTER UPDATE OF count, event, tag ON musicbrainz.event_tag
    FOR EACH ROW EXECUTE PROCEDURE search_event_tag_update();

CREATE TRIGGER search_event_tag_delete BEFORE DELETE ON musicbrainz.event_tag
    FOR EACH ROW EXECUTE PROCEDURE search_event_tag_delete();

CREATE TRIGGER search_event_type_insert AFTER INSERT ON musicbrainz.event_type
    FOR EACH ROW EXECUTE PROCEDURE search_event_type_insert();

CREATE TRIGGER search_event_type_update AFTER UPDATE OF gid, name ON musicbrainz.event_type
    FOR EACH ROW EXECUTE PROCEDURE search_event_type_update();

CREATE TRIGGER search_event_type_delete BEFORE DELETE ON musicbrainz.event_type
    FOR EACH ROW EXECUTE PROCEDURE search_event_type_delete();

CREATE TRIGGER search_instrument_alias_insert AFTER INSERT ON musicbrainz.instrument_alias
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_alias_insert();

CREATE TRIGGER search_instrument_alias_update AFTER UPDATE OF begin_date_day, begin_date_month, begin_date_year, end_date_day, end_date_month, end_date_year, instrument, locale, name, primary_for_locale, sort_name, type ON musicbrainz.instrument_alias
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_alias_update();

CREATE TRIGGER search_instrument_alias_delete BEFORE DELETE ON musicbrainz.instrument_alias
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_alias_delete();

CREATE TRIGGER search_instrument_tag_insert AFTER INSERT ON musicbrainz.instrument_tag
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_tag_insert();

CREATE TRIGGER search_instrument_tag_update AFTER UPDATE OF count, instrument, tag ON musicbrainz.instrument_tag
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_tag_update();

CREATE TRIGGER search_instrument_tag_delete BEFORE DELETE ON musicbrainz.instrument_tag
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_tag_delete();

CREATE TRIGGER search_instrument_type_insert AFTER INSERT ON musicbrainz.instrument_type
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_type_insert();

CREATE TRIGGER search_instrument_type_update AFTER UPDATE OF gid, name ON musicbrainz.instrument_type
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_type_update();

CREATE TRIGGER search_instrument_type_delete BEFORE DELETE ON musicbrainz.instrument_type
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_type_delete();

CREATE TRIGGER search_label_alias_insert AFTER INSERT ON musicbrainz.label_alias
    FOR EACH ROW EXECUTE PROCEDURE search_label_alias_insert();

CREATE TRIGGER search_label_alias_update AFTER UPDATE OF begin_date_day, begin_date_month, begin_date_year, end_date_day, end_date_month, end_date_year, label, locale, name, primary_for_locale, sort_name, type ON musicbrainz.label_alias
    FOR EACH ROW EXECUTE PROCEDURE search_label_alias_update();

CREATE TRIGGER search_label_alias_delete BEFORE DELETE ON musicbrainz.label_alias
    FOR EACH ROW EXECUTE PROCEDURE search_label_alias_delete();

CREATE TRIGGER search_label_ipi_insert AFTER INSERT ON musicbrainz.label_ipi
    FOR EACH ROW EXECUTE PROCEDURE search_label_ipi_insert();

CREATE TRIGGER search_label_ipi_update AFTER UPDATE OF ipi, label ON musicbrainz.label_ipi
    FOR EACH ROW EXECUTE PROCEDURE search_label_ipi_update();

CREATE TRIGGER search_label_ipi_delete BEFORE DELETE ON musicbrainz.label_ipi
    FOR EACH ROW EXECUTE PROCEDURE search_label_ipi_delete();

CREATE TRIGGER search_label_isni_insert AFTER INSERT ON musicbrainz.label_isni
    FOR EACH ROW EXECUTE PROCEDURE search_label_isni_insert();

CREATE TRIGGER search_label_isni_update AFTER UPDATE OF isni, label ON musicbrainz.label_isni
    FOR EACH ROW EXECUTE PROCEDURE search_label_isni_update();

CREATE TRIGGER search_label_isni_delete BEFORE DELETE ON musicbrainz.label_isni
    FOR EACH ROW EXECUTE PROCEDURE search_label_isni_delete();

CREATE TRIGGER search_label_tag_insert AFTER INSERT ON musicbrainz.label_tag
    FOR EACH ROW EXECUTE PROCEDURE search_label_tag_insert();

CREATE TRIGGER search_label_tag_update AFTER UPDATE OF count, label, tag ON musicbrainz.label_tag
    FOR EACH ROW EXECUTE PROCEDURE search_label_tag_update();

CREATE TRIGGER search_label_tag_delete BEFORE DELETE ON musicbrainz.label_tag
    FOR EACH ROW EXECUTE PROCEDURE search_label_tag_delete();

CREATE TRIGGER search_label_type_insert AFTER INSERT ON musicbrainz.label_type
    FOR EACH ROW EXECUTE PROCEDURE search_label_type_insert();

CREATE TRIGGER search_label_type_update AFTER UPDATE OF gid, name ON musicbrainz.label_type
    FOR EACH ROW EXECUTE PROCEDURE search_label_type_update();

CREATE TRIGGER search_label_type_delete BEFORE DELETE ON musicbrainz.label_type
    FOR EACH ROW EXECUTE PROCEDURE search_label_type_delete();

CREATE TRIGGER search_place_alias_insert AFTER INSERT ON musicbrainz.place_alias
    FOR EACH ROW EXECUTE PROCEDURE search_place_alias_insert();

CREATE TRIGGER search_place_alias_update AFTER UPDATE OF begin_date_day, begin_date_month, begin_date_year, end_date_day, end_date_month, end_date_year, locale, name, place, primary_for_locale, sort_name, type ON musicbrainz.place_alias
    FOR EACH ROW EXECUTE PROCEDURE search_place_alias_update();

CREATE TRIGGER search_place_alias_delete BEFORE DELETE ON musicbrainz.place_alias
    FOR EACH ROW EXECUTE PROCEDURE search_place_alias_delete();

CREATE TRIGGER search_place_type_insert AFTER INSERT ON musicbrainz.place_type
    FOR EACH ROW EXECUTE PROCEDURE search_place_type_insert();

CREATE TRIGGER search_place_type_update AFTER UPDATE OF gid, name ON musicbrainz.place_type
    FOR EACH ROW EXECUTE PROCEDURE search_place_type_update();

CREATE TRIGGER search_place_type_delete BEFORE DELETE ON musicbrainz.place_type
    FOR EACH ROW EXECUTE PROCEDURE search_place_type_delete();

CREATE TRIGGER search_recording_alias_insert AFTER INSERT ON musicbrainz.recording_alias
    FOR EACH ROW EXECUTE PROCEDURE search_recording_alias_insert();

CREATE TRIGGER search_recording_alias_update AFTER UPDATE OF name, recording, type ON musicbrainz.recording_alias
    FOR EACH ROW EXECUTE PROCEDURE search_recording_alias_update();

CREATE TRIGGER search_recording_alias_delete BEFORE DELETE ON musicbrainz.recording_alias
    FOR EACH ROW EXECUTE PROCEDURE search_recording_alias_delete();

CREATE TRIGGER search_artist_credit_insert AFTER INSERT ON musicbrainz.artist_credit
    FOR EACH ROW EXECUTE PROCEDURE search_artist_credit_insert();

CREATE TRIGGER search_artist_credit_update AFTER UPDATE OF name ON musicbrainz.artist_credit
    FOR EACH ROW EXECUTE PROCEDURE search_artist_credit_update();

CREATE TRIGGER search_artist_credit_delete BEFORE DELETE ON musicbrainz.artist_credit
    FOR EACH ROW EXECUTE PROCEDURE search_artist_credit_delete();

CREATE TRIGGER search_artist_credit_name_insert AFTER INSERT ON musicbrainz.artist_credit_name
    FOR EACH ROW EXECUTE PROCEDURE search_artist_credit_name_insert();

CREATE TRIGGER search_artist_credit_name_update AFTER UPDATE OF artist, artist_credit, join_phrase, name ON musicbrainz.artist_credit_name
    FOR EACH ROW EXECUTE PROCEDURE search_artist_credit_name_update();

CREATE TRIGGER search_artist_credit_name_delete BEFORE DELETE ON musicbrainz.artist_credit_name
    FOR EACH ROW EXECUTE PROCEDURE search_artist_credit_name_delete();

CREATE TRIGGER search_track_insert AFTER INSERT ON musicbrainz.track
    FOR EACH ROW EXECUTE PROCEDURE search_track_insert();

CREATE TRIGGER search_track_update AFTER UPDATE OF artist_credit, gid, length, medium, name, number, position, recording ON musicbrainz.track
    FOR EACH ROW EXECUTE PROCEDURE search_track_update();

CREATE TRIGGER search_track_delete BEFORE DELETE ON musicbrainz.track
    FOR EACH ROW EXECUTE PROCEDURE search_track_delete();

CREATE TRIGGER search_medium_insert AFTER INSERT ON musicbrainz.medium
    FOR EACH ROW EXECUTE PROCEDURE search_medium_insert();

CREATE TRIGGER search_medium_update AFTER UPDATE OF format, position, release, track_count ON musicbrainz.medium
    FOR EACH ROW EXECUTE PROCEDURE search_medium_update();

CREATE TRIGGER search_medium_delete BEFORE DELETE ON musicbrainz.medium
    FOR EACH ROW EXECUTE PROCEDURE search_medium_delete();

CREATE TRIGGER search_release_country_insert AFTER INSERT ON musicbrainz.release_country
    FOR EACH ROW EXECUTE PROCEDURE search_release_country_insert();

CREATE TRIGGER search_release_country_update AFTER UPDATE OF country, date_day, date_month, date_year, release ON musicbrainz.release_country
    FOR EACH ROW EXECUTE PROCEDURE search_release_country_update();

CREATE TRIGGER search_release_country_delete BEFORE DELETE ON musicbrainz.release_country
    FOR EACH ROW EXECUTE PROCEDURE search_release_country_delete();

CREATE TRIGGER search_country_area_insert AFTER INSERT ON musicbrainz.country_area
    FOR EACH ROW EXECUTE PROCEDURE search_country_area_insert();

CREATE TRIGGER search_country_area_update AFTER UPDATE OF area ON musicbrainz.country_area
    FOR EACH ROW EXECUTE PROCEDURE search_country_area_update();

CREATE TRIGGER search_country_area_delete BEFORE DELETE ON musicbrainz.country_area
    FOR EACH ROW EXECUTE PROCEDURE search_country_area_delete();

CREATE TRIGGER search_medium_format_insert AFTER INSERT ON musicbrainz.medium_format
    FOR EACH ROW EXECUTE PROCEDURE search_medium_format_insert();

CREATE TRIGGER search_medium_format_update AFTER UPDATE OF name ON musicbrainz.medium_format
    FOR EACH ROW EXECUTE PROCEDURE search_medium_format_update();

CREATE TRIGGER search_medium_format_delete BEFORE DELETE ON musicbrainz.medium_format
    FOR EACH ROW EXECUTE PROCEDURE search_medium_format_delete();

CREATE TRIGGER search_isrc_insert AFTER INSERT ON musicbrainz.isrc
    FOR EACH ROW EXECUTE PROCEDURE search_isrc_insert();

CREATE TRIGGER search_isrc_update AFTER UPDATE OF isrc, recording ON musicbrainz.isrc
    FOR EACH ROW EXECUTE PROCEDURE search_isrc_update();

CREATE TRIGGER search_isrc_delete BEFORE DELETE ON musicbrainz.isrc
    FOR EACH ROW EXECUTE PROCEDURE search_isrc_delete();

CREATE TRIGGER search_release_group_primary_type_insert AFTER INSERT ON musicbrainz.release_group_primary_type
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_primary_type_insert();

CREATE TRIGGER search_release_group_primary_type_update AFTER UPDATE OF gid, name ON musicbrainz.release_group_primary_type
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_primary_type_update();

CREATE TRIGGER search_release_group_primary_type_delete BEFORE DELETE ON musicbrainz.release_group_primary_type
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_primary_type_delete();

CREATE TRIGGER search_release_group_secondary_type_join_insert AFTER INSERT ON musicbrainz.release_group_secondary_type_join
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_secondary_type_join_insert();

CREATE TRIGGER search_release_group_secondary_type_join_update AFTER UPDATE OF release_group, secondary_type ON musicbrainz.release_group_secondary_type_join
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_secondary_type_join_update();

CREATE TRIGGER search_release_group_secondary_type_join_delete BEFORE DELETE ON musicbrainz.release_group_secondary_type_join
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_secondary_type_join_delete();

CREATE TRIGGER search_release_group_secondary_type_insert AFTER INSERT ON musicbrainz.release_group_secondary_type
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_secondary_type_insert();

CREATE TRIGGER search_release_group_secondary_type_update AFTER UPDATE OF gid, name ON musicbrainz.release_group_secondary_type
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_secondary_type_update();

CREATE TRIGGER search_release_group_secondary_type_delete BEFORE DELETE ON musicbrainz.release_group_secondary_type
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_secondary_type_delete();

CREATE TRIGGER search_release_status_insert AFTER INSERT ON musicbrainz.release_status
    FOR EACH ROW EXECUTE PROCEDURE search_release_status_insert();

CREATE TRIGGER search_release_status_update AFTER UPDATE OF name ON musicbrainz.release_status
    FOR EACH ROW EXECUTE PROCEDURE search_release_status_update();

CREATE TRIGGER search_release_status_delete BEFORE DELETE ON musicbrainz.release_status
    FOR EACH ROW EXECUTE PROCEDURE search_release_status_delete();

CREATE TRIGGER search_recording_tag_insert AFTER INSERT ON musicbrainz.recording_tag
    FOR EACH ROW EXECUTE PROCEDURE search_recording_tag_insert();

CREATE TRIGGER search_recording_tag_update AFTER UPDATE OF count, recording, tag ON musicbrainz.recording_tag
    FOR EACH ROW EXECUTE PROCEDURE search_recording_tag_update();

CREATE TRIGGER search_recording_tag_delete BEFORE DELETE ON musicbrainz.recording_tag
    FOR EACH ROW EXECUTE PROCEDURE search_recording_tag_delete();

CREATE TRIGGER search_release_alias_insert AFTER INSERT ON musicbrainz.release_alias
    FOR EACH ROW EXECUTE PROCEDURE search_release_alias_insert();

CREATE TRIGGER search_release_alias_update AFTER UPDATE OF name, release, type ON musicbrainz.release_alias
    FOR EACH ROW EXECUTE PROCEDURE search_release_alias_update();

CREATE TRIGGER search_release_alias_delete BEFORE DELETE ON musicbrainz.release_alias
    FOR EACH ROW EXECUTE PROCEDURE search_release_alias_delete();

CREATE TRIGGER search_release_meta_insert AFTER INSERT ON musicbrainz.release_meta
    FOR EACH ROW EXECUTE PROCEDURE search_release_meta_insert();

CREATE TRIGGER search_release_meta_update AFTER UPDATE OF amazon_asin, id ON musicbrainz.release_meta
    FOR EACH ROW EXECUTE PROCEDURE search_release_meta_update();

CREATE TRIGGER search_release_meta_delete BEFORE DELETE ON musicbrainz.release_meta
    FOR EACH ROW EXECUTE PROCEDURE search_release_meta_delete();

CREATE TRIGGER search_release_label_insert AFTER INSERT ON musicbrainz.release_label
    FOR EACH ROW EXECUTE PROCEDURE search_release_label_insert();

CREATE TRIGGER search_release_label_update AFTER UPDATE OF catalog_number, label, release ON musicbrainz.release_label
    FOR EACH ROW EXECUTE PROCEDURE search_release_label_update();

CREATE TRIGGER search_release_label_delete BEFORE DELETE ON musicbrainz.release_label
    FOR EACH ROW EXECUTE PROCEDURE search_release_label_delete();

CREATE TRIGGER search_language_insert AFTER INSERT ON musicbrainz.language
    FOR EACH ROW EXECUTE PROCEDURE search_language_insert();

CREATE TRIGGER search_language_update AFTER UPDATE OF iso_code_3 ON musicbrainz.language
    FOR EACH ROW EXECUTE PROCEDURE search_language_update();

CREATE TRIGGER search_language_delete BEFORE DELETE ON musicbrainz.language
    FOR EACH ROW EXECUTE PROCEDURE search_language_delete();

CREATE TRIGGER search_script_insert AFTER INSERT ON musicbrainz.script
    FOR EACH ROW EXECUTE PROCEDURE search_script_insert();

CREATE TRIGGER search_script_update AFTER UPDATE OF iso_code ON musicbrainz.script
    FOR EACH ROW EXECUTE PROCEDURE search_script_update();

CREATE TRIGGER search_script_delete BEFORE DELETE ON musicbrainz.script
    FOR EACH ROW EXECUTE PROCEDURE search_script_delete();

CREATE TRIGGER search_release_tag_insert AFTER INSERT ON musicbrainz.release_tag
    FOR EACH ROW EXECUTE PROCEDURE search_release_tag_insert();

CREATE TRIGGER search_release_tag_update AFTER UPDATE OF count, release, tag ON musicbrainz.release_tag
    FOR EACH ROW EXECUTE PROCEDURE search_release_tag_update();

CREATE TRIGGER search_release_tag_delete BEFORE DELETE ON musicbrainz.release_tag
    FOR EACH ROW EXECUTE PROCEDURE search_release_tag_delete();

CREATE TRIGGER search_release_group_alias_insert AFTER INSERT ON musicbrainz.release_group_alias
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_alias_insert();

CREATE TRIGGER search_release_group_alias_update AFTER UPDATE OF name, release_group, type ON musicbrainz.release_group_alias
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_alias_update();

CREATE TRIGGER search_release_group_alias_delete BEFORE DELETE ON musicbrainz.release_group_alias
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_alias_delete();

CREATE TRIGGER search_release_group_tag_insert AFTER INSERT ON musicbrainz.release_group_tag
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_tag_insert();

CREATE TRIGGER search_release_group_tag_update AFTER UPDATE OF count, release_group, tag ON musicbrainz.release_group_tag
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_tag_update();

CREATE TRIGGER search_release_group_tag_delete BEFORE DELETE ON musicbrainz.release_group_tag
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_tag_delete();

CREATE TRIGGER search_series_alias_insert AFTER INSERT ON musicbrainz.series_alias
    FOR EACH ROW EXECUTE PROCEDURE search_series_alias_insert();

CREATE TRIGGER search_series_alias_update AFTER UPDATE OF begin_date_day, begin_date_month, begin_date_year, end_date_day, end_date_month, end_date_year, locale, name, primary_for_locale, series, sort_name, type ON musicbrainz.series_alias
    FOR EACH ROW EXECUTE PROCEDURE search_series_alias_update();

CREATE TRIGGER search_series_alias_delete BEFORE DELETE ON musicbrainz.series_alias
    FOR EACH ROW EXECUTE PROCEDURE search_series_alias_delete();

CREATE TRIGGER search_link_attribute_type_insert AFTER INSERT ON musicbrainz.link_attribute_type
    FOR EACH ROW EXECUTE PROCEDURE search_link_attribute_type_insert();

CREATE TRIGGER search_link_attribute_type_update AFTER UPDATE OF gid, name ON musicbrainz.link_attribute_type
    FOR EACH ROW EXECUTE PROCEDURE search_link_attribute_type_update();

CREATE TRIGGER search_link_attribute_type_delete BEFORE DELETE ON musicbrainz.link_attribute_type
    FOR EACH ROW EXECUTE PROCEDURE search_link_attribute_type_delete();

CREATE TRIGGER search_series_tag_insert AFTER INSERT ON musicbrainz.series_tag
    FOR EACH ROW EXECUTE PROCEDURE search_series_tag_insert();

CREATE TRIGGER search_series_tag_update AFTER UPDATE OF count, series, tag ON musicbrainz.series_tag
    FOR EACH ROW EXECUTE PROCEDURE search_series_tag_update();

CREATE TRIGGER search_series_tag_delete BEFORE DELETE ON musicbrainz.series_tag
    FOR EACH ROW EXECUTE PROCEDURE search_series_tag_delete();

CREATE TRIGGER search_series_type_insert AFTER INSERT ON musicbrainz.series_type
    FOR EACH ROW EXECUTE PROCEDURE search_series_type_insert();

CREATE TRIGGER search_series_type_update AFTER UPDATE OF gid, name ON musicbrainz.series_type
    FOR EACH ROW EXECUTE PROCEDURE search_series_type_update();

CREATE TRIGGER search_series_type_delete BEFORE DELETE ON musicbrainz.series_type
    FOR EACH ROW EXECUTE PROCEDURE search_series_type_delete();

CREATE TRIGGER search_url_insert AFTER INSERT ON musicbrainz.url
    FOR EACH ROW EXECUTE PROCEDURE search_url_insert();

CREATE TRIGGER search_url_update AFTER UPDATE OF gid, url ON musicbrainz.url
    FOR EACH ROW EXECUTE PROCEDURE search_url_update();

CREATE TRIGGER search_url_delete BEFORE DELETE ON musicbrainz.url
    FOR EACH ROW EXECUTE PROCEDURE search_url_delete();

CREATE TRIGGER search_l_artist_url_insert AFTER INSERT ON musicbrainz.l_artist_url
    FOR EACH ROW EXECUTE PROCEDURE search_l_artist_url_insert();

CREATE TRIGGER search_l_artist_url_update AFTER UPDATE OF entity0, entity1, link ON musicbrainz.l_artist_url
    FOR EACH ROW EXECUTE PROCEDURE search_l_artist_url_update();

CREATE TRIGGER search_l_artist_url_delete BEFORE DELETE ON musicbrainz.l_artist_url
    FOR EACH ROW EXECUTE PROCEDURE search_l_artist_url_delete();

CREATE TRIGGER search_link_insert AFTER INSERT ON musicbrainz.link
    FOR EACH ROW EXECUTE PROCEDURE search_link_insert();

CREATE TRIGGER search_link_update AFTER UPDATE OF link_type ON musicbrainz.link
    FOR EACH ROW EXECUTE PROCEDURE search_link_update();

CREATE TRIGGER search_link_delete BEFORE DELETE ON musicbrainz.link
    FOR EACH ROW EXECUTE PROCEDURE search_link_delete();

CREATE TRIGGER search_link_type_insert AFTER INSERT ON musicbrainz.link_type
    FOR EACH ROW EXECUTE PROCEDURE search_link_type_insert();

CREATE TRIGGER search_link_type_update AFTER UPDATE OF gid, name ON musicbrainz.link_type
    FOR EACH ROW EXECUTE PROCEDURE search_link_type_update();

CREATE TRIGGER search_link_type_delete BEFORE DELETE ON musicbrainz.link_type
    FOR EACH ROW EXECUTE PROCEDURE search_link_type_delete();

CREATE TRIGGER search_l_release_url_insert AFTER INSERT ON musicbrainz.l_release_url
    FOR EACH ROW EXECUTE PROCEDURE search_l_release_url_insert();

CREATE TRIGGER search_l_release_url_update AFTER UPDATE OF entity0, entity1, link ON musicbrainz.l_release_url
    FOR EACH ROW EXECUTE PROCEDURE search_l_release_url_update();

CREATE TRIGGER search_l_release_url_delete BEFORE DELETE ON musicbrainz.l_release_url
    FOR EACH ROW EXECUTE PROCEDURE search_l_release_url_delete();

CREATE TRIGGER search_work_alias_insert AFTER INSERT ON musicbrainz.work_alias
    FOR EACH ROW EXECUTE PROCEDURE search_work_alias_insert();

CREATE TRIGGER search_work_alias_update AFTER UPDATE OF begin_date_day, begin_date_month, begin_date_year, end_date_day, end_date_month, end_date_year, locale, name, primary_for_locale, sort_name, type, work ON musicbrainz.work_alias
    FOR EACH ROW EXECUTE PROCEDURE search_work_alias_update();

CREATE TRIGGER search_work_alias_delete BEFORE DELETE ON musicbrainz.work_alias
    FOR EACH ROW EXECUTE PROCEDURE search_work_alias_delete();

CREATE TRIGGER search_l_artist_work_insert AFTER INSERT ON musicbrainz.l_artist_work
    FOR EACH ROW EXECUTE PROCEDURE search_l_artist_work_insert();

CREATE TRIGGER search_l_artist_work_update AFTER UPDATE OF entity0, entity1, link ON musicbrainz.l_artist_work
    FOR EACH ROW EXECUTE PROCEDURE search_l_artist_work_update();

CREATE TRIGGER search_l_artist_work_delete BEFORE DELETE ON musicbrainz.l_artist_work
    FOR EACH ROW EXECUTE PROCEDURE search_l_artist_work_delete();

CREATE TRIGGER search_iswc_insert AFTER INSERT ON musicbrainz.iswc
    FOR EACH ROW EXECUTE PROCEDURE search_iswc_insert();

CREATE TRIGGER search_iswc_update AFTER UPDATE OF iswc, work ON musicbrainz.iswc
    FOR EACH ROW EXECUTE PROCEDURE search_iswc_update();

CREATE TRIGGER search_iswc_delete BEFORE DELETE ON musicbrainz.iswc
    FOR EACH ROW EXECUTE PROCEDURE search_iswc_delete();

CREATE TRIGGER search_work_language_insert AFTER INSERT ON musicbrainz.work_language
    FOR EACH ROW EXECUTE PROCEDURE search_work_language_insert();

CREATE TRIGGER search_work_language_update AFTER UPDATE OF language, work ON musicbrainz.work_language
    FOR EACH ROW EXECUTE PROCEDURE search_work_language_update();

CREATE TRIGGER search_work_language_delete BEFORE DELETE ON musicbrainz.work_language
    FOR EACH ROW EXECUTE PROCEDURE search_work_language_delete();

CREATE TRIGGER search_l_recording_work_insert AFTER INSERT ON musicbrainz.l_recording_work
    FOR EACH ROW EXECUTE PROCEDURE search_l_recording_work_insert();

CREATE TRIGGER search_l_recording_work_update AFTER UPDATE OF entity0, entity1, link ON musicbrainz.l_recording_work
    FOR EACH ROW EXECUTE PROCEDURE search_l_recording_work_update();

CREATE TRIGGER search_l_recording_work_delete BEFORE DELETE ON musicbrainz.l_recording_work
    FOR EACH ROW EXECUTE PROCEDURE search_l_recording_work_delete();

CREATE TRIGGER search_work_tag_insert AFTER INSERT ON musicbrainz.work_tag
    FOR EACH ROW EXECUTE PROCEDURE search_work_tag_insert();

CREATE TRIGGER search_work_tag_update AFTER UPDATE OF count, tag, work ON musicbrainz.work_tag
    FOR EACH ROW EXECUTE PROCEDURE search_work_tag_update();

CREATE TRIGGER search_work_tag_delete BEFORE DELETE ON musicbrainz.work_tag
    FOR EACH ROW EXECUTE PROCEDURE search_work_tag_delete();

CREATE TRIGGER search_work_type_insert AFTER INSERT ON musicbrainz.work_type
    FOR EACH ROW EXECUTE PROCEDURE search_work_type_insert();

CREATE TRIGGER search_work_type_update AFTER UPDATE OF gid, name ON musicbrainz.work_type
    FOR EACH ROW EXECUTE PROCEDURE search_work_type_update();

CREATE TRIGGER search_work_type_delete BEFORE DELETE ON musicbrainz.work_type
    FOR EACH ROW EXECUTE PROCEDURE search_work_type_delete();

COMMIT;

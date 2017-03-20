-- Automatically generated, do not edit
\set ON_ERROR_STOP 1
BEGIN;

CREATE TRIGGER search_annotation_insert AFTER INSERT ON annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_insert();

CREATE TRIGGER search_annotation_update AFTER UPDATE ON annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_update();

CREATE TRIGGER search_annotation_delete BEFORE DELETE ON annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_delete();

CREATE TRIGGER search_area_annotation_insert AFTER INSERT ON area_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_area_annotation_insert();

CREATE TRIGGER search_area_annotation_update AFTER UPDATE ON area_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_area_annotation_update();

CREATE TRIGGER search_area_annotation_delete BEFORE DELETE ON area_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_area_annotation_delete();

CREATE TRIGGER search_area_insert AFTER INSERT ON area
    FOR EACH ROW EXECUTE PROCEDURE search_area_insert();

CREATE TRIGGER search_area_update AFTER UPDATE ON area
    FOR EACH ROW EXECUTE PROCEDURE search_area_update();

CREATE TRIGGER search_area_delete BEFORE DELETE ON area
    FOR EACH ROW EXECUTE PROCEDURE search_area_delete();

CREATE TRIGGER search_artist_annotation_insert AFTER INSERT ON artist_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_artist_annotation_insert();

CREATE TRIGGER search_artist_annotation_update AFTER UPDATE ON artist_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_artist_annotation_update();

CREATE TRIGGER search_artist_annotation_delete BEFORE DELETE ON artist_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_artist_annotation_delete();

CREATE TRIGGER search_artist_insert AFTER INSERT ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_artist_insert();

CREATE TRIGGER search_artist_update AFTER UPDATE ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_artist_update();

CREATE TRIGGER search_artist_delete BEFORE DELETE ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_artist_delete();

CREATE TRIGGER search_event_annotation_insert AFTER INSERT ON event_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_event_annotation_insert();

CREATE TRIGGER search_event_annotation_update AFTER UPDATE ON event_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_event_annotation_update();

CREATE TRIGGER search_event_annotation_delete BEFORE DELETE ON event_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_event_annotation_delete();

CREATE TRIGGER search_event_insert AFTER INSERT ON event
    FOR EACH ROW EXECUTE PROCEDURE search_event_insert();

CREATE TRIGGER search_event_update AFTER UPDATE ON event
    FOR EACH ROW EXECUTE PROCEDURE search_event_update();

CREATE TRIGGER search_event_delete BEFORE DELETE ON event
    FOR EACH ROW EXECUTE PROCEDURE search_event_delete();

CREATE TRIGGER search_instrument_annotation_insert AFTER INSERT ON instrument_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_annotation_insert();

CREATE TRIGGER search_instrument_annotation_update AFTER UPDATE ON instrument_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_annotation_update();

CREATE TRIGGER search_instrument_annotation_delete BEFORE DELETE ON instrument_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_annotation_delete();

CREATE TRIGGER search_instrument_insert AFTER INSERT ON instrument
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_insert();

CREATE TRIGGER search_instrument_update AFTER UPDATE ON instrument
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_update();

CREATE TRIGGER search_instrument_delete BEFORE DELETE ON instrument
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_delete();

CREATE TRIGGER search_label_annotation_insert AFTER INSERT ON label_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_label_annotation_insert();

CREATE TRIGGER search_label_annotation_update AFTER UPDATE ON label_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_label_annotation_update();

CREATE TRIGGER search_label_annotation_delete BEFORE DELETE ON label_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_label_annotation_delete();

CREATE TRIGGER search_label_insert AFTER INSERT ON label
    FOR EACH ROW EXECUTE PROCEDURE search_label_insert();

CREATE TRIGGER search_label_update AFTER UPDATE ON label
    FOR EACH ROW EXECUTE PROCEDURE search_label_update();

CREATE TRIGGER search_label_delete BEFORE DELETE ON label
    FOR EACH ROW EXECUTE PROCEDURE search_label_delete();

CREATE TRIGGER search_place_annotation_insert AFTER INSERT ON place_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_place_annotation_insert();

CREATE TRIGGER search_place_annotation_update AFTER UPDATE ON place_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_place_annotation_update();

CREATE TRIGGER search_place_annotation_delete BEFORE DELETE ON place_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_place_annotation_delete();

CREATE TRIGGER search_place_insert AFTER INSERT ON place
    FOR EACH ROW EXECUTE PROCEDURE search_place_insert();

CREATE TRIGGER search_place_update AFTER UPDATE ON place
    FOR EACH ROW EXECUTE PROCEDURE search_place_update();

CREATE TRIGGER search_place_delete BEFORE DELETE ON place
    FOR EACH ROW EXECUTE PROCEDURE search_place_delete();

CREATE TRIGGER search_recording_annotation_insert AFTER INSERT ON recording_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_recording_annotation_insert();

CREATE TRIGGER search_recording_annotation_update AFTER UPDATE ON recording_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_recording_annotation_update();

CREATE TRIGGER search_recording_annotation_delete BEFORE DELETE ON recording_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_recording_annotation_delete();

CREATE TRIGGER search_recording_insert AFTER INSERT ON recording
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert();

CREATE TRIGGER search_recording_update AFTER UPDATE ON recording
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update();

CREATE TRIGGER search_recording_delete BEFORE DELETE ON recording
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete();

CREATE TRIGGER search_release_annotation_insert AFTER INSERT ON release_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_release_annotation_insert();

CREATE TRIGGER search_release_annotation_update AFTER UPDATE ON release_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_release_annotation_update();

CREATE TRIGGER search_release_annotation_delete BEFORE DELETE ON release_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_release_annotation_delete();

CREATE TRIGGER search_release_insert AFTER INSERT ON release
    FOR EACH ROW EXECUTE PROCEDURE search_release_insert();

CREATE TRIGGER search_release_update AFTER UPDATE ON release
    FOR EACH ROW EXECUTE PROCEDURE search_release_update();

CREATE TRIGGER search_release_delete BEFORE DELETE ON release
    FOR EACH ROW EXECUTE PROCEDURE search_release_delete();

CREATE TRIGGER search_release_group_annotation_insert AFTER INSERT ON release_group_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_annotation_insert();

CREATE TRIGGER search_release_group_annotation_update AFTER UPDATE ON release_group_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_annotation_update();

CREATE TRIGGER search_release_group_annotation_delete BEFORE DELETE ON release_group_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_annotation_delete();

CREATE TRIGGER search_release_group_insert AFTER INSERT ON release_group
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_insert();

CREATE TRIGGER search_release_group_update AFTER UPDATE ON release_group
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_update();

CREATE TRIGGER search_release_group_delete BEFORE DELETE ON release_group
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_delete();

CREATE TRIGGER search_series_annotation_insert AFTER INSERT ON series_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_series_annotation_insert();

CREATE TRIGGER search_series_annotation_update AFTER UPDATE ON series_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_series_annotation_update();

CREATE TRIGGER search_series_annotation_delete BEFORE DELETE ON series_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_series_annotation_delete();

CREATE TRIGGER search_series_insert AFTER INSERT ON series
    FOR EACH ROW EXECUTE PROCEDURE search_series_insert();

CREATE TRIGGER search_series_update AFTER UPDATE ON series
    FOR EACH ROW EXECUTE PROCEDURE search_series_update();

CREATE TRIGGER search_series_delete BEFORE DELETE ON series
    FOR EACH ROW EXECUTE PROCEDURE search_series_delete();

CREATE TRIGGER search_work_annotation_insert AFTER INSERT ON work_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_work_annotation_insert();

CREATE TRIGGER search_work_annotation_update AFTER UPDATE ON work_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_work_annotation_update();

CREATE TRIGGER search_work_annotation_delete BEFORE DELETE ON work_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_work_annotation_delete();

CREATE TRIGGER search_work_insert AFTER INSERT ON work
    FOR EACH ROW EXECUTE PROCEDURE search_work_insert();

CREATE TRIGGER search_work_update AFTER UPDATE ON work
    FOR EACH ROW EXECUTE PROCEDURE search_work_update();

CREATE TRIGGER search_work_delete BEFORE DELETE ON work
    FOR EACH ROW EXECUTE PROCEDURE search_work_delete();

CREATE TRIGGER search_area_alias_insert AFTER INSERT ON area_alias
    FOR EACH ROW EXECUTE PROCEDURE search_area_alias_insert();

CREATE TRIGGER search_area_alias_update AFTER UPDATE ON area_alias
    FOR EACH ROW EXECUTE PROCEDURE search_area_alias_update();

CREATE TRIGGER search_area_alias_delete BEFORE DELETE ON area_alias
    FOR EACH ROW EXECUTE PROCEDURE search_area_alias_delete();

CREATE TRIGGER search_iso_3166_1_insert AFTER INSERT ON iso_3166_1
    FOR EACH ROW EXECUTE PROCEDURE search_iso_3166_1_insert();

CREATE TRIGGER search_iso_3166_1_update AFTER UPDATE ON iso_3166_1
    FOR EACH ROW EXECUTE PROCEDURE search_iso_3166_1_update();

CREATE TRIGGER search_iso_3166_1_delete BEFORE DELETE ON iso_3166_1
    FOR EACH ROW EXECUTE PROCEDURE search_iso_3166_1_delete();

CREATE TRIGGER search_iso_3166_2_insert AFTER INSERT ON iso_3166_2
    FOR EACH ROW EXECUTE PROCEDURE search_iso_3166_2_insert();

CREATE TRIGGER search_iso_3166_2_update AFTER UPDATE ON iso_3166_2
    FOR EACH ROW EXECUTE PROCEDURE search_iso_3166_2_update();

CREATE TRIGGER search_iso_3166_2_delete BEFORE DELETE ON iso_3166_2
    FOR EACH ROW EXECUTE PROCEDURE search_iso_3166_2_delete();

CREATE TRIGGER search_iso_3166_3_insert AFTER INSERT ON iso_3166_3
    FOR EACH ROW EXECUTE PROCEDURE search_iso_3166_3_insert();

CREATE TRIGGER search_iso_3166_3_update AFTER UPDATE ON iso_3166_3
    FOR EACH ROW EXECUTE PROCEDURE search_iso_3166_3_update();

CREATE TRIGGER search_iso_3166_3_delete BEFORE DELETE ON iso_3166_3
    FOR EACH ROW EXECUTE PROCEDURE search_iso_3166_3_delete();

CREATE TRIGGER search_area_type_insert AFTER INSERT ON area_type
    FOR EACH ROW EXECUTE PROCEDURE search_area_type_insert();

CREATE TRIGGER search_area_type_update AFTER UPDATE ON area_type
    FOR EACH ROW EXECUTE PROCEDURE search_area_type_update();

CREATE TRIGGER search_area_type_delete BEFORE DELETE ON area_type
    FOR EACH ROW EXECUTE PROCEDURE search_area_type_delete();

CREATE TRIGGER search_artist_alias_insert AFTER INSERT ON artist_alias
    FOR EACH ROW EXECUTE PROCEDURE search_artist_alias_insert();

CREATE TRIGGER search_artist_alias_update AFTER UPDATE ON artist_alias
    FOR EACH ROW EXECUTE PROCEDURE search_artist_alias_update();

CREATE TRIGGER search_artist_alias_delete BEFORE DELETE ON artist_alias
    FOR EACH ROW EXECUTE PROCEDURE search_artist_alias_delete();

CREATE TRIGGER search_gender_insert AFTER INSERT ON gender
    FOR EACH ROW EXECUTE PROCEDURE search_gender_insert();

CREATE TRIGGER search_gender_update AFTER UPDATE ON gender
    FOR EACH ROW EXECUTE PROCEDURE search_gender_update();

CREATE TRIGGER search_gender_delete BEFORE DELETE ON gender
    FOR EACH ROW EXECUTE PROCEDURE search_gender_delete();

CREATE TRIGGER search_artist_ipi_insert AFTER INSERT ON artist_ipi
    FOR EACH ROW EXECUTE PROCEDURE search_artist_ipi_insert();

CREATE TRIGGER search_artist_ipi_update AFTER UPDATE ON artist_ipi
    FOR EACH ROW EXECUTE PROCEDURE search_artist_ipi_update();

CREATE TRIGGER search_artist_ipi_delete BEFORE DELETE ON artist_ipi
    FOR EACH ROW EXECUTE PROCEDURE search_artist_ipi_delete();

CREATE TRIGGER search_artist_isni_insert AFTER INSERT ON artist_isni
    FOR EACH ROW EXECUTE PROCEDURE search_artist_isni_insert();

CREATE TRIGGER search_artist_isni_update AFTER UPDATE ON artist_isni
    FOR EACH ROW EXECUTE PROCEDURE search_artist_isni_update();

CREATE TRIGGER search_artist_isni_delete BEFORE DELETE ON artist_isni
    FOR EACH ROW EXECUTE PROCEDURE search_artist_isni_delete();

CREATE TRIGGER search_artist_tag_insert AFTER INSERT ON artist_tag
    FOR EACH ROW EXECUTE PROCEDURE search_artist_tag_insert();

CREATE TRIGGER search_artist_tag_update AFTER UPDATE ON artist_tag
    FOR EACH ROW EXECUTE PROCEDURE search_artist_tag_update();

CREATE TRIGGER search_artist_tag_delete BEFORE DELETE ON artist_tag
    FOR EACH ROW EXECUTE PROCEDURE search_artist_tag_delete();

CREATE TRIGGER search_tag_insert AFTER INSERT ON tag
    FOR EACH ROW EXECUTE PROCEDURE search_tag_insert();

CREATE TRIGGER search_tag_update AFTER UPDATE ON tag
    FOR EACH ROW EXECUTE PROCEDURE search_tag_update();

CREATE TRIGGER search_tag_delete BEFORE DELETE ON tag
    FOR EACH ROW EXECUTE PROCEDURE search_tag_delete();

CREATE TRIGGER search_artist_credit_name_insert AFTER INSERT ON artist_credit_name
    FOR EACH ROW EXECUTE PROCEDURE search_artist_credit_name_insert();

CREATE TRIGGER search_artist_credit_name_update AFTER UPDATE ON artist_credit_name
    FOR EACH ROW EXECUTE PROCEDURE search_artist_credit_name_update();

CREATE TRIGGER search_artist_credit_name_delete BEFORE DELETE ON artist_credit_name
    FOR EACH ROW EXECUTE PROCEDURE search_artist_credit_name_delete();

CREATE TRIGGER search_artist_credit_insert AFTER INSERT ON artist_credit
    FOR EACH ROW EXECUTE PROCEDURE search_artist_credit_insert();

CREATE TRIGGER search_artist_credit_update AFTER UPDATE ON artist_credit
    FOR EACH ROW EXECUTE PROCEDURE search_artist_credit_update();

CREATE TRIGGER search_artist_credit_delete BEFORE DELETE ON artist_credit
    FOR EACH ROW EXECUTE PROCEDURE search_artist_credit_delete();

CREATE TRIGGER search_artist_type_insert AFTER INSERT ON artist_type
    FOR EACH ROW EXECUTE PROCEDURE search_artist_type_insert();

CREATE TRIGGER search_artist_type_update AFTER UPDATE ON artist_type
    FOR EACH ROW EXECUTE PROCEDURE search_artist_type_update();

CREATE TRIGGER search_artist_type_delete BEFORE DELETE ON artist_type
    FOR EACH ROW EXECUTE PROCEDURE search_artist_type_delete();

CREATE TRIGGER search_release_raw_insert AFTER INSERT ON release_raw
    FOR EACH ROW EXECUTE PROCEDURE search_release_raw_insert();

CREATE TRIGGER search_release_raw_update AFTER UPDATE ON release_raw
    FOR EACH ROW EXECUTE PROCEDURE search_release_raw_update();

CREATE TRIGGER search_release_raw_delete BEFORE DELETE ON release_raw
    FOR EACH ROW EXECUTE PROCEDURE search_release_raw_delete();

CREATE TRIGGER search_cdtoc_raw_insert AFTER INSERT ON cdtoc_raw
    FOR EACH ROW EXECUTE PROCEDURE search_cdtoc_raw_insert();

CREATE TRIGGER search_cdtoc_raw_update AFTER UPDATE ON cdtoc_raw
    FOR EACH ROW EXECUTE PROCEDURE search_cdtoc_raw_update();

CREATE TRIGGER search_cdtoc_raw_delete BEFORE DELETE ON cdtoc_raw
    FOR EACH ROW EXECUTE PROCEDURE search_cdtoc_raw_delete();

CREATE TRIGGER search_editor_insert AFTER INSERT ON editor
    FOR EACH ROW EXECUTE PROCEDURE search_editor_insert();

CREATE TRIGGER search_editor_update AFTER UPDATE ON editor
    FOR EACH ROW EXECUTE PROCEDURE search_editor_update();

CREATE TRIGGER search_editor_delete BEFORE DELETE ON editor
    FOR EACH ROW EXECUTE PROCEDURE search_editor_delete();

CREATE TRIGGER search_event_alias_insert AFTER INSERT ON event_alias
    FOR EACH ROW EXECUTE PROCEDURE search_event_alias_insert();

CREATE TRIGGER search_event_alias_update AFTER UPDATE ON event_alias
    FOR EACH ROW EXECUTE PROCEDURE search_event_alias_update();

CREATE TRIGGER search_event_alias_delete BEFORE DELETE ON event_alias
    FOR EACH ROW EXECUTE PROCEDURE search_event_alias_delete();

CREATE TRIGGER search_l_area_event_insert AFTER INSERT ON l_area_event
    FOR EACH ROW EXECUTE PROCEDURE search_l_area_event_insert();

CREATE TRIGGER search_l_area_event_update AFTER UPDATE ON l_area_event
    FOR EACH ROW EXECUTE PROCEDURE search_l_area_event_update();

CREATE TRIGGER search_l_area_event_delete BEFORE DELETE ON l_area_event
    FOR EACH ROW EXECUTE PROCEDURE search_l_area_event_delete();

CREATE TRIGGER search_l_artist_event_insert AFTER INSERT ON l_artist_event
    FOR EACH ROW EXECUTE PROCEDURE search_l_artist_event_insert();

CREATE TRIGGER search_l_artist_event_update AFTER UPDATE ON l_artist_event
    FOR EACH ROW EXECUTE PROCEDURE search_l_artist_event_update();

CREATE TRIGGER search_l_artist_event_delete BEFORE DELETE ON l_artist_event
    FOR EACH ROW EXECUTE PROCEDURE search_l_artist_event_delete();

CREATE TRIGGER search_l_event_place_insert AFTER INSERT ON l_event_place
    FOR EACH ROW EXECUTE PROCEDURE search_l_event_place_insert();

CREATE TRIGGER search_l_event_place_update AFTER UPDATE ON l_event_place
    FOR EACH ROW EXECUTE PROCEDURE search_l_event_place_update();

CREATE TRIGGER search_l_event_place_delete BEFORE DELETE ON l_event_place
    FOR EACH ROW EXECUTE PROCEDURE search_l_event_place_delete();

CREATE TRIGGER search_event_tag_insert AFTER INSERT ON event_tag
    FOR EACH ROW EXECUTE PROCEDURE search_event_tag_insert();

CREATE TRIGGER search_event_tag_update AFTER UPDATE ON event_tag
    FOR EACH ROW EXECUTE PROCEDURE search_event_tag_update();

CREATE TRIGGER search_event_tag_delete BEFORE DELETE ON event_tag
    FOR EACH ROW EXECUTE PROCEDURE search_event_tag_delete();

CREATE TRIGGER search_event_type_insert AFTER INSERT ON event_type
    FOR EACH ROW EXECUTE PROCEDURE search_event_type_insert();

CREATE TRIGGER search_event_type_update AFTER UPDATE ON event_type
    FOR EACH ROW EXECUTE PROCEDURE search_event_type_update();

CREATE TRIGGER search_event_type_delete BEFORE DELETE ON event_type
    FOR EACH ROW EXECUTE PROCEDURE search_event_type_delete();

CREATE TRIGGER search_instrument_alias_insert AFTER INSERT ON instrument_alias
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_alias_insert();

CREATE TRIGGER search_instrument_alias_update AFTER UPDATE ON instrument_alias
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_alias_update();

CREATE TRIGGER search_instrument_alias_delete BEFORE DELETE ON instrument_alias
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_alias_delete();

CREATE TRIGGER search_instrument_tag_insert AFTER INSERT ON instrument_tag
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_tag_insert();

CREATE TRIGGER search_instrument_tag_update AFTER UPDATE ON instrument_tag
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_tag_update();

CREATE TRIGGER search_instrument_tag_delete BEFORE DELETE ON instrument_tag
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_tag_delete();

CREATE TRIGGER search_instrument_type_insert AFTER INSERT ON instrument_type
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_type_insert();

CREATE TRIGGER search_instrument_type_update AFTER UPDATE ON instrument_type
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_type_update();

CREATE TRIGGER search_instrument_type_delete BEFORE DELETE ON instrument_type
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_type_delete();

CREATE TRIGGER search_label_alias_insert AFTER INSERT ON label_alias
    FOR EACH ROW EXECUTE PROCEDURE search_label_alias_insert();

CREATE TRIGGER search_label_alias_update AFTER UPDATE ON label_alias
    FOR EACH ROW EXECUTE PROCEDURE search_label_alias_update();

CREATE TRIGGER search_label_alias_delete BEFORE DELETE ON label_alias
    FOR EACH ROW EXECUTE PROCEDURE search_label_alias_delete();

CREATE TRIGGER search_label_ipi_insert AFTER INSERT ON label_ipi
    FOR EACH ROW EXECUTE PROCEDURE search_label_ipi_insert();

CREATE TRIGGER search_label_ipi_update AFTER UPDATE ON label_ipi
    FOR EACH ROW EXECUTE PROCEDURE search_label_ipi_update();

CREATE TRIGGER search_label_ipi_delete BEFORE DELETE ON label_ipi
    FOR EACH ROW EXECUTE PROCEDURE search_label_ipi_delete();

CREATE TRIGGER search_label_tag_insert AFTER INSERT ON label_tag
    FOR EACH ROW EXECUTE PROCEDURE search_label_tag_insert();

CREATE TRIGGER search_label_tag_update AFTER UPDATE ON label_tag
    FOR EACH ROW EXECUTE PROCEDURE search_label_tag_update();

CREATE TRIGGER search_label_tag_delete BEFORE DELETE ON label_tag
    FOR EACH ROW EXECUTE PROCEDURE search_label_tag_delete();

CREATE TRIGGER search_label_type_insert AFTER INSERT ON label_type
    FOR EACH ROW EXECUTE PROCEDURE search_label_type_insert();

CREATE TRIGGER search_label_type_update AFTER UPDATE ON label_type
    FOR EACH ROW EXECUTE PROCEDURE search_label_type_update();

CREATE TRIGGER search_label_type_delete BEFORE DELETE ON label_type
    FOR EACH ROW EXECUTE PROCEDURE search_label_type_delete();

CREATE TRIGGER search_place_alias_insert AFTER INSERT ON place_alias
    FOR EACH ROW EXECUTE PROCEDURE search_place_alias_insert();

CREATE TRIGGER search_place_alias_update AFTER UPDATE ON place_alias
    FOR EACH ROW EXECUTE PROCEDURE search_place_alias_update();

CREATE TRIGGER search_place_alias_delete BEFORE DELETE ON place_alias
    FOR EACH ROW EXECUTE PROCEDURE search_place_alias_delete();

CREATE TRIGGER search_place_type_insert AFTER INSERT ON place_type
    FOR EACH ROW EXECUTE PROCEDURE search_place_type_insert();

CREATE TRIGGER search_place_type_update AFTER UPDATE ON place_type
    FOR EACH ROW EXECUTE PROCEDURE search_place_type_update();

CREATE TRIGGER search_place_type_delete BEFORE DELETE ON place_type
    FOR EACH ROW EXECUTE PROCEDURE search_place_type_delete();

CREATE TRIGGER search_track_insert AFTER INSERT ON track
    FOR EACH ROW EXECUTE PROCEDURE search_track_insert();

CREATE TRIGGER search_track_update AFTER UPDATE ON track
    FOR EACH ROW EXECUTE PROCEDURE search_track_update();

CREATE TRIGGER search_track_delete BEFORE DELETE ON track
    FOR EACH ROW EXECUTE PROCEDURE search_track_delete();

CREATE TRIGGER search_medium_insert AFTER INSERT ON medium
    FOR EACH ROW EXECUTE PROCEDURE search_medium_insert();

CREATE TRIGGER search_medium_update AFTER UPDATE ON medium
    FOR EACH ROW EXECUTE PROCEDURE search_medium_update();

CREATE TRIGGER search_medium_delete BEFORE DELETE ON medium
    FOR EACH ROW EXECUTE PROCEDURE search_medium_delete();

CREATE TRIGGER search_release_country_insert AFTER INSERT ON release_country
    FOR EACH ROW EXECUTE PROCEDURE search_release_country_insert();

CREATE TRIGGER search_release_country_update AFTER UPDATE ON release_country
    FOR EACH ROW EXECUTE PROCEDURE search_release_country_update();

CREATE TRIGGER search_release_country_delete BEFORE DELETE ON release_country
    FOR EACH ROW EXECUTE PROCEDURE search_release_country_delete();

CREATE TRIGGER search_country_area_insert AFTER INSERT ON country_area
    FOR EACH ROW EXECUTE PROCEDURE search_country_area_insert();

CREATE TRIGGER search_country_area_update AFTER UPDATE ON country_area
    FOR EACH ROW EXECUTE PROCEDURE search_country_area_update();

CREATE TRIGGER search_country_area_delete BEFORE DELETE ON country_area
    FOR EACH ROW EXECUTE PROCEDURE search_country_area_delete();

CREATE TRIGGER search_medium_format_insert AFTER INSERT ON medium_format
    FOR EACH ROW EXECUTE PROCEDURE search_medium_format_insert();

CREATE TRIGGER search_medium_format_update AFTER UPDATE ON medium_format
    FOR EACH ROW EXECUTE PROCEDURE search_medium_format_update();

CREATE TRIGGER search_medium_format_delete BEFORE DELETE ON medium_format
    FOR EACH ROW EXECUTE PROCEDURE search_medium_format_delete();

CREATE TRIGGER search_isrc_insert AFTER INSERT ON isrc
    FOR EACH ROW EXECUTE PROCEDURE search_isrc_insert();

CREATE TRIGGER search_isrc_update AFTER UPDATE ON isrc
    FOR EACH ROW EXECUTE PROCEDURE search_isrc_update();

CREATE TRIGGER search_isrc_delete BEFORE DELETE ON isrc
    FOR EACH ROW EXECUTE PROCEDURE search_isrc_delete();

CREATE TRIGGER search_release_group_primary_type_insert AFTER INSERT ON release_group_primary_type
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_primary_type_insert();

CREATE TRIGGER search_release_group_primary_type_update AFTER UPDATE ON release_group_primary_type
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_primary_type_update();

CREATE TRIGGER search_release_group_primary_type_delete BEFORE DELETE ON release_group_primary_type
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_primary_type_delete();

CREATE TRIGGER search_release_group_secondary_type_join_insert AFTER INSERT ON release_group_secondary_type_join
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_secondary_type_join_insert();

CREATE TRIGGER search_release_group_secondary_type_join_update AFTER UPDATE ON release_group_secondary_type_join
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_secondary_type_join_update();

CREATE TRIGGER search_release_group_secondary_type_join_delete BEFORE DELETE ON release_group_secondary_type_join
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_secondary_type_join_delete();

CREATE TRIGGER search_release_group_secondary_type_insert AFTER INSERT ON release_group_secondary_type
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_secondary_type_insert();

CREATE TRIGGER search_release_group_secondary_type_update AFTER UPDATE ON release_group_secondary_type
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_secondary_type_update();

CREATE TRIGGER search_release_group_secondary_type_delete BEFORE DELETE ON release_group_secondary_type
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_secondary_type_delete();

CREATE TRIGGER search_release_status_insert AFTER INSERT ON release_status
    FOR EACH ROW EXECUTE PROCEDURE search_release_status_insert();

CREATE TRIGGER search_release_status_update AFTER UPDATE ON release_status
    FOR EACH ROW EXECUTE PROCEDURE search_release_status_update();

CREATE TRIGGER search_release_status_delete BEFORE DELETE ON release_status
    FOR EACH ROW EXECUTE PROCEDURE search_release_status_delete();

CREATE TRIGGER search_recording_tag_insert AFTER INSERT ON recording_tag
    FOR EACH ROW EXECUTE PROCEDURE search_recording_tag_insert();

CREATE TRIGGER search_recording_tag_update AFTER UPDATE ON recording_tag
    FOR EACH ROW EXECUTE PROCEDURE search_recording_tag_update();

CREATE TRIGGER search_recording_tag_delete BEFORE DELETE ON recording_tag
    FOR EACH ROW EXECUTE PROCEDURE search_recording_tag_delete();

CREATE TRIGGER search_release_meta_insert AFTER INSERT ON release_meta
    FOR EACH ROW EXECUTE PROCEDURE search_release_meta_insert();

CREATE TRIGGER search_release_meta_update AFTER UPDATE ON release_meta
    FOR EACH ROW EXECUTE PROCEDURE search_release_meta_update();

CREATE TRIGGER search_release_meta_delete BEFORE DELETE ON release_meta
    FOR EACH ROW EXECUTE PROCEDURE search_release_meta_delete();

CREATE TRIGGER search_release_label_insert AFTER INSERT ON release_label
    FOR EACH ROW EXECUTE PROCEDURE search_release_label_insert();

CREATE TRIGGER search_release_label_update AFTER UPDATE ON release_label
    FOR EACH ROW EXECUTE PROCEDURE search_release_label_update();

CREATE TRIGGER search_release_label_delete BEFORE DELETE ON release_label
    FOR EACH ROW EXECUTE PROCEDURE search_release_label_delete();

CREATE TRIGGER search_medium_cdtoc_insert AFTER INSERT ON medium_cdtoc
    FOR EACH ROW EXECUTE PROCEDURE search_medium_cdtoc_insert();

CREATE TRIGGER search_medium_cdtoc_update AFTER UPDATE ON medium_cdtoc
    FOR EACH ROW EXECUTE PROCEDURE search_medium_cdtoc_update();

CREATE TRIGGER search_medium_cdtoc_delete BEFORE DELETE ON medium_cdtoc
    FOR EACH ROW EXECUTE PROCEDURE search_medium_cdtoc_delete();

CREATE TRIGGER search_language_insert AFTER INSERT ON language
    FOR EACH ROW EXECUTE PROCEDURE search_language_insert();

CREATE TRIGGER search_language_update AFTER UPDATE ON language
    FOR EACH ROW EXECUTE PROCEDURE search_language_update();

CREATE TRIGGER search_language_delete BEFORE DELETE ON language
    FOR EACH ROW EXECUTE PROCEDURE search_language_delete();

CREATE TRIGGER search_script_insert AFTER INSERT ON script
    FOR EACH ROW EXECUTE PROCEDURE search_script_insert();

CREATE TRIGGER search_script_update AFTER UPDATE ON script
    FOR EACH ROW EXECUTE PROCEDURE search_script_update();

CREATE TRIGGER search_script_delete BEFORE DELETE ON script
    FOR EACH ROW EXECUTE PROCEDURE search_script_delete();

CREATE TRIGGER search_release_tag_insert AFTER INSERT ON release_tag
    FOR EACH ROW EXECUTE PROCEDURE search_release_tag_insert();

CREATE TRIGGER search_release_tag_update AFTER UPDATE ON release_tag
    FOR EACH ROW EXECUTE PROCEDURE search_release_tag_update();

CREATE TRIGGER search_release_tag_delete BEFORE DELETE ON release_tag
    FOR EACH ROW EXECUTE PROCEDURE search_release_tag_delete();

CREATE TRIGGER search_release_group_tag_insert AFTER INSERT ON release_group_tag
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_tag_insert();

CREATE TRIGGER search_release_group_tag_update AFTER UPDATE ON release_group_tag
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_tag_update();

CREATE TRIGGER search_release_group_tag_delete BEFORE DELETE ON release_group_tag
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_tag_delete();

CREATE TRIGGER search_series_alias_insert AFTER INSERT ON series_alias
    FOR EACH ROW EXECUTE PROCEDURE search_series_alias_insert();

CREATE TRIGGER search_series_alias_update AFTER UPDATE ON series_alias
    FOR EACH ROW EXECUTE PROCEDURE search_series_alias_update();

CREATE TRIGGER search_series_alias_delete BEFORE DELETE ON series_alias
    FOR EACH ROW EXECUTE PROCEDURE search_series_alias_delete();

CREATE TRIGGER search_link_attribute_type_insert AFTER INSERT ON link_attribute_type
    FOR EACH ROW EXECUTE PROCEDURE search_link_attribute_type_insert();

CREATE TRIGGER search_link_attribute_type_update AFTER UPDATE ON link_attribute_type
    FOR EACH ROW EXECUTE PROCEDURE search_link_attribute_type_update();

CREATE TRIGGER search_link_attribute_type_delete BEFORE DELETE ON link_attribute_type
    FOR EACH ROW EXECUTE PROCEDURE search_link_attribute_type_delete();

CREATE TRIGGER search_series_tag_insert AFTER INSERT ON series_tag
    FOR EACH ROW EXECUTE PROCEDURE search_series_tag_insert();

CREATE TRIGGER search_series_tag_update AFTER UPDATE ON series_tag
    FOR EACH ROW EXECUTE PROCEDURE search_series_tag_update();

CREATE TRIGGER search_series_tag_delete BEFORE DELETE ON series_tag
    FOR EACH ROW EXECUTE PROCEDURE search_series_tag_delete();

CREATE TRIGGER search_series_type_insert AFTER INSERT ON series_type
    FOR EACH ROW EXECUTE PROCEDURE search_series_type_insert();

CREATE TRIGGER search_series_type_update AFTER UPDATE ON series_type
    FOR EACH ROW EXECUTE PROCEDURE search_series_type_update();

CREATE TRIGGER search_series_type_delete BEFORE DELETE ON series_type
    FOR EACH ROW EXECUTE PROCEDURE search_series_type_delete();

CREATE TRIGGER search_url_insert AFTER INSERT ON url
    FOR EACH ROW EXECUTE PROCEDURE search_url_insert();

CREATE TRIGGER search_url_update AFTER UPDATE ON url
    FOR EACH ROW EXECUTE PROCEDURE search_url_update();

CREATE TRIGGER search_url_delete BEFORE DELETE ON url
    FOR EACH ROW EXECUTE PROCEDURE search_url_delete();

CREATE TRIGGER search_work_alias_insert AFTER INSERT ON work_alias
    FOR EACH ROW EXECUTE PROCEDURE search_work_alias_insert();

CREATE TRIGGER search_work_alias_update AFTER UPDATE ON work_alias
    FOR EACH ROW EXECUTE PROCEDURE search_work_alias_update();

CREATE TRIGGER search_work_alias_delete BEFORE DELETE ON work_alias
    FOR EACH ROW EXECUTE PROCEDURE search_work_alias_delete();

CREATE TRIGGER search_l_artist_work_insert AFTER INSERT ON l_artist_work
    FOR EACH ROW EXECUTE PROCEDURE search_l_artist_work_insert();

CREATE TRIGGER search_l_artist_work_update AFTER UPDATE ON l_artist_work
    FOR EACH ROW EXECUTE PROCEDURE search_l_artist_work_update();

CREATE TRIGGER search_l_artist_work_delete BEFORE DELETE ON l_artist_work
    FOR EACH ROW EXECUTE PROCEDURE search_l_artist_work_delete();

CREATE TRIGGER search_iswc_insert AFTER INSERT ON iswc
    FOR EACH ROW EXECUTE PROCEDURE search_iswc_insert();

CREATE TRIGGER search_iswc_update AFTER UPDATE ON iswc
    FOR EACH ROW EXECUTE PROCEDURE search_iswc_update();

CREATE TRIGGER search_iswc_delete BEFORE DELETE ON iswc
    FOR EACH ROW EXECUTE PROCEDURE search_iswc_delete();

CREATE TRIGGER search_work_tag_insert AFTER INSERT ON work_tag
    FOR EACH ROW EXECUTE PROCEDURE search_work_tag_insert();

CREATE TRIGGER search_work_tag_update AFTER UPDATE ON work_tag
    FOR EACH ROW EXECUTE PROCEDURE search_work_tag_update();

CREATE TRIGGER search_work_tag_delete BEFORE DELETE ON work_tag
    FOR EACH ROW EXECUTE PROCEDURE search_work_tag_delete();

CREATE TRIGGER search_work_type_insert AFTER INSERT ON work_type
    FOR EACH ROW EXECUTE PROCEDURE search_work_type_insert();

CREATE TRIGGER search_work_type_update AFTER UPDATE ON work_type
    FOR EACH ROW EXECUTE PROCEDURE search_work_type_update();

CREATE TRIGGER search_work_type_delete BEFORE DELETE ON work_type
    FOR EACH ROW EXECUTE PROCEDURE search_work_type_delete();

COMMIT;

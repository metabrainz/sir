-- Automatically generated, do not edit
\set ON_ERROR_STOP 1
BEGIN;

CREATE TRIGGER search_artist_delete_direct BEFORE DELETE ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_artist_delete_direct();

CREATE TRIGGER search_artist_insert_direct AFTER INSERT ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_artist_insert_direct();

CREATE TRIGGER search_artist_update_direct AFTER UPDATE ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_artist_update_direct();

CREATE TRIGGER search_artist_delete_2_aliases BEFORE DELETE ON artist_alias
    FOR EACH ROW EXECUTE PROCEDURE search_artist_delete_2_aliases();

CREATE TRIGGER search_artist_insert_2_aliases AFTER INSERT ON artist_alias
    FOR EACH ROW EXECUTE PROCEDURE search_artist_insert_2_aliases();

CREATE TRIGGER search_artist_update_2_aliases AFTER UPDATE ON artist_alias
    FOR EACH ROW EXECUTE PROCEDURE search_artist_update_2_aliases();

CREATE TRIGGER search_artist_delete_4_area BEFORE DELETE ON area
    FOR EACH ROW EXECUTE PROCEDURE search_artist_delete_4_area();

CREATE TRIGGER search_artist_insert_4_area AFTER INSERT ON area
    FOR EACH ROW EXECUTE PROCEDURE search_artist_insert_4_area();

CREATE TRIGGER search_artist_update_4_area AFTER UPDATE ON area
    FOR EACH ROW EXECUTE PROCEDURE search_artist_update_4_area();

CREATE TRIGGER search_artist_delete_6_area_aliases BEFORE DELETE ON area_alias
    FOR EACH ROW EXECUTE PROCEDURE search_artist_delete_6_area_aliases();

CREATE TRIGGER search_artist_insert_6_area_aliases AFTER INSERT ON area_alias
    FOR EACH ROW EXECUTE PROCEDURE search_artist_insert_6_area_aliases();

CREATE TRIGGER search_artist_update_6_area_aliases AFTER UPDATE ON area_alias
    FOR EACH ROW EXECUTE PROCEDURE search_artist_update_6_area_aliases();

CREATE TRIGGER search_artist_delete_8_begin_area BEFORE DELETE ON area
    FOR EACH ROW EXECUTE PROCEDURE search_artist_delete_8_begin_area();

CREATE TRIGGER search_artist_insert_8_begin_area AFTER INSERT ON area
    FOR EACH ROW EXECUTE PROCEDURE search_artist_insert_8_begin_area();

CREATE TRIGGER search_artist_update_8_begin_area AFTER UPDATE ON area
    FOR EACH ROW EXECUTE PROCEDURE search_artist_update_8_begin_area();

CREATE TRIGGER search_artist_delete_10_begin_area_aliases BEFORE DELETE ON area_alias
    FOR EACH ROW EXECUTE PROCEDURE search_artist_delete_10_begin_area_aliases();

CREATE TRIGGER search_artist_insert_10_begin_area_aliases AFTER INSERT ON area_alias
    FOR EACH ROW EXECUTE PROCEDURE search_artist_insert_10_begin_area_aliases();

CREATE TRIGGER search_artist_update_10_begin_area_aliases AFTER UPDATE ON area_alias
    FOR EACH ROW EXECUTE PROCEDURE search_artist_update_10_begin_area_aliases();

CREATE TRIGGER search_artist_delete_12_end_area BEFORE DELETE ON area
    FOR EACH ROW EXECUTE PROCEDURE search_artist_delete_12_end_area();

CREATE TRIGGER search_artist_insert_12_end_area AFTER INSERT ON area
    FOR EACH ROW EXECUTE PROCEDURE search_artist_insert_12_end_area();

CREATE TRIGGER search_artist_update_12_end_area AFTER UPDATE ON area
    FOR EACH ROW EXECUTE PROCEDURE search_artist_update_12_end_area();

CREATE TRIGGER search_artist_delete_14_end_area_aliases BEFORE DELETE ON area_alias
    FOR EACH ROW EXECUTE PROCEDURE search_artist_delete_14_end_area_aliases();

CREATE TRIGGER search_artist_insert_14_end_area_aliases AFTER INSERT ON area_alias
    FOR EACH ROW EXECUTE PROCEDURE search_artist_insert_14_end_area_aliases();

CREATE TRIGGER search_artist_update_14_end_area_aliases AFTER UPDATE ON area_alias
    FOR EACH ROW EXECUTE PROCEDURE search_artist_update_14_end_area_aliases();

CREATE TRIGGER search_artist_delete_17_ipis BEFORE DELETE ON artist_ipi
    FOR EACH ROW EXECUTE PROCEDURE search_artist_delete_17_ipis();

CREATE TRIGGER search_artist_insert_17_ipis AFTER INSERT ON artist_ipi
    FOR EACH ROW EXECUTE PROCEDURE search_artist_insert_17_ipis();

CREATE TRIGGER search_artist_update_17_ipis AFTER UPDATE ON artist_ipi
    FOR EACH ROW EXECUTE PROCEDURE search_artist_update_17_ipis();

CREATE TRIGGER search_artist_delete_19_type BEFORE DELETE ON artist_type
    FOR EACH ROW EXECUTE PROCEDURE search_artist_delete_19_type();

CREATE TRIGGER search_artist_insert_19_type AFTER INSERT ON artist_type
    FOR EACH ROW EXECUTE PROCEDURE search_artist_insert_19_type();

CREATE TRIGGER search_artist_update_19_type AFTER UPDATE ON artist_type
    FOR EACH ROW EXECUTE PROCEDURE search_artist_update_19_type();

CREATE TRIGGER search_work_delete_direct BEFORE DELETE ON work
    FOR EACH ROW EXECUTE PROCEDURE search_work_delete_direct();

CREATE TRIGGER search_work_insert_direct AFTER INSERT ON work
    FOR EACH ROW EXECUTE PROCEDURE search_work_insert_direct();

CREATE TRIGGER search_work_update_direct AFTER UPDATE ON work
    FOR EACH ROW EXECUTE PROCEDURE search_work_update_direct();

CREATE TRIGGER search_work_delete_2_aliases BEFORE DELETE ON work_alias
    FOR EACH ROW EXECUTE PROCEDURE search_work_delete_2_aliases();

CREATE TRIGGER search_work_insert_2_aliases AFTER INSERT ON work_alias
    FOR EACH ROW EXECUTE PROCEDURE search_work_insert_2_aliases();

CREATE TRIGGER search_work_update_2_aliases AFTER UPDATE ON work_alias
    FOR EACH ROW EXECUTE PROCEDURE search_work_update_2_aliases();

CREATE TRIGGER search_work_delete_4_artist_links BEFORE DELETE ON l_artist_work
    FOR EACH ROW EXECUTE PROCEDURE search_work_delete_4_artist_links();

CREATE TRIGGER search_work_insert_4_artist_links AFTER INSERT ON l_artist_work
    FOR EACH ROW EXECUTE PROCEDURE search_work_insert_4_artist_links();

CREATE TRIGGER search_work_update_4_artist_links AFTER UPDATE ON l_artist_work
    FOR EACH ROW EXECUTE PROCEDURE search_work_update_4_artist_links();

CREATE TRIGGER search_work_delete_5_artist_links_artist BEFORE DELETE ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_work_delete_5_artist_links_artist();

CREATE TRIGGER search_work_insert_5_artist_links_artist AFTER INSERT ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_work_insert_5_artist_links_artist();

CREATE TRIGGER search_work_update_5_artist_links_artist AFTER UPDATE ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_work_update_5_artist_links_artist();

CREATE TRIGGER search_work_delete_9_iswcs BEFORE DELETE ON iswc
    FOR EACH ROW EXECUTE PROCEDURE search_work_delete_9_iswcs();

CREATE TRIGGER search_work_insert_9_iswcs AFTER INSERT ON iswc
    FOR EACH ROW EXECUTE PROCEDURE search_work_insert_9_iswcs();

CREATE TRIGGER search_work_update_9_iswcs AFTER UPDATE ON iswc
    FOR EACH ROW EXECUTE PROCEDURE search_work_update_9_iswcs();

CREATE TRIGGER search_work_delete_11_language BEFORE DELETE ON language
    FOR EACH ROW EXECUTE PROCEDURE search_work_delete_11_language();

CREATE TRIGGER search_work_insert_11_language AFTER INSERT ON language
    FOR EACH ROW EXECUTE PROCEDURE search_work_insert_11_language();

CREATE TRIGGER search_work_update_11_language AFTER UPDATE ON language
    FOR EACH ROW EXECUTE PROCEDURE search_work_update_11_language();

CREATE TRIGGER search_label_delete_direct BEFORE DELETE ON label
    FOR EACH ROW EXECUTE PROCEDURE search_label_delete_direct();

CREATE TRIGGER search_label_insert_direct AFTER INSERT ON label
    FOR EACH ROW EXECUTE PROCEDURE search_label_insert_direct();

CREATE TRIGGER search_label_update_direct AFTER UPDATE ON label
    FOR EACH ROW EXECUTE PROCEDURE search_label_update_direct();

CREATE TRIGGER search_label_delete_2_aliases BEFORE DELETE ON label_alias
    FOR EACH ROW EXECUTE PROCEDURE search_label_delete_2_aliases();

CREATE TRIGGER search_label_insert_2_aliases AFTER INSERT ON label_alias
    FOR EACH ROW EXECUTE PROCEDURE search_label_insert_2_aliases();

CREATE TRIGGER search_label_update_2_aliases AFTER UPDATE ON label_alias
    FOR EACH ROW EXECUTE PROCEDURE search_label_update_2_aliases();

CREATE TRIGGER search_label_delete_4_area BEFORE DELETE ON area
    FOR EACH ROW EXECUTE PROCEDURE search_label_delete_4_area();

CREATE TRIGGER search_label_insert_4_area AFTER INSERT ON area
    FOR EACH ROW EXECUTE PROCEDURE search_label_insert_4_area();

CREATE TRIGGER search_label_update_4_area AFTER UPDATE ON area
    FOR EACH ROW EXECUTE PROCEDURE search_label_update_4_area();

CREATE TRIGGER search_label_delete_7_ipis BEFORE DELETE ON label_ipi
    FOR EACH ROW EXECUTE PROCEDURE search_label_delete_7_ipis();

CREATE TRIGGER search_label_insert_7_ipis AFTER INSERT ON label_ipi
    FOR EACH ROW EXECUTE PROCEDURE search_label_insert_7_ipis();

CREATE TRIGGER search_label_update_7_ipis AFTER UPDATE ON label_ipi
    FOR EACH ROW EXECUTE PROCEDURE search_label_update_7_ipis();

CREATE TRIGGER search_label_delete_9_type BEFORE DELETE ON label_type
    FOR EACH ROW EXECUTE PROCEDURE search_label_delete_9_type();

CREATE TRIGGER search_label_insert_9_type AFTER INSERT ON label_type
    FOR EACH ROW EXECUTE PROCEDURE search_label_insert_9_type();

CREATE TRIGGER search_label_update_9_type AFTER UPDATE ON label_type
    FOR EACH ROW EXECUTE PROCEDURE search_label_update_9_type();

CREATE TRIGGER search_recording_delete_direct BEFORE DELETE ON recording
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_direct();

CREATE TRIGGER search_recording_insert_direct AFTER INSERT ON recording
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_direct();

CREATE TRIGGER search_recording_update_direct AFTER UPDATE ON recording
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_direct();

CREATE TRIGGER search_recording_delete_0_artist_credit BEFORE DELETE ON artist_credit
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_0_artist_credit();

CREATE TRIGGER search_recording_insert_0_artist_credit AFTER INSERT ON artist_credit
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_0_artist_credit();

CREATE TRIGGER search_recording_update_0_artist_credit AFTER UPDATE ON artist_credit
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_0_artist_credit();

CREATE TRIGGER search_recording_delete_1_artist_credit_artists BEFORE DELETE ON artist_credit_name
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_1_artist_credit_artists();

CREATE TRIGGER search_recording_insert_1_artist_credit_artists AFTER INSERT ON artist_credit_name
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_1_artist_credit_artists();

CREATE TRIGGER search_recording_update_1_artist_credit_artists AFTER UPDATE ON artist_credit_name
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_1_artist_credit_artists();

CREATE TRIGGER search_recording_delete_2_artist_credit_artists_artist BEFORE DELETE ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_2_artist_credit_artists_artist();

CREATE TRIGGER search_recording_insert_2_artist_credit_artists_artist AFTER INSERT ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_2_artist_credit_artists_artist();

CREATE TRIGGER search_recording_update_2_artist_credit_artists_artist AFTER UPDATE ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_2_artist_credit_artists_artist();

CREATE TRIGGER search_recording_delete_7_tracks BEFORE DELETE ON track
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_7_tracks();

CREATE TRIGGER search_recording_insert_7_tracks AFTER INSERT ON track
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_7_tracks();

CREATE TRIGGER search_recording_update_7_tracks AFTER UPDATE ON track
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_7_tracks();

CREATE TRIGGER search_recording_delete_8_tracks_medium BEFORE DELETE ON medium
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_8_tracks_medium();

CREATE TRIGGER search_recording_insert_8_tracks_medium AFTER INSERT ON medium
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_8_tracks_medium();

CREATE TRIGGER search_recording_update_8_tracks_medium AFTER UPDATE ON medium
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_8_tracks_medium();

CREATE TRIGGER search_recording_delete_9_tracks_medium_release BEFORE DELETE ON release
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_9_tracks_medium_release();

CREATE TRIGGER search_recording_insert_9_tracks_medium_release AFTER INSERT ON release
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_9_tracks_medium_release();

CREATE TRIGGER search_recording_update_9_tracks_medium_release AFTER UPDATE ON release
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_9_tracks_medium_release();

CREATE TRIGGER search_recording_delete_10_tracks_medium_release_country_dates BEFORE DELETE ON release_country
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_10_tracks_medium_release_country_dates();

CREATE TRIGGER search_recording_insert_10_tracks_medium_release_country_dates AFTER INSERT ON release_country
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_10_tracks_medium_release_country_dates();

CREATE TRIGGER search_recording_update_10_tracks_medium_release_country_dates AFTER UPDATE ON release_country
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_10_tracks_medium_release_country_dates();

CREATE TRIGGER search_recording_delete_11_tracks_medium_release_country_dates_country BEFORE DELETE ON country_area
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_11_tracks_medium_release_country_dates_country();

CREATE TRIGGER search_recording_insert_11_tracks_medium_release_country_dates_country AFTER INSERT ON country_area
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_11_tracks_medium_release_country_dates_country();

CREATE TRIGGER search_recording_update_11_tracks_medium_release_country_dates_country AFTER UPDATE ON country_area
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_11_tracks_medium_release_country_dates_country();

CREATE TRIGGER search_recording_delete_12_tracks_medium_release_country_dates_country_area BEFORE DELETE ON area
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_12_tracks_medium_release_country_dates_country_area();

CREATE TRIGGER search_recording_insert_12_tracks_medium_release_country_dates_country_area AFTER INSERT ON area
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_12_tracks_medium_release_country_dates_country_area();

CREATE TRIGGER search_recording_update_12_tracks_medium_release_country_dates_country_area AFTER UPDATE ON area
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_12_tracks_medium_release_country_dates_country_area();

CREATE TRIGGER search_recording_delete_16_tracks_medium_format BEFORE DELETE ON medium_format
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_16_tracks_medium_format();

CREATE TRIGGER search_recording_insert_16_tracks_medium_format AFTER INSERT ON medium_format
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_16_tracks_medium_format();

CREATE TRIGGER search_recording_update_16_tracks_medium_format AFTER UPDATE ON medium_format
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_16_tracks_medium_format();

CREATE TRIGGER search_recording_delete_18_isrcs BEFORE DELETE ON isrc
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_18_isrcs();

CREATE TRIGGER search_recording_insert_18_isrcs AFTER INSERT ON isrc
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_18_isrcs();

CREATE TRIGGER search_recording_update_18_isrcs AFTER UPDATE ON isrc
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_18_isrcs();

CREATE TRIGGER search_recording_delete_23_tracks_medium_release_release_group BEFORE DELETE ON release_group
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_23_tracks_medium_release_release_group();

CREATE TRIGGER search_recording_insert_23_tracks_medium_release_release_group AFTER INSERT ON release_group
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_23_tracks_medium_release_release_group();

CREATE TRIGGER search_recording_update_23_tracks_medium_release_release_group AFTER UPDATE ON release_group
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_23_tracks_medium_release_release_group();

CREATE TRIGGER search_recording_delete_24_tracks_medium_release_release_group_type BEFORE DELETE ON release_group_primary_type
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_24_tracks_medium_release_release_group_type();

CREATE TRIGGER search_recording_insert_24_tracks_medium_release_release_group_type AFTER INSERT ON release_group_primary_type
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_24_tracks_medium_release_release_group_type();

CREATE TRIGGER search_recording_update_24_tracks_medium_release_release_group_type AFTER UPDATE ON release_group_primary_type
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_24_tracks_medium_release_release_group_type();

CREATE TRIGGER search_recording_delete_30_tracks_medium_release_release_group_secondary_types BEFORE DELETE ON release_group_secondary_type_join
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_30_tracks_medium_release_release_group_secondary_types();

CREATE TRIGGER search_recording_insert_30_tracks_medium_release_release_group_secondary_types AFTER INSERT ON release_group_secondary_type_join
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_30_tracks_medium_release_release_group_secondary_types();

CREATE TRIGGER search_recording_update_30_tracks_medium_release_release_group_secondary_types AFTER UPDATE ON release_group_secondary_type_join
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_30_tracks_medium_release_release_group_secondary_types();

CREATE TRIGGER search_recording_delete_31_tracks_medium_release_release_group_secondary_types_secondary_type BEFORE DELETE ON release_group_secondary_type
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_31_tracks_medium_release_release_group_secondary_types_secondary_type();

CREATE TRIGGER search_recording_insert_31_tracks_medium_release_release_group_secondary_types_secondary_type AFTER INSERT ON release_group_secondary_type
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_31_tracks_medium_release_release_group_secondary_types_secondary_type();

CREATE TRIGGER search_recording_update_31_tracks_medium_release_release_group_secondary_types_secondary_type AFTER UPDATE ON release_group_secondary_type
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_31_tracks_medium_release_release_group_secondary_types_secondary_type();

CREATE TRIGGER search_recording_delete_33_tracks_medium_release_status BEFORE DELETE ON release_status
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_33_tracks_medium_release_status();

CREATE TRIGGER search_recording_insert_33_tracks_medium_release_status AFTER INSERT ON release_status
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_33_tracks_medium_release_status();

CREATE TRIGGER search_recording_update_33_tracks_medium_release_status AFTER UPDATE ON release_status
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_33_tracks_medium_release_status();

CREATE TRIGGER search_recording_delete_38_tracks_medium_release_mediums BEFORE DELETE ON medium
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_38_tracks_medium_release_mediums();

CREATE TRIGGER search_recording_insert_38_tracks_medium_release_mediums AFTER INSERT ON medium
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_38_tracks_medium_release_mediums();

CREATE TRIGGER search_recording_update_38_tracks_medium_release_mediums AFTER UPDATE ON medium
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_38_tracks_medium_release_mediums();

CREATE TRIGGER search_release_delete_direct BEFORE DELETE ON release
    FOR EACH ROW EXECUTE PROCEDURE search_release_delete_direct();

CREATE TRIGGER search_release_insert_direct AFTER INSERT ON release
    FOR EACH ROW EXECUTE PROCEDURE search_release_insert_direct();

CREATE TRIGGER search_release_update_direct AFTER UPDATE ON release
    FOR EACH ROW EXECUTE PROCEDURE search_release_update_direct();

CREATE TRIGGER search_release_delete_2_artist_credit BEFORE DELETE ON artist_credit
    FOR EACH ROW EXECUTE PROCEDURE search_release_delete_2_artist_credit();

CREATE TRIGGER search_release_insert_2_artist_credit AFTER INSERT ON artist_credit
    FOR EACH ROW EXECUTE PROCEDURE search_release_insert_2_artist_credit();

CREATE TRIGGER search_release_update_2_artist_credit AFTER UPDATE ON artist_credit
    FOR EACH ROW EXECUTE PROCEDURE search_release_update_2_artist_credit();

CREATE TRIGGER search_release_delete_3_artist_credit_artists BEFORE DELETE ON artist_credit_name
    FOR EACH ROW EXECUTE PROCEDURE search_release_delete_3_artist_credit_artists();

CREATE TRIGGER search_release_insert_3_artist_credit_artists AFTER INSERT ON artist_credit_name
    FOR EACH ROW EXECUTE PROCEDURE search_release_insert_3_artist_credit_artists();

CREATE TRIGGER search_release_update_3_artist_credit_artists AFTER UPDATE ON artist_credit_name
    FOR EACH ROW EXECUTE PROCEDURE search_release_update_3_artist_credit_artists();

CREATE TRIGGER search_release_delete_4_artist_credit_artists_artist BEFORE DELETE ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_release_delete_4_artist_credit_artists_artist();

CREATE TRIGGER search_release_insert_4_artist_credit_artists_artist AFTER INSERT ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_release_insert_4_artist_credit_artists_artist();

CREATE TRIGGER search_release_update_4_artist_credit_artists_artist AFTER UPDATE ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_release_update_4_artist_credit_artists_artist();

CREATE TRIGGER search_release_delete_6_country_dates BEFORE DELETE ON release_country
    FOR EACH ROW EXECUTE PROCEDURE search_release_delete_6_country_dates();

CREATE TRIGGER search_release_insert_6_country_dates AFTER INSERT ON release_country
    FOR EACH ROW EXECUTE PROCEDURE search_release_insert_6_country_dates();

CREATE TRIGGER search_release_update_6_country_dates AFTER UPDATE ON release_country
    FOR EACH ROW EXECUTE PROCEDURE search_release_update_6_country_dates();

CREATE TRIGGER search_release_delete_7_country_dates_country BEFORE DELETE ON country_area
    FOR EACH ROW EXECUTE PROCEDURE search_release_delete_7_country_dates_country();

CREATE TRIGGER search_release_insert_7_country_dates_country AFTER INSERT ON country_area
    FOR EACH ROW EXECUTE PROCEDURE search_release_insert_7_country_dates_country();

CREATE TRIGGER search_release_update_7_country_dates_country AFTER UPDATE ON country_area
    FOR EACH ROW EXECUTE PROCEDURE search_release_update_7_country_dates_country();

CREATE TRIGGER search_release_delete_8_country_dates_country_area BEFORE DELETE ON area
    FOR EACH ROW EXECUTE PROCEDURE search_release_delete_8_country_dates_country_area();

CREATE TRIGGER search_release_insert_8_country_dates_country_area AFTER INSERT ON area
    FOR EACH ROW EXECUTE PROCEDURE search_release_insert_8_country_dates_country_area();

CREATE TRIGGER search_release_update_8_country_dates_country_area AFTER UPDATE ON area
    FOR EACH ROW EXECUTE PROCEDURE search_release_update_8_country_dates_country_area();

CREATE TRIGGER search_release_delete_11_language BEFORE DELETE ON language
    FOR EACH ROW EXECUTE PROCEDURE search_release_delete_11_language();

CREATE TRIGGER search_release_insert_11_language AFTER INSERT ON language
    FOR EACH ROW EXECUTE PROCEDURE search_release_insert_11_language();

CREATE TRIGGER search_release_update_11_language AFTER UPDATE ON language
    FOR EACH ROW EXECUTE PROCEDURE search_release_update_11_language();

CREATE TRIGGER search_release_delete_13_script BEFORE DELETE ON script
    FOR EACH ROW EXECUTE PROCEDURE search_release_delete_13_script();

CREATE TRIGGER search_release_insert_13_script AFTER INSERT ON script
    FOR EACH ROW EXECUTE PROCEDURE search_release_insert_13_script();

CREATE TRIGGER search_release_update_13_script AFTER UPDATE ON script
    FOR EACH ROW EXECUTE PROCEDURE search_release_update_13_script();

CREATE TRIGGER search_release_group_delete_direct BEFORE DELETE ON release_group
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_delete_direct();

CREATE TRIGGER search_release_group_insert_direct AFTER INSERT ON release_group
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_insert_direct();

CREATE TRIGGER search_release_group_update_direct AFTER UPDATE ON release_group
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_update_direct();

CREATE TRIGGER search_release_group_delete_2_releases BEFORE DELETE ON release
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_delete_2_releases();

CREATE TRIGGER search_release_group_insert_2_releases AFTER INSERT ON release
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_insert_2_releases();

CREATE TRIGGER search_release_group_update_2_releases AFTER UPDATE ON release
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_update_2_releases();

CREATE TRIGGER search_release_group_delete_4_artist_credit BEFORE DELETE ON artist_credit
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_delete_4_artist_credit();

CREATE TRIGGER search_release_group_insert_4_artist_credit AFTER INSERT ON artist_credit
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_insert_4_artist_credit();

CREATE TRIGGER search_release_group_update_4_artist_credit AFTER UPDATE ON artist_credit
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_update_4_artist_credit();

CREATE TRIGGER search_release_group_delete_5_artist_credit_artists BEFORE DELETE ON artist_credit_name
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_delete_5_artist_credit_artists();

CREATE TRIGGER search_release_group_insert_5_artist_credit_artists AFTER INSERT ON artist_credit_name
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_insert_5_artist_credit_artists();

CREATE TRIGGER search_release_group_update_5_artist_credit_artists AFTER UPDATE ON artist_credit_name
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_update_5_artist_credit_artists();

CREATE TRIGGER search_release_group_delete_6_artist_credit_artists_artist BEFORE DELETE ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_delete_6_artist_credit_artists_artist();

CREATE TRIGGER search_release_group_insert_6_artist_credit_artists_artist AFTER INSERT ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_insert_6_artist_credit_artists_artist();

CREATE TRIGGER search_release_group_update_6_artist_credit_artists_artist AFTER UPDATE ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_update_6_artist_credit_artists_artist();
COMMIT;

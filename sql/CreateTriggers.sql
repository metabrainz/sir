-- Automatically generated, do not edit
\set ON_ERROR_STOP 1
BEGIN;

CREATE TRIGGER search_annotation_delete_0 BEFORE DELETE ON annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_delete_0();
COMMENT ON TRIGGER search_annotation_delete_0 ON annotation IS 'The path for this trigger is direct';

CREATE TRIGGER search_annotation_insert_0 AFTER INSERT ON annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_insert_0();
COMMENT ON TRIGGER search_annotation_insert_0 ON annotation IS 'The path for this trigger is direct';

CREATE TRIGGER search_annotation_update_0 AFTER UPDATE ON annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_update_0();
COMMENT ON TRIGGER search_annotation_update_0 ON annotation IS 'The path for this trigger is direct';

CREATE TRIGGER search_annotation_delete_1 BEFORE DELETE ON area_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_delete_1();
COMMENT ON TRIGGER search_annotation_delete_1 ON area_annotation IS 'The path for this trigger is areas';

CREATE TRIGGER search_annotation_insert_1 AFTER INSERT ON area_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_insert_1();
COMMENT ON TRIGGER search_annotation_insert_1 ON area_annotation IS 'The path for this trigger is areas';

CREATE TRIGGER search_annotation_update_1 AFTER UPDATE ON area_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_update_1();
COMMENT ON TRIGGER search_annotation_update_1 ON area_annotation IS 'The path for this trigger is areas';

CREATE TRIGGER search_annotation_delete_2 BEFORE DELETE ON area
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_delete_2();
COMMENT ON TRIGGER search_annotation_delete_2 ON area IS 'The path for this trigger is areas.area';

CREATE TRIGGER search_annotation_insert_2 AFTER INSERT ON area
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_insert_2();
COMMENT ON TRIGGER search_annotation_insert_2 ON area IS 'The path for this trigger is areas.area';

CREATE TRIGGER search_annotation_update_2 AFTER UPDATE ON area
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_update_2();
COMMENT ON TRIGGER search_annotation_update_2 ON area IS 'The path for this trigger is areas.area';

CREATE TRIGGER search_annotation_delete_3 BEFORE DELETE ON artist_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_delete_3();
COMMENT ON TRIGGER search_annotation_delete_3 ON artist_annotation IS 'The path for this trigger is artists';

CREATE TRIGGER search_annotation_insert_3 AFTER INSERT ON artist_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_insert_3();
COMMENT ON TRIGGER search_annotation_insert_3 ON artist_annotation IS 'The path for this trigger is artists';

CREATE TRIGGER search_annotation_update_3 AFTER UPDATE ON artist_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_update_3();
COMMENT ON TRIGGER search_annotation_update_3 ON artist_annotation IS 'The path for this trigger is artists';

CREATE TRIGGER search_annotation_delete_4 BEFORE DELETE ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_delete_4();
COMMENT ON TRIGGER search_annotation_delete_4 ON artist IS 'The path for this trigger is artists.artist';

CREATE TRIGGER search_annotation_insert_4 AFTER INSERT ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_insert_4();
COMMENT ON TRIGGER search_annotation_insert_4 ON artist IS 'The path for this trigger is artists.artist';

CREATE TRIGGER search_annotation_update_4 AFTER UPDATE ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_update_4();
COMMENT ON TRIGGER search_annotation_update_4 ON artist IS 'The path for this trigger is artists.artist';

CREATE TRIGGER search_annotation_delete_5 BEFORE DELETE ON event_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_delete_5();
COMMENT ON TRIGGER search_annotation_delete_5 ON event_annotation IS 'The path for this trigger is events';

CREATE TRIGGER search_annotation_insert_5 AFTER INSERT ON event_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_insert_5();
COMMENT ON TRIGGER search_annotation_insert_5 ON event_annotation IS 'The path for this trigger is events';

CREATE TRIGGER search_annotation_update_5 AFTER UPDATE ON event_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_update_5();
COMMENT ON TRIGGER search_annotation_update_5 ON event_annotation IS 'The path for this trigger is events';

CREATE TRIGGER search_annotation_delete_6 BEFORE DELETE ON event
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_delete_6();
COMMENT ON TRIGGER search_annotation_delete_6 ON event IS 'The path for this trigger is events.event';

CREATE TRIGGER search_annotation_insert_6 AFTER INSERT ON event
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_insert_6();
COMMENT ON TRIGGER search_annotation_insert_6 ON event IS 'The path for this trigger is events.event';

CREATE TRIGGER search_annotation_update_6 AFTER UPDATE ON event
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_update_6();
COMMENT ON TRIGGER search_annotation_update_6 ON event IS 'The path for this trigger is events.event';

CREATE TRIGGER search_annotation_delete_7 BEFORE DELETE ON instrument_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_delete_7();
COMMENT ON TRIGGER search_annotation_delete_7 ON instrument_annotation IS 'The path for this trigger is instruments';

CREATE TRIGGER search_annotation_insert_7 AFTER INSERT ON instrument_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_insert_7();
COMMENT ON TRIGGER search_annotation_insert_7 ON instrument_annotation IS 'The path for this trigger is instruments';

CREATE TRIGGER search_annotation_update_7 AFTER UPDATE ON instrument_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_update_7();
COMMENT ON TRIGGER search_annotation_update_7 ON instrument_annotation IS 'The path for this trigger is instruments';

CREATE TRIGGER search_annotation_delete_8 BEFORE DELETE ON instrument
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_delete_8();
COMMENT ON TRIGGER search_annotation_delete_8 ON instrument IS 'The path for this trigger is instruments.instrument';

CREATE TRIGGER search_annotation_insert_8 AFTER INSERT ON instrument
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_insert_8();
COMMENT ON TRIGGER search_annotation_insert_8 ON instrument IS 'The path for this trigger is instruments.instrument';

CREATE TRIGGER search_annotation_update_8 AFTER UPDATE ON instrument
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_update_8();
COMMENT ON TRIGGER search_annotation_update_8 ON instrument IS 'The path for this trigger is instruments.instrument';

CREATE TRIGGER search_annotation_delete_9 BEFORE DELETE ON label_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_delete_9();
COMMENT ON TRIGGER search_annotation_delete_9 ON label_annotation IS 'The path for this trigger is labels';

CREATE TRIGGER search_annotation_insert_9 AFTER INSERT ON label_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_insert_9();
COMMENT ON TRIGGER search_annotation_insert_9 ON label_annotation IS 'The path for this trigger is labels';

CREATE TRIGGER search_annotation_update_9 AFTER UPDATE ON label_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_update_9();
COMMENT ON TRIGGER search_annotation_update_9 ON label_annotation IS 'The path for this trigger is labels';

CREATE TRIGGER search_annotation_delete_10 BEFORE DELETE ON label
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_delete_10();
COMMENT ON TRIGGER search_annotation_delete_10 ON label IS 'The path for this trigger is labels.label';

CREATE TRIGGER search_annotation_insert_10 AFTER INSERT ON label
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_insert_10();
COMMENT ON TRIGGER search_annotation_insert_10 ON label IS 'The path for this trigger is labels.label';

CREATE TRIGGER search_annotation_update_10 AFTER UPDATE ON label
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_update_10();
COMMENT ON TRIGGER search_annotation_update_10 ON label IS 'The path for this trigger is labels.label';

CREATE TRIGGER search_annotation_delete_11 BEFORE DELETE ON place_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_delete_11();
COMMENT ON TRIGGER search_annotation_delete_11 ON place_annotation IS 'The path for this trigger is places';

CREATE TRIGGER search_annotation_insert_11 AFTER INSERT ON place_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_insert_11();
COMMENT ON TRIGGER search_annotation_insert_11 ON place_annotation IS 'The path for this trigger is places';

CREATE TRIGGER search_annotation_update_11 AFTER UPDATE ON place_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_update_11();
COMMENT ON TRIGGER search_annotation_update_11 ON place_annotation IS 'The path for this trigger is places';

CREATE TRIGGER search_annotation_delete_12 BEFORE DELETE ON place
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_delete_12();
COMMENT ON TRIGGER search_annotation_delete_12 ON place IS 'The path for this trigger is places.place';

CREATE TRIGGER search_annotation_insert_12 AFTER INSERT ON place
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_insert_12();
COMMENT ON TRIGGER search_annotation_insert_12 ON place IS 'The path for this trigger is places.place';

CREATE TRIGGER search_annotation_update_12 AFTER UPDATE ON place
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_update_12();
COMMENT ON TRIGGER search_annotation_update_12 ON place IS 'The path for this trigger is places.place';

CREATE TRIGGER search_annotation_delete_13 BEFORE DELETE ON recording_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_delete_13();
COMMENT ON TRIGGER search_annotation_delete_13 ON recording_annotation IS 'The path for this trigger is recordings';

CREATE TRIGGER search_annotation_insert_13 AFTER INSERT ON recording_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_insert_13();
COMMENT ON TRIGGER search_annotation_insert_13 ON recording_annotation IS 'The path for this trigger is recordings';

CREATE TRIGGER search_annotation_update_13 AFTER UPDATE ON recording_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_update_13();
COMMENT ON TRIGGER search_annotation_update_13 ON recording_annotation IS 'The path for this trigger is recordings';

CREATE TRIGGER search_annotation_delete_14 BEFORE DELETE ON recording
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_delete_14();
COMMENT ON TRIGGER search_annotation_delete_14 ON recording IS 'The path for this trigger is recordings.recording';

CREATE TRIGGER search_annotation_insert_14 AFTER INSERT ON recording
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_insert_14();
COMMENT ON TRIGGER search_annotation_insert_14 ON recording IS 'The path for this trigger is recordings.recording';

CREATE TRIGGER search_annotation_update_14 AFTER UPDATE ON recording
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_update_14();
COMMENT ON TRIGGER search_annotation_update_14 ON recording IS 'The path for this trigger is recordings.recording';

CREATE TRIGGER search_annotation_delete_15 BEFORE DELETE ON release_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_delete_15();
COMMENT ON TRIGGER search_annotation_delete_15 ON release_annotation IS 'The path for this trigger is releases';

CREATE TRIGGER search_annotation_insert_15 AFTER INSERT ON release_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_insert_15();
COMMENT ON TRIGGER search_annotation_insert_15 ON release_annotation IS 'The path for this trigger is releases';

CREATE TRIGGER search_annotation_update_15 AFTER UPDATE ON release_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_update_15();
COMMENT ON TRIGGER search_annotation_update_15 ON release_annotation IS 'The path for this trigger is releases';

CREATE TRIGGER search_annotation_delete_16 BEFORE DELETE ON release
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_delete_16();
COMMENT ON TRIGGER search_annotation_delete_16 ON release IS 'The path for this trigger is releases.release';

CREATE TRIGGER search_annotation_insert_16 AFTER INSERT ON release
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_insert_16();
COMMENT ON TRIGGER search_annotation_insert_16 ON release IS 'The path for this trigger is releases.release';

CREATE TRIGGER search_annotation_update_16 AFTER UPDATE ON release
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_update_16();
COMMENT ON TRIGGER search_annotation_update_16 ON release IS 'The path for this trigger is releases.release';

CREATE TRIGGER search_annotation_delete_17 BEFORE DELETE ON release_group_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_delete_17();
COMMENT ON TRIGGER search_annotation_delete_17 ON release_group_annotation IS 'The path for this trigger is release_groups';

CREATE TRIGGER search_annotation_insert_17 AFTER INSERT ON release_group_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_insert_17();
COMMENT ON TRIGGER search_annotation_insert_17 ON release_group_annotation IS 'The path for this trigger is release_groups';

CREATE TRIGGER search_annotation_update_17 AFTER UPDATE ON release_group_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_update_17();
COMMENT ON TRIGGER search_annotation_update_17 ON release_group_annotation IS 'The path for this trigger is release_groups';

CREATE TRIGGER search_annotation_delete_18 BEFORE DELETE ON release_group
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_delete_18();
COMMENT ON TRIGGER search_annotation_delete_18 ON release_group IS 'The path for this trigger is release_groups.release_group';

CREATE TRIGGER search_annotation_insert_18 AFTER INSERT ON release_group
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_insert_18();
COMMENT ON TRIGGER search_annotation_insert_18 ON release_group IS 'The path for this trigger is release_groups.release_group';

CREATE TRIGGER search_annotation_update_18 AFTER UPDATE ON release_group
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_update_18();
COMMENT ON TRIGGER search_annotation_update_18 ON release_group IS 'The path for this trigger is release_groups.release_group';

CREATE TRIGGER search_annotation_delete_19 BEFORE DELETE ON series_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_delete_19();
COMMENT ON TRIGGER search_annotation_delete_19 ON series_annotation IS 'The path for this trigger is series';

CREATE TRIGGER search_annotation_insert_19 AFTER INSERT ON series_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_insert_19();
COMMENT ON TRIGGER search_annotation_insert_19 ON series_annotation IS 'The path for this trigger is series';

CREATE TRIGGER search_annotation_update_19 AFTER UPDATE ON series_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_update_19();
COMMENT ON TRIGGER search_annotation_update_19 ON series_annotation IS 'The path for this trigger is series';

CREATE TRIGGER search_annotation_delete_20 BEFORE DELETE ON series
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_delete_20();
COMMENT ON TRIGGER search_annotation_delete_20 ON series IS 'The path for this trigger is series.series';

CREATE TRIGGER search_annotation_insert_20 AFTER INSERT ON series
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_insert_20();
COMMENT ON TRIGGER search_annotation_insert_20 ON series IS 'The path for this trigger is series.series';

CREATE TRIGGER search_annotation_update_20 AFTER UPDATE ON series
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_update_20();
COMMENT ON TRIGGER search_annotation_update_20 ON series IS 'The path for this trigger is series.series';

CREATE TRIGGER search_annotation_delete_21 BEFORE DELETE ON work_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_delete_21();
COMMENT ON TRIGGER search_annotation_delete_21 ON work_annotation IS 'The path for this trigger is works';

CREATE TRIGGER search_annotation_insert_21 AFTER INSERT ON work_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_insert_21();
COMMENT ON TRIGGER search_annotation_insert_21 ON work_annotation IS 'The path for this trigger is works';

CREATE TRIGGER search_annotation_update_21 AFTER UPDATE ON work_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_update_21();
COMMENT ON TRIGGER search_annotation_update_21 ON work_annotation IS 'The path for this trigger is works';

CREATE TRIGGER search_annotation_delete_22 BEFORE DELETE ON work
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_delete_22();
COMMENT ON TRIGGER search_annotation_delete_22 ON work IS 'The path for this trigger is works.work';

CREATE TRIGGER search_annotation_insert_22 AFTER INSERT ON work
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_insert_22();
COMMENT ON TRIGGER search_annotation_insert_22 ON work IS 'The path for this trigger is works.work';

CREATE TRIGGER search_annotation_update_22 AFTER UPDATE ON work
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_update_22();
COMMENT ON TRIGGER search_annotation_update_22 ON work IS 'The path for this trigger is works.work';

CREATE TRIGGER search_area_delete_0 BEFORE DELETE ON area
    FOR EACH ROW EXECUTE PROCEDURE search_area_delete_0();
COMMENT ON TRIGGER search_area_delete_0 ON area IS 'The path for this trigger is direct';

CREATE TRIGGER search_area_insert_0 AFTER INSERT ON area
    FOR EACH ROW EXECUTE PROCEDURE search_area_insert_0();
COMMENT ON TRIGGER search_area_insert_0 ON area IS 'The path for this trigger is direct';

CREATE TRIGGER search_area_update_0 AFTER UPDATE ON area
    FOR EACH ROW EXECUTE PROCEDURE search_area_update_0();
COMMENT ON TRIGGER search_area_update_0 ON area IS 'The path for this trigger is direct';

CREATE TRIGGER search_area_delete_1 BEFORE DELETE ON area_alias
    FOR EACH ROW EXECUTE PROCEDURE search_area_delete_1();
COMMENT ON TRIGGER search_area_delete_1 ON area_alias IS 'The path for this trigger is aliases';

CREATE TRIGGER search_area_insert_1 AFTER INSERT ON area_alias
    FOR EACH ROW EXECUTE PROCEDURE search_area_insert_1();
COMMENT ON TRIGGER search_area_insert_1 ON area_alias IS 'The path for this trigger is aliases';

CREATE TRIGGER search_area_update_1 AFTER UPDATE ON area_alias
    FOR EACH ROW EXECUTE PROCEDURE search_area_update_1();
COMMENT ON TRIGGER search_area_update_1 ON area_alias IS 'The path for this trigger is aliases';

CREATE TRIGGER search_area_delete_2 BEFORE DELETE ON iso_3166_1
    FOR EACH ROW EXECUTE PROCEDURE search_area_delete_2();
COMMENT ON TRIGGER search_area_delete_2 ON iso_3166_1 IS 'The path for this trigger is iso_3166_1_codes';

CREATE TRIGGER search_area_insert_2 AFTER INSERT ON iso_3166_1
    FOR EACH ROW EXECUTE PROCEDURE search_area_insert_2();
COMMENT ON TRIGGER search_area_insert_2 ON iso_3166_1 IS 'The path for this trigger is iso_3166_1_codes';

CREATE TRIGGER search_area_update_2 AFTER UPDATE ON iso_3166_1
    FOR EACH ROW EXECUTE PROCEDURE search_area_update_2();
COMMENT ON TRIGGER search_area_update_2 ON iso_3166_1 IS 'The path for this trigger is iso_3166_1_codes';

CREATE TRIGGER search_area_delete_3 BEFORE DELETE ON iso_3166_2
    FOR EACH ROW EXECUTE PROCEDURE search_area_delete_3();
COMMENT ON TRIGGER search_area_delete_3 ON iso_3166_2 IS 'The path for this trigger is iso_3166_2_codes';

CREATE TRIGGER search_area_insert_3 AFTER INSERT ON iso_3166_2
    FOR EACH ROW EXECUTE PROCEDURE search_area_insert_3();
COMMENT ON TRIGGER search_area_insert_3 ON iso_3166_2 IS 'The path for this trigger is iso_3166_2_codes';

CREATE TRIGGER search_area_update_3 AFTER UPDATE ON iso_3166_2
    FOR EACH ROW EXECUTE PROCEDURE search_area_update_3();
COMMENT ON TRIGGER search_area_update_3 ON iso_3166_2 IS 'The path for this trigger is iso_3166_2_codes';

CREATE TRIGGER search_area_delete_4 BEFORE DELETE ON iso_3166_3
    FOR EACH ROW EXECUTE PROCEDURE search_area_delete_4();
COMMENT ON TRIGGER search_area_delete_4 ON iso_3166_3 IS 'The path for this trigger is iso_3166_3_codes';

CREATE TRIGGER search_area_insert_4 AFTER INSERT ON iso_3166_3
    FOR EACH ROW EXECUTE PROCEDURE search_area_insert_4();
COMMENT ON TRIGGER search_area_insert_4 ON iso_3166_3 IS 'The path for this trigger is iso_3166_3_codes';

CREATE TRIGGER search_area_update_4 AFTER UPDATE ON iso_3166_3
    FOR EACH ROW EXECUTE PROCEDURE search_area_update_4();
COMMENT ON TRIGGER search_area_update_4 ON iso_3166_3 IS 'The path for this trigger is iso_3166_3_codes';

CREATE TRIGGER search_area_delete_5 BEFORE DELETE ON area_type
    FOR EACH ROW EXECUTE PROCEDURE search_area_delete_5();
COMMENT ON TRIGGER search_area_delete_5 ON area_type IS 'The path for this trigger is type';

CREATE TRIGGER search_area_insert_5 AFTER INSERT ON area_type
    FOR EACH ROW EXECUTE PROCEDURE search_area_insert_5();
COMMENT ON TRIGGER search_area_insert_5 ON area_type IS 'The path for this trigger is type';

CREATE TRIGGER search_area_update_5 AFTER UPDATE ON area_type
    FOR EACH ROW EXECUTE PROCEDURE search_area_update_5();
COMMENT ON TRIGGER search_area_update_5 ON area_type IS 'The path for this trigger is type';

CREATE TRIGGER search_artist_delete_0 BEFORE DELETE ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_artist_delete_0();
COMMENT ON TRIGGER search_artist_delete_0 ON artist IS 'The path for this trigger is direct';

CREATE TRIGGER search_artist_insert_0 AFTER INSERT ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_artist_insert_0();
COMMENT ON TRIGGER search_artist_insert_0 ON artist IS 'The path for this trigger is direct';

CREATE TRIGGER search_artist_update_0 AFTER UPDATE ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_artist_update_0();
COMMENT ON TRIGGER search_artist_update_0 ON artist IS 'The path for this trigger is direct';

CREATE TRIGGER search_artist_delete_1 BEFORE DELETE ON artist_alias
    FOR EACH ROW EXECUTE PROCEDURE search_artist_delete_1();
COMMENT ON TRIGGER search_artist_delete_1 ON artist_alias IS 'The path for this trigger is aliases';

CREATE TRIGGER search_artist_insert_1 AFTER INSERT ON artist_alias
    FOR EACH ROW EXECUTE PROCEDURE search_artist_insert_1();
COMMENT ON TRIGGER search_artist_insert_1 ON artist_alias IS 'The path for this trigger is aliases';

CREATE TRIGGER search_artist_update_1 AFTER UPDATE ON artist_alias
    FOR EACH ROW EXECUTE PROCEDURE search_artist_update_1();
COMMENT ON TRIGGER search_artist_update_1 ON artist_alias IS 'The path for this trigger is aliases';

CREATE TRIGGER search_artist_delete_2 BEFORE DELETE ON area
    FOR EACH ROW EXECUTE PROCEDURE search_artist_delete_2();
COMMENT ON TRIGGER search_artist_delete_2 ON area IS 'The path for this trigger is area';

CREATE TRIGGER search_artist_insert_2 AFTER INSERT ON area
    FOR EACH ROW EXECUTE PROCEDURE search_artist_insert_2();
COMMENT ON TRIGGER search_artist_insert_2 ON area IS 'The path for this trigger is area';

CREATE TRIGGER search_artist_update_2 AFTER UPDATE ON area
    FOR EACH ROW EXECUTE PROCEDURE search_artist_update_2();
COMMENT ON TRIGGER search_artist_update_2 ON area IS 'The path for this trigger is area';

CREATE TRIGGER search_artist_delete_3 BEFORE DELETE ON area_alias
    FOR EACH ROW EXECUTE PROCEDURE search_artist_delete_3();
COMMENT ON TRIGGER search_artist_delete_3 ON area_alias IS 'The path for this trigger is area.aliases';

CREATE TRIGGER search_artist_insert_3 AFTER INSERT ON area_alias
    FOR EACH ROW EXECUTE PROCEDURE search_artist_insert_3();
COMMENT ON TRIGGER search_artist_insert_3 ON area_alias IS 'The path for this trigger is area.aliases';

CREATE TRIGGER search_artist_update_3 AFTER UPDATE ON area_alias
    FOR EACH ROW EXECUTE PROCEDURE search_artist_update_3();
COMMENT ON TRIGGER search_artist_update_3 ON area_alias IS 'The path for this trigger is area.aliases';

CREATE TRIGGER search_artist_delete_4 BEFORE DELETE ON area
    FOR EACH ROW EXECUTE PROCEDURE search_artist_delete_4();
COMMENT ON TRIGGER search_artist_delete_4 ON area IS 'The path for this trigger is begin_area';

CREATE TRIGGER search_artist_insert_4 AFTER INSERT ON area
    FOR EACH ROW EXECUTE PROCEDURE search_artist_insert_4();
COMMENT ON TRIGGER search_artist_insert_4 ON area IS 'The path for this trigger is begin_area';

CREATE TRIGGER search_artist_update_4 AFTER UPDATE ON area
    FOR EACH ROW EXECUTE PROCEDURE search_artist_update_4();
COMMENT ON TRIGGER search_artist_update_4 ON area IS 'The path for this trigger is begin_area';

CREATE TRIGGER search_artist_delete_5 BEFORE DELETE ON area_alias
    FOR EACH ROW EXECUTE PROCEDURE search_artist_delete_5();
COMMENT ON TRIGGER search_artist_delete_5 ON area_alias IS 'The path for this trigger is begin_area.aliases';

CREATE TRIGGER search_artist_insert_5 AFTER INSERT ON area_alias
    FOR EACH ROW EXECUTE PROCEDURE search_artist_insert_5();
COMMENT ON TRIGGER search_artist_insert_5 ON area_alias IS 'The path for this trigger is begin_area.aliases';

CREATE TRIGGER search_artist_update_5 AFTER UPDATE ON area_alias
    FOR EACH ROW EXECUTE PROCEDURE search_artist_update_5();
COMMENT ON TRIGGER search_artist_update_5 ON area_alias IS 'The path for this trigger is begin_area.aliases';

CREATE TRIGGER search_artist_delete_6 BEFORE DELETE ON iso_3166_1
    FOR EACH ROW EXECUTE PROCEDURE search_artist_delete_6();
COMMENT ON TRIGGER search_artist_delete_6 ON iso_3166_1 IS 'The path for this trigger is area.iso_3166_1_codes';

CREATE TRIGGER search_artist_insert_6 AFTER INSERT ON iso_3166_1
    FOR EACH ROW EXECUTE PROCEDURE search_artist_insert_6();
COMMENT ON TRIGGER search_artist_insert_6 ON iso_3166_1 IS 'The path for this trigger is area.iso_3166_1_codes';

CREATE TRIGGER search_artist_update_6 AFTER UPDATE ON iso_3166_1
    FOR EACH ROW EXECUTE PROCEDURE search_artist_update_6();
COMMENT ON TRIGGER search_artist_update_6 ON iso_3166_1 IS 'The path for this trigger is area.iso_3166_1_codes';

CREATE TRIGGER search_artist_delete_7 BEFORE DELETE ON area
    FOR EACH ROW EXECUTE PROCEDURE search_artist_delete_7();
COMMENT ON TRIGGER search_artist_delete_7 ON area IS 'The path for this trigger is end_area';

CREATE TRIGGER search_artist_insert_7 AFTER INSERT ON area
    FOR EACH ROW EXECUTE PROCEDURE search_artist_insert_7();
COMMENT ON TRIGGER search_artist_insert_7 ON area IS 'The path for this trigger is end_area';

CREATE TRIGGER search_artist_update_7 AFTER UPDATE ON area
    FOR EACH ROW EXECUTE PROCEDURE search_artist_update_7();
COMMENT ON TRIGGER search_artist_update_7 ON area IS 'The path for this trigger is end_area';

CREATE TRIGGER search_artist_delete_8 BEFORE DELETE ON area_alias
    FOR EACH ROW EXECUTE PROCEDURE search_artist_delete_8();
COMMENT ON TRIGGER search_artist_delete_8 ON area_alias IS 'The path for this trigger is end_area.aliases';

CREATE TRIGGER search_artist_insert_8 AFTER INSERT ON area_alias
    FOR EACH ROW EXECUTE PROCEDURE search_artist_insert_8();
COMMENT ON TRIGGER search_artist_insert_8 ON area_alias IS 'The path for this trigger is end_area.aliases';

CREATE TRIGGER search_artist_update_8 AFTER UPDATE ON area_alias
    FOR EACH ROW EXECUTE PROCEDURE search_artist_update_8();
COMMENT ON TRIGGER search_artist_update_8 ON area_alias IS 'The path for this trigger is end_area.aliases';

CREATE TRIGGER search_artist_delete_9 BEFORE DELETE ON gender
    FOR EACH ROW EXECUTE PROCEDURE search_artist_delete_9();
COMMENT ON TRIGGER search_artist_delete_9 ON gender IS 'The path for this trigger is gender';

CREATE TRIGGER search_artist_insert_9 AFTER INSERT ON gender
    FOR EACH ROW EXECUTE PROCEDURE search_artist_insert_9();
COMMENT ON TRIGGER search_artist_insert_9 ON gender IS 'The path for this trigger is gender';

CREATE TRIGGER search_artist_update_9 AFTER UPDATE ON gender
    FOR EACH ROW EXECUTE PROCEDURE search_artist_update_9();
COMMENT ON TRIGGER search_artist_update_9 ON gender IS 'The path for this trigger is gender';

CREATE TRIGGER search_artist_delete_10 BEFORE DELETE ON artist_ipi
    FOR EACH ROW EXECUTE PROCEDURE search_artist_delete_10();
COMMENT ON TRIGGER search_artist_delete_10 ON artist_ipi IS 'The path for this trigger is ipis';

CREATE TRIGGER search_artist_insert_10 AFTER INSERT ON artist_ipi
    FOR EACH ROW EXECUTE PROCEDURE search_artist_insert_10();
COMMENT ON TRIGGER search_artist_insert_10 ON artist_ipi IS 'The path for this trigger is ipis';

CREATE TRIGGER search_artist_update_10 AFTER UPDATE ON artist_ipi
    FOR EACH ROW EXECUTE PROCEDURE search_artist_update_10();
COMMENT ON TRIGGER search_artist_update_10 ON artist_ipi IS 'The path for this trigger is ipis';

CREATE TRIGGER search_artist_delete_11 BEFORE DELETE ON artist_isni
    FOR EACH ROW EXECUTE PROCEDURE search_artist_delete_11();
COMMENT ON TRIGGER search_artist_delete_11 ON artist_isni IS 'The path for this trigger is isnis';

CREATE TRIGGER search_artist_insert_11 AFTER INSERT ON artist_isni
    FOR EACH ROW EXECUTE PROCEDURE search_artist_insert_11();
COMMENT ON TRIGGER search_artist_insert_11 ON artist_isni IS 'The path for this trigger is isnis';

CREATE TRIGGER search_artist_update_11 AFTER UPDATE ON artist_isni
    FOR EACH ROW EXECUTE PROCEDURE search_artist_update_11();
COMMENT ON TRIGGER search_artist_update_11 ON artist_isni IS 'The path for this trigger is isnis';

CREATE TRIGGER search_artist_delete_12 BEFORE DELETE ON artist_tag
    FOR EACH ROW EXECUTE PROCEDURE search_artist_delete_12();
COMMENT ON TRIGGER search_artist_delete_12 ON artist_tag IS 'The path for this trigger is tags';

CREATE TRIGGER search_artist_insert_12 AFTER INSERT ON artist_tag
    FOR EACH ROW EXECUTE PROCEDURE search_artist_insert_12();
COMMENT ON TRIGGER search_artist_insert_12 ON artist_tag IS 'The path for this trigger is tags';

CREATE TRIGGER search_artist_update_12 AFTER UPDATE ON artist_tag
    FOR EACH ROW EXECUTE PROCEDURE search_artist_update_12();
COMMENT ON TRIGGER search_artist_update_12 ON artist_tag IS 'The path for this trigger is tags';

CREATE TRIGGER search_artist_delete_13 BEFORE DELETE ON tag
    FOR EACH ROW EXECUTE PROCEDURE search_artist_delete_13();
COMMENT ON TRIGGER search_artist_delete_13 ON tag IS 'The path for this trigger is tags.tag';

CREATE TRIGGER search_artist_insert_13 AFTER INSERT ON tag
    FOR EACH ROW EXECUTE PROCEDURE search_artist_insert_13();
COMMENT ON TRIGGER search_artist_insert_13 ON tag IS 'The path for this trigger is tags.tag';

CREATE TRIGGER search_artist_update_13 AFTER UPDATE ON tag
    FOR EACH ROW EXECUTE PROCEDURE search_artist_update_13();
COMMENT ON TRIGGER search_artist_update_13 ON tag IS 'The path for this trigger is tags.tag';

CREATE TRIGGER search_artist_delete_14 BEFORE DELETE ON artist_credit_name
    FOR EACH ROW EXECUTE PROCEDURE search_artist_delete_14();
COMMENT ON TRIGGER search_artist_delete_14 ON artist_credit_name IS 'The path for this trigger is artist_credit_names';

CREATE TRIGGER search_artist_insert_14 AFTER INSERT ON artist_credit_name
    FOR EACH ROW EXECUTE PROCEDURE search_artist_insert_14();
COMMENT ON TRIGGER search_artist_insert_14 ON artist_credit_name IS 'The path for this trigger is artist_credit_names';

CREATE TRIGGER search_artist_update_14 AFTER UPDATE ON artist_credit_name
    FOR EACH ROW EXECUTE PROCEDURE search_artist_update_14();
COMMENT ON TRIGGER search_artist_update_14 ON artist_credit_name IS 'The path for this trigger is artist_credit_names';

CREATE TRIGGER search_artist_delete_15 BEFORE DELETE ON artist_credit
    FOR EACH ROW EXECUTE PROCEDURE search_artist_delete_15();
COMMENT ON TRIGGER search_artist_delete_15 ON artist_credit IS 'The path for this trigger is artist_credit_names.artist_credit';

CREATE TRIGGER search_artist_insert_15 AFTER INSERT ON artist_credit
    FOR EACH ROW EXECUTE PROCEDURE search_artist_insert_15();
COMMENT ON TRIGGER search_artist_insert_15 ON artist_credit IS 'The path for this trigger is artist_credit_names.artist_credit';

CREATE TRIGGER search_artist_update_15 AFTER UPDATE ON artist_credit
    FOR EACH ROW EXECUTE PROCEDURE search_artist_update_15();
COMMENT ON TRIGGER search_artist_update_15 ON artist_credit IS 'The path for this trigger is artist_credit_names.artist_credit';

CREATE TRIGGER search_artist_delete_16 BEFORE DELETE ON artist_type
    FOR EACH ROW EXECUTE PROCEDURE search_artist_delete_16();
COMMENT ON TRIGGER search_artist_delete_16 ON artist_type IS 'The path for this trigger is type';

CREATE TRIGGER search_artist_insert_16 AFTER INSERT ON artist_type
    FOR EACH ROW EXECUTE PROCEDURE search_artist_insert_16();
COMMENT ON TRIGGER search_artist_insert_16 ON artist_type IS 'The path for this trigger is type';

CREATE TRIGGER search_artist_update_16 AFTER UPDATE ON artist_type
    FOR EACH ROW EXECUTE PROCEDURE search_artist_update_16();
COMMENT ON TRIGGER search_artist_update_16 ON artist_type IS 'The path for this trigger is type';

CREATE TRIGGER search_cdstub_delete_0 BEFORE DELETE ON release_raw
    FOR EACH ROW EXECUTE PROCEDURE search_cdstub_delete_0();
COMMENT ON TRIGGER search_cdstub_delete_0 ON release_raw IS 'The path for this trigger is direct';

CREATE TRIGGER search_cdstub_insert_0 AFTER INSERT ON release_raw
    FOR EACH ROW EXECUTE PROCEDURE search_cdstub_insert_0();
COMMENT ON TRIGGER search_cdstub_insert_0 ON release_raw IS 'The path for this trigger is direct';

CREATE TRIGGER search_cdstub_update_0 AFTER UPDATE ON release_raw
    FOR EACH ROW EXECUTE PROCEDURE search_cdstub_update_0();
COMMENT ON TRIGGER search_cdstub_update_0 ON release_raw IS 'The path for this trigger is direct';

CREATE TRIGGER search_cdstub_delete_1 BEFORE DELETE ON cdtoc_raw
    FOR EACH ROW EXECUTE PROCEDURE search_cdstub_delete_1();
COMMENT ON TRIGGER search_cdstub_delete_1 ON cdtoc_raw IS 'The path for this trigger is discids';

CREATE TRIGGER search_cdstub_insert_1 AFTER INSERT ON cdtoc_raw
    FOR EACH ROW EXECUTE PROCEDURE search_cdstub_insert_1();
COMMENT ON TRIGGER search_cdstub_insert_1 ON cdtoc_raw IS 'The path for this trigger is discids';

CREATE TRIGGER search_cdstub_update_1 AFTER UPDATE ON cdtoc_raw
    FOR EACH ROW EXECUTE PROCEDURE search_cdstub_update_1();
COMMENT ON TRIGGER search_cdstub_update_1 ON cdtoc_raw IS 'The path for this trigger is discids';

CREATE TRIGGER search_editor_delete_0 BEFORE DELETE ON editor
    FOR EACH ROW EXECUTE PROCEDURE search_editor_delete_0();
COMMENT ON TRIGGER search_editor_delete_0 ON editor IS 'The path for this trigger is direct';

CREATE TRIGGER search_editor_insert_0 AFTER INSERT ON editor
    FOR EACH ROW EXECUTE PROCEDURE search_editor_insert_0();
COMMENT ON TRIGGER search_editor_insert_0 ON editor IS 'The path for this trigger is direct';

CREATE TRIGGER search_editor_update_0 AFTER UPDATE ON editor
    FOR EACH ROW EXECUTE PROCEDURE search_editor_update_0();
COMMENT ON TRIGGER search_editor_update_0 ON editor IS 'The path for this trigger is direct';

CREATE TRIGGER search_event_delete_0 BEFORE DELETE ON event
    FOR EACH ROW EXECUTE PROCEDURE search_event_delete_0();
COMMENT ON TRIGGER search_event_delete_0 ON event IS 'The path for this trigger is direct';

CREATE TRIGGER search_event_insert_0 AFTER INSERT ON event
    FOR EACH ROW EXECUTE PROCEDURE search_event_insert_0();
COMMENT ON TRIGGER search_event_insert_0 ON event IS 'The path for this trigger is direct';

CREATE TRIGGER search_event_update_0 AFTER UPDATE ON event
    FOR EACH ROW EXECUTE PROCEDURE search_event_update_0();
COMMENT ON TRIGGER search_event_update_0 ON event IS 'The path for this trigger is direct';

CREATE TRIGGER search_event_delete_1 BEFORE DELETE ON event_alias
    FOR EACH ROW EXECUTE PROCEDURE search_event_delete_1();
COMMENT ON TRIGGER search_event_delete_1 ON event_alias IS 'The path for this trigger is aliases';

CREATE TRIGGER search_event_insert_1 AFTER INSERT ON event_alias
    FOR EACH ROW EXECUTE PROCEDURE search_event_insert_1();
COMMENT ON TRIGGER search_event_insert_1 ON event_alias IS 'The path for this trigger is aliases';

CREATE TRIGGER search_event_update_1 AFTER UPDATE ON event_alias
    FOR EACH ROW EXECUTE PROCEDURE search_event_update_1();
COMMENT ON TRIGGER search_event_update_1 ON event_alias IS 'The path for this trigger is aliases';

CREATE TRIGGER search_event_delete_2 BEFORE DELETE ON l_area_event
    FOR EACH ROW EXECUTE PROCEDURE search_event_delete_2();
COMMENT ON TRIGGER search_event_delete_2 ON l_area_event IS 'The path for this trigger is area_links';

CREATE TRIGGER search_event_insert_2 AFTER INSERT ON l_area_event
    FOR EACH ROW EXECUTE PROCEDURE search_event_insert_2();
COMMENT ON TRIGGER search_event_insert_2 ON l_area_event IS 'The path for this trigger is area_links';

CREATE TRIGGER search_event_update_2 AFTER UPDATE ON l_area_event
    FOR EACH ROW EXECUTE PROCEDURE search_event_update_2();
COMMENT ON TRIGGER search_event_update_2 ON l_area_event IS 'The path for this trigger is area_links';

CREATE TRIGGER search_event_delete_3 BEFORE DELETE ON area
    FOR EACH ROW EXECUTE PROCEDURE search_event_delete_3();
COMMENT ON TRIGGER search_event_delete_3 ON area IS 'The path for this trigger is area_links.entity0';

CREATE TRIGGER search_event_insert_3 AFTER INSERT ON area
    FOR EACH ROW EXECUTE PROCEDURE search_event_insert_3();
COMMENT ON TRIGGER search_event_insert_3 ON area IS 'The path for this trigger is area_links.entity0';

CREATE TRIGGER search_event_update_3 AFTER UPDATE ON area
    FOR EACH ROW EXECUTE PROCEDURE search_event_update_3();
COMMENT ON TRIGGER search_event_update_3 ON area IS 'The path for this trigger is area_links.entity0';

CREATE TRIGGER search_event_delete_4 BEFORE DELETE ON l_artist_event
    FOR EACH ROW EXECUTE PROCEDURE search_event_delete_4();
COMMENT ON TRIGGER search_event_delete_4 ON l_artist_event IS 'The path for this trigger is artist_links';

CREATE TRIGGER search_event_insert_4 AFTER INSERT ON l_artist_event
    FOR EACH ROW EXECUTE PROCEDURE search_event_insert_4();
COMMENT ON TRIGGER search_event_insert_4 ON l_artist_event IS 'The path for this trigger is artist_links';

CREATE TRIGGER search_event_update_4 AFTER UPDATE ON l_artist_event
    FOR EACH ROW EXECUTE PROCEDURE search_event_update_4();
COMMENT ON TRIGGER search_event_update_4 ON l_artist_event IS 'The path for this trigger is artist_links';

CREATE TRIGGER search_event_delete_5 BEFORE DELETE ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_event_delete_5();
COMMENT ON TRIGGER search_event_delete_5 ON artist IS 'The path for this trigger is artist_links.entity0';

CREATE TRIGGER search_event_insert_5 AFTER INSERT ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_event_insert_5();
COMMENT ON TRIGGER search_event_insert_5 ON artist IS 'The path for this trigger is artist_links.entity0';

CREATE TRIGGER search_event_update_5 AFTER UPDATE ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_event_update_5();
COMMENT ON TRIGGER search_event_update_5 ON artist IS 'The path for this trigger is artist_links.entity0';

CREATE TRIGGER search_event_delete_6 BEFORE DELETE ON l_event_place
    FOR EACH ROW EXECUTE PROCEDURE search_event_delete_6();
COMMENT ON TRIGGER search_event_delete_6 ON l_event_place IS 'The path for this trigger is place_links';

CREATE TRIGGER search_event_insert_6 AFTER INSERT ON l_event_place
    FOR EACH ROW EXECUTE PROCEDURE search_event_insert_6();
COMMENT ON TRIGGER search_event_insert_6 ON l_event_place IS 'The path for this trigger is place_links';

CREATE TRIGGER search_event_update_6 AFTER UPDATE ON l_event_place
    FOR EACH ROW EXECUTE PROCEDURE search_event_update_6();
COMMENT ON TRIGGER search_event_update_6 ON l_event_place IS 'The path for this trigger is place_links';

CREATE TRIGGER search_event_delete_7 BEFORE DELETE ON place
    FOR EACH ROW EXECUTE PROCEDURE search_event_delete_7();
COMMENT ON TRIGGER search_event_delete_7 ON place IS 'The path for this trigger is place_links.entity1';

CREATE TRIGGER search_event_insert_7 AFTER INSERT ON place
    FOR EACH ROW EXECUTE PROCEDURE search_event_insert_7();
COMMENT ON TRIGGER search_event_insert_7 ON place IS 'The path for this trigger is place_links.entity1';

CREATE TRIGGER search_event_update_7 AFTER UPDATE ON place
    FOR EACH ROW EXECUTE PROCEDURE search_event_update_7();
COMMENT ON TRIGGER search_event_update_7 ON place IS 'The path for this trigger is place_links.entity1';

CREATE TRIGGER search_event_delete_8 BEFORE DELETE ON event_tag
    FOR EACH ROW EXECUTE PROCEDURE search_event_delete_8();
COMMENT ON TRIGGER search_event_delete_8 ON event_tag IS 'The path for this trigger is tags';

CREATE TRIGGER search_event_insert_8 AFTER INSERT ON event_tag
    FOR EACH ROW EXECUTE PROCEDURE search_event_insert_8();
COMMENT ON TRIGGER search_event_insert_8 ON event_tag IS 'The path for this trigger is tags';

CREATE TRIGGER search_event_update_8 AFTER UPDATE ON event_tag
    FOR EACH ROW EXECUTE PROCEDURE search_event_update_8();
COMMENT ON TRIGGER search_event_update_8 ON event_tag IS 'The path for this trigger is tags';

CREATE TRIGGER search_event_delete_9 BEFORE DELETE ON tag
    FOR EACH ROW EXECUTE PROCEDURE search_event_delete_9();
COMMENT ON TRIGGER search_event_delete_9 ON tag IS 'The path for this trigger is tags.tag';

CREATE TRIGGER search_event_insert_9 AFTER INSERT ON tag
    FOR EACH ROW EXECUTE PROCEDURE search_event_insert_9();
COMMENT ON TRIGGER search_event_insert_9 ON tag IS 'The path for this trigger is tags.tag';

CREATE TRIGGER search_event_update_9 AFTER UPDATE ON tag
    FOR EACH ROW EXECUTE PROCEDURE search_event_update_9();
COMMENT ON TRIGGER search_event_update_9 ON tag IS 'The path for this trigger is tags.tag';

CREATE TRIGGER search_event_delete_10 BEFORE DELETE ON event_type
    FOR EACH ROW EXECUTE PROCEDURE search_event_delete_10();
COMMENT ON TRIGGER search_event_delete_10 ON event_type IS 'The path for this trigger is type';

CREATE TRIGGER search_event_insert_10 AFTER INSERT ON event_type
    FOR EACH ROW EXECUTE PROCEDURE search_event_insert_10();
COMMENT ON TRIGGER search_event_insert_10 ON event_type IS 'The path for this trigger is type';

CREATE TRIGGER search_event_update_10 AFTER UPDATE ON event_type
    FOR EACH ROW EXECUTE PROCEDURE search_event_update_10();
COMMENT ON TRIGGER search_event_update_10 ON event_type IS 'The path for this trigger is type';

CREATE TRIGGER search_instrument_delete_0 BEFORE DELETE ON instrument
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_delete_0();
COMMENT ON TRIGGER search_instrument_delete_0 ON instrument IS 'The path for this trigger is direct';

CREATE TRIGGER search_instrument_insert_0 AFTER INSERT ON instrument
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_insert_0();
COMMENT ON TRIGGER search_instrument_insert_0 ON instrument IS 'The path for this trigger is direct';

CREATE TRIGGER search_instrument_update_0 AFTER UPDATE ON instrument
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_update_0();
COMMENT ON TRIGGER search_instrument_update_0 ON instrument IS 'The path for this trigger is direct';

CREATE TRIGGER search_instrument_delete_1 BEFORE DELETE ON instrument_alias
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_delete_1();
COMMENT ON TRIGGER search_instrument_delete_1 ON instrument_alias IS 'The path for this trigger is aliases';

CREATE TRIGGER search_instrument_insert_1 AFTER INSERT ON instrument_alias
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_insert_1();
COMMENT ON TRIGGER search_instrument_insert_1 ON instrument_alias IS 'The path for this trigger is aliases';

CREATE TRIGGER search_instrument_update_1 AFTER UPDATE ON instrument_alias
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_update_1();
COMMENT ON TRIGGER search_instrument_update_1 ON instrument_alias IS 'The path for this trigger is aliases';

CREATE TRIGGER search_instrument_delete_2 BEFORE DELETE ON instrument_tag
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_delete_2();
COMMENT ON TRIGGER search_instrument_delete_2 ON instrument_tag IS 'The path for this trigger is tags';

CREATE TRIGGER search_instrument_insert_2 AFTER INSERT ON instrument_tag
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_insert_2();
COMMENT ON TRIGGER search_instrument_insert_2 ON instrument_tag IS 'The path for this trigger is tags';

CREATE TRIGGER search_instrument_update_2 AFTER UPDATE ON instrument_tag
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_update_2();
COMMENT ON TRIGGER search_instrument_update_2 ON instrument_tag IS 'The path for this trigger is tags';

CREATE TRIGGER search_instrument_delete_3 BEFORE DELETE ON tag
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_delete_3();
COMMENT ON TRIGGER search_instrument_delete_3 ON tag IS 'The path for this trigger is tags.tag';

CREATE TRIGGER search_instrument_insert_3 AFTER INSERT ON tag
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_insert_3();
COMMENT ON TRIGGER search_instrument_insert_3 ON tag IS 'The path for this trigger is tags.tag';

CREATE TRIGGER search_instrument_update_3 AFTER UPDATE ON tag
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_update_3();
COMMENT ON TRIGGER search_instrument_update_3 ON tag IS 'The path for this trigger is tags.tag';

CREATE TRIGGER search_instrument_delete_4 BEFORE DELETE ON instrument_type
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_delete_4();
COMMENT ON TRIGGER search_instrument_delete_4 ON instrument_type IS 'The path for this trigger is type';

CREATE TRIGGER search_instrument_insert_4 AFTER INSERT ON instrument_type
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_insert_4();
COMMENT ON TRIGGER search_instrument_insert_4 ON instrument_type IS 'The path for this trigger is type';

CREATE TRIGGER search_instrument_update_4 AFTER UPDATE ON instrument_type
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_update_4();
COMMENT ON TRIGGER search_instrument_update_4 ON instrument_type IS 'The path for this trigger is type';

CREATE TRIGGER search_label_delete_0 BEFORE DELETE ON label
    FOR EACH ROW EXECUTE PROCEDURE search_label_delete_0();
COMMENT ON TRIGGER search_label_delete_0 ON label IS 'The path for this trigger is direct';

CREATE TRIGGER search_label_insert_0 AFTER INSERT ON label
    FOR EACH ROW EXECUTE PROCEDURE search_label_insert_0();
COMMENT ON TRIGGER search_label_insert_0 ON label IS 'The path for this trigger is direct';

CREATE TRIGGER search_label_update_0 AFTER UPDATE ON label
    FOR EACH ROW EXECUTE PROCEDURE search_label_update_0();
COMMENT ON TRIGGER search_label_update_0 ON label IS 'The path for this trigger is direct';

CREATE TRIGGER search_label_delete_1 BEFORE DELETE ON label_alias
    FOR EACH ROW EXECUTE PROCEDURE search_label_delete_1();
COMMENT ON TRIGGER search_label_delete_1 ON label_alias IS 'The path for this trigger is aliases';

CREATE TRIGGER search_label_insert_1 AFTER INSERT ON label_alias
    FOR EACH ROW EXECUTE PROCEDURE search_label_insert_1();
COMMENT ON TRIGGER search_label_insert_1 ON label_alias IS 'The path for this trigger is aliases';

CREATE TRIGGER search_label_update_1 AFTER UPDATE ON label_alias
    FOR EACH ROW EXECUTE PROCEDURE search_label_update_1();
COMMENT ON TRIGGER search_label_update_1 ON label_alias IS 'The path for this trigger is aliases';

CREATE TRIGGER search_label_delete_2 BEFORE DELETE ON area
    FOR EACH ROW EXECUTE PROCEDURE search_label_delete_2();
COMMENT ON TRIGGER search_label_delete_2 ON area IS 'The path for this trigger is area';

CREATE TRIGGER search_label_insert_2 AFTER INSERT ON area
    FOR EACH ROW EXECUTE PROCEDURE search_label_insert_2();
COMMENT ON TRIGGER search_label_insert_2 ON area IS 'The path for this trigger is area';

CREATE TRIGGER search_label_update_2 AFTER UPDATE ON area
    FOR EACH ROW EXECUTE PROCEDURE search_label_update_2();
COMMENT ON TRIGGER search_label_update_2 ON area IS 'The path for this trigger is area';

CREATE TRIGGER search_label_delete_3 BEFORE DELETE ON area_alias
    FOR EACH ROW EXECUTE PROCEDURE search_label_delete_3();
COMMENT ON TRIGGER search_label_delete_3 ON area_alias IS 'The path for this trigger is area.aliases';

CREATE TRIGGER search_label_insert_3 AFTER INSERT ON area_alias
    FOR EACH ROW EXECUTE PROCEDURE search_label_insert_3();
COMMENT ON TRIGGER search_label_insert_3 ON area_alias IS 'The path for this trigger is area.aliases';

CREATE TRIGGER search_label_update_3 AFTER UPDATE ON area_alias
    FOR EACH ROW EXECUTE PROCEDURE search_label_update_3();
COMMENT ON TRIGGER search_label_update_3 ON area_alias IS 'The path for this trigger is area.aliases';

CREATE TRIGGER search_label_delete_4 BEFORE DELETE ON iso_3166_1
    FOR EACH ROW EXECUTE PROCEDURE search_label_delete_4();
COMMENT ON TRIGGER search_label_delete_4 ON iso_3166_1 IS 'The path for this trigger is area.iso_3166_1_codes';

CREATE TRIGGER search_label_insert_4 AFTER INSERT ON iso_3166_1
    FOR EACH ROW EXECUTE PROCEDURE search_label_insert_4();
COMMENT ON TRIGGER search_label_insert_4 ON iso_3166_1 IS 'The path for this trigger is area.iso_3166_1_codes';

CREATE TRIGGER search_label_update_4 AFTER UPDATE ON iso_3166_1
    FOR EACH ROW EXECUTE PROCEDURE search_label_update_4();
COMMENT ON TRIGGER search_label_update_4 ON iso_3166_1 IS 'The path for this trigger is area.iso_3166_1_codes';

CREATE TRIGGER search_label_delete_5 BEFORE DELETE ON label_ipi
    FOR EACH ROW EXECUTE PROCEDURE search_label_delete_5();
COMMENT ON TRIGGER search_label_delete_5 ON label_ipi IS 'The path for this trigger is ipis';

CREATE TRIGGER search_label_insert_5 AFTER INSERT ON label_ipi
    FOR EACH ROW EXECUTE PROCEDURE search_label_insert_5();
COMMENT ON TRIGGER search_label_insert_5 ON label_ipi IS 'The path for this trigger is ipis';

CREATE TRIGGER search_label_update_5 AFTER UPDATE ON label_ipi
    FOR EACH ROW EXECUTE PROCEDURE search_label_update_5();
COMMENT ON TRIGGER search_label_update_5 ON label_ipi IS 'The path for this trigger is ipis';

CREATE TRIGGER search_label_delete_6 BEFORE DELETE ON label_tag
    FOR EACH ROW EXECUTE PROCEDURE search_label_delete_6();
COMMENT ON TRIGGER search_label_delete_6 ON label_tag IS 'The path for this trigger is tags';

CREATE TRIGGER search_label_insert_6 AFTER INSERT ON label_tag
    FOR EACH ROW EXECUTE PROCEDURE search_label_insert_6();
COMMENT ON TRIGGER search_label_insert_6 ON label_tag IS 'The path for this trigger is tags';

CREATE TRIGGER search_label_update_6 AFTER UPDATE ON label_tag
    FOR EACH ROW EXECUTE PROCEDURE search_label_update_6();
COMMENT ON TRIGGER search_label_update_6 ON label_tag IS 'The path for this trigger is tags';

CREATE TRIGGER search_label_delete_7 BEFORE DELETE ON tag
    FOR EACH ROW EXECUTE PROCEDURE search_label_delete_7();
COMMENT ON TRIGGER search_label_delete_7 ON tag IS 'The path for this trigger is tags.tag';

CREATE TRIGGER search_label_insert_7 AFTER INSERT ON tag
    FOR EACH ROW EXECUTE PROCEDURE search_label_insert_7();
COMMENT ON TRIGGER search_label_insert_7 ON tag IS 'The path for this trigger is tags.tag';

CREATE TRIGGER search_label_update_7 AFTER UPDATE ON tag
    FOR EACH ROW EXECUTE PROCEDURE search_label_update_7();
COMMENT ON TRIGGER search_label_update_7 ON tag IS 'The path for this trigger is tags.tag';

CREATE TRIGGER search_label_delete_8 BEFORE DELETE ON label_type
    FOR EACH ROW EXECUTE PROCEDURE search_label_delete_8();
COMMENT ON TRIGGER search_label_delete_8 ON label_type IS 'The path for this trigger is type';

CREATE TRIGGER search_label_insert_8 AFTER INSERT ON label_type
    FOR EACH ROW EXECUTE PROCEDURE search_label_insert_8();
COMMENT ON TRIGGER search_label_insert_8 ON label_type IS 'The path for this trigger is type';

CREATE TRIGGER search_label_update_8 AFTER UPDATE ON label_type
    FOR EACH ROW EXECUTE PROCEDURE search_label_update_8();
COMMENT ON TRIGGER search_label_update_8 ON label_type IS 'The path for this trigger is type';

CREATE TRIGGER search_place_delete_0 BEFORE DELETE ON place
    FOR EACH ROW EXECUTE PROCEDURE search_place_delete_0();
COMMENT ON TRIGGER search_place_delete_0 ON place IS 'The path for this trigger is direct';

CREATE TRIGGER search_place_insert_0 AFTER INSERT ON place
    FOR EACH ROW EXECUTE PROCEDURE search_place_insert_0();
COMMENT ON TRIGGER search_place_insert_0 ON place IS 'The path for this trigger is direct';

CREATE TRIGGER search_place_update_0 AFTER UPDATE ON place
    FOR EACH ROW EXECUTE PROCEDURE search_place_update_0();
COMMENT ON TRIGGER search_place_update_0 ON place IS 'The path for this trigger is direct';

CREATE TRIGGER search_place_delete_1 BEFORE DELETE ON place_alias
    FOR EACH ROW EXECUTE PROCEDURE search_place_delete_1();
COMMENT ON TRIGGER search_place_delete_1 ON place_alias IS 'The path for this trigger is aliases';

CREATE TRIGGER search_place_insert_1 AFTER INSERT ON place_alias
    FOR EACH ROW EXECUTE PROCEDURE search_place_insert_1();
COMMENT ON TRIGGER search_place_insert_1 ON place_alias IS 'The path for this trigger is aliases';

CREATE TRIGGER search_place_update_1 AFTER UPDATE ON place_alias
    FOR EACH ROW EXECUTE PROCEDURE search_place_update_1();
COMMENT ON TRIGGER search_place_update_1 ON place_alias IS 'The path for this trigger is aliases';

CREATE TRIGGER search_place_delete_2 BEFORE DELETE ON area
    FOR EACH ROW EXECUTE PROCEDURE search_place_delete_2();
COMMENT ON TRIGGER search_place_delete_2 ON area IS 'The path for this trigger is area';

CREATE TRIGGER search_place_insert_2 AFTER INSERT ON area
    FOR EACH ROW EXECUTE PROCEDURE search_place_insert_2();
COMMENT ON TRIGGER search_place_insert_2 ON area IS 'The path for this trigger is area';

CREATE TRIGGER search_place_update_2 AFTER UPDATE ON area
    FOR EACH ROW EXECUTE PROCEDURE search_place_update_2();
COMMENT ON TRIGGER search_place_update_2 ON area IS 'The path for this trigger is area';

CREATE TRIGGER search_place_delete_3 BEFORE DELETE ON area_alias
    FOR EACH ROW EXECUTE PROCEDURE search_place_delete_3();
COMMENT ON TRIGGER search_place_delete_3 ON area_alias IS 'The path for this trigger is area.aliases';

CREATE TRIGGER search_place_insert_3 AFTER INSERT ON area_alias
    FOR EACH ROW EXECUTE PROCEDURE search_place_insert_3();
COMMENT ON TRIGGER search_place_insert_3 ON area_alias IS 'The path for this trigger is area.aliases';

CREATE TRIGGER search_place_update_3 AFTER UPDATE ON area_alias
    FOR EACH ROW EXECUTE PROCEDURE search_place_update_3();
COMMENT ON TRIGGER search_place_update_3 ON area_alias IS 'The path for this trigger is area.aliases';

CREATE TRIGGER search_place_delete_4 BEFORE DELETE ON place_type
    FOR EACH ROW EXECUTE PROCEDURE search_place_delete_4();
COMMENT ON TRIGGER search_place_delete_4 ON place_type IS 'The path for this trigger is type';

CREATE TRIGGER search_place_insert_4 AFTER INSERT ON place_type
    FOR EACH ROW EXECUTE PROCEDURE search_place_insert_4();
COMMENT ON TRIGGER search_place_insert_4 ON place_type IS 'The path for this trigger is type';

CREATE TRIGGER search_place_update_4 AFTER UPDATE ON place_type
    FOR EACH ROW EXECUTE PROCEDURE search_place_update_4();
COMMENT ON TRIGGER search_place_update_4 ON place_type IS 'The path for this trigger is type';

CREATE TRIGGER search_recording_delete_0 BEFORE DELETE ON recording
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_0();
COMMENT ON TRIGGER search_recording_delete_0 ON recording IS 'The path for this trigger is direct';

CREATE TRIGGER search_recording_insert_0 AFTER INSERT ON recording
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_0();
COMMENT ON TRIGGER search_recording_insert_0 ON recording IS 'The path for this trigger is direct';

CREATE TRIGGER search_recording_update_0 AFTER UPDATE ON recording
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_0();
COMMENT ON TRIGGER search_recording_update_0 ON recording IS 'The path for this trigger is direct';

CREATE TRIGGER search_recording_delete_1 BEFORE DELETE ON artist_credit
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_1();
COMMENT ON TRIGGER search_recording_delete_1 ON artist_credit IS 'The path for this trigger is artist_credit';

CREATE TRIGGER search_recording_insert_1 AFTER INSERT ON artist_credit
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_1();
COMMENT ON TRIGGER search_recording_insert_1 ON artist_credit IS 'The path for this trigger is artist_credit';

CREATE TRIGGER search_recording_update_1 AFTER UPDATE ON artist_credit
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_1();
COMMENT ON TRIGGER search_recording_update_1 ON artist_credit IS 'The path for this trigger is artist_credit';

CREATE TRIGGER search_recording_delete_2 BEFORE DELETE ON artist_credit_name
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_2();
COMMENT ON TRIGGER search_recording_delete_2 ON artist_credit_name IS 'The path for this trigger is artist_credit.artists';

CREATE TRIGGER search_recording_insert_2 AFTER INSERT ON artist_credit_name
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_2();
COMMENT ON TRIGGER search_recording_insert_2 ON artist_credit_name IS 'The path for this trigger is artist_credit.artists';

CREATE TRIGGER search_recording_update_2 AFTER UPDATE ON artist_credit_name
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_2();
COMMENT ON TRIGGER search_recording_update_2 ON artist_credit_name IS 'The path for this trigger is artist_credit.artists';

CREATE TRIGGER search_recording_delete_3 BEFORE DELETE ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_3();
COMMENT ON TRIGGER search_recording_delete_3 ON artist IS 'The path for this trigger is artist_credit.artists.artist';

CREATE TRIGGER search_recording_insert_3 AFTER INSERT ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_3();
COMMENT ON TRIGGER search_recording_insert_3 ON artist IS 'The path for this trigger is artist_credit.artists.artist';

CREATE TRIGGER search_recording_update_3 AFTER UPDATE ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_3();
COMMENT ON TRIGGER search_recording_update_3 ON artist IS 'The path for this trigger is artist_credit.artists.artist';

CREATE TRIGGER search_recording_delete_4 BEFORE DELETE ON track
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_4();
COMMENT ON TRIGGER search_recording_delete_4 ON track IS 'The path for this trigger is tracks';

CREATE TRIGGER search_recording_insert_4 AFTER INSERT ON track
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_4();
COMMENT ON TRIGGER search_recording_insert_4 ON track IS 'The path for this trigger is tracks';

CREATE TRIGGER search_recording_update_4 AFTER UPDATE ON track
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_4();
COMMENT ON TRIGGER search_recording_update_4 ON track IS 'The path for this trigger is tracks';

CREATE TRIGGER search_recording_delete_5 BEFORE DELETE ON medium
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_5();
COMMENT ON TRIGGER search_recording_delete_5 ON medium IS 'The path for this trigger is tracks.medium';

CREATE TRIGGER search_recording_insert_5 AFTER INSERT ON medium
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_5();
COMMENT ON TRIGGER search_recording_insert_5 ON medium IS 'The path for this trigger is tracks.medium';

CREATE TRIGGER search_recording_update_5 AFTER UPDATE ON medium
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_5();
COMMENT ON TRIGGER search_recording_update_5 ON medium IS 'The path for this trigger is tracks.medium';

CREATE TRIGGER search_recording_delete_6 BEFORE DELETE ON release
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_6();
COMMENT ON TRIGGER search_recording_delete_6 ON release IS 'The path for this trigger is tracks.medium.release';

CREATE TRIGGER search_recording_insert_6 AFTER INSERT ON release
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_6();
COMMENT ON TRIGGER search_recording_insert_6 ON release IS 'The path for this trigger is tracks.medium.release';

CREATE TRIGGER search_recording_update_6 AFTER UPDATE ON release
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_6();
COMMENT ON TRIGGER search_recording_update_6 ON release IS 'The path for this trigger is tracks.medium.release';

CREATE TRIGGER search_recording_delete_7 BEFORE DELETE ON release_country
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_7();
COMMENT ON TRIGGER search_recording_delete_7 ON release_country IS 'The path for this trigger is tracks.medium.release.country_dates';

CREATE TRIGGER search_recording_insert_7 AFTER INSERT ON release_country
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_7();
COMMENT ON TRIGGER search_recording_insert_7 ON release_country IS 'The path for this trigger is tracks.medium.release.country_dates';

CREATE TRIGGER search_recording_update_7 AFTER UPDATE ON release_country
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_7();
COMMENT ON TRIGGER search_recording_update_7 ON release_country IS 'The path for this trigger is tracks.medium.release.country_dates';

CREATE TRIGGER search_recording_delete_8 BEFORE DELETE ON country_area
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_8();
COMMENT ON TRIGGER search_recording_delete_8 ON country_area IS 'The path for this trigger is tracks.medium.release.country_dates.country';

CREATE TRIGGER search_recording_insert_8 AFTER INSERT ON country_area
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_8();
COMMENT ON TRIGGER search_recording_insert_8 ON country_area IS 'The path for this trigger is tracks.medium.release.country_dates.country';

CREATE TRIGGER search_recording_update_8 AFTER UPDATE ON country_area
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_8();
COMMENT ON TRIGGER search_recording_update_8 ON country_area IS 'The path for this trigger is tracks.medium.release.country_dates.country';

CREATE TRIGGER search_recording_delete_9 BEFORE DELETE ON area
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_9();
COMMENT ON TRIGGER search_recording_delete_9 ON area IS 'The path for this trigger is tracks.medium.release.country_dates.country.area';

CREATE TRIGGER search_recording_insert_9 AFTER INSERT ON area
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_9();
COMMENT ON TRIGGER search_recording_insert_9 ON area IS 'The path for this trigger is tracks.medium.release.country_dates.country.area';

CREATE TRIGGER search_recording_update_9 AFTER UPDATE ON area
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_9();
COMMENT ON TRIGGER search_recording_update_9 ON area IS 'The path for this trigger is tracks.medium.release.country_dates.country.area';

CREATE TRIGGER search_recording_delete_10 BEFORE DELETE ON medium_format
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_10();
COMMENT ON TRIGGER search_recording_delete_10 ON medium_format IS 'The path for this trigger is tracks.medium.format';

CREATE TRIGGER search_recording_insert_10 AFTER INSERT ON medium_format
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_10();
COMMENT ON TRIGGER search_recording_insert_10 ON medium_format IS 'The path for this trigger is tracks.medium.format';

CREATE TRIGGER search_recording_update_10 AFTER UPDATE ON medium_format
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_10();
COMMENT ON TRIGGER search_recording_update_10 ON medium_format IS 'The path for this trigger is tracks.medium.format';

CREATE TRIGGER search_recording_delete_11 BEFORE DELETE ON isrc
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_11();
COMMENT ON TRIGGER search_recording_delete_11 ON isrc IS 'The path for this trigger is isrcs';

CREATE TRIGGER search_recording_insert_11 AFTER INSERT ON isrc
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_11();
COMMENT ON TRIGGER search_recording_insert_11 ON isrc IS 'The path for this trigger is isrcs';

CREATE TRIGGER search_recording_update_11 AFTER UPDATE ON isrc
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_11();
COMMENT ON TRIGGER search_recording_update_11 ON isrc IS 'The path for this trigger is isrcs';

CREATE TRIGGER search_recording_delete_12 BEFORE DELETE ON release_group
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_12();
COMMENT ON TRIGGER search_recording_delete_12 ON release_group IS 'The path for this trigger is tracks.medium.release.release_group';

CREATE TRIGGER search_recording_insert_12 AFTER INSERT ON release_group
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_12();
COMMENT ON TRIGGER search_recording_insert_12 ON release_group IS 'The path for this trigger is tracks.medium.release.release_group';

CREATE TRIGGER search_recording_update_12 AFTER UPDATE ON release_group
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_12();
COMMENT ON TRIGGER search_recording_update_12 ON release_group IS 'The path for this trigger is tracks.medium.release.release_group';

CREATE TRIGGER search_recording_delete_13 BEFORE DELETE ON release_group_primary_type
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_13();
COMMENT ON TRIGGER search_recording_delete_13 ON release_group_primary_type IS 'The path for this trigger is tracks.medium.release.release_group.type';

CREATE TRIGGER search_recording_insert_13 AFTER INSERT ON release_group_primary_type
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_13();
COMMENT ON TRIGGER search_recording_insert_13 ON release_group_primary_type IS 'The path for this trigger is tracks.medium.release.release_group.type';

CREATE TRIGGER search_recording_update_13 AFTER UPDATE ON release_group_primary_type
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_13();
COMMENT ON TRIGGER search_recording_update_13 ON release_group_primary_type IS 'The path for this trigger is tracks.medium.release.release_group.type';

CREATE TRIGGER search_recording_delete_14 BEFORE DELETE ON release_group_secondary_type_join
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_14();
COMMENT ON TRIGGER search_recording_delete_14 ON release_group_secondary_type_join IS 'The path for this trigger is tracks.medium.release.release_group.secondary_types';

CREATE TRIGGER search_recording_insert_14 AFTER INSERT ON release_group_secondary_type_join
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_14();
COMMENT ON TRIGGER search_recording_insert_14 ON release_group_secondary_type_join IS 'The path for this trigger is tracks.medium.release.release_group.secondary_types';

CREATE TRIGGER search_recording_update_14 AFTER UPDATE ON release_group_secondary_type_join
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_14();
COMMENT ON TRIGGER search_recording_update_14 ON release_group_secondary_type_join IS 'The path for this trigger is tracks.medium.release.release_group.secondary_types';

CREATE TRIGGER search_recording_delete_15 BEFORE DELETE ON release_group_secondary_type
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_15();
COMMENT ON TRIGGER search_recording_delete_15 ON release_group_secondary_type IS 'The path for this trigger is tracks.medium.release.release_group.secondary_types.secondary_type';

CREATE TRIGGER search_recording_insert_15 AFTER INSERT ON release_group_secondary_type
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_15();
COMMENT ON TRIGGER search_recording_insert_15 ON release_group_secondary_type IS 'The path for this trigger is tracks.medium.release.release_group.secondary_types.secondary_type';

CREATE TRIGGER search_recording_update_15 AFTER UPDATE ON release_group_secondary_type
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_15();
COMMENT ON TRIGGER search_recording_update_15 ON release_group_secondary_type IS 'The path for this trigger is tracks.medium.release.release_group.secondary_types.secondary_type';

CREATE TRIGGER search_recording_delete_16 BEFORE DELETE ON release_status
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_16();
COMMENT ON TRIGGER search_recording_delete_16 ON release_status IS 'The path for this trigger is tracks.medium.release.status';

CREATE TRIGGER search_recording_insert_16 AFTER INSERT ON release_status
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_16();
COMMENT ON TRIGGER search_recording_insert_16 ON release_status IS 'The path for this trigger is tracks.medium.release.status';

CREATE TRIGGER search_recording_update_16 AFTER UPDATE ON release_status
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_16();
COMMENT ON TRIGGER search_recording_update_16 ON release_status IS 'The path for this trigger is tracks.medium.release.status';

CREATE TRIGGER search_recording_delete_17 BEFORE DELETE ON recording_tag
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_17();
COMMENT ON TRIGGER search_recording_delete_17 ON recording_tag IS 'The path for this trigger is tags';

CREATE TRIGGER search_recording_insert_17 AFTER INSERT ON recording_tag
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_17();
COMMENT ON TRIGGER search_recording_insert_17 ON recording_tag IS 'The path for this trigger is tags';

CREATE TRIGGER search_recording_update_17 AFTER UPDATE ON recording_tag
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_17();
COMMENT ON TRIGGER search_recording_update_17 ON recording_tag IS 'The path for this trigger is tags';

CREATE TRIGGER search_recording_delete_18 BEFORE DELETE ON tag
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_18();
COMMENT ON TRIGGER search_recording_delete_18 ON tag IS 'The path for this trigger is tags.tag';

CREATE TRIGGER search_recording_insert_18 AFTER INSERT ON tag
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_18();
COMMENT ON TRIGGER search_recording_insert_18 ON tag IS 'The path for this trigger is tags.tag';

CREATE TRIGGER search_recording_update_18 AFTER UPDATE ON tag
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_18();
COMMENT ON TRIGGER search_recording_update_18 ON tag IS 'The path for this trigger is tags.tag';

CREATE TRIGGER search_recording_delete_19 BEFORE DELETE ON medium
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete_19();
COMMENT ON TRIGGER search_recording_delete_19 ON medium IS 'The path for this trigger is tracks.medium.release.mediums';

CREATE TRIGGER search_recording_insert_19 AFTER INSERT ON medium
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert_19();
COMMENT ON TRIGGER search_recording_insert_19 ON medium IS 'The path for this trigger is tracks.medium.release.mediums';

CREATE TRIGGER search_recording_update_19 AFTER UPDATE ON medium
    FOR EACH ROW EXECUTE PROCEDURE search_recording_update_19();
COMMENT ON TRIGGER search_recording_update_19 ON medium IS 'The path for this trigger is tracks.medium.release.mediums';

CREATE TRIGGER search_release_delete_0 BEFORE DELETE ON release
    FOR EACH ROW EXECUTE PROCEDURE search_release_delete_0();
COMMENT ON TRIGGER search_release_delete_0 ON release IS 'The path for this trigger is direct';

CREATE TRIGGER search_release_insert_0 AFTER INSERT ON release
    FOR EACH ROW EXECUTE PROCEDURE search_release_insert_0();
COMMENT ON TRIGGER search_release_insert_0 ON release IS 'The path for this trigger is direct';

CREATE TRIGGER search_release_update_0 AFTER UPDATE ON release
    FOR EACH ROW EXECUTE PROCEDURE search_release_update_0();
COMMENT ON TRIGGER search_release_update_0 ON release IS 'The path for this trigger is direct';

CREATE TRIGGER search_release_delete_1 BEFORE DELETE ON artist_credit
    FOR EACH ROW EXECUTE PROCEDURE search_release_delete_1();
COMMENT ON TRIGGER search_release_delete_1 ON artist_credit IS 'The path for this trigger is artist_credit';

CREATE TRIGGER search_release_insert_1 AFTER INSERT ON artist_credit
    FOR EACH ROW EXECUTE PROCEDURE search_release_insert_1();
COMMENT ON TRIGGER search_release_insert_1 ON artist_credit IS 'The path for this trigger is artist_credit';

CREATE TRIGGER search_release_update_1 AFTER UPDATE ON artist_credit
    FOR EACH ROW EXECUTE PROCEDURE search_release_update_1();
COMMENT ON TRIGGER search_release_update_1 ON artist_credit IS 'The path for this trigger is artist_credit';

CREATE TRIGGER search_release_delete_2 BEFORE DELETE ON artist_credit_name
    FOR EACH ROW EXECUTE PROCEDURE search_release_delete_2();
COMMENT ON TRIGGER search_release_delete_2 ON artist_credit_name IS 'The path for this trigger is artist_credit.artists';

CREATE TRIGGER search_release_insert_2 AFTER INSERT ON artist_credit_name
    FOR EACH ROW EXECUTE PROCEDURE search_release_insert_2();
COMMENT ON TRIGGER search_release_insert_2 ON artist_credit_name IS 'The path for this trigger is artist_credit.artists';

CREATE TRIGGER search_release_update_2 AFTER UPDATE ON artist_credit_name
    FOR EACH ROW EXECUTE PROCEDURE search_release_update_2();
COMMENT ON TRIGGER search_release_update_2 ON artist_credit_name IS 'The path for this trigger is artist_credit.artists';

CREATE TRIGGER search_release_delete_3 BEFORE DELETE ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_release_delete_3();
COMMENT ON TRIGGER search_release_delete_3 ON artist IS 'The path for this trigger is artist_credit.artists.artist';

CREATE TRIGGER search_release_insert_3 AFTER INSERT ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_release_insert_3();
COMMENT ON TRIGGER search_release_insert_3 ON artist IS 'The path for this trigger is artist_credit.artists.artist';

CREATE TRIGGER search_release_update_3 AFTER UPDATE ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_release_update_3();
COMMENT ON TRIGGER search_release_update_3 ON artist IS 'The path for this trigger is artist_credit.artists.artist';

CREATE TRIGGER search_release_delete_4 BEFORE DELETE ON release_meta
    FOR EACH ROW EXECUTE PROCEDURE search_release_delete_4();
COMMENT ON TRIGGER search_release_delete_4 ON release_meta IS 'The path for this trigger is asin';

CREATE TRIGGER search_release_insert_4 AFTER INSERT ON release_meta
    FOR EACH ROW EXECUTE PROCEDURE search_release_insert_4();
COMMENT ON TRIGGER search_release_insert_4 ON release_meta IS 'The path for this trigger is asin';

CREATE TRIGGER search_release_update_4 AFTER UPDATE ON release_meta
    FOR EACH ROW EXECUTE PROCEDURE search_release_update_4();
COMMENT ON TRIGGER search_release_update_4 ON release_meta IS 'The path for this trigger is asin';

CREATE TRIGGER search_release_delete_5 BEFORE DELETE ON release_country
    FOR EACH ROW EXECUTE PROCEDURE search_release_delete_5();
COMMENT ON TRIGGER search_release_delete_5 ON release_country IS 'The path for this trigger is country_dates';

CREATE TRIGGER search_release_insert_5 AFTER INSERT ON release_country
    FOR EACH ROW EXECUTE PROCEDURE search_release_insert_5();
COMMENT ON TRIGGER search_release_insert_5 ON release_country IS 'The path for this trigger is country_dates';

CREATE TRIGGER search_release_update_5 AFTER UPDATE ON release_country
    FOR EACH ROW EXECUTE PROCEDURE search_release_update_5();
COMMENT ON TRIGGER search_release_update_5 ON release_country IS 'The path for this trigger is country_dates';

CREATE TRIGGER search_release_delete_6 BEFORE DELETE ON country_area
    FOR EACH ROW EXECUTE PROCEDURE search_release_delete_6();
COMMENT ON TRIGGER search_release_delete_6 ON country_area IS 'The path for this trigger is country_dates.country';

CREATE TRIGGER search_release_insert_6 AFTER INSERT ON country_area
    FOR EACH ROW EXECUTE PROCEDURE search_release_insert_6();
COMMENT ON TRIGGER search_release_insert_6 ON country_area IS 'The path for this trigger is country_dates.country';

CREATE TRIGGER search_release_update_6 AFTER UPDATE ON country_area
    FOR EACH ROW EXECUTE PROCEDURE search_release_update_6();
COMMENT ON TRIGGER search_release_update_6 ON country_area IS 'The path for this trigger is country_dates.country';

CREATE TRIGGER search_release_delete_7 BEFORE DELETE ON area
    FOR EACH ROW EXECUTE PROCEDURE search_release_delete_7();
COMMENT ON TRIGGER search_release_delete_7 ON area IS 'The path for this trigger is country_dates.country.area';

CREATE TRIGGER search_release_insert_7 AFTER INSERT ON area
    FOR EACH ROW EXECUTE PROCEDURE search_release_insert_7();
COMMENT ON TRIGGER search_release_insert_7 ON area IS 'The path for this trigger is country_dates.country.area';

CREATE TRIGGER search_release_update_7 AFTER UPDATE ON area
    FOR EACH ROW EXECUTE PROCEDURE search_release_update_7();
COMMENT ON TRIGGER search_release_update_7 ON area IS 'The path for this trigger is country_dates.country.area';

CREATE TRIGGER search_release_delete_8 BEFORE DELETE ON release_label
    FOR EACH ROW EXECUTE PROCEDURE search_release_delete_8();
COMMENT ON TRIGGER search_release_delete_8 ON release_label IS 'The path for this trigger is labels';

CREATE TRIGGER search_release_insert_8 AFTER INSERT ON release_label
    FOR EACH ROW EXECUTE PROCEDURE search_release_insert_8();
COMMENT ON TRIGGER search_release_insert_8 ON release_label IS 'The path for this trigger is labels';

CREATE TRIGGER search_release_update_8 AFTER UPDATE ON release_label
    FOR EACH ROW EXECUTE PROCEDURE search_release_update_8();
COMMENT ON TRIGGER search_release_update_8 ON release_label IS 'The path for this trigger is labels';

CREATE TRIGGER search_release_delete_9 BEFORE DELETE ON medium
    FOR EACH ROW EXECUTE PROCEDURE search_release_delete_9();
COMMENT ON TRIGGER search_release_delete_9 ON medium IS 'The path for this trigger is mediums';

CREATE TRIGGER search_release_insert_9 AFTER INSERT ON medium
    FOR EACH ROW EXECUTE PROCEDURE search_release_insert_9();
COMMENT ON TRIGGER search_release_insert_9 ON medium IS 'The path for this trigger is mediums';

CREATE TRIGGER search_release_update_9 AFTER UPDATE ON medium
    FOR EACH ROW EXECUTE PROCEDURE search_release_update_9();
COMMENT ON TRIGGER search_release_update_9 ON medium IS 'The path for this trigger is mediums';

CREATE TRIGGER search_release_delete_10 BEFORE DELETE ON medium_cdtoc
    FOR EACH ROW EXECUTE PROCEDURE search_release_delete_10();
COMMENT ON TRIGGER search_release_delete_10 ON medium_cdtoc IS 'The path for this trigger is mediums.cdtocs';

CREATE TRIGGER search_release_insert_10 AFTER INSERT ON medium_cdtoc
    FOR EACH ROW EXECUTE PROCEDURE search_release_insert_10();
COMMENT ON TRIGGER search_release_insert_10 ON medium_cdtoc IS 'The path for this trigger is mediums.cdtocs';

CREATE TRIGGER search_release_update_10 AFTER UPDATE ON medium_cdtoc
    FOR EACH ROW EXECUTE PROCEDURE search_release_update_10();
COMMENT ON TRIGGER search_release_update_10 ON medium_cdtoc IS 'The path for this trigger is mediums.cdtocs';

CREATE TRIGGER search_release_delete_11 BEFORE DELETE ON medium_format
    FOR EACH ROW EXECUTE PROCEDURE search_release_delete_11();
COMMENT ON TRIGGER search_release_delete_11 ON medium_format IS 'The path for this trigger is mediums.format';

CREATE TRIGGER search_release_insert_11 AFTER INSERT ON medium_format
    FOR EACH ROW EXECUTE PROCEDURE search_release_insert_11();
COMMENT ON TRIGGER search_release_insert_11 ON medium_format IS 'The path for this trigger is mediums.format';

CREATE TRIGGER search_release_update_11 AFTER UPDATE ON medium_format
    FOR EACH ROW EXECUTE PROCEDURE search_release_update_11();
COMMENT ON TRIGGER search_release_update_11 ON medium_format IS 'The path for this trigger is mediums.format';

CREATE TRIGGER search_release_delete_12 BEFORE DELETE ON label
    FOR EACH ROW EXECUTE PROCEDURE search_release_delete_12();
COMMENT ON TRIGGER search_release_delete_12 ON label IS 'The path for this trigger is labels.label';

CREATE TRIGGER search_release_insert_12 AFTER INSERT ON label
    FOR EACH ROW EXECUTE PROCEDURE search_release_insert_12();
COMMENT ON TRIGGER search_release_insert_12 ON label IS 'The path for this trigger is labels.label';

CREATE TRIGGER search_release_update_12 AFTER UPDATE ON label
    FOR EACH ROW EXECUTE PROCEDURE search_release_update_12();
COMMENT ON TRIGGER search_release_update_12 ON label IS 'The path for this trigger is labels.label';

CREATE TRIGGER search_release_delete_13 BEFORE DELETE ON language
    FOR EACH ROW EXECUTE PROCEDURE search_release_delete_13();
COMMENT ON TRIGGER search_release_delete_13 ON language IS 'The path for this trigger is language';

CREATE TRIGGER search_release_insert_13 AFTER INSERT ON language
    FOR EACH ROW EXECUTE PROCEDURE search_release_insert_13();
COMMENT ON TRIGGER search_release_insert_13 ON language IS 'The path for this trigger is language';

CREATE TRIGGER search_release_update_13 AFTER UPDATE ON language
    FOR EACH ROW EXECUTE PROCEDURE search_release_update_13();
COMMENT ON TRIGGER search_release_update_13 ON language IS 'The path for this trigger is language';

CREATE TRIGGER search_release_delete_14 BEFORE DELETE ON release_group
    FOR EACH ROW EXECUTE PROCEDURE search_release_delete_14();
COMMENT ON TRIGGER search_release_delete_14 ON release_group IS 'The path for this trigger is release_group';

CREATE TRIGGER search_release_insert_14 AFTER INSERT ON release_group
    FOR EACH ROW EXECUTE PROCEDURE search_release_insert_14();
COMMENT ON TRIGGER search_release_insert_14 ON release_group IS 'The path for this trigger is release_group';

CREATE TRIGGER search_release_update_14 AFTER UPDATE ON release_group
    FOR EACH ROW EXECUTE PROCEDURE search_release_update_14();
COMMENT ON TRIGGER search_release_update_14 ON release_group IS 'The path for this trigger is release_group';

CREATE TRIGGER search_release_delete_15 BEFORE DELETE ON release_group_primary_type
    FOR EACH ROW EXECUTE PROCEDURE search_release_delete_15();
COMMENT ON TRIGGER search_release_delete_15 ON release_group_primary_type IS 'The path for this trigger is release_group.type';

CREATE TRIGGER search_release_insert_15 AFTER INSERT ON release_group_primary_type
    FOR EACH ROW EXECUTE PROCEDURE search_release_insert_15();
COMMENT ON TRIGGER search_release_insert_15 ON release_group_primary_type IS 'The path for this trigger is release_group.type';

CREATE TRIGGER search_release_update_15 AFTER UPDATE ON release_group_primary_type
    FOR EACH ROW EXECUTE PROCEDURE search_release_update_15();
COMMENT ON TRIGGER search_release_update_15 ON release_group_primary_type IS 'The path for this trigger is release_group.type';

CREATE TRIGGER search_release_delete_16 BEFORE DELETE ON script
    FOR EACH ROW EXECUTE PROCEDURE search_release_delete_16();
COMMENT ON TRIGGER search_release_delete_16 ON script IS 'The path for this trigger is script';

CREATE TRIGGER search_release_insert_16 AFTER INSERT ON script
    FOR EACH ROW EXECUTE PROCEDURE search_release_insert_16();
COMMENT ON TRIGGER search_release_insert_16 ON script IS 'The path for this trigger is script';

CREATE TRIGGER search_release_update_16 AFTER UPDATE ON script
    FOR EACH ROW EXECUTE PROCEDURE search_release_update_16();
COMMENT ON TRIGGER search_release_update_16 ON script IS 'The path for this trigger is script';

CREATE TRIGGER search_release_delete_17 BEFORE DELETE ON release_group_secondary_type_join
    FOR EACH ROW EXECUTE PROCEDURE search_release_delete_17();
COMMENT ON TRIGGER search_release_delete_17 ON release_group_secondary_type_join IS 'The path for this trigger is release_group.secondary_types';

CREATE TRIGGER search_release_insert_17 AFTER INSERT ON release_group_secondary_type_join
    FOR EACH ROW EXECUTE PROCEDURE search_release_insert_17();
COMMENT ON TRIGGER search_release_insert_17 ON release_group_secondary_type_join IS 'The path for this trigger is release_group.secondary_types';

CREATE TRIGGER search_release_update_17 AFTER UPDATE ON release_group_secondary_type_join
    FOR EACH ROW EXECUTE PROCEDURE search_release_update_17();
COMMENT ON TRIGGER search_release_update_17 ON release_group_secondary_type_join IS 'The path for this trigger is release_group.secondary_types';

CREATE TRIGGER search_release_delete_18 BEFORE DELETE ON release_group_secondary_type
    FOR EACH ROW EXECUTE PROCEDURE search_release_delete_18();
COMMENT ON TRIGGER search_release_delete_18 ON release_group_secondary_type IS 'The path for this trigger is release_group.secondary_types.secondary_type';

CREATE TRIGGER search_release_insert_18 AFTER INSERT ON release_group_secondary_type
    FOR EACH ROW EXECUTE PROCEDURE search_release_insert_18();
COMMENT ON TRIGGER search_release_insert_18 ON release_group_secondary_type IS 'The path for this trigger is release_group.secondary_types.secondary_type';

CREATE TRIGGER search_release_update_18 AFTER UPDATE ON release_group_secondary_type
    FOR EACH ROW EXECUTE PROCEDURE search_release_update_18();
COMMENT ON TRIGGER search_release_update_18 ON release_group_secondary_type IS 'The path for this trigger is release_group.secondary_types.secondary_type';

CREATE TRIGGER search_release_delete_19 BEFORE DELETE ON release_status
    FOR EACH ROW EXECUTE PROCEDURE search_release_delete_19();
COMMENT ON TRIGGER search_release_delete_19 ON release_status IS 'The path for this trigger is status';

CREATE TRIGGER search_release_insert_19 AFTER INSERT ON release_status
    FOR EACH ROW EXECUTE PROCEDURE search_release_insert_19();
COMMENT ON TRIGGER search_release_insert_19 ON release_status IS 'The path for this trigger is status';

CREATE TRIGGER search_release_update_19 AFTER UPDATE ON release_status
    FOR EACH ROW EXECUTE PROCEDURE search_release_update_19();
COMMENT ON TRIGGER search_release_update_19 ON release_status IS 'The path for this trigger is status';

CREATE TRIGGER search_release_delete_20 BEFORE DELETE ON release_tag
    FOR EACH ROW EXECUTE PROCEDURE search_release_delete_20();
COMMENT ON TRIGGER search_release_delete_20 ON release_tag IS 'The path for this trigger is tags';

CREATE TRIGGER search_release_insert_20 AFTER INSERT ON release_tag
    FOR EACH ROW EXECUTE PROCEDURE search_release_insert_20();
COMMENT ON TRIGGER search_release_insert_20 ON release_tag IS 'The path for this trigger is tags';

CREATE TRIGGER search_release_update_20 AFTER UPDATE ON release_tag
    FOR EACH ROW EXECUTE PROCEDURE search_release_update_20();
COMMENT ON TRIGGER search_release_update_20 ON release_tag IS 'The path for this trigger is tags';

CREATE TRIGGER search_release_delete_21 BEFORE DELETE ON tag
    FOR EACH ROW EXECUTE PROCEDURE search_release_delete_21();
COMMENT ON TRIGGER search_release_delete_21 ON tag IS 'The path for this trigger is tags.tag';

CREATE TRIGGER search_release_insert_21 AFTER INSERT ON tag
    FOR EACH ROW EXECUTE PROCEDURE search_release_insert_21();
COMMENT ON TRIGGER search_release_insert_21 ON tag IS 'The path for this trigger is tags.tag';

CREATE TRIGGER search_release_update_21 AFTER UPDATE ON tag
    FOR EACH ROW EXECUTE PROCEDURE search_release_update_21();
COMMENT ON TRIGGER search_release_update_21 ON tag IS 'The path for this trigger is tags.tag';

CREATE TRIGGER search_release_group_delete_0 BEFORE DELETE ON release_group
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_delete_0();
COMMENT ON TRIGGER search_release_group_delete_0 ON release_group IS 'The path for this trigger is direct';

CREATE TRIGGER search_release_group_insert_0 AFTER INSERT ON release_group
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_insert_0();
COMMENT ON TRIGGER search_release_group_insert_0 ON release_group IS 'The path for this trigger is direct';

CREATE TRIGGER search_release_group_update_0 AFTER UPDATE ON release_group
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_update_0();
COMMENT ON TRIGGER search_release_group_update_0 ON release_group IS 'The path for this trigger is direct';

CREATE TRIGGER search_release_group_delete_1 BEFORE DELETE ON artist_credit
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_delete_1();
COMMENT ON TRIGGER search_release_group_delete_1 ON artist_credit IS 'The path for this trigger is artist_credit';

CREATE TRIGGER search_release_group_insert_1 AFTER INSERT ON artist_credit
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_insert_1();
COMMENT ON TRIGGER search_release_group_insert_1 ON artist_credit IS 'The path for this trigger is artist_credit';

CREATE TRIGGER search_release_group_update_1 AFTER UPDATE ON artist_credit
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_update_1();
COMMENT ON TRIGGER search_release_group_update_1 ON artist_credit IS 'The path for this trigger is artist_credit';

CREATE TRIGGER search_release_group_delete_2 BEFORE DELETE ON artist_credit_name
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_delete_2();
COMMENT ON TRIGGER search_release_group_delete_2 ON artist_credit_name IS 'The path for this trigger is artist_credit.artists';

CREATE TRIGGER search_release_group_insert_2 AFTER INSERT ON artist_credit_name
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_insert_2();
COMMENT ON TRIGGER search_release_group_insert_2 ON artist_credit_name IS 'The path for this trigger is artist_credit.artists';

CREATE TRIGGER search_release_group_update_2 AFTER UPDATE ON artist_credit_name
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_update_2();
COMMENT ON TRIGGER search_release_group_update_2 ON artist_credit_name IS 'The path for this trigger is artist_credit.artists';

CREATE TRIGGER search_release_group_delete_3 BEFORE DELETE ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_delete_3();
COMMENT ON TRIGGER search_release_group_delete_3 ON artist IS 'The path for this trigger is artist_credit.artists.artist';

CREATE TRIGGER search_release_group_insert_3 AFTER INSERT ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_insert_3();
COMMENT ON TRIGGER search_release_group_insert_3 ON artist IS 'The path for this trigger is artist_credit.artists.artist';

CREATE TRIGGER search_release_group_update_3 AFTER UPDATE ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_update_3();
COMMENT ON TRIGGER search_release_group_update_3 ON artist IS 'The path for this trigger is artist_credit.artists.artist';

CREATE TRIGGER search_release_group_delete_4 BEFORE DELETE ON release
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_delete_4();
COMMENT ON TRIGGER search_release_group_delete_4 ON release IS 'The path for this trigger is releases';

CREATE TRIGGER search_release_group_insert_4 AFTER INSERT ON release
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_insert_4();
COMMENT ON TRIGGER search_release_group_insert_4 ON release IS 'The path for this trigger is releases';

CREATE TRIGGER search_release_group_update_4 AFTER UPDATE ON release
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_update_4();
COMMENT ON TRIGGER search_release_group_update_4 ON release IS 'The path for this trigger is releases';

CREATE TRIGGER search_release_group_delete_5 BEFORE DELETE ON release_status
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_delete_5();
COMMENT ON TRIGGER search_release_group_delete_5 ON release_status IS 'The path for this trigger is releases.status';

CREATE TRIGGER search_release_group_insert_5 AFTER INSERT ON release_status
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_insert_5();
COMMENT ON TRIGGER search_release_group_insert_5 ON release_status IS 'The path for this trigger is releases.status';

CREATE TRIGGER search_release_group_update_5 AFTER UPDATE ON release_status
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_update_5();
COMMENT ON TRIGGER search_release_group_update_5 ON release_status IS 'The path for this trigger is releases.status';

CREATE TRIGGER search_release_group_delete_6 BEFORE DELETE ON release_group_tag
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_delete_6();
COMMENT ON TRIGGER search_release_group_delete_6 ON release_group_tag IS 'The path for this trigger is tags';

CREATE TRIGGER search_release_group_insert_6 AFTER INSERT ON release_group_tag
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_insert_6();
COMMENT ON TRIGGER search_release_group_insert_6 ON release_group_tag IS 'The path for this trigger is tags';

CREATE TRIGGER search_release_group_update_6 AFTER UPDATE ON release_group_tag
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_update_6();
COMMENT ON TRIGGER search_release_group_update_6 ON release_group_tag IS 'The path for this trigger is tags';

CREATE TRIGGER search_release_group_delete_7 BEFORE DELETE ON tag
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_delete_7();
COMMENT ON TRIGGER search_release_group_delete_7 ON tag IS 'The path for this trigger is tags.tag';

CREATE TRIGGER search_release_group_insert_7 AFTER INSERT ON tag
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_insert_7();
COMMENT ON TRIGGER search_release_group_insert_7 ON tag IS 'The path for this trigger is tags.tag';

CREATE TRIGGER search_release_group_update_7 AFTER UPDATE ON tag
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_update_7();
COMMENT ON TRIGGER search_release_group_update_7 ON tag IS 'The path for this trigger is tags.tag';

CREATE TRIGGER search_release_group_delete_8 BEFORE DELETE ON release_group_primary_type
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_delete_8();
COMMENT ON TRIGGER search_release_group_delete_8 ON release_group_primary_type IS 'The path for this trigger is type';

CREATE TRIGGER search_release_group_insert_8 AFTER INSERT ON release_group_primary_type
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_insert_8();
COMMENT ON TRIGGER search_release_group_insert_8 ON release_group_primary_type IS 'The path for this trigger is type';

CREATE TRIGGER search_release_group_update_8 AFTER UPDATE ON release_group_primary_type
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_update_8();
COMMENT ON TRIGGER search_release_group_update_8 ON release_group_primary_type IS 'The path for this trigger is type';

CREATE TRIGGER search_release_group_delete_9 BEFORE DELETE ON release_group_secondary_type_join
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_delete_9();
COMMENT ON TRIGGER search_release_group_delete_9 ON release_group_secondary_type_join IS 'The path for this trigger is secondary_types';

CREATE TRIGGER search_release_group_insert_9 AFTER INSERT ON release_group_secondary_type_join
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_insert_9();
COMMENT ON TRIGGER search_release_group_insert_9 ON release_group_secondary_type_join IS 'The path for this trigger is secondary_types';

CREATE TRIGGER search_release_group_update_9 AFTER UPDATE ON release_group_secondary_type_join
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_update_9();
COMMENT ON TRIGGER search_release_group_update_9 ON release_group_secondary_type_join IS 'The path for this trigger is secondary_types';

CREATE TRIGGER search_release_group_delete_10 BEFORE DELETE ON release_group_secondary_type
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_delete_10();
COMMENT ON TRIGGER search_release_group_delete_10 ON release_group_secondary_type IS 'The path for this trigger is secondary_types.secondary_type';

CREATE TRIGGER search_release_group_insert_10 AFTER INSERT ON release_group_secondary_type
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_insert_10();
COMMENT ON TRIGGER search_release_group_insert_10 ON release_group_secondary_type IS 'The path for this trigger is secondary_types.secondary_type';

CREATE TRIGGER search_release_group_update_10 AFTER UPDATE ON release_group_secondary_type
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_update_10();
COMMENT ON TRIGGER search_release_group_update_10 ON release_group_secondary_type IS 'The path for this trigger is secondary_types.secondary_type';

CREATE TRIGGER search_series_delete_0 BEFORE DELETE ON series
    FOR EACH ROW EXECUTE PROCEDURE search_series_delete_0();
COMMENT ON TRIGGER search_series_delete_0 ON series IS 'The path for this trigger is direct';

CREATE TRIGGER search_series_insert_0 AFTER INSERT ON series
    FOR EACH ROW EXECUTE PROCEDURE search_series_insert_0();
COMMENT ON TRIGGER search_series_insert_0 ON series IS 'The path for this trigger is direct';

CREATE TRIGGER search_series_update_0 AFTER UPDATE ON series
    FOR EACH ROW EXECUTE PROCEDURE search_series_update_0();
COMMENT ON TRIGGER search_series_update_0 ON series IS 'The path for this trigger is direct';

CREATE TRIGGER search_series_delete_1 BEFORE DELETE ON series_alias
    FOR EACH ROW EXECUTE PROCEDURE search_series_delete_1();
COMMENT ON TRIGGER search_series_delete_1 ON series_alias IS 'The path for this trigger is aliases';

CREATE TRIGGER search_series_insert_1 AFTER INSERT ON series_alias
    FOR EACH ROW EXECUTE PROCEDURE search_series_insert_1();
COMMENT ON TRIGGER search_series_insert_1 ON series_alias IS 'The path for this trigger is aliases';

CREATE TRIGGER search_series_update_1 AFTER UPDATE ON series_alias
    FOR EACH ROW EXECUTE PROCEDURE search_series_update_1();
COMMENT ON TRIGGER search_series_update_1 ON series_alias IS 'The path for this trigger is aliases';

CREATE TRIGGER search_series_delete_2 BEFORE DELETE ON link_attribute_type
    FOR EACH ROW EXECUTE PROCEDURE search_series_delete_2();
COMMENT ON TRIGGER search_series_delete_2 ON link_attribute_type IS 'The path for this trigger is link_attribute_type';

CREATE TRIGGER search_series_insert_2 AFTER INSERT ON link_attribute_type
    FOR EACH ROW EXECUTE PROCEDURE search_series_insert_2();
COMMENT ON TRIGGER search_series_insert_2 ON link_attribute_type IS 'The path for this trigger is link_attribute_type';

CREATE TRIGGER search_series_update_2 AFTER UPDATE ON link_attribute_type
    FOR EACH ROW EXECUTE PROCEDURE search_series_update_2();
COMMENT ON TRIGGER search_series_update_2 ON link_attribute_type IS 'The path for this trigger is link_attribute_type';

CREATE TRIGGER search_series_delete_3 BEFORE DELETE ON series_tag
    FOR EACH ROW EXECUTE PROCEDURE search_series_delete_3();
COMMENT ON TRIGGER search_series_delete_3 ON series_tag IS 'The path for this trigger is tags';

CREATE TRIGGER search_series_insert_3 AFTER INSERT ON series_tag
    FOR EACH ROW EXECUTE PROCEDURE search_series_insert_3();
COMMENT ON TRIGGER search_series_insert_3 ON series_tag IS 'The path for this trigger is tags';

CREATE TRIGGER search_series_update_3 AFTER UPDATE ON series_tag
    FOR EACH ROW EXECUTE PROCEDURE search_series_update_3();
COMMENT ON TRIGGER search_series_update_3 ON series_tag IS 'The path for this trigger is tags';

CREATE TRIGGER search_series_delete_4 BEFORE DELETE ON tag
    FOR EACH ROW EXECUTE PROCEDURE search_series_delete_4();
COMMENT ON TRIGGER search_series_delete_4 ON tag IS 'The path for this trigger is tags.tag';

CREATE TRIGGER search_series_insert_4 AFTER INSERT ON tag
    FOR EACH ROW EXECUTE PROCEDURE search_series_insert_4();
COMMENT ON TRIGGER search_series_insert_4 ON tag IS 'The path for this trigger is tags.tag';

CREATE TRIGGER search_series_update_4 AFTER UPDATE ON tag
    FOR EACH ROW EXECUTE PROCEDURE search_series_update_4();
COMMENT ON TRIGGER search_series_update_4 ON tag IS 'The path for this trigger is tags.tag';

CREATE TRIGGER search_series_delete_5 BEFORE DELETE ON series_type
    FOR EACH ROW EXECUTE PROCEDURE search_series_delete_5();
COMMENT ON TRIGGER search_series_delete_5 ON series_type IS 'The path for this trigger is type';

CREATE TRIGGER search_series_insert_5 AFTER INSERT ON series_type
    FOR EACH ROW EXECUTE PROCEDURE search_series_insert_5();
COMMENT ON TRIGGER search_series_insert_5 ON series_type IS 'The path for this trigger is type';

CREATE TRIGGER search_series_update_5 AFTER UPDATE ON series_type
    FOR EACH ROW EXECUTE PROCEDURE search_series_update_5();
COMMENT ON TRIGGER search_series_update_5 ON series_type IS 'The path for this trigger is type';

CREATE TRIGGER search_tag_delete_0 BEFORE DELETE ON tag
    FOR EACH ROW EXECUTE PROCEDURE search_tag_delete_0();
COMMENT ON TRIGGER search_tag_delete_0 ON tag IS 'The path for this trigger is direct';

CREATE TRIGGER search_tag_insert_0 AFTER INSERT ON tag
    FOR EACH ROW EXECUTE PROCEDURE search_tag_insert_0();
COMMENT ON TRIGGER search_tag_insert_0 ON tag IS 'The path for this trigger is direct';

CREATE TRIGGER search_tag_update_0 AFTER UPDATE ON tag
    FOR EACH ROW EXECUTE PROCEDURE search_tag_update_0();
COMMENT ON TRIGGER search_tag_update_0 ON tag IS 'The path for this trigger is direct';

CREATE TRIGGER search_url_delete_0 BEFORE DELETE ON url
    FOR EACH ROW EXECUTE PROCEDURE search_url_delete_0();
COMMENT ON TRIGGER search_url_delete_0 ON url IS 'The path for this trigger is direct';

CREATE TRIGGER search_url_insert_0 AFTER INSERT ON url
    FOR EACH ROW EXECUTE PROCEDURE search_url_insert_0();
COMMENT ON TRIGGER search_url_insert_0 ON url IS 'The path for this trigger is direct';

CREATE TRIGGER search_url_update_0 AFTER UPDATE ON url
    FOR EACH ROW EXECUTE PROCEDURE search_url_update_0();
COMMENT ON TRIGGER search_url_update_0 ON url IS 'The path for this trigger is direct';

CREATE TRIGGER search_work_delete_0 BEFORE DELETE ON work
    FOR EACH ROW EXECUTE PROCEDURE search_work_delete_0();
COMMENT ON TRIGGER search_work_delete_0 ON work IS 'The path for this trigger is direct';

CREATE TRIGGER search_work_insert_0 AFTER INSERT ON work
    FOR EACH ROW EXECUTE PROCEDURE search_work_insert_0();
COMMENT ON TRIGGER search_work_insert_0 ON work IS 'The path for this trigger is direct';

CREATE TRIGGER search_work_update_0 AFTER UPDATE ON work
    FOR EACH ROW EXECUTE PROCEDURE search_work_update_0();
COMMENT ON TRIGGER search_work_update_0 ON work IS 'The path for this trigger is direct';

CREATE TRIGGER search_work_delete_1 BEFORE DELETE ON work_alias
    FOR EACH ROW EXECUTE PROCEDURE search_work_delete_1();
COMMENT ON TRIGGER search_work_delete_1 ON work_alias IS 'The path for this trigger is aliases';

CREATE TRIGGER search_work_insert_1 AFTER INSERT ON work_alias
    FOR EACH ROW EXECUTE PROCEDURE search_work_insert_1();
COMMENT ON TRIGGER search_work_insert_1 ON work_alias IS 'The path for this trigger is aliases';

CREATE TRIGGER search_work_update_1 AFTER UPDATE ON work_alias
    FOR EACH ROW EXECUTE PROCEDURE search_work_update_1();
COMMENT ON TRIGGER search_work_update_1 ON work_alias IS 'The path for this trigger is aliases';

CREATE TRIGGER search_work_delete_2 BEFORE DELETE ON l_artist_work
    FOR EACH ROW EXECUTE PROCEDURE search_work_delete_2();
COMMENT ON TRIGGER search_work_delete_2 ON l_artist_work IS 'The path for this trigger is artist_links';

CREATE TRIGGER search_work_insert_2 AFTER INSERT ON l_artist_work
    FOR EACH ROW EXECUTE PROCEDURE search_work_insert_2();
COMMENT ON TRIGGER search_work_insert_2 ON l_artist_work IS 'The path for this trigger is artist_links';

CREATE TRIGGER search_work_update_2 AFTER UPDATE ON l_artist_work
    FOR EACH ROW EXECUTE PROCEDURE search_work_update_2();
COMMENT ON TRIGGER search_work_update_2 ON l_artist_work IS 'The path for this trigger is artist_links';

CREATE TRIGGER search_work_delete_3 BEFORE DELETE ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_work_delete_3();
COMMENT ON TRIGGER search_work_delete_3 ON artist IS 'The path for this trigger is artist_links.artist';

CREATE TRIGGER search_work_insert_3 AFTER INSERT ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_work_insert_3();
COMMENT ON TRIGGER search_work_insert_3 ON artist IS 'The path for this trigger is artist_links.artist';

CREATE TRIGGER search_work_update_3 AFTER UPDATE ON artist
    FOR EACH ROW EXECUTE PROCEDURE search_work_update_3();
COMMENT ON TRIGGER search_work_update_3 ON artist IS 'The path for this trigger is artist_links.artist';

CREATE TRIGGER search_work_delete_4 BEFORE DELETE ON iswc
    FOR EACH ROW EXECUTE PROCEDURE search_work_delete_4();
COMMENT ON TRIGGER search_work_delete_4 ON iswc IS 'The path for this trigger is iswcs';

CREATE TRIGGER search_work_insert_4 AFTER INSERT ON iswc
    FOR EACH ROW EXECUTE PROCEDURE search_work_insert_4();
COMMENT ON TRIGGER search_work_insert_4 ON iswc IS 'The path for this trigger is iswcs';

CREATE TRIGGER search_work_update_4 AFTER UPDATE ON iswc
    FOR EACH ROW EXECUTE PROCEDURE search_work_update_4();
COMMENT ON TRIGGER search_work_update_4 ON iswc IS 'The path for this trigger is iswcs';

CREATE TRIGGER search_work_delete_5 BEFORE DELETE ON language
    FOR EACH ROW EXECUTE PROCEDURE search_work_delete_5();
COMMENT ON TRIGGER search_work_delete_5 ON language IS 'The path for this trigger is language';

CREATE TRIGGER search_work_insert_5 AFTER INSERT ON language
    FOR EACH ROW EXECUTE PROCEDURE search_work_insert_5();
COMMENT ON TRIGGER search_work_insert_5 ON language IS 'The path for this trigger is language';

CREATE TRIGGER search_work_update_5 AFTER UPDATE ON language
    FOR EACH ROW EXECUTE PROCEDURE search_work_update_5();
COMMENT ON TRIGGER search_work_update_5 ON language IS 'The path for this trigger is language';

CREATE TRIGGER search_work_delete_6 BEFORE DELETE ON work_tag
    FOR EACH ROW EXECUTE PROCEDURE search_work_delete_6();
COMMENT ON TRIGGER search_work_delete_6 ON work_tag IS 'The path for this trigger is tags';

CREATE TRIGGER search_work_insert_6 AFTER INSERT ON work_tag
    FOR EACH ROW EXECUTE PROCEDURE search_work_insert_6();
COMMENT ON TRIGGER search_work_insert_6 ON work_tag IS 'The path for this trigger is tags';

CREATE TRIGGER search_work_update_6 AFTER UPDATE ON work_tag
    FOR EACH ROW EXECUTE PROCEDURE search_work_update_6();
COMMENT ON TRIGGER search_work_update_6 ON work_tag IS 'The path for this trigger is tags';

CREATE TRIGGER search_work_delete_7 BEFORE DELETE ON tag
    FOR EACH ROW EXECUTE PROCEDURE search_work_delete_7();
COMMENT ON TRIGGER search_work_delete_7 ON tag IS 'The path for this trigger is tags.tag';

CREATE TRIGGER search_work_insert_7 AFTER INSERT ON tag
    FOR EACH ROW EXECUTE PROCEDURE search_work_insert_7();
COMMENT ON TRIGGER search_work_insert_7 ON tag IS 'The path for this trigger is tags.tag';

CREATE TRIGGER search_work_update_7 AFTER UPDATE ON tag
    FOR EACH ROW EXECUTE PROCEDURE search_work_update_7();
COMMENT ON TRIGGER search_work_update_7 ON tag IS 'The path for this trigger is tags.tag';

CREATE TRIGGER search_work_delete_8 BEFORE DELETE ON work_type
    FOR EACH ROW EXECUTE PROCEDURE search_work_delete_8();
COMMENT ON TRIGGER search_work_delete_8 ON work_type IS 'The path for this trigger is type';

CREATE TRIGGER search_work_insert_8 AFTER INSERT ON work_type
    FOR EACH ROW EXECUTE PROCEDURE search_work_insert_8();
COMMENT ON TRIGGER search_work_insert_8 ON work_type IS 'The path for this trigger is type';

CREATE TRIGGER search_work_update_8 AFTER UPDATE ON work_type
    FOR EACH ROW EXECUTE PROCEDURE search_work_update_8();
COMMENT ON TRIGGER search_work_update_8 ON work_type IS 'The path for this trigger is type';
COMMIT;

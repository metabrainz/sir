-- Automatically generated, do not edit!
\set ON_ERROR_STOP 1
BEGIN;

CREATE TRIGGER search_annotation_insert AFTER INSERT ON musicbrainz.annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_insert();

CREATE TRIGGER search_annotation_update AFTER UPDATE OF editor, id, text ON musicbrainz.annotation
    FOR EACH ROW
    WHEN ((OLD.editor, OLD.id, OLD.text) IS DISTINCT FROM (NEW.editor, NEW.id, NEW.text))
    EXECUTE PROCEDURE search_annotation_update();

CREATE TRIGGER search_annotation_delete BEFORE DELETE ON musicbrainz.annotation
    FOR EACH ROW EXECUTE PROCEDURE search_annotation_delete();

CREATE TRIGGER search_area_annotation_insert AFTER INSERT ON musicbrainz.area_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_area_annotation_insert();

CREATE TRIGGER search_area_annotation_update AFTER UPDATE OF annotation, area ON musicbrainz.area_annotation
    FOR EACH ROW
    WHEN ((OLD.annotation, OLD.area) IS DISTINCT FROM (NEW.annotation, NEW.area))
    EXECUTE PROCEDURE search_area_annotation_update();

CREATE TRIGGER search_area_annotation_delete BEFORE DELETE ON musicbrainz.area_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_area_annotation_delete();

CREATE TRIGGER search_area_insert AFTER INSERT ON musicbrainz.area
    FOR EACH ROW EXECUTE PROCEDURE search_area_insert();

CREATE TRIGGER search_area_update AFTER UPDATE OF begin_date_day, begin_date_month, begin_date_year, comment, end_date_day, end_date_month, end_date_year, ended, gid, name, type ON musicbrainz.area
    FOR EACH ROW
    WHEN ((OLD.begin_date_day, OLD.begin_date_month, OLD.begin_date_year, OLD.comment, OLD.end_date_day, OLD.end_date_month, OLD.end_date_year, OLD.ended, OLD.gid, OLD.name, OLD.type) IS DISTINCT FROM (NEW.begin_date_day, NEW.begin_date_month, NEW.begin_date_year, NEW.comment, NEW.end_date_day, NEW.end_date_month, NEW.end_date_year, NEW.ended, NEW.gid, NEW.name, NEW.type))
    EXECUTE PROCEDURE search_area_update();

CREATE TRIGGER search_area_delete BEFORE DELETE ON musicbrainz.area
    FOR EACH ROW EXECUTE PROCEDURE search_area_delete();

CREATE TRIGGER search_artist_annotation_insert AFTER INSERT ON musicbrainz.artist_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_artist_annotation_insert();

CREATE TRIGGER search_artist_annotation_update AFTER UPDATE OF annotation, artist ON musicbrainz.artist_annotation
    FOR EACH ROW
    WHEN ((OLD.annotation, OLD.artist) IS DISTINCT FROM (NEW.annotation, NEW.artist))
    EXECUTE PROCEDURE search_artist_annotation_update();

CREATE TRIGGER search_artist_annotation_delete BEFORE DELETE ON musicbrainz.artist_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_artist_annotation_delete();

CREATE TRIGGER search_artist_insert AFTER INSERT ON musicbrainz.artist
    FOR EACH ROW EXECUTE PROCEDURE search_artist_insert();

CREATE TRIGGER search_artist_update AFTER UPDATE OF area, begin_area, begin_date_day, begin_date_month, begin_date_year, comment, end_area, end_date_day, end_date_month, end_date_year, ended, gender, gid, name, sort_name, type ON musicbrainz.artist
    FOR EACH ROW
    WHEN ((OLD.area, OLD.begin_area, OLD.begin_date_day, OLD.begin_date_month, OLD.begin_date_year, OLD.comment, OLD.end_area, OLD.end_date_day, OLD.end_date_month, OLD.end_date_year, OLD.ended, OLD.gender, OLD.gid, OLD.name, OLD.sort_name, OLD.type) IS DISTINCT FROM (NEW.area, NEW.begin_area, NEW.begin_date_day, NEW.begin_date_month, NEW.begin_date_year, NEW.comment, NEW.end_area, NEW.end_date_day, NEW.end_date_month, NEW.end_date_year, NEW.ended, NEW.gender, NEW.gid, NEW.name, NEW.sort_name, NEW.type))
    EXECUTE PROCEDURE search_artist_update();

CREATE TRIGGER search_artist_delete BEFORE DELETE ON musicbrainz.artist
    FOR EACH ROW EXECUTE PROCEDURE search_artist_delete();

CREATE TRIGGER search_event_annotation_insert AFTER INSERT ON musicbrainz.event_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_event_annotation_insert();

CREATE TRIGGER search_event_annotation_update AFTER UPDATE OF annotation, event ON musicbrainz.event_annotation
    FOR EACH ROW
    WHEN ((OLD.annotation, OLD.event) IS DISTINCT FROM (NEW.annotation, NEW.event))
    EXECUTE PROCEDURE search_event_annotation_update();

CREATE TRIGGER search_event_annotation_delete BEFORE DELETE ON musicbrainz.event_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_event_annotation_delete();

CREATE TRIGGER search_event_insert AFTER INSERT ON musicbrainz.event
    FOR EACH ROW EXECUTE PROCEDURE search_event_insert();

CREATE TRIGGER search_event_update AFTER UPDATE OF begin_date_day, begin_date_month, begin_date_year, comment, end_date_day, end_date_month, end_date_year, ended, gid, name, time, type ON musicbrainz.event
    FOR EACH ROW
    WHEN ((OLD.begin_date_day, OLD.begin_date_month, OLD.begin_date_year, OLD.comment, OLD.end_date_day, OLD.end_date_month, OLD.end_date_year, OLD.ended, OLD.gid, OLD.name, OLD.time, OLD.type) IS DISTINCT FROM (NEW.begin_date_day, NEW.begin_date_month, NEW.begin_date_year, NEW.comment, NEW.end_date_day, NEW.end_date_month, NEW.end_date_year, NEW.ended, NEW.gid, NEW.name, NEW.time, NEW.type))
    EXECUTE PROCEDURE search_event_update();

CREATE TRIGGER search_event_delete BEFORE DELETE ON musicbrainz.event
    FOR EACH ROW EXECUTE PROCEDURE search_event_delete();

CREATE TRIGGER search_genre_annotation_insert AFTER INSERT ON musicbrainz.genre_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_genre_annotation_insert();

CREATE TRIGGER search_genre_annotation_update AFTER UPDATE OF annotation, genre ON musicbrainz.genre_annotation
    FOR EACH ROW
    WHEN ((OLD.annotation, OLD.genre) IS DISTINCT FROM (NEW.annotation, NEW.genre))
    EXECUTE PROCEDURE search_genre_annotation_update();

CREATE TRIGGER search_genre_annotation_delete BEFORE DELETE ON musicbrainz.genre_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_genre_annotation_delete();

CREATE TRIGGER search_genre_insert AFTER INSERT ON musicbrainz.genre
    FOR EACH ROW EXECUTE PROCEDURE search_genre_insert();

CREATE TRIGGER search_genre_update AFTER UPDATE OF gid, name ON musicbrainz.genre
    FOR EACH ROW
    WHEN ((OLD.gid, OLD.name) IS DISTINCT FROM (NEW.gid, NEW.name))
    EXECUTE PROCEDURE search_genre_update();

CREATE TRIGGER search_genre_delete BEFORE DELETE ON musicbrainz.genre
    FOR EACH ROW EXECUTE PROCEDURE search_genre_delete();

CREATE TRIGGER search_instrument_annotation_insert AFTER INSERT ON musicbrainz.instrument_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_annotation_insert();

CREATE TRIGGER search_instrument_annotation_update AFTER UPDATE OF annotation, instrument ON musicbrainz.instrument_annotation
    FOR EACH ROW
    WHEN ((OLD.annotation, OLD.instrument) IS DISTINCT FROM (NEW.annotation, NEW.instrument))
    EXECUTE PROCEDURE search_instrument_annotation_update();

CREATE TRIGGER search_instrument_annotation_delete BEFORE DELETE ON musicbrainz.instrument_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_annotation_delete();

CREATE TRIGGER search_instrument_insert AFTER INSERT ON musicbrainz.instrument
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_insert();

CREATE TRIGGER search_instrument_update AFTER UPDATE OF comment, description, gid, name, type ON musicbrainz.instrument
    FOR EACH ROW
    WHEN ((OLD.comment, OLD.description, OLD.gid, OLD.name, OLD.type) IS DISTINCT FROM (NEW.comment, NEW.description, NEW.gid, NEW.name, NEW.type))
    EXECUTE PROCEDURE search_instrument_update();

CREATE TRIGGER search_instrument_delete BEFORE DELETE ON musicbrainz.instrument
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_delete();

CREATE TRIGGER search_label_annotation_insert AFTER INSERT ON musicbrainz.label_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_label_annotation_insert();

CREATE TRIGGER search_label_annotation_update AFTER UPDATE OF annotation, label ON musicbrainz.label_annotation
    FOR EACH ROW
    WHEN ((OLD.annotation, OLD.label) IS DISTINCT FROM (NEW.annotation, NEW.label))
    EXECUTE PROCEDURE search_label_annotation_update();

CREATE TRIGGER search_label_annotation_delete BEFORE DELETE ON musicbrainz.label_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_label_annotation_delete();

CREATE TRIGGER search_label_insert AFTER INSERT ON musicbrainz.label
    FOR EACH ROW EXECUTE PROCEDURE search_label_insert();

CREATE TRIGGER search_label_update AFTER UPDATE OF area, begin_date_day, begin_date_month, begin_date_year, comment, end_date_day, end_date_month, end_date_year, ended, gid, label_code, name, type ON musicbrainz.label
    FOR EACH ROW
    WHEN ((OLD.area, OLD.begin_date_day, OLD.begin_date_month, OLD.begin_date_year, OLD.comment, OLD.end_date_day, OLD.end_date_month, OLD.end_date_year, OLD.ended, OLD.gid, OLD.label_code, OLD.name, OLD.type) IS DISTINCT FROM (NEW.area, NEW.begin_date_day, NEW.begin_date_month, NEW.begin_date_year, NEW.comment, NEW.end_date_day, NEW.end_date_month, NEW.end_date_year, NEW.ended, NEW.gid, NEW.label_code, NEW.name, NEW.type))
    EXECUTE PROCEDURE search_label_update();

CREATE TRIGGER search_label_delete BEFORE DELETE ON musicbrainz.label
    FOR EACH ROW EXECUTE PROCEDURE search_label_delete();

CREATE TRIGGER search_place_annotation_insert AFTER INSERT ON musicbrainz.place_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_place_annotation_insert();

CREATE TRIGGER search_place_annotation_update AFTER UPDATE OF annotation, place ON musicbrainz.place_annotation
    FOR EACH ROW
    WHEN ((OLD.annotation, OLD.place) IS DISTINCT FROM (NEW.annotation, NEW.place))
    EXECUTE PROCEDURE search_place_annotation_update();

CREATE TRIGGER search_place_annotation_delete BEFORE DELETE ON musicbrainz.place_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_place_annotation_delete();

CREATE TRIGGER search_place_insert AFTER INSERT ON musicbrainz.place
    FOR EACH ROW EXECUTE PROCEDURE search_place_insert();

CREATE TRIGGER search_place_update AFTER UPDATE OF address, area, begin_date_day, begin_date_month, begin_date_year, comment, coordinates, end_date_day, end_date_month, end_date_year, ended, gid, name, type ON musicbrainz.place
    FOR EACH ROW
    WHEN ((OLD.address, OLD.area, OLD.begin_date_day, OLD.begin_date_month, OLD.begin_date_year, OLD.comment, OLD.end_date_day, OLD.end_date_month, OLD.end_date_year, OLD.ended, OLD.gid, OLD.name, OLD.type) IS DISTINCT FROM (NEW.address, NEW.area, NEW.begin_date_day, NEW.begin_date_month, NEW.begin_date_year, NEW.comment, NEW.end_date_day, NEW.end_date_month, NEW.end_date_year, NEW.ended, NEW.gid, NEW.name, NEW.type))
    EXECUTE PROCEDURE search_place_update();

CREATE TRIGGER search_place_delete BEFORE DELETE ON musicbrainz.place
    FOR EACH ROW EXECUTE PROCEDURE search_place_delete();

CREATE TRIGGER search_recording_annotation_insert AFTER INSERT ON musicbrainz.recording_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_recording_annotation_insert();

CREATE TRIGGER search_recording_annotation_update AFTER UPDATE OF annotation, recording ON musicbrainz.recording_annotation
    FOR EACH ROW
    WHEN ((OLD.annotation, OLD.recording) IS DISTINCT FROM (NEW.annotation, NEW.recording))
    EXECUTE PROCEDURE search_recording_annotation_update();

CREATE TRIGGER search_recording_annotation_delete BEFORE DELETE ON musicbrainz.recording_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_recording_annotation_delete();

CREATE TRIGGER search_recording_insert AFTER INSERT ON musicbrainz.recording
    FOR EACH ROW EXECUTE PROCEDURE search_recording_insert();

CREATE TRIGGER search_recording_update AFTER UPDATE OF artist_credit, comment, gid, length, name, video ON musicbrainz.recording
    FOR EACH ROW
    WHEN ((OLD.artist_credit, OLD.comment, OLD.gid, OLD.length, OLD.name, OLD.video) IS DISTINCT FROM (NEW.artist_credit, NEW.comment, NEW.gid, NEW.length, NEW.name, NEW.video))
    EXECUTE PROCEDURE search_recording_update();

CREATE TRIGGER search_recording_delete BEFORE DELETE ON musicbrainz.recording
    FOR EACH ROW EXECUTE PROCEDURE search_recording_delete();

CREATE TRIGGER search_release_annotation_insert AFTER INSERT ON musicbrainz.release_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_release_annotation_insert();

CREATE TRIGGER search_release_annotation_update AFTER UPDATE OF annotation, release ON musicbrainz.release_annotation
    FOR EACH ROW
    WHEN ((OLD.annotation, OLD.release) IS DISTINCT FROM (NEW.annotation, NEW.release))
    EXECUTE PROCEDURE search_release_annotation_update();

CREATE TRIGGER search_release_annotation_delete BEFORE DELETE ON musicbrainz.release_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_release_annotation_delete();

CREATE TRIGGER search_release_insert AFTER INSERT ON musicbrainz.release
    FOR EACH ROW EXECUTE PROCEDURE search_release_insert();

CREATE TRIGGER search_release_update AFTER UPDATE OF artist_credit, barcode, comment, gid, language, name, packaging, quality, release_group, script, status ON musicbrainz.release
    FOR EACH ROW
    WHEN ((OLD.artist_credit, OLD.barcode, OLD.comment, OLD.gid, OLD.language, OLD.name, OLD.packaging, OLD.quality, OLD.release_group, OLD.script, OLD.status) IS DISTINCT FROM (NEW.artist_credit, NEW.barcode, NEW.comment, NEW.gid, NEW.language, NEW.name, NEW.packaging, NEW.quality, NEW.release_group, NEW.script, NEW.status))
    EXECUTE PROCEDURE search_release_update();

CREATE TRIGGER search_release_delete BEFORE DELETE ON musicbrainz.release
    FOR EACH ROW EXECUTE PROCEDURE search_release_delete();

CREATE TRIGGER search_release_group_annotation_insert AFTER INSERT ON musicbrainz.release_group_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_annotation_insert();

CREATE TRIGGER search_release_group_annotation_update AFTER UPDATE OF annotation, release_group ON musicbrainz.release_group_annotation
    FOR EACH ROW
    WHEN ((OLD.annotation, OLD.release_group) IS DISTINCT FROM (NEW.annotation, NEW.release_group))
    EXECUTE PROCEDURE search_release_group_annotation_update();

CREATE TRIGGER search_release_group_annotation_delete BEFORE DELETE ON musicbrainz.release_group_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_annotation_delete();

CREATE TRIGGER search_release_group_insert AFTER INSERT ON musicbrainz.release_group
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_insert();

CREATE TRIGGER search_release_group_update AFTER UPDATE OF artist_credit, comment, gid, name, type ON musicbrainz.release_group
    FOR EACH ROW
    WHEN ((OLD.artist_credit, OLD.comment, OLD.gid, OLD.name, OLD.type) IS DISTINCT FROM (NEW.artist_credit, NEW.comment, NEW.gid, NEW.name, NEW.type))
    EXECUTE PROCEDURE search_release_group_update();

CREATE TRIGGER search_release_group_delete BEFORE DELETE ON musicbrainz.release_group
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_delete();

CREATE TRIGGER search_series_annotation_insert AFTER INSERT ON musicbrainz.series_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_series_annotation_insert();

CREATE TRIGGER search_series_annotation_update AFTER UPDATE OF annotation, series ON musicbrainz.series_annotation
    FOR EACH ROW
    WHEN ((OLD.annotation, OLD.series) IS DISTINCT FROM (NEW.annotation, NEW.series))
    EXECUTE PROCEDURE search_series_annotation_update();

CREATE TRIGGER search_series_annotation_delete BEFORE DELETE ON musicbrainz.series_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_series_annotation_delete();

CREATE TRIGGER search_series_insert AFTER INSERT ON musicbrainz.series
    FOR EACH ROW EXECUTE PROCEDURE search_series_insert();

CREATE TRIGGER search_series_update AFTER UPDATE OF comment, gid, name, ordering_type, type ON musicbrainz.series
    FOR EACH ROW
    WHEN ((OLD.comment, OLD.gid, OLD.name, OLD.ordering_type, OLD.type) IS DISTINCT FROM (NEW.comment, NEW.gid, NEW.name, NEW.ordering_type, NEW.type))
    EXECUTE PROCEDURE search_series_update();

CREATE TRIGGER search_series_delete BEFORE DELETE ON musicbrainz.series
    FOR EACH ROW EXECUTE PROCEDURE search_series_delete();

CREATE TRIGGER search_work_annotation_insert AFTER INSERT ON musicbrainz.work_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_work_annotation_insert();

CREATE TRIGGER search_work_annotation_update AFTER UPDATE OF annotation, work ON musicbrainz.work_annotation
    FOR EACH ROW
    WHEN ((OLD.annotation, OLD.work) IS DISTINCT FROM (NEW.annotation, NEW.work))
    EXECUTE PROCEDURE search_work_annotation_update();

CREATE TRIGGER search_work_annotation_delete BEFORE DELETE ON musicbrainz.work_annotation
    FOR EACH ROW EXECUTE PROCEDURE search_work_annotation_delete();

CREATE TRIGGER search_work_insert AFTER INSERT ON musicbrainz.work
    FOR EACH ROW EXECUTE PROCEDURE search_work_insert();

CREATE TRIGGER search_work_update AFTER UPDATE OF comment, gid, name, type ON musicbrainz.work
    FOR EACH ROW
    WHEN ((OLD.comment, OLD.gid, OLD.name, OLD.type) IS DISTINCT FROM (NEW.comment, NEW.gid, NEW.name, NEW.type))
    EXECUTE PROCEDURE search_work_update();

CREATE TRIGGER search_work_delete BEFORE DELETE ON musicbrainz.work
    FOR EACH ROW EXECUTE PROCEDURE search_work_delete();

CREATE TRIGGER search_area_alias_insert AFTER INSERT ON musicbrainz.area_alias
    FOR EACH ROW EXECUTE PROCEDURE search_area_alias_insert();

CREATE TRIGGER search_area_alias_update AFTER UPDATE OF area, begin_date_day, begin_date_month, begin_date_year, end_date_day, end_date_month, end_date_year, locale, name, primary_for_locale, sort_name, type ON musicbrainz.area_alias
    FOR EACH ROW
    WHEN ((OLD.area, OLD.begin_date_day, OLD.begin_date_month, OLD.begin_date_year, OLD.end_date_day, OLD.end_date_month, OLD.end_date_year, OLD.locale, OLD.name, OLD.primary_for_locale, OLD.sort_name, OLD.type) IS DISTINCT FROM (NEW.area, NEW.begin_date_day, NEW.begin_date_month, NEW.begin_date_year, NEW.end_date_day, NEW.end_date_month, NEW.end_date_year, NEW.locale, NEW.name, NEW.primary_for_locale, NEW.sort_name, NEW.type))
    EXECUTE PROCEDURE search_area_alias_update();

CREATE TRIGGER search_area_alias_delete BEFORE DELETE ON musicbrainz.area_alias
    FOR EACH ROW EXECUTE PROCEDURE search_area_alias_delete();

CREATE TRIGGER search_iso_3166_1_insert AFTER INSERT ON musicbrainz.iso_3166_1
    FOR EACH ROW EXECUTE PROCEDURE search_iso_3166_1_insert();

CREATE TRIGGER search_iso_3166_1_update AFTER UPDATE OF area, code ON musicbrainz.iso_3166_1
    FOR EACH ROW
    WHEN ((OLD.area, OLD.code) IS DISTINCT FROM (NEW.area, NEW.code))
    EXECUTE PROCEDURE search_iso_3166_1_update();

CREATE TRIGGER search_iso_3166_1_delete BEFORE DELETE ON musicbrainz.iso_3166_1
    FOR EACH ROW EXECUTE PROCEDURE search_iso_3166_1_delete();

CREATE TRIGGER search_iso_3166_2_insert AFTER INSERT ON musicbrainz.iso_3166_2
    FOR EACH ROW EXECUTE PROCEDURE search_iso_3166_2_insert();

CREATE TRIGGER search_iso_3166_2_update AFTER UPDATE OF area, code ON musicbrainz.iso_3166_2
    FOR EACH ROW
    WHEN ((OLD.area, OLD.code) IS DISTINCT FROM (NEW.area, NEW.code))
    EXECUTE PROCEDURE search_iso_3166_2_update();

CREATE TRIGGER search_iso_3166_2_delete BEFORE DELETE ON musicbrainz.iso_3166_2
    FOR EACH ROW EXECUTE PROCEDURE search_iso_3166_2_delete();

CREATE TRIGGER search_iso_3166_3_insert AFTER INSERT ON musicbrainz.iso_3166_3
    FOR EACH ROW EXECUTE PROCEDURE search_iso_3166_3_insert();

CREATE TRIGGER search_iso_3166_3_update AFTER UPDATE OF area, code ON musicbrainz.iso_3166_3
    FOR EACH ROW
    WHEN ((OLD.area, OLD.code) IS DISTINCT FROM (NEW.area, NEW.code))
    EXECUTE PROCEDURE search_iso_3166_3_update();

CREATE TRIGGER search_iso_3166_3_delete BEFORE DELETE ON musicbrainz.iso_3166_3
    FOR EACH ROW EXECUTE PROCEDURE search_iso_3166_3_delete();

CREATE TRIGGER search_area_tag_insert AFTER INSERT ON musicbrainz.area_tag
    FOR EACH ROW EXECUTE PROCEDURE search_area_tag_insert();

CREATE TRIGGER search_area_tag_update AFTER UPDATE OF area, count, tag ON musicbrainz.area_tag
    FOR EACH ROW
    WHEN ((OLD.area, OLD.count, OLD.tag) IS DISTINCT FROM (NEW.area, NEW.count, NEW.tag))
    EXECUTE PROCEDURE search_area_tag_update();

CREATE TRIGGER search_area_tag_delete BEFORE DELETE ON musicbrainz.area_tag
    FOR EACH ROW EXECUTE PROCEDURE search_area_tag_delete();

CREATE TRIGGER search_tag_insert AFTER INSERT ON musicbrainz.tag
    FOR EACH ROW EXECUTE PROCEDURE search_tag_insert();

CREATE TRIGGER search_tag_update AFTER UPDATE OF id, name ON musicbrainz.tag
    FOR EACH ROW
    WHEN ((OLD.id, OLD.name) IS DISTINCT FROM (NEW.id, NEW.name))
    EXECUTE PROCEDURE search_tag_update();

CREATE TRIGGER search_tag_delete BEFORE DELETE ON musicbrainz.tag
    FOR EACH ROW EXECUTE PROCEDURE search_tag_delete();

CREATE TRIGGER search_area_type_insert AFTER INSERT ON musicbrainz.area_type
    FOR EACH ROW EXECUTE PROCEDURE search_area_type_insert();

CREATE TRIGGER search_area_type_update AFTER UPDATE OF gid, id, name ON musicbrainz.area_type
    FOR EACH ROW
    WHEN ((OLD.gid, OLD.id, OLD.name) IS DISTINCT FROM (NEW.gid, NEW.id, NEW.name))
    EXECUTE PROCEDURE search_area_type_update();

CREATE TRIGGER search_area_type_delete BEFORE DELETE ON musicbrainz.area_type
    FOR EACH ROW EXECUTE PROCEDURE search_area_type_delete();

CREATE TRIGGER search_artist_alias_insert AFTER INSERT ON musicbrainz.artist_alias
    FOR EACH ROW EXECUTE PROCEDURE search_artist_alias_insert();

CREATE TRIGGER search_artist_alias_update AFTER UPDATE OF artist, begin_date_day, begin_date_month, begin_date_year, end_date_day, end_date_month, end_date_year, locale, name, primary_for_locale, sort_name, type ON musicbrainz.artist_alias
    FOR EACH ROW
    WHEN ((OLD.artist, OLD.begin_date_day, OLD.begin_date_month, OLD.begin_date_year, OLD.end_date_day, OLD.end_date_month, OLD.end_date_year, OLD.locale, OLD.name, OLD.primary_for_locale, OLD.sort_name, OLD.type) IS DISTINCT FROM (NEW.artist, NEW.begin_date_day, NEW.begin_date_month, NEW.begin_date_year, NEW.end_date_day, NEW.end_date_month, NEW.end_date_year, NEW.locale, NEW.name, NEW.primary_for_locale, NEW.sort_name, NEW.type))
    EXECUTE PROCEDURE search_artist_alias_update();

CREATE TRIGGER search_artist_alias_delete BEFORE DELETE ON musicbrainz.artist_alias
    FOR EACH ROW EXECUTE PROCEDURE search_artist_alias_delete();

CREATE TRIGGER search_gender_insert AFTER INSERT ON musicbrainz.gender
    FOR EACH ROW EXECUTE PROCEDURE search_gender_insert();

CREATE TRIGGER search_gender_update AFTER UPDATE OF gid, name ON musicbrainz.gender
    FOR EACH ROW
    WHEN ((OLD.gid, OLD.name) IS DISTINCT FROM (NEW.gid, NEW.name))
    EXECUTE PROCEDURE search_gender_update();

CREATE TRIGGER search_gender_delete BEFORE DELETE ON musicbrainz.gender
    FOR EACH ROW EXECUTE PROCEDURE search_gender_delete();

CREATE TRIGGER search_artist_ipi_insert AFTER INSERT ON musicbrainz.artist_ipi
    FOR EACH ROW EXECUTE PROCEDURE search_artist_ipi_insert();

CREATE TRIGGER search_artist_ipi_update AFTER UPDATE OF artist, ipi ON musicbrainz.artist_ipi
    FOR EACH ROW
    WHEN ((OLD.artist, OLD.ipi) IS DISTINCT FROM (NEW.artist, NEW.ipi))
    EXECUTE PROCEDURE search_artist_ipi_update();

CREATE TRIGGER search_artist_ipi_delete BEFORE DELETE ON musicbrainz.artist_ipi
    FOR EACH ROW EXECUTE PROCEDURE search_artist_ipi_delete();

CREATE TRIGGER search_artist_isni_insert AFTER INSERT ON musicbrainz.artist_isni
    FOR EACH ROW EXECUTE PROCEDURE search_artist_isni_insert();

CREATE TRIGGER search_artist_isni_update AFTER UPDATE OF artist, isni ON musicbrainz.artist_isni
    FOR EACH ROW
    WHEN ((OLD.artist, OLD.isni) IS DISTINCT FROM (NEW.artist, NEW.isni))
    EXECUTE PROCEDURE search_artist_isni_update();

CREATE TRIGGER search_artist_isni_delete BEFORE DELETE ON musicbrainz.artist_isni
    FOR EACH ROW EXECUTE PROCEDURE search_artist_isni_delete();

CREATE TRIGGER search_artist_tag_insert AFTER INSERT ON musicbrainz.artist_tag
    FOR EACH ROW EXECUTE PROCEDURE search_artist_tag_insert();

CREATE TRIGGER search_artist_tag_update AFTER UPDATE OF artist, count, tag ON musicbrainz.artist_tag
    FOR EACH ROW
    WHEN ((OLD.artist, OLD.count, OLD.tag) IS DISTINCT FROM (NEW.artist, NEW.count, NEW.tag))
    EXECUTE PROCEDURE search_artist_tag_update();

CREATE TRIGGER search_artist_tag_delete BEFORE DELETE ON musicbrainz.artist_tag
    FOR EACH ROW EXECUTE PROCEDURE search_artist_tag_delete();

CREATE TRIGGER search_artist_type_insert AFTER INSERT ON musicbrainz.artist_type
    FOR EACH ROW EXECUTE PROCEDURE search_artist_type_insert();

CREATE TRIGGER search_artist_type_update AFTER UPDATE OF gid, name ON musicbrainz.artist_type
    FOR EACH ROW
    WHEN ((OLD.gid, OLD.name) IS DISTINCT FROM (NEW.gid, NEW.name))
    EXECUTE PROCEDURE search_artist_type_update();

CREATE TRIGGER search_artist_type_delete BEFORE DELETE ON musicbrainz.artist_type
    FOR EACH ROW EXECUTE PROCEDURE search_artist_type_delete();

CREATE TRIGGER search_release_raw_insert AFTER INSERT ON musicbrainz.release_raw
    FOR EACH ROW EXECUTE PROCEDURE search_release_raw_insert();

CREATE TRIGGER search_release_raw_update AFTER UPDATE OF added, artist, barcode, comment, id, title ON musicbrainz.release_raw
    FOR EACH ROW
    WHEN ((OLD.added, OLD.artist, OLD.barcode, OLD.comment, OLD.id, OLD.title) IS DISTINCT FROM (NEW.added, NEW.artist, NEW.barcode, NEW.comment, NEW.id, NEW.title))
    EXECUTE PROCEDURE search_release_raw_update();

CREATE TRIGGER search_release_raw_delete BEFORE DELETE ON musicbrainz.release_raw
    FOR EACH ROW EXECUTE PROCEDURE search_release_raw_delete();

CREATE TRIGGER search_cdtoc_raw_insert AFTER INSERT ON musicbrainz.cdtoc_raw
    FOR EACH ROW EXECUTE PROCEDURE search_cdtoc_raw_insert();

CREATE TRIGGER search_cdtoc_raw_update AFTER UPDATE OF discid, release, track_count ON musicbrainz.cdtoc_raw
    FOR EACH ROW
    WHEN ((OLD.discid, OLD.release, OLD.track_count) IS DISTINCT FROM (NEW.discid, NEW.release, NEW.track_count))
    EXECUTE PROCEDURE search_cdtoc_raw_update();

CREATE TRIGGER search_cdtoc_raw_delete BEFORE DELETE ON musicbrainz.cdtoc_raw
    FOR EACH ROW EXECUTE PROCEDURE search_cdtoc_raw_delete();

CREATE TRIGGER search_editor_insert AFTER INSERT ON musicbrainz.editor
    FOR EACH ROW EXECUTE PROCEDURE search_editor_insert();

CREATE TRIGGER search_editor_update AFTER UPDATE OF area, bio, gender, id, name ON musicbrainz.editor
    FOR EACH ROW
    WHEN ((OLD.area, OLD.bio, OLD.gender, OLD.id, OLD.name) IS DISTINCT FROM (NEW.area, NEW.bio, NEW.gender, NEW.id, NEW.name))
    EXECUTE PROCEDURE search_editor_update();

CREATE TRIGGER search_editor_delete BEFORE DELETE ON musicbrainz.editor
    FOR EACH ROW EXECUTE PROCEDURE search_editor_delete();

CREATE TRIGGER search_event_alias_insert AFTER INSERT ON musicbrainz.event_alias
    FOR EACH ROW EXECUTE PROCEDURE search_event_alias_insert();

CREATE TRIGGER search_event_alias_update AFTER UPDATE OF begin_date_day, begin_date_month, begin_date_year, end_date_day, end_date_month, end_date_year, event, locale, name, primary_for_locale, sort_name, type ON musicbrainz.event_alias
    FOR EACH ROW
    WHEN ((OLD.begin_date_day, OLD.begin_date_month, OLD.begin_date_year, OLD.end_date_day, OLD.end_date_month, OLD.end_date_year, OLD.event, OLD.locale, OLD.name, OLD.primary_for_locale, OLD.sort_name, OLD.type) IS DISTINCT FROM (NEW.begin_date_day, NEW.begin_date_month, NEW.begin_date_year, NEW.end_date_day, NEW.end_date_month, NEW.end_date_year, NEW.event, NEW.locale, NEW.name, NEW.primary_for_locale, NEW.sort_name, NEW.type))
    EXECUTE PROCEDURE search_event_alias_update();

CREATE TRIGGER search_event_alias_delete BEFORE DELETE ON musicbrainz.event_alias
    FOR EACH ROW EXECUTE PROCEDURE search_event_alias_delete();

CREATE TRIGGER search_l_area_event_insert AFTER INSERT ON musicbrainz.l_area_event
    FOR EACH ROW EXECUTE PROCEDURE search_l_area_event_insert();

CREATE TRIGGER search_l_area_event_update AFTER UPDATE OF entity0, entity1, link ON musicbrainz.l_area_event
    FOR EACH ROW
    WHEN ((OLD.entity0, OLD.entity1, OLD.link) IS DISTINCT FROM (NEW.entity0, NEW.entity1, NEW.link))
    EXECUTE PROCEDURE search_l_area_event_update();

CREATE TRIGGER search_l_area_event_delete BEFORE DELETE ON musicbrainz.l_area_event
    FOR EACH ROW EXECUTE PROCEDURE search_l_area_event_delete();

CREATE TRIGGER search_l_artist_event_insert AFTER INSERT ON musicbrainz.l_artist_event
    FOR EACH ROW EXECUTE PROCEDURE search_l_artist_event_insert();

CREATE TRIGGER search_l_artist_event_update AFTER UPDATE OF entity0, entity1, link ON musicbrainz.l_artist_event
    FOR EACH ROW
    WHEN ((OLD.entity0, OLD.entity1, OLD.link) IS DISTINCT FROM (NEW.entity0, NEW.entity1, NEW.link))
    EXECUTE PROCEDURE search_l_artist_event_update();

CREATE TRIGGER search_l_artist_event_delete BEFORE DELETE ON musicbrainz.l_artist_event
    FOR EACH ROW EXECUTE PROCEDURE search_l_artist_event_delete();

CREATE TRIGGER search_l_event_place_insert AFTER INSERT ON musicbrainz.l_event_place
    FOR EACH ROW EXECUTE PROCEDURE search_l_event_place_insert();

CREATE TRIGGER search_l_event_place_update AFTER UPDATE OF entity0, entity1, link ON musicbrainz.l_event_place
    FOR EACH ROW
    WHEN ((OLD.entity0, OLD.entity1, OLD.link) IS DISTINCT FROM (NEW.entity0, NEW.entity1, NEW.link))
    EXECUTE PROCEDURE search_l_event_place_update();

CREATE TRIGGER search_l_event_place_delete BEFORE DELETE ON musicbrainz.l_event_place
    FOR EACH ROW EXECUTE PROCEDURE search_l_event_place_delete();

CREATE TRIGGER search_event_tag_insert AFTER INSERT ON musicbrainz.event_tag
    FOR EACH ROW EXECUTE PROCEDURE search_event_tag_insert();

CREATE TRIGGER search_event_tag_update AFTER UPDATE OF count, event, tag ON musicbrainz.event_tag
    FOR EACH ROW
    WHEN ((OLD.count, OLD.event, OLD.tag) IS DISTINCT FROM (NEW.count, NEW.event, NEW.tag))
    EXECUTE PROCEDURE search_event_tag_update();

CREATE TRIGGER search_event_tag_delete BEFORE DELETE ON musicbrainz.event_tag
    FOR EACH ROW EXECUTE PROCEDURE search_event_tag_delete();

CREATE TRIGGER search_event_type_insert AFTER INSERT ON musicbrainz.event_type
    FOR EACH ROW EXECUTE PROCEDURE search_event_type_insert();

CREATE TRIGGER search_event_type_update AFTER UPDATE OF gid, name ON musicbrainz.event_type
    FOR EACH ROW
    WHEN ((OLD.gid, OLD.name) IS DISTINCT FROM (NEW.gid, NEW.name))
    EXECUTE PROCEDURE search_event_type_update();

CREATE TRIGGER search_event_type_delete BEFORE DELETE ON musicbrainz.event_type
    FOR EACH ROW EXECUTE PROCEDURE search_event_type_delete();

CREATE TRIGGER search_instrument_alias_insert AFTER INSERT ON musicbrainz.instrument_alias
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_alias_insert();

CREATE TRIGGER search_instrument_alias_update AFTER UPDATE OF begin_date_day, begin_date_month, begin_date_year, end_date_day, end_date_month, end_date_year, instrument, locale, name, primary_for_locale, sort_name, type ON musicbrainz.instrument_alias
    FOR EACH ROW
    WHEN ((OLD.begin_date_day, OLD.begin_date_month, OLD.begin_date_year, OLD.end_date_day, OLD.end_date_month, OLD.end_date_year, OLD.instrument, OLD.locale, OLD.name, OLD.primary_for_locale, OLD.sort_name, OLD.type) IS DISTINCT FROM (NEW.begin_date_day, NEW.begin_date_month, NEW.begin_date_year, NEW.end_date_day, NEW.end_date_month, NEW.end_date_year, NEW.instrument, NEW.locale, NEW.name, NEW.primary_for_locale, NEW.sort_name, NEW.type))
    EXECUTE PROCEDURE search_instrument_alias_update();

CREATE TRIGGER search_instrument_alias_delete BEFORE DELETE ON musicbrainz.instrument_alias
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_alias_delete();

CREATE TRIGGER search_instrument_tag_insert AFTER INSERT ON musicbrainz.instrument_tag
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_tag_insert();

CREATE TRIGGER search_instrument_tag_update AFTER UPDATE OF count, instrument, tag ON musicbrainz.instrument_tag
    FOR EACH ROW
    WHEN ((OLD.count, OLD.instrument, OLD.tag) IS DISTINCT FROM (NEW.count, NEW.instrument, NEW.tag))
    EXECUTE PROCEDURE search_instrument_tag_update();

CREATE TRIGGER search_instrument_tag_delete BEFORE DELETE ON musicbrainz.instrument_tag
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_tag_delete();

CREATE TRIGGER search_instrument_type_insert AFTER INSERT ON musicbrainz.instrument_type
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_type_insert();

CREATE TRIGGER search_instrument_type_update AFTER UPDATE OF gid, name ON musicbrainz.instrument_type
    FOR EACH ROW
    WHEN ((OLD.gid, OLD.name) IS DISTINCT FROM (NEW.gid, NEW.name))
    EXECUTE PROCEDURE search_instrument_type_update();

CREATE TRIGGER search_instrument_type_delete BEFORE DELETE ON musicbrainz.instrument_type
    FOR EACH ROW EXECUTE PROCEDURE search_instrument_type_delete();

CREATE TRIGGER search_label_alias_insert AFTER INSERT ON musicbrainz.label_alias
    FOR EACH ROW EXECUTE PROCEDURE search_label_alias_insert();

CREATE TRIGGER search_label_alias_update AFTER UPDATE OF begin_date_day, begin_date_month, begin_date_year, end_date_day, end_date_month, end_date_year, label, locale, name, primary_for_locale, sort_name, type ON musicbrainz.label_alias
    FOR EACH ROW
    WHEN ((OLD.begin_date_day, OLD.begin_date_month, OLD.begin_date_year, OLD.end_date_day, OLD.end_date_month, OLD.end_date_year, OLD.label, OLD.locale, OLD.name, OLD.primary_for_locale, OLD.sort_name, OLD.type) IS DISTINCT FROM (NEW.begin_date_day, NEW.begin_date_month, NEW.begin_date_year, NEW.end_date_day, NEW.end_date_month, NEW.end_date_year, NEW.label, NEW.locale, NEW.name, NEW.primary_for_locale, NEW.sort_name, NEW.type))
    EXECUTE PROCEDURE search_label_alias_update();

CREATE TRIGGER search_label_alias_delete BEFORE DELETE ON musicbrainz.label_alias
    FOR EACH ROW EXECUTE PROCEDURE search_label_alias_delete();

CREATE TRIGGER search_label_ipi_insert AFTER INSERT ON musicbrainz.label_ipi
    FOR EACH ROW EXECUTE PROCEDURE search_label_ipi_insert();

CREATE TRIGGER search_label_ipi_update AFTER UPDATE OF ipi, label ON musicbrainz.label_ipi
    FOR EACH ROW
    WHEN ((OLD.ipi, OLD.label) IS DISTINCT FROM (NEW.ipi, NEW.label))
    EXECUTE PROCEDURE search_label_ipi_update();

CREATE TRIGGER search_label_ipi_delete BEFORE DELETE ON musicbrainz.label_ipi
    FOR EACH ROW EXECUTE PROCEDURE search_label_ipi_delete();

CREATE TRIGGER search_label_isni_insert AFTER INSERT ON musicbrainz.label_isni
    FOR EACH ROW EXECUTE PROCEDURE search_label_isni_insert();

CREATE TRIGGER search_label_isni_update AFTER UPDATE OF isni, label ON musicbrainz.label_isni
    FOR EACH ROW
    WHEN ((OLD.isni, OLD.label) IS DISTINCT FROM (NEW.isni, NEW.label))
    EXECUTE PROCEDURE search_label_isni_update();

CREATE TRIGGER search_label_isni_delete BEFORE DELETE ON musicbrainz.label_isni
    FOR EACH ROW EXECUTE PROCEDURE search_label_isni_delete();

CREATE TRIGGER search_label_tag_insert AFTER INSERT ON musicbrainz.label_tag
    FOR EACH ROW EXECUTE PROCEDURE search_label_tag_insert();

CREATE TRIGGER search_label_tag_update AFTER UPDATE OF count, label, tag ON musicbrainz.label_tag
    FOR EACH ROW
    WHEN ((OLD.count, OLD.label, OLD.tag) IS DISTINCT FROM (NEW.count, NEW.label, NEW.tag))
    EXECUTE PROCEDURE search_label_tag_update();

CREATE TRIGGER search_label_tag_delete BEFORE DELETE ON musicbrainz.label_tag
    FOR EACH ROW EXECUTE PROCEDURE search_label_tag_delete();

CREATE TRIGGER search_label_type_insert AFTER INSERT ON musicbrainz.label_type
    FOR EACH ROW EXECUTE PROCEDURE search_label_type_insert();

CREATE TRIGGER search_label_type_update AFTER UPDATE OF gid, name ON musicbrainz.label_type
    FOR EACH ROW
    WHEN ((OLD.gid, OLD.name) IS DISTINCT FROM (NEW.gid, NEW.name))
    EXECUTE PROCEDURE search_label_type_update();

CREATE TRIGGER search_label_type_delete BEFORE DELETE ON musicbrainz.label_type
    FOR EACH ROW EXECUTE PROCEDURE search_label_type_delete();

CREATE TRIGGER search_place_alias_insert AFTER INSERT ON musicbrainz.place_alias
    FOR EACH ROW EXECUTE PROCEDURE search_place_alias_insert();

CREATE TRIGGER search_place_alias_update AFTER UPDATE OF begin_date_day, begin_date_month, begin_date_year, end_date_day, end_date_month, end_date_year, locale, name, place, primary_for_locale, sort_name, type ON musicbrainz.place_alias
    FOR EACH ROW
    WHEN ((OLD.begin_date_day, OLD.begin_date_month, OLD.begin_date_year, OLD.end_date_day, OLD.end_date_month, OLD.end_date_year, OLD.locale, OLD.name, OLD.place, OLD.primary_for_locale, OLD.sort_name, OLD.type) IS DISTINCT FROM (NEW.begin_date_day, NEW.begin_date_month, NEW.begin_date_year, NEW.end_date_day, NEW.end_date_month, NEW.end_date_year, NEW.locale, NEW.name, NEW.place, NEW.primary_for_locale, NEW.sort_name, NEW.type))
    EXECUTE PROCEDURE search_place_alias_update();

CREATE TRIGGER search_place_alias_delete BEFORE DELETE ON musicbrainz.place_alias
    FOR EACH ROW EXECUTE PROCEDURE search_place_alias_delete();

CREATE TRIGGER search_place_type_insert AFTER INSERT ON musicbrainz.place_type
    FOR EACH ROW EXECUTE PROCEDURE search_place_type_insert();

CREATE TRIGGER search_place_type_update AFTER UPDATE OF gid, name ON musicbrainz.place_type
    FOR EACH ROW
    WHEN ((OLD.gid, OLD.name) IS DISTINCT FROM (NEW.gid, NEW.name))
    EXECUTE PROCEDURE search_place_type_update();

CREATE TRIGGER search_place_type_delete BEFORE DELETE ON musicbrainz.place_type
    FOR EACH ROW EXECUTE PROCEDURE search_place_type_delete();

CREATE TRIGGER search_recording_alias_insert AFTER INSERT ON musicbrainz.recording_alias
    FOR EACH ROW EXECUTE PROCEDURE search_recording_alias_insert();

CREATE TRIGGER search_recording_alias_update AFTER UPDATE OF name, recording, type ON musicbrainz.recording_alias
    FOR EACH ROW
    WHEN ((OLD.name, OLD.recording, OLD.type) IS DISTINCT FROM (NEW.name, NEW.recording, NEW.type))
    EXECUTE PROCEDURE search_recording_alias_update();

CREATE TRIGGER search_recording_alias_delete BEFORE DELETE ON musicbrainz.recording_alias
    FOR EACH ROW EXECUTE PROCEDURE search_recording_alias_delete();

CREATE TRIGGER search_artist_credit_insert AFTER INSERT ON musicbrainz.artist_credit
    FOR EACH ROW EXECUTE PROCEDURE search_artist_credit_insert();

CREATE TRIGGER search_artist_credit_update AFTER UPDATE OF gid, name ON musicbrainz.artist_credit
    FOR EACH ROW
    WHEN ((OLD.gid, OLD.name) IS DISTINCT FROM (NEW.gid, NEW.name))
    EXECUTE PROCEDURE search_artist_credit_update();

CREATE TRIGGER search_artist_credit_delete BEFORE DELETE ON musicbrainz.artist_credit
    FOR EACH ROW EXECUTE PROCEDURE search_artist_credit_delete();

CREATE TRIGGER search_artist_credit_name_insert AFTER INSERT ON musicbrainz.artist_credit_name
    FOR EACH ROW EXECUTE PROCEDURE search_artist_credit_name_insert();

CREATE TRIGGER search_artist_credit_name_update AFTER UPDATE OF artist, artist_credit, join_phrase, name ON musicbrainz.artist_credit_name
    FOR EACH ROW
    WHEN ((OLD.artist, OLD.artist_credit, OLD.join_phrase, OLD.name) IS DISTINCT FROM (NEW.artist, NEW.artist_credit, NEW.join_phrase, NEW.name))
    EXECUTE PROCEDURE search_artist_credit_name_update();

CREATE TRIGGER search_artist_credit_name_delete BEFORE DELETE ON musicbrainz.artist_credit_name
    FOR EACH ROW EXECUTE PROCEDURE search_artist_credit_name_delete();

CREATE TRIGGER search_track_insert AFTER INSERT ON musicbrainz.track
    FOR EACH ROW EXECUTE PROCEDURE search_track_insert();

CREATE TRIGGER search_track_update AFTER UPDATE OF artist_credit, gid, length, medium, name, number, position, recording ON musicbrainz.track
    FOR EACH ROW
    WHEN ((OLD.artist_credit, OLD.gid, OLD.length, OLD.medium, OLD.name, OLD.number, OLD.position, OLD.recording) IS DISTINCT FROM (NEW.artist_credit, NEW.gid, NEW.length, NEW.medium, NEW.name, NEW.number, NEW.position, NEW.recording))
    EXECUTE PROCEDURE search_track_update();

CREATE TRIGGER search_track_delete BEFORE DELETE ON musicbrainz.track
    FOR EACH ROW EXECUTE PROCEDURE search_track_delete();

CREATE TRIGGER search_medium_insert AFTER INSERT ON musicbrainz.medium
    FOR EACH ROW EXECUTE PROCEDURE search_medium_insert();

CREATE TRIGGER search_medium_update AFTER UPDATE OF format, gid, position, release, track_count ON musicbrainz.medium
    FOR EACH ROW
    WHEN ((OLD.format, OLD.gid, OLD.position, OLD.release, OLD.track_count) IS DISTINCT FROM (NEW.format, NEW.gid, NEW.position, NEW.release, NEW.track_count))
    EXECUTE PROCEDURE search_medium_update();

CREATE TRIGGER search_medium_delete BEFORE DELETE ON musicbrainz.medium
    FOR EACH ROW EXECUTE PROCEDURE search_medium_delete();

CREATE TRIGGER search_release_country_insert AFTER INSERT ON musicbrainz.release_country
    FOR EACH ROW EXECUTE PROCEDURE search_release_country_insert();

CREATE TRIGGER search_release_country_update AFTER UPDATE OF country, date_day, date_month, date_year, release ON musicbrainz.release_country
    FOR EACH ROW
    WHEN ((OLD.country, OLD.date_day, OLD.date_month, OLD.date_year, OLD.release) IS DISTINCT FROM (NEW.country, NEW.date_day, NEW.date_month, NEW.date_year, NEW.release))
    EXECUTE PROCEDURE search_release_country_update();

CREATE TRIGGER search_release_country_delete BEFORE DELETE ON musicbrainz.release_country
    FOR EACH ROW EXECUTE PROCEDURE search_release_country_delete();

CREATE TRIGGER search_country_area_insert AFTER INSERT ON musicbrainz.country_area
    FOR EACH ROW EXECUTE PROCEDURE search_country_area_insert();

CREATE TRIGGER search_country_area_update AFTER UPDATE OF area ON musicbrainz.country_area
    FOR EACH ROW
    WHEN ((OLD.area) IS DISTINCT FROM (NEW.area))
    EXECUTE PROCEDURE search_country_area_update();

CREATE TRIGGER search_country_area_delete BEFORE DELETE ON musicbrainz.country_area
    FOR EACH ROW EXECUTE PROCEDURE search_country_area_delete();

CREATE TRIGGER search_recording_first_release_date_insert AFTER INSERT ON musicbrainz.recording_first_release_date
    FOR EACH ROW EXECUTE PROCEDURE search_recording_first_release_date_insert();

CREATE TRIGGER search_recording_first_release_date_update AFTER UPDATE OF day, month, recording, year ON musicbrainz.recording_first_release_date
    FOR EACH ROW
    WHEN ((OLD.day, OLD.month, OLD.recording, OLD.year) IS DISTINCT FROM (NEW.day, NEW.month, NEW.recording, NEW.year))
    EXECUTE PROCEDURE search_recording_first_release_date_update();

CREATE TRIGGER search_recording_first_release_date_delete BEFORE DELETE ON musicbrainz.recording_first_release_date
    FOR EACH ROW EXECUTE PROCEDURE search_recording_first_release_date_delete();

CREATE TRIGGER search_medium_format_insert AFTER INSERT ON musicbrainz.medium_format
    FOR EACH ROW EXECUTE PROCEDURE search_medium_format_insert();

CREATE TRIGGER search_medium_format_update AFTER UPDATE OF name ON musicbrainz.medium_format
    FOR EACH ROW
    WHEN ((OLD.name) IS DISTINCT FROM (NEW.name))
    EXECUTE PROCEDURE search_medium_format_update();

CREATE TRIGGER search_medium_format_delete BEFORE DELETE ON musicbrainz.medium_format
    FOR EACH ROW EXECUTE PROCEDURE search_medium_format_delete();

CREATE TRIGGER search_isrc_insert AFTER INSERT ON musicbrainz.isrc
    FOR EACH ROW EXECUTE PROCEDURE search_isrc_insert();

CREATE TRIGGER search_isrc_update AFTER UPDATE OF isrc, recording ON musicbrainz.isrc
    FOR EACH ROW
    WHEN ((OLD.isrc, OLD.recording) IS DISTINCT FROM (NEW.isrc, NEW.recording))
    EXECUTE PROCEDURE search_isrc_update();

CREATE TRIGGER search_isrc_delete BEFORE DELETE ON musicbrainz.isrc
    FOR EACH ROW EXECUTE PROCEDURE search_isrc_delete();

CREATE TRIGGER search_release_group_primary_type_insert AFTER INSERT ON musicbrainz.release_group_primary_type
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_primary_type_insert();

CREATE TRIGGER search_release_group_primary_type_update AFTER UPDATE OF gid, name ON musicbrainz.release_group_primary_type
    FOR EACH ROW
    WHEN ((OLD.gid, OLD.name) IS DISTINCT FROM (NEW.gid, NEW.name))
    EXECUTE PROCEDURE search_release_group_primary_type_update();

CREATE TRIGGER search_release_group_primary_type_delete BEFORE DELETE ON musicbrainz.release_group_primary_type
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_primary_type_delete();

CREATE TRIGGER search_release_group_secondary_type_join_insert AFTER INSERT ON musicbrainz.release_group_secondary_type_join
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_secondary_type_join_insert();

CREATE TRIGGER search_release_group_secondary_type_join_update AFTER UPDATE OF release_group, secondary_type ON musicbrainz.release_group_secondary_type_join
    FOR EACH ROW
    WHEN ((OLD.release_group, OLD.secondary_type) IS DISTINCT FROM (NEW.release_group, NEW.secondary_type))
    EXECUTE PROCEDURE search_release_group_secondary_type_join_update();

CREATE TRIGGER search_release_group_secondary_type_join_delete BEFORE DELETE ON musicbrainz.release_group_secondary_type_join
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_secondary_type_join_delete();

CREATE TRIGGER search_release_group_secondary_type_insert AFTER INSERT ON musicbrainz.release_group_secondary_type
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_secondary_type_insert();

CREATE TRIGGER search_release_group_secondary_type_update AFTER UPDATE OF gid, name ON musicbrainz.release_group_secondary_type
    FOR EACH ROW
    WHEN ((OLD.gid, OLD.name) IS DISTINCT FROM (NEW.gid, NEW.name))
    EXECUTE PROCEDURE search_release_group_secondary_type_update();

CREATE TRIGGER search_release_group_secondary_type_delete BEFORE DELETE ON musicbrainz.release_group_secondary_type
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_secondary_type_delete();

CREATE TRIGGER search_release_status_insert AFTER INSERT ON musicbrainz.release_status
    FOR EACH ROW EXECUTE PROCEDURE search_release_status_insert();

CREATE TRIGGER search_release_status_update AFTER UPDATE OF gid, name ON musicbrainz.release_status
    FOR EACH ROW
    WHEN ((OLD.gid, OLD.name) IS DISTINCT FROM (NEW.gid, NEW.name))
    EXECUTE PROCEDURE search_release_status_update();

CREATE TRIGGER search_release_status_delete BEFORE DELETE ON musicbrainz.release_status
    FOR EACH ROW EXECUTE PROCEDURE search_release_status_delete();

CREATE TRIGGER search_recording_tag_insert AFTER INSERT ON musicbrainz.recording_tag
    FOR EACH ROW EXECUTE PROCEDURE search_recording_tag_insert();

CREATE TRIGGER search_recording_tag_update AFTER UPDATE OF count, recording, tag ON musicbrainz.recording_tag
    FOR EACH ROW
    WHEN ((OLD.count, OLD.recording, OLD.tag) IS DISTINCT FROM (NEW.count, NEW.recording, NEW.tag))
    EXECUTE PROCEDURE search_recording_tag_update();

CREATE TRIGGER search_recording_tag_delete BEFORE DELETE ON musicbrainz.recording_tag
    FOR EACH ROW EXECUTE PROCEDURE search_recording_tag_delete();

CREATE TRIGGER search_release_alias_insert AFTER INSERT ON musicbrainz.release_alias
    FOR EACH ROW EXECUTE PROCEDURE search_release_alias_insert();

CREATE TRIGGER search_release_alias_update AFTER UPDATE OF name, release, type ON musicbrainz.release_alias
    FOR EACH ROW
    WHEN ((OLD.name, OLD.release, OLD.type) IS DISTINCT FROM (NEW.name, NEW.release, NEW.type))
    EXECUTE PROCEDURE search_release_alias_update();

CREATE TRIGGER search_release_alias_delete BEFORE DELETE ON musicbrainz.release_alias
    FOR EACH ROW EXECUTE PROCEDURE search_release_alias_delete();

CREATE TRIGGER search_release_meta_insert AFTER INSERT ON musicbrainz.release_meta
    FOR EACH ROW EXECUTE PROCEDURE search_release_meta_insert();

CREATE TRIGGER search_release_meta_update AFTER UPDATE OF amazon_asin, id ON musicbrainz.release_meta
    FOR EACH ROW
    WHEN ((OLD.amazon_asin, OLD.id) IS DISTINCT FROM (NEW.amazon_asin, NEW.id))
    EXECUTE PROCEDURE search_release_meta_update();

CREATE TRIGGER search_release_meta_delete BEFORE DELETE ON musicbrainz.release_meta
    FOR EACH ROW EXECUTE PROCEDURE search_release_meta_delete();

CREATE TRIGGER search_release_label_insert AFTER INSERT ON musicbrainz.release_label
    FOR EACH ROW EXECUTE PROCEDURE search_release_label_insert();

CREATE TRIGGER search_release_label_update AFTER UPDATE OF catalog_number, label, release ON musicbrainz.release_label
    FOR EACH ROW
    WHEN ((OLD.catalog_number, OLD.label, OLD.release) IS DISTINCT FROM (NEW.catalog_number, NEW.label, NEW.release))
    EXECUTE PROCEDURE search_release_label_update();

CREATE TRIGGER search_release_label_delete BEFORE DELETE ON musicbrainz.release_label
    FOR EACH ROW EXECUTE PROCEDURE search_release_label_delete();

CREATE TRIGGER search_language_insert AFTER INSERT ON musicbrainz.language
    FOR EACH ROW EXECUTE PROCEDURE search_language_insert();

CREATE TRIGGER search_language_update AFTER UPDATE OF iso_code_3 ON musicbrainz.language
    FOR EACH ROW
    WHEN ((OLD.iso_code_3) IS DISTINCT FROM (NEW.iso_code_3))
    EXECUTE PROCEDURE search_language_update();

CREATE TRIGGER search_language_delete BEFORE DELETE ON musicbrainz.language
    FOR EACH ROW EXECUTE PROCEDURE search_language_delete();

CREATE TRIGGER search_release_packaging_insert AFTER INSERT ON musicbrainz.release_packaging
    FOR EACH ROW EXECUTE PROCEDURE search_release_packaging_insert();

CREATE TRIGGER search_release_packaging_update AFTER UPDATE OF gid, name ON musicbrainz.release_packaging
    FOR EACH ROW
    WHEN ((OLD.gid, OLD.name) IS DISTINCT FROM (NEW.gid, NEW.name))
    EXECUTE PROCEDURE search_release_packaging_update();

CREATE TRIGGER search_release_packaging_delete BEFORE DELETE ON musicbrainz.release_packaging
    FOR EACH ROW EXECUTE PROCEDURE search_release_packaging_delete();

CREATE TRIGGER search_script_insert AFTER INSERT ON musicbrainz.script
    FOR EACH ROW EXECUTE PROCEDURE search_script_insert();

CREATE TRIGGER search_script_update AFTER UPDATE OF iso_code ON musicbrainz.script
    FOR EACH ROW
    WHEN ((OLD.iso_code) IS DISTINCT FROM (NEW.iso_code))
    EXECUTE PROCEDURE search_script_update();

CREATE TRIGGER search_script_delete BEFORE DELETE ON musicbrainz.script
    FOR EACH ROW EXECUTE PROCEDURE search_script_delete();

CREATE TRIGGER search_release_tag_insert AFTER INSERT ON musicbrainz.release_tag
    FOR EACH ROW EXECUTE PROCEDURE search_release_tag_insert();

CREATE TRIGGER search_release_tag_update AFTER UPDATE OF count, release, tag ON musicbrainz.release_tag
    FOR EACH ROW
    WHEN ((OLD.count, OLD.release, OLD.tag) IS DISTINCT FROM (NEW.count, NEW.release, NEW.tag))
    EXECUTE PROCEDURE search_release_tag_update();

CREATE TRIGGER search_release_tag_delete BEFORE DELETE ON musicbrainz.release_tag
    FOR EACH ROW EXECUTE PROCEDURE search_release_tag_delete();

CREATE TRIGGER search_release_group_alias_insert AFTER INSERT ON musicbrainz.release_group_alias
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_alias_insert();

CREATE TRIGGER search_release_group_alias_update AFTER UPDATE OF name, release_group, type ON musicbrainz.release_group_alias
    FOR EACH ROW
    WHEN ((OLD.name, OLD.release_group, OLD.type) IS DISTINCT FROM (NEW.name, NEW.release_group, NEW.type))
    EXECUTE PROCEDURE search_release_group_alias_update();

CREATE TRIGGER search_release_group_alias_delete BEFORE DELETE ON musicbrainz.release_group_alias
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_alias_delete();

CREATE TRIGGER search_release_group_meta_insert AFTER INSERT ON musicbrainz.release_group_meta
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_meta_insert();

CREATE TRIGGER search_release_group_meta_update AFTER UPDATE OF first_release_date_day, first_release_date_month, first_release_date_year, id ON musicbrainz.release_group_meta
    FOR EACH ROW
    WHEN ((OLD.first_release_date_day, OLD.first_release_date_month, OLD.first_release_date_year, OLD.id) IS DISTINCT FROM (NEW.first_release_date_day, NEW.first_release_date_month, NEW.first_release_date_year, NEW.id))
    EXECUTE PROCEDURE search_release_group_meta_update();

CREATE TRIGGER search_release_group_meta_delete BEFORE DELETE ON musicbrainz.release_group_meta
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_meta_delete();

CREATE TRIGGER search_release_group_tag_insert AFTER INSERT ON musicbrainz.release_group_tag
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_tag_insert();

CREATE TRIGGER search_release_group_tag_update AFTER UPDATE OF count, release_group, tag ON musicbrainz.release_group_tag
    FOR EACH ROW
    WHEN ((OLD.count, OLD.release_group, OLD.tag) IS DISTINCT FROM (NEW.count, NEW.release_group, NEW.tag))
    EXECUTE PROCEDURE search_release_group_tag_update();

CREATE TRIGGER search_release_group_tag_delete BEFORE DELETE ON musicbrainz.release_group_tag
    FOR EACH ROW EXECUTE PROCEDURE search_release_group_tag_delete();

CREATE TRIGGER search_series_alias_insert AFTER INSERT ON musicbrainz.series_alias
    FOR EACH ROW EXECUTE PROCEDURE search_series_alias_insert();

CREATE TRIGGER search_series_alias_update AFTER UPDATE OF begin_date_day, begin_date_month, begin_date_year, end_date_day, end_date_month, end_date_year, locale, name, primary_for_locale, series, sort_name, type ON musicbrainz.series_alias
    FOR EACH ROW
    WHEN ((OLD.begin_date_day, OLD.begin_date_month, OLD.begin_date_year, OLD.end_date_day, OLD.end_date_month, OLD.end_date_year, OLD.locale, OLD.name, OLD.primary_for_locale, OLD.series, OLD.sort_name, OLD.type) IS DISTINCT FROM (NEW.begin_date_day, NEW.begin_date_month, NEW.begin_date_year, NEW.end_date_day, NEW.end_date_month, NEW.end_date_year, NEW.locale, NEW.name, NEW.primary_for_locale, NEW.series, NEW.sort_name, NEW.type))
    EXECUTE PROCEDURE search_series_alias_update();

CREATE TRIGGER search_series_alias_delete BEFORE DELETE ON musicbrainz.series_alias
    FOR EACH ROW EXECUTE PROCEDURE search_series_alias_delete();

CREATE TRIGGER search_series_tag_insert AFTER INSERT ON musicbrainz.series_tag
    FOR EACH ROW EXECUTE PROCEDURE search_series_tag_insert();

CREATE TRIGGER search_series_tag_update AFTER UPDATE OF count, series, tag ON musicbrainz.series_tag
    FOR EACH ROW
    WHEN ((OLD.count, OLD.series, OLD.tag) IS DISTINCT FROM (NEW.count, NEW.series, NEW.tag))
    EXECUTE PROCEDURE search_series_tag_update();

CREATE TRIGGER search_series_tag_delete BEFORE DELETE ON musicbrainz.series_tag
    FOR EACH ROW EXECUTE PROCEDURE search_series_tag_delete();

CREATE TRIGGER search_series_type_insert AFTER INSERT ON musicbrainz.series_type
    FOR EACH ROW EXECUTE PROCEDURE search_series_type_insert();

CREATE TRIGGER search_series_type_update AFTER UPDATE OF gid, name ON musicbrainz.series_type
    FOR EACH ROW
    WHEN ((OLD.gid, OLD.name) IS DISTINCT FROM (NEW.gid, NEW.name))
    EXECUTE PROCEDURE search_series_type_update();

CREATE TRIGGER search_series_type_delete BEFORE DELETE ON musicbrainz.series_type
    FOR EACH ROW EXECUTE PROCEDURE search_series_type_delete();

CREATE TRIGGER search_url_insert AFTER INSERT ON musicbrainz.url
    FOR EACH ROW EXECUTE PROCEDURE search_url_insert();

CREATE TRIGGER search_url_update AFTER UPDATE OF gid, url ON musicbrainz.url
    FOR EACH ROW
    WHEN ((OLD.gid, OLD.url) IS DISTINCT FROM (NEW.gid, NEW.url))
    EXECUTE PROCEDURE search_url_update();

CREATE TRIGGER search_url_delete BEFORE DELETE ON musicbrainz.url
    FOR EACH ROW EXECUTE PROCEDURE search_url_delete();

CREATE TRIGGER search_l_artist_url_insert AFTER INSERT ON musicbrainz.l_artist_url
    FOR EACH ROW EXECUTE PROCEDURE search_l_artist_url_insert();

CREATE TRIGGER search_l_artist_url_update AFTER UPDATE OF entity0, entity1, link ON musicbrainz.l_artist_url
    FOR EACH ROW
    WHEN ((OLD.entity0, OLD.entity1, OLD.link) IS DISTINCT FROM (NEW.entity0, NEW.entity1, NEW.link))
    EXECUTE PROCEDURE search_l_artist_url_update();

CREATE TRIGGER search_l_artist_url_delete BEFORE DELETE ON musicbrainz.l_artist_url
    FOR EACH ROW EXECUTE PROCEDURE search_l_artist_url_delete();

CREATE TRIGGER search_link_insert AFTER INSERT ON musicbrainz.link
    FOR EACH ROW EXECUTE PROCEDURE search_link_insert();

CREATE TRIGGER search_link_update AFTER UPDATE OF link_type ON musicbrainz.link
    FOR EACH ROW
    WHEN ((OLD.link_type) IS DISTINCT FROM (NEW.link_type))
    EXECUTE PROCEDURE search_link_update();

CREATE TRIGGER search_link_delete BEFORE DELETE ON musicbrainz.link
    FOR EACH ROW EXECUTE PROCEDURE search_link_delete();

CREATE TRIGGER search_link_type_insert AFTER INSERT ON musicbrainz.link_type
    FOR EACH ROW EXECUTE PROCEDURE search_link_type_insert();

CREATE TRIGGER search_link_type_update AFTER UPDATE OF gid, name ON musicbrainz.link_type
    FOR EACH ROW
    WHEN ((OLD.gid, OLD.name) IS DISTINCT FROM (NEW.gid, NEW.name))
    EXECUTE PROCEDURE search_link_type_update();

CREATE TRIGGER search_link_type_delete BEFORE DELETE ON musicbrainz.link_type
    FOR EACH ROW EXECUTE PROCEDURE search_link_type_delete();

CREATE TRIGGER search_l_release_url_insert AFTER INSERT ON musicbrainz.l_release_url
    FOR EACH ROW EXECUTE PROCEDURE search_l_release_url_insert();

CREATE TRIGGER search_l_release_url_update AFTER UPDATE OF entity0, entity1, link ON musicbrainz.l_release_url
    FOR EACH ROW
    WHEN ((OLD.entity0, OLD.entity1, OLD.link) IS DISTINCT FROM (NEW.entity0, NEW.entity1, NEW.link))
    EXECUTE PROCEDURE search_l_release_url_update();

CREATE TRIGGER search_l_release_url_delete BEFORE DELETE ON musicbrainz.l_release_url
    FOR EACH ROW EXECUTE PROCEDURE search_l_release_url_delete();

CREATE TRIGGER search_work_alias_insert AFTER INSERT ON musicbrainz.work_alias
    FOR EACH ROW EXECUTE PROCEDURE search_work_alias_insert();

CREATE TRIGGER search_work_alias_update AFTER UPDATE OF begin_date_day, begin_date_month, begin_date_year, end_date_day, end_date_month, end_date_year, locale, name, primary_for_locale, sort_name, type, work ON musicbrainz.work_alias
    FOR EACH ROW
    WHEN ((OLD.begin_date_day, OLD.begin_date_month, OLD.begin_date_year, OLD.end_date_day, OLD.end_date_month, OLD.end_date_year, OLD.locale, OLD.name, OLD.primary_for_locale, OLD.sort_name, OLD.type, OLD.work) IS DISTINCT FROM (NEW.begin_date_day, NEW.begin_date_month, NEW.begin_date_year, NEW.end_date_day, NEW.end_date_month, NEW.end_date_year, NEW.locale, NEW.name, NEW.primary_for_locale, NEW.sort_name, NEW.type, NEW.work))
    EXECUTE PROCEDURE search_work_alias_update();

CREATE TRIGGER search_work_alias_delete BEFORE DELETE ON musicbrainz.work_alias
    FOR EACH ROW EXECUTE PROCEDURE search_work_alias_delete();

CREATE TRIGGER search_l_artist_work_insert AFTER INSERT ON musicbrainz.l_artist_work
    FOR EACH ROW EXECUTE PROCEDURE search_l_artist_work_insert();

CREATE TRIGGER search_l_artist_work_update AFTER UPDATE OF entity0, entity1, link ON musicbrainz.l_artist_work
    FOR EACH ROW
    WHEN ((OLD.entity0, OLD.entity1, OLD.link) IS DISTINCT FROM (NEW.entity0, NEW.entity1, NEW.link))
    EXECUTE PROCEDURE search_l_artist_work_update();

CREATE TRIGGER search_l_artist_work_delete BEFORE DELETE ON musicbrainz.l_artist_work
    FOR EACH ROW EXECUTE PROCEDURE search_l_artist_work_delete();

CREATE TRIGGER search_iswc_insert AFTER INSERT ON musicbrainz.iswc
    FOR EACH ROW EXECUTE PROCEDURE search_iswc_insert();

CREATE TRIGGER search_iswc_update AFTER UPDATE OF iswc, work ON musicbrainz.iswc
    FOR EACH ROW
    WHEN ((OLD.iswc, OLD.work) IS DISTINCT FROM (NEW.iswc, NEW.work))
    EXECUTE PROCEDURE search_iswc_update();

CREATE TRIGGER search_iswc_delete BEFORE DELETE ON musicbrainz.iswc
    FOR EACH ROW EXECUTE PROCEDURE search_iswc_delete();

CREATE TRIGGER search_work_language_insert AFTER INSERT ON musicbrainz.work_language
    FOR EACH ROW EXECUTE PROCEDURE search_work_language_insert();

CREATE TRIGGER search_work_language_update AFTER UPDATE OF language, work ON musicbrainz.work_language
    FOR EACH ROW
    WHEN ((OLD.language, OLD.work) IS DISTINCT FROM (NEW.language, NEW.work))
    EXECUTE PROCEDURE search_work_language_update();

CREATE TRIGGER search_work_language_delete BEFORE DELETE ON musicbrainz.work_language
    FOR EACH ROW EXECUTE PROCEDURE search_work_language_delete();

CREATE TRIGGER search_l_recording_work_insert AFTER INSERT ON musicbrainz.l_recording_work
    FOR EACH ROW EXECUTE PROCEDURE search_l_recording_work_insert();

CREATE TRIGGER search_l_recording_work_update AFTER UPDATE OF entity0, entity1, link ON musicbrainz.l_recording_work
    FOR EACH ROW
    WHEN ((OLD.entity0, OLD.entity1, OLD.link) IS DISTINCT FROM (NEW.entity0, NEW.entity1, NEW.link))
    EXECUTE PROCEDURE search_l_recording_work_update();

CREATE TRIGGER search_l_recording_work_delete BEFORE DELETE ON musicbrainz.l_recording_work
    FOR EACH ROW EXECUTE PROCEDURE search_l_recording_work_delete();

CREATE TRIGGER search_work_tag_insert AFTER INSERT ON musicbrainz.work_tag
    FOR EACH ROW EXECUTE PROCEDURE search_work_tag_insert();

CREATE TRIGGER search_work_tag_update AFTER UPDATE OF count, tag, work ON musicbrainz.work_tag
    FOR EACH ROW
    WHEN ((OLD.count, OLD.tag, OLD.work) IS DISTINCT FROM (NEW.count, NEW.tag, NEW.work))
    EXECUTE PROCEDURE search_work_tag_update();

CREATE TRIGGER search_work_tag_delete BEFORE DELETE ON musicbrainz.work_tag
    FOR EACH ROW EXECUTE PROCEDURE search_work_tag_delete();

CREATE TRIGGER search_work_type_insert AFTER INSERT ON musicbrainz.work_type
    FOR EACH ROW EXECUTE PROCEDURE search_work_type_insert();

CREATE TRIGGER search_work_type_update AFTER UPDATE OF gid, name ON musicbrainz.work_type
    FOR EACH ROW
    WHEN ((OLD.gid, OLD.name) IS DISTINCT FROM (NEW.gid, NEW.name))
    EXECUTE PROCEDURE search_work_type_update();

CREATE TRIGGER search_work_type_delete BEFORE DELETE ON musicbrainz.work_type
    FOR EACH ROW EXECUTE PROCEDURE search_work_type_delete();

COMMIT;

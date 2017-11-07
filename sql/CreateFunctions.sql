-- Automatically generated, do not edit!
\set ON_ERROR_STOP 1
BEGIN;

CREATE OR REPLACE FUNCTION search_annotation_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"annotation"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_annotation_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"annotation"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_annotation_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'delete', (
            WITH keys(id) AS (SELECT OLD.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"annotation"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_area_annotation_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(annotation, area) AS (SELECT NEW.annotation, NEW.area)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"area_annotation"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_area_annotation_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(annotation, area) AS (SELECT NEW.annotation, NEW.area)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"area_annotation"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_area_annotation_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(annotation, area) AS (SELECT OLD.annotation, OLD.area)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"area_annotation"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_area_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"area"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_area_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"area"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_area_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'delete', (
            WITH keys(gid) AS (SELECT OLD.gid)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"area"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_annotation_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(annotation, artist) AS (SELECT NEW.annotation, NEW.artist)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"artist_annotation"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_annotation_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(annotation, artist) AS (SELECT NEW.annotation, NEW.artist)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"artist_annotation"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_annotation_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(annotation, artist) AS (SELECT OLD.annotation, OLD.artist)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"artist_annotation"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"artist"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"artist"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'delete', (
            WITH keys(gid) AS (SELECT OLD.gid)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"artist"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_event_annotation_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(annotation, event) AS (SELECT NEW.annotation, NEW.event)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"event_annotation"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_event_annotation_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(annotation, event) AS (SELECT NEW.annotation, NEW.event)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"event_annotation"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_event_annotation_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(annotation, event) AS (SELECT OLD.annotation, OLD.event)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"event_annotation"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_event_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"event"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_event_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"event"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_event_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'delete', (
            WITH keys(gid) AS (SELECT OLD.gid)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"event"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_instrument_annotation_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(annotation, instrument) AS (SELECT NEW.annotation, NEW.instrument)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"instrument_annotation"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_instrument_annotation_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(annotation, instrument) AS (SELECT NEW.annotation, NEW.instrument)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"instrument_annotation"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_instrument_annotation_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(annotation, instrument) AS (SELECT OLD.annotation, OLD.instrument)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"instrument_annotation"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_instrument_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"instrument"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_instrument_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"instrument"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_instrument_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'delete', (
            WITH keys(gid) AS (SELECT OLD.gid)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"instrument"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_annotation_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(annotation, label) AS (SELECT NEW.annotation, NEW.label)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"label_annotation"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_annotation_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(annotation, label) AS (SELECT NEW.annotation, NEW.label)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"label_annotation"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_annotation_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(annotation, label) AS (SELECT OLD.annotation, OLD.label)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"label_annotation"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"label"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"label"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'delete', (
            WITH keys(gid) AS (SELECT OLD.gid)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"label"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_place_annotation_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(annotation, place) AS (SELECT NEW.annotation, NEW.place)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"place_annotation"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_place_annotation_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(annotation, place) AS (SELECT NEW.annotation, NEW.place)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"place_annotation"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_place_annotation_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(annotation, place) AS (SELECT OLD.annotation, OLD.place)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"place_annotation"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_place_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"place"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_place_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"place"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_place_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'delete', (
            WITH keys(gid) AS (SELECT OLD.gid)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"place"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_annotation_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(annotation, recording) AS (SELECT NEW.annotation, NEW.recording)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"recording_annotation"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_annotation_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(annotation, recording) AS (SELECT NEW.annotation, NEW.recording)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"recording_annotation"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_annotation_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(annotation, recording) AS (SELECT OLD.annotation, OLD.recording)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"recording_annotation"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"recording"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"recording"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'delete', (
            WITH keys(gid) AS (SELECT OLD.gid)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"recording"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_annotation_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(annotation, release) AS (SELECT NEW.annotation, NEW.release)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_annotation"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_annotation_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(annotation, release) AS (SELECT NEW.annotation, NEW.release)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_annotation"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_annotation_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(annotation, release) AS (SELECT OLD.annotation, OLD.release)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_annotation"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'delete', (
            WITH keys(gid) AS (SELECT OLD.gid)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_annotation_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(annotation, release_group) AS (SELECT NEW.annotation, NEW.release_group)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_group_annotation"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_annotation_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(annotation, release_group) AS (SELECT NEW.annotation, NEW.release_group)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_group_annotation"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_annotation_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(annotation, release_group) AS (SELECT OLD.annotation, OLD.release_group)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_group_annotation"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_group"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_group"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'delete', (
            WITH keys(gid) AS (SELECT OLD.gid)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_group"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_series_annotation_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(annotation, series) AS (SELECT NEW.annotation, NEW.series)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"series_annotation"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_series_annotation_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(annotation, series) AS (SELECT NEW.annotation, NEW.series)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"series_annotation"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_series_annotation_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(annotation, series) AS (SELECT OLD.annotation, OLD.series)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"series_annotation"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_series_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"series"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_series_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"series"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_series_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'delete', (
            WITH keys(gid) AS (SELECT OLD.gid)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"series"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_annotation_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(annotation, work) AS (SELECT NEW.annotation, NEW.work)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"work_annotation"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_annotation_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(annotation, work) AS (SELECT NEW.annotation, NEW.work)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"work_annotation"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_annotation_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(annotation, work) AS (SELECT OLD.annotation, OLD.work)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"work_annotation"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"work"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"work"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'delete', (
            WITH keys(gid) AS (SELECT OLD.gid)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"work"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_area_alias_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(area, id, type) AS (SELECT NEW.area, NEW.id, NEW.type)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"area_alias"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_area_alias_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(area, id, type) AS (SELECT NEW.area, NEW.id, NEW.type)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"area_alias"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_area_alias_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(area, id, type) AS (SELECT OLD.area, OLD.id, OLD.type)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"area_alias"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_iso_3166_1_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(area, code) AS (SELECT NEW.area, NEW.code)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"iso_3166_1"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_iso_3166_1_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(area, code) AS (SELECT NEW.area, NEW.code)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"iso_3166_1"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_iso_3166_1_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(area, code) AS (SELECT OLD.area, OLD.code)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"iso_3166_1"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_iso_3166_2_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(area, code) AS (SELECT NEW.area, NEW.code)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"iso_3166_2"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_iso_3166_2_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(area, code) AS (SELECT NEW.area, NEW.code)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"iso_3166_2"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_iso_3166_2_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(area, code) AS (SELECT OLD.area, OLD.code)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"iso_3166_2"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_iso_3166_3_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(area, code) AS (SELECT NEW.area, NEW.code)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"iso_3166_3"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_iso_3166_3_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(area, code) AS (SELECT NEW.area, NEW.code)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"iso_3166_3"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_iso_3166_3_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(area, code) AS (SELECT OLD.area, OLD.code)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"iso_3166_3"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_area_tag_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(area, tag) AS (SELECT NEW.area, NEW.tag)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"area_tag"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_area_tag_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(area, tag) AS (SELECT NEW.area, NEW.tag)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"area_tag"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_area_tag_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(area, tag) AS (SELECT OLD.area, OLD.tag)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"area_tag"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_tag_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"tag"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_tag_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"tag"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_tag_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'delete', (
            WITH keys(id) AS (SELECT OLD.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"tag"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_area_type_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id, parent) AS (SELECT NEW.id, NEW.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"area_type"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_area_type_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, parent) AS (SELECT NEW.id, NEW.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"area_type"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_area_type_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, parent) AS (SELECT OLD.id, OLD.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"area_type"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_alias_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(artist, id, type) AS (SELECT NEW.artist, NEW.id, NEW.type)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"artist_alias"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_alias_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(artist, id, type) AS (SELECT NEW.artist, NEW.id, NEW.type)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"artist_alias"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_alias_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(artist, id, type) AS (SELECT OLD.artist, OLD.id, OLD.type)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"artist_alias"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_gender_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id, parent) AS (SELECT NEW.id, NEW.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"gender"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_gender_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, parent) AS (SELECT NEW.id, NEW.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"gender"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_gender_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, parent) AS (SELECT OLD.id, OLD.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"gender"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_ipi_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(artist, ipi) AS (SELECT NEW.artist, NEW.ipi)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"artist_ipi"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_ipi_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(artist, ipi) AS (SELECT NEW.artist, NEW.ipi)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"artist_ipi"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_ipi_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(artist, ipi) AS (SELECT OLD.artist, OLD.ipi)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"artist_ipi"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_isni_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(artist, isni) AS (SELECT NEW.artist, NEW.isni)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"artist_isni"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_isni_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(artist, isni) AS (SELECT NEW.artist, NEW.isni)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"artist_isni"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_isni_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(artist, isni) AS (SELECT OLD.artist, OLD.isni)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"artist_isni"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_tag_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(artist, tag) AS (SELECT NEW.artist, NEW.tag)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"artist_tag"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_tag_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(artist, tag) AS (SELECT NEW.artist, NEW.tag)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"artist_tag"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_tag_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(artist, tag) AS (SELECT OLD.artist, OLD.tag)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"artist_tag"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_credit_name_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(artist, artist_credit, position) AS (SELECT NEW.artist, NEW.artist_credit, NEW.position)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"artist_credit_name"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_credit_name_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(artist, artist_credit, position) AS (SELECT NEW.artist, NEW.artist_credit, NEW.position)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"artist_credit_name"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_credit_name_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(artist, artist_credit, position) AS (SELECT OLD.artist, OLD.artist_credit, OLD.position)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"artist_credit_name"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_credit_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"artist_credit"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_credit_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"artist_credit"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_credit_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id) AS (SELECT OLD.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"artist_credit"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_type_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id, parent) AS (SELECT NEW.id, NEW.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"artist_type"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_type_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, parent) AS (SELECT NEW.id, NEW.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"artist_type"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_type_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, parent) AS (SELECT OLD.id, OLD.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"artist_type"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_raw_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_raw"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_raw_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_raw"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_raw_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'delete', (
            WITH keys(id) AS (SELECT OLD.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_raw"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_cdtoc_raw_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id, release) AS (SELECT NEW.id, NEW.release)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"cdtoc_raw"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_cdtoc_raw_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, release) AS (SELECT NEW.id, NEW.release)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"cdtoc_raw"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_cdtoc_raw_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, release) AS (SELECT OLD.id, OLD.release)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"cdtoc_raw"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_editor_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"editor"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_editor_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"editor"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_editor_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'delete', (
            WITH keys(id) AS (SELECT OLD.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"editor"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_event_alias_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(event, id, type) AS (SELECT NEW.event, NEW.id, NEW.type)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"event_alias"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_event_alias_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(event, id, type) AS (SELECT NEW.event, NEW.id, NEW.type)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"event_alias"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_event_alias_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(event, id, type) AS (SELECT OLD.event, OLD.id, OLD.type)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"event_alias"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_area_event_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(entity0, entity1, id, link) AS (SELECT NEW.entity0, NEW.entity1, NEW.id, NEW.link)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"l_area_event"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_area_event_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(entity0, entity1, id, link) AS (SELECT NEW.entity0, NEW.entity1, NEW.id, NEW.link)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"l_area_event"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_area_event_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(entity0, entity1, id, link) AS (SELECT OLD.entity0, OLD.entity1, OLD.id, OLD.link)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"l_area_event"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_artist_event_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(entity0, entity1, id, link) AS (SELECT NEW.entity0, NEW.entity1, NEW.id, NEW.link)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"l_artist_event"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_artist_event_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(entity0, entity1, id, link) AS (SELECT NEW.entity0, NEW.entity1, NEW.id, NEW.link)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"l_artist_event"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_artist_event_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(entity0, entity1, id, link) AS (SELECT OLD.entity0, OLD.entity1, OLD.id, OLD.link)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"l_artist_event"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_event_place_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(entity0, entity1, id, link) AS (SELECT NEW.entity0, NEW.entity1, NEW.id, NEW.link)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"l_event_place"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_event_place_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(entity0, entity1, id, link) AS (SELECT NEW.entity0, NEW.entity1, NEW.id, NEW.link)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"l_event_place"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_event_place_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(entity0, entity1, id, link) AS (SELECT OLD.entity0, OLD.entity1, OLD.id, OLD.link)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"l_event_place"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_event_tag_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(event, tag) AS (SELECT NEW.event, NEW.tag)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"event_tag"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_event_tag_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(event, tag) AS (SELECT NEW.event, NEW.tag)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"event_tag"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_event_tag_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(event, tag) AS (SELECT OLD.event, OLD.tag)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"event_tag"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_event_type_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id, parent) AS (SELECT NEW.id, NEW.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"event_type"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_event_type_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, parent) AS (SELECT NEW.id, NEW.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"event_type"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_event_type_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, parent) AS (SELECT OLD.id, OLD.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"event_type"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_instrument_alias_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id, instrument, type) AS (SELECT NEW.id, NEW.instrument, NEW.type)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"instrument_alias"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_instrument_alias_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, instrument, type) AS (SELECT NEW.id, NEW.instrument, NEW.type)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"instrument_alias"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_instrument_alias_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, instrument, type) AS (SELECT OLD.id, OLD.instrument, OLD.type)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"instrument_alias"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_instrument_tag_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(instrument, tag) AS (SELECT NEW.instrument, NEW.tag)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"instrument_tag"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_instrument_tag_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(instrument, tag) AS (SELECT NEW.instrument, NEW.tag)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"instrument_tag"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_instrument_tag_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(instrument, tag) AS (SELECT OLD.instrument, OLD.tag)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"instrument_tag"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_instrument_type_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id, parent) AS (SELECT NEW.id, NEW.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"instrument_type"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_instrument_type_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, parent) AS (SELECT NEW.id, NEW.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"instrument_type"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_instrument_type_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, parent) AS (SELECT OLD.id, OLD.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"instrument_type"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_alias_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id, label, type) AS (SELECT NEW.id, NEW.label, NEW.type)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"label_alias"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_alias_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, label, type) AS (SELECT NEW.id, NEW.label, NEW.type)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"label_alias"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_alias_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, label, type) AS (SELECT OLD.id, OLD.label, OLD.type)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"label_alias"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_ipi_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(ipi, label) AS (SELECT NEW.ipi, NEW.label)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"label_ipi"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_ipi_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(ipi, label) AS (SELECT NEW.ipi, NEW.label)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"label_ipi"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_ipi_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(ipi, label) AS (SELECT OLD.ipi, OLD.label)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"label_ipi"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_tag_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(label, tag) AS (SELECT NEW.label, NEW.tag)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"label_tag"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_tag_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(label, tag) AS (SELECT NEW.label, NEW.tag)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"label_tag"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_tag_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(label, tag) AS (SELECT OLD.label, OLD.tag)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"label_tag"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_type_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id, parent) AS (SELECT NEW.id, NEW.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"label_type"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_type_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, parent) AS (SELECT NEW.id, NEW.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"label_type"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_type_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, parent) AS (SELECT OLD.id, OLD.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"label_type"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_place_alias_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id, place, type) AS (SELECT NEW.id, NEW.place, NEW.type)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"place_alias"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_place_alias_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, place, type) AS (SELECT NEW.id, NEW.place, NEW.type)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"place_alias"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_place_alias_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, place, type) AS (SELECT OLD.id, OLD.place, OLD.type)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"place_alias"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_place_type_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id, parent) AS (SELECT NEW.id, NEW.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"place_type"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_place_type_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, parent) AS (SELECT NEW.id, NEW.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"place_type"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_place_type_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, parent) AS (SELECT OLD.id, OLD.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"place_type"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_track_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(artist_credit, id, medium, recording) AS (SELECT NEW.artist_credit, NEW.id, NEW.medium, NEW.recording)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"track"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_track_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(artist_credit, id, medium, recording) AS (SELECT NEW.artist_credit, NEW.id, NEW.medium, NEW.recording)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"track"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_track_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(artist_credit, id, medium, recording) AS (SELECT OLD.artist_credit, OLD.id, OLD.medium, OLD.recording)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"track"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_medium_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(format, id, release) AS (SELECT NEW.format, NEW.id, NEW.release)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"medium"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_medium_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(format, id, release) AS (SELECT NEW.format, NEW.id, NEW.release)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"medium"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_medium_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(format, id, release) AS (SELECT OLD.format, OLD.id, OLD.release)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"medium"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_country_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(country, release) AS (SELECT NEW.country, NEW.release)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_country"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_country_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(country, release) AS (SELECT NEW.country, NEW.release)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_country"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_country_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(country, release) AS (SELECT OLD.country, OLD.release)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_country"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_country_area_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(area) AS (SELECT NEW.area)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"country_area"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_country_area_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(area) AS (SELECT NEW.area)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"country_area"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_country_area_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(area) AS (SELECT OLD.area)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"country_area"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_medium_format_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id, parent) AS (SELECT NEW.id, NEW.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"medium_format"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_medium_format_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, parent) AS (SELECT NEW.id, NEW.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"medium_format"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_medium_format_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, parent) AS (SELECT OLD.id, OLD.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"medium_format"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_isrc_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id, recording) AS (SELECT NEW.id, NEW.recording)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"isrc"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_isrc_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, recording) AS (SELECT NEW.id, NEW.recording)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"isrc"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_isrc_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, recording) AS (SELECT OLD.id, OLD.recording)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"isrc"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_primary_type_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id, parent) AS (SELECT NEW.id, NEW.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_group_primary_type"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_primary_type_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, parent) AS (SELECT NEW.id, NEW.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_group_primary_type"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_primary_type_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, parent) AS (SELECT OLD.id, OLD.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_group_primary_type"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_secondary_type_join_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(release_group, secondary_type) AS (SELECT NEW.release_group, NEW.secondary_type)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_group_secondary_type_join"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_secondary_type_join_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(release_group, secondary_type) AS (SELECT NEW.release_group, NEW.secondary_type)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_group_secondary_type_join"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_secondary_type_join_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(release_group, secondary_type) AS (SELECT OLD.release_group, OLD.secondary_type)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_group_secondary_type_join"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_secondary_type_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id, parent) AS (SELECT NEW.id, NEW.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_group_secondary_type"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_secondary_type_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, parent) AS (SELECT NEW.id, NEW.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_group_secondary_type"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_secondary_type_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, parent) AS (SELECT OLD.id, OLD.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_group_secondary_type"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_status_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id, parent) AS (SELECT NEW.id, NEW.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_status"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_status_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, parent) AS (SELECT NEW.id, NEW.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_status"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_status_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, parent) AS (SELECT OLD.id, OLD.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_status"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_tag_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(recording, tag) AS (SELECT NEW.recording, NEW.tag)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"recording_tag"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_tag_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(recording, tag) AS (SELECT NEW.recording, NEW.tag)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"recording_tag"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_tag_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(recording, tag) AS (SELECT OLD.recording, OLD.tag)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"recording_tag"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_meta_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_meta"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_meta_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_meta"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_meta_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id) AS (SELECT OLD.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_meta"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_label_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id, label, release) AS (SELECT NEW.id, NEW.label, NEW.release)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_label"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_label_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, label, release) AS (SELECT NEW.id, NEW.label, NEW.release)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_label"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_label_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, label, release) AS (SELECT OLD.id, OLD.label, OLD.release)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_label"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_medium_cdtoc_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(cdtoc, id, medium) AS (SELECT NEW.cdtoc, NEW.id, NEW.medium)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"medium_cdtoc"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_medium_cdtoc_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(cdtoc, id, medium) AS (SELECT NEW.cdtoc, NEW.id, NEW.medium)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"medium_cdtoc"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_medium_cdtoc_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(cdtoc, id, medium) AS (SELECT OLD.cdtoc, OLD.id, OLD.medium)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"medium_cdtoc"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_language_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"language"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_language_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"language"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_language_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id) AS (SELECT OLD.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"language"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_script_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"script"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_script_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"script"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_script_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id) AS (SELECT OLD.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"script"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_tag_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(release, tag) AS (SELECT NEW.release, NEW.tag)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_tag"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_tag_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(release, tag) AS (SELECT NEW.release, NEW.tag)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_tag"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_tag_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(release, tag) AS (SELECT OLD.release, OLD.tag)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_tag"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_tag_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(release_group, tag) AS (SELECT NEW.release_group, NEW.tag)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_group_tag"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_tag_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(release_group, tag) AS (SELECT NEW.release_group, NEW.tag)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_group_tag"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_tag_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(release_group, tag) AS (SELECT OLD.release_group, OLD.tag)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"release_group_tag"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_series_alias_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id, series, type) AS (SELECT NEW.id, NEW.series, NEW.type)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"series_alias"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_series_alias_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, series, type) AS (SELECT NEW.id, NEW.series, NEW.type)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"series_alias"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_series_alias_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, series, type) AS (SELECT OLD.id, OLD.series, OLD.type)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"series_alias"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_link_attribute_type_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id, parent, root) AS (SELECT NEW.id, NEW.parent, NEW.root)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"link_attribute_type"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_link_attribute_type_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, parent, root) AS (SELECT NEW.id, NEW.parent, NEW.root)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"link_attribute_type"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_link_attribute_type_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, parent, root) AS (SELECT OLD.id, OLD.parent, OLD.root)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"link_attribute_type"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_series_tag_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(series, tag) AS (SELECT NEW.series, NEW.tag)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"series_tag"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_series_tag_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(series, tag) AS (SELECT NEW.series, NEW.tag)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"series_tag"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_series_tag_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(series, tag) AS (SELECT OLD.series, OLD.tag)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"series_tag"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_series_type_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id, parent) AS (SELECT NEW.id, NEW.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"series_type"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_series_type_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, parent) AS (SELECT NEW.id, NEW.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"series_type"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_series_type_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, parent) AS (SELECT OLD.id, OLD.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"series_type"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_url_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"url"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_url_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"url"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_url_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'delete', (
            WITH keys(gid) AS (SELECT OLD.gid)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"url"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_artist_url_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(entity0, entity1, id, link) AS (SELECT NEW.entity0, NEW.entity1, NEW.id, NEW.link)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"l_artist_url"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_artist_url_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(entity0, entity1, id, link) AS (SELECT NEW.entity0, NEW.entity1, NEW.id, NEW.link)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"l_artist_url"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_artist_url_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(entity0, entity1, id, link) AS (SELECT OLD.entity0, OLD.entity1, OLD.id, OLD.link)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"l_artist_url"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_link_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id, link_type) AS (SELECT NEW.id, NEW.link_type)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"link"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_link_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, link_type) AS (SELECT NEW.id, NEW.link_type)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"link"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_link_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, link_type) AS (SELECT OLD.id, OLD.link_type)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"link"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_link_type_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id, parent) AS (SELECT NEW.id, NEW.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"link_type"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_link_type_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, parent) AS (SELECT NEW.id, NEW.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"link_type"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_link_type_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, parent) AS (SELECT OLD.id, OLD.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"link_type"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_alias_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id, type, work) AS (SELECT NEW.id, NEW.type, NEW.work)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"work_alias"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_alias_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, type, work) AS (SELECT NEW.id, NEW.type, NEW.work)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"work_alias"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_alias_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, type, work) AS (SELECT OLD.id, OLD.type, OLD.work)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"work_alias"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_artist_work_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(entity0, entity1, id, link) AS (SELECT NEW.entity0, NEW.entity1, NEW.id, NEW.link)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"l_artist_work"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_artist_work_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(entity0, entity1, id, link) AS (SELECT NEW.entity0, NEW.entity1, NEW.id, NEW.link)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"l_artist_work"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_artist_work_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(entity0, entity1, id, link) AS (SELECT OLD.entity0, OLD.entity1, OLD.id, OLD.link)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"l_artist_work"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_iswc_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id, work) AS (SELECT NEW.id, NEW.work)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"iswc"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_iswc_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, work) AS (SELECT NEW.id, NEW.work)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"iswc"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_iswc_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, work) AS (SELECT OLD.id, OLD.work)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"iswc"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_language_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(language, work) AS (SELECT NEW.language, NEW.work)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"work_language"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_language_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(language, work) AS (SELECT NEW.language, NEW.work)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"work_language"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_language_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(language, work) AS (SELECT OLD.language, OLD.work)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"work_language"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_recording_work_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(entity0, entity1, id, link) AS (SELECT NEW.entity0, NEW.entity1, NEW.id, NEW.link)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"l_recording_work"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_recording_work_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(entity0, entity1, id, link) AS (SELECT NEW.entity0, NEW.entity1, NEW.id, NEW.link)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"l_recording_work"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_recording_work_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(entity0, entity1, id, link) AS (SELECT OLD.entity0, OLD.entity1, OLD.id, OLD.link)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"l_recording_work"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_tag_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(tag, work) AS (SELECT NEW.tag, NEW.work)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"work_tag"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_tag_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(tag, work) AS (SELECT NEW.tag, NEW.work)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"work_tag"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_tag_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(tag, work) AS (SELECT OLD.tag, OLD.work)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"work_tag"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_type_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'index', (
            WITH keys(id, parent) AS (SELECT NEW.id, NEW.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"work_type"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_type_update() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, parent) AS (SELECT NEW.id, NEW.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"work_type"')::text FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_type_delete() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(2, 'search', 'update', (
            WITH keys(id, parent) AS (SELECT OLD.id, OLD.parent)
            SELECT jsonb_set(to_jsonb(keys), '{_table}', '"work_type"')::text FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

COMMIT;

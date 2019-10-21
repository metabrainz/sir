-- Automatically generated, do not edit!
\set ON_ERROR_STOP 1
BEGIN;

CREATE OR REPLACE FUNCTION search_annotation_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(editor, id) AS (SELECT NEW.editor, NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"annotation"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_annotation_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(editor, id) AS (SELECT NEW.editor, NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"annotation"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_annotation_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'delete', (
            WITH keys(editor, id) AS (SELECT OLD.editor, OLD.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"annotation"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_area_annotation_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(annotation, area) AS (SELECT NEW.annotation, NEW.area)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"area_annotation"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_area_annotation_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(annotation, area) AS (SELECT NEW.annotation, NEW.area)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"area_annotation"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_area_annotation_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(annotation, area) AS (SELECT OLD.annotation, OLD.area)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"area_annotation"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_area_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id, type) AS (SELECT NEW.id, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"area"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_area_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id, type) AS (SELECT NEW.id, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"area"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_area_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'delete', (
            WITH keys(id, type, gid) AS (SELECT OLD.id, OLD.type, OLD.gid)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"area"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_annotation_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(annotation, artist) AS (SELECT NEW.annotation, NEW.artist)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"artist_annotation"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_annotation_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(annotation, artist) AS (SELECT NEW.annotation, NEW.artist)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"artist_annotation"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_annotation_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(annotation, artist) AS (SELECT OLD.annotation, OLD.artist)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"artist_annotation"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(area, begin_area, end_area, gender, id, type) AS (SELECT NEW.area, NEW.begin_area, NEW.end_area, NEW.gender, NEW.id, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"artist"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(area, begin_area, end_area, gender, id, type) AS (SELECT NEW.area, NEW.begin_area, NEW.end_area, NEW.gender, NEW.id, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"artist"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'delete', (
            WITH keys(area, begin_area, end_area, gender, id, type, gid) AS (SELECT OLD.area, OLD.begin_area, OLD.end_area, OLD.gender, OLD.id, OLD.type, OLD.gid)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"artist"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_event_annotation_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(annotation, event) AS (SELECT NEW.annotation, NEW.event)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"event_annotation"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_event_annotation_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(annotation, event) AS (SELECT NEW.annotation, NEW.event)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"event_annotation"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_event_annotation_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(annotation, event) AS (SELECT OLD.annotation, OLD.event)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"event_annotation"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_event_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id, type) AS (SELECT NEW.id, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"event"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_event_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id, type) AS (SELECT NEW.id, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"event"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_event_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'delete', (
            WITH keys(id, type, gid) AS (SELECT OLD.id, OLD.type, OLD.gid)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"event"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_instrument_annotation_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(annotation, instrument) AS (SELECT NEW.annotation, NEW.instrument)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"instrument_annotation"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_instrument_annotation_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(annotation, instrument) AS (SELECT NEW.annotation, NEW.instrument)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"instrument_annotation"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_instrument_annotation_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(annotation, instrument) AS (SELECT OLD.annotation, OLD.instrument)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"instrument_annotation"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_instrument_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id, type) AS (SELECT NEW.id, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"instrument"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_instrument_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id, type) AS (SELECT NEW.id, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"instrument"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_instrument_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'delete', (
            WITH keys(id, type, gid) AS (SELECT OLD.id, OLD.type, OLD.gid)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"instrument"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_annotation_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(annotation, label) AS (SELECT NEW.annotation, NEW.label)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"label_annotation"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_annotation_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(annotation, label) AS (SELECT NEW.annotation, NEW.label)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"label_annotation"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_annotation_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(annotation, label) AS (SELECT OLD.annotation, OLD.label)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"label_annotation"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(area, id, type) AS (SELECT NEW.area, NEW.id, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"label"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(area, id, type) AS (SELECT NEW.area, NEW.id, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"label"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'delete', (
            WITH keys(area, id, type, gid) AS (SELECT OLD.area, OLD.id, OLD.type, OLD.gid)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"label"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_place_annotation_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(annotation, place) AS (SELECT NEW.annotation, NEW.place)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"place_annotation"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_place_annotation_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(annotation, place) AS (SELECT NEW.annotation, NEW.place)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"place_annotation"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_place_annotation_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(annotation, place) AS (SELECT OLD.annotation, OLD.place)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"place_annotation"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_place_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(area, id, type) AS (SELECT NEW.area, NEW.id, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"place"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_place_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(area, id, type) AS (SELECT NEW.area, NEW.id, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"place"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_place_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'delete', (
            WITH keys(area, id, type, gid) AS (SELECT OLD.area, OLD.id, OLD.type, OLD.gid)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"place"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_annotation_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(annotation, recording) AS (SELECT NEW.annotation, NEW.recording)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"recording_annotation"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_annotation_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(annotation, recording) AS (SELECT NEW.annotation, NEW.recording)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"recording_annotation"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_annotation_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(annotation, recording) AS (SELECT OLD.annotation, OLD.recording)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"recording_annotation"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(artist_credit, id) AS (SELECT NEW.artist_credit, NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"recording"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(artist_credit, id) AS (SELECT NEW.artist_credit, NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"recording"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'delete', (
            WITH keys(artist_credit, id, gid) AS (SELECT OLD.artist_credit, OLD.id, OLD.gid)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"recording"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_annotation_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(annotation, release) AS (SELECT NEW.annotation, NEW.release)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_annotation"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_annotation_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(annotation, release) AS (SELECT NEW.annotation, NEW.release)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_annotation"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_annotation_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(annotation, release) AS (SELECT OLD.annotation, OLD.release)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_annotation"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(artist_credit, id, language, packaging, release_group, script, status) AS (SELECT NEW.artist_credit, NEW.id, NEW.language, NEW.packaging, NEW.release_group, NEW.script, NEW.status)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(artist_credit, id, language, packaging, release_group, script, status) AS (SELECT NEW.artist_credit, NEW.id, NEW.language, NEW.packaging, NEW.release_group, NEW.script, NEW.status)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'delete', (
            WITH keys(artist_credit, id, language, packaging, release_group, script, status, gid) AS (SELECT OLD.artist_credit, OLD.id, OLD.language, OLD.packaging, OLD.release_group, OLD.script, OLD.status, OLD.gid)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_annotation_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(annotation, release_group) AS (SELECT NEW.annotation, NEW.release_group)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_group_annotation"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_annotation_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(annotation, release_group) AS (SELECT NEW.annotation, NEW.release_group)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_group_annotation"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_annotation_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(annotation, release_group) AS (SELECT OLD.annotation, OLD.release_group)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_group_annotation"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(artist_credit, id, type) AS (SELECT NEW.artist_credit, NEW.id, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_group"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(artist_credit, id, type) AS (SELECT NEW.artist_credit, NEW.id, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_group"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'delete', (
            WITH keys(artist_credit, id, type, gid) AS (SELECT OLD.artist_credit, OLD.id, OLD.type, OLD.gid)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_group"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_series_annotation_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(annotation, series) AS (SELECT NEW.annotation, NEW.series)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"series_annotation"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_series_annotation_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(annotation, series) AS (SELECT NEW.annotation, NEW.series)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"series_annotation"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_series_annotation_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(annotation, series) AS (SELECT OLD.annotation, OLD.series)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"series_annotation"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_series_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id, ordering_attribute, ordering_type, type) AS (SELECT NEW.id, NEW.ordering_attribute, NEW.ordering_type, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"series"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_series_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id, ordering_attribute, ordering_type, type) AS (SELECT NEW.id, NEW.ordering_attribute, NEW.ordering_type, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"series"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_series_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'delete', (
            WITH keys(id, ordering_attribute, ordering_type, type, gid) AS (SELECT OLD.id, OLD.ordering_attribute, OLD.ordering_type, OLD.type, OLD.gid)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"series"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_annotation_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(annotation, work) AS (SELECT NEW.annotation, NEW.work)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"work_annotation"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_annotation_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(annotation, work) AS (SELECT NEW.annotation, NEW.work)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"work_annotation"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_annotation_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(annotation, work) AS (SELECT OLD.annotation, OLD.work)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"work_annotation"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id, type) AS (SELECT NEW.id, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"work"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id, type) AS (SELECT NEW.id, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"work"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'delete', (
            WITH keys(id, type, gid) AS (SELECT OLD.id, OLD.type, OLD.gid)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"work"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_area_alias_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(area, id, type) AS (SELECT NEW.area, NEW.id, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"area_alias"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_area_alias_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(area, id, type) AS (SELECT NEW.area, NEW.id, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"area_alias"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_area_alias_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(area, id, type) AS (SELECT OLD.area, OLD.id, OLD.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"area_alias"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_iso_3166_1_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(area, code) AS (SELECT NEW.area, NEW.code)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"iso_3166_1"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_iso_3166_1_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(area, code) AS (SELECT NEW.area, NEW.code)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"iso_3166_1"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_iso_3166_1_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(area, code) AS (SELECT OLD.area, OLD.code)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"iso_3166_1"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_iso_3166_2_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(area, code) AS (SELECT NEW.area, NEW.code)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"iso_3166_2"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_iso_3166_2_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(area, code) AS (SELECT NEW.area, NEW.code)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"iso_3166_2"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_iso_3166_2_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(area, code) AS (SELECT OLD.area, OLD.code)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"iso_3166_2"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_iso_3166_3_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(area, code) AS (SELECT NEW.area, NEW.code)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"iso_3166_3"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_iso_3166_3_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(area, code) AS (SELECT NEW.area, NEW.code)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"iso_3166_3"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_iso_3166_3_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(area, code) AS (SELECT OLD.area, OLD.code)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"iso_3166_3"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_area_tag_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(area, tag) AS (SELECT NEW.area, NEW.tag)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"area_tag"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_area_tag_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(area, tag) AS (SELECT NEW.area, NEW.tag)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"area_tag"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_area_tag_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(area, tag) AS (SELECT OLD.area, OLD.tag)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"area_tag"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_tag_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"tag"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_tag_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"tag"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_tag_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'delete', (
            WITH keys(id) AS (SELECT OLD.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"tag"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_area_type_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"area_type"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_area_type_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"area_type"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_area_type_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT OLD.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"area_type"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_alias_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(artist, id, type) AS (SELECT NEW.artist, NEW.id, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"artist_alias"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_alias_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(artist, id, type) AS (SELECT NEW.artist, NEW.id, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"artist_alias"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_alias_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(artist, id, type) AS (SELECT OLD.artist, OLD.id, OLD.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"artist_alias"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_gender_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"gender"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_gender_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"gender"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_gender_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT OLD.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"gender"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_ipi_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(artist, ipi) AS (SELECT NEW.artist, NEW.ipi)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"artist_ipi"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_ipi_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(artist, ipi) AS (SELECT NEW.artist, NEW.ipi)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"artist_ipi"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_ipi_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(artist, ipi) AS (SELECT OLD.artist, OLD.ipi)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"artist_ipi"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_isni_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(artist, isni) AS (SELECT NEW.artist, NEW.isni)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"artist_isni"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_isni_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(artist, isni) AS (SELECT NEW.artist, NEW.isni)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"artist_isni"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_isni_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(artist, isni) AS (SELECT OLD.artist, OLD.isni)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"artist_isni"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_tag_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(artist, tag) AS (SELECT NEW.artist, NEW.tag)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"artist_tag"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_tag_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(artist, tag) AS (SELECT NEW.artist, NEW.tag)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"artist_tag"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_tag_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(artist, tag) AS (SELECT OLD.artist, OLD.tag)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"artist_tag"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_type_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"artist_type"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_type_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"artist_type"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_type_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT OLD.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"artist_type"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_raw_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_raw"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_raw_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_raw"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_raw_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'delete', (
            WITH keys(id) AS (SELECT OLD.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_raw"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_cdtoc_raw_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id, release) AS (SELECT NEW.id, NEW.release)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"cdtoc_raw"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_cdtoc_raw_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id, release) AS (SELECT NEW.id, NEW.release)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"cdtoc_raw"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_cdtoc_raw_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id, release) AS (SELECT OLD.id, OLD.release)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"cdtoc_raw"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_editor_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(area, gender, id) AS (SELECT NEW.area, NEW.gender, NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"editor"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_editor_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(area, gender, id) AS (SELECT NEW.area, NEW.gender, NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"editor"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_editor_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'delete', (
            WITH keys(area, gender, id) AS (SELECT OLD.area, OLD.gender, OLD.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"editor"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_event_alias_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(event, id, type) AS (SELECT NEW.event, NEW.id, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"event_alias"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_event_alias_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(event, id, type) AS (SELECT NEW.event, NEW.id, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"event_alias"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_event_alias_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(event, id, type) AS (SELECT OLD.event, OLD.id, OLD.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"event_alias"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_area_event_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(entity0, entity1, id, link) AS (SELECT NEW.entity0, NEW.entity1, NEW.id, NEW.link)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"l_area_event"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_area_event_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(entity0, entity1, id, link) AS (SELECT NEW.entity0, NEW.entity1, NEW.id, NEW.link)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"l_area_event"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_area_event_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(entity0, entity1, id, link) AS (SELECT OLD.entity0, OLD.entity1, OLD.id, OLD.link)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"l_area_event"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_artist_event_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(entity0, entity1, id, link) AS (SELECT NEW.entity0, NEW.entity1, NEW.id, NEW.link)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"l_artist_event"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_artist_event_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(entity0, entity1, id, link) AS (SELECT NEW.entity0, NEW.entity1, NEW.id, NEW.link)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"l_artist_event"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_artist_event_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(entity0, entity1, id, link) AS (SELECT OLD.entity0, OLD.entity1, OLD.id, OLD.link)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"l_artist_event"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_event_place_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(entity0, entity1, id, link) AS (SELECT NEW.entity0, NEW.entity1, NEW.id, NEW.link)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"l_event_place"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_event_place_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(entity0, entity1, id, link) AS (SELECT NEW.entity0, NEW.entity1, NEW.id, NEW.link)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"l_event_place"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_event_place_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(entity0, entity1, id, link) AS (SELECT OLD.entity0, OLD.entity1, OLD.id, OLD.link)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"l_event_place"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_event_tag_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(event, tag) AS (SELECT NEW.event, NEW.tag)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"event_tag"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_event_tag_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(event, tag) AS (SELECT NEW.event, NEW.tag)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"event_tag"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_event_tag_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(event, tag) AS (SELECT OLD.event, OLD.tag)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"event_tag"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_event_type_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"event_type"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_event_type_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"event_type"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_event_type_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT OLD.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"event_type"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_instrument_alias_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id, instrument, type) AS (SELECT NEW.id, NEW.instrument, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"instrument_alias"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_instrument_alias_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id, instrument, type) AS (SELECT NEW.id, NEW.instrument, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"instrument_alias"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_instrument_alias_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id, instrument, type) AS (SELECT OLD.id, OLD.instrument, OLD.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"instrument_alias"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_instrument_tag_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(instrument, tag) AS (SELECT NEW.instrument, NEW.tag)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"instrument_tag"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_instrument_tag_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(instrument, tag) AS (SELECT NEW.instrument, NEW.tag)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"instrument_tag"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_instrument_tag_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(instrument, tag) AS (SELECT OLD.instrument, OLD.tag)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"instrument_tag"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_instrument_type_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"instrument_type"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_instrument_type_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"instrument_type"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_instrument_type_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT OLD.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"instrument_type"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_alias_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id, label, type) AS (SELECT NEW.id, NEW.label, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"label_alias"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_alias_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id, label, type) AS (SELECT NEW.id, NEW.label, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"label_alias"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_alias_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id, label, type) AS (SELECT OLD.id, OLD.label, OLD.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"label_alias"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_ipi_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(ipi, label) AS (SELECT NEW.ipi, NEW.label)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"label_ipi"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_ipi_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(ipi, label) AS (SELECT NEW.ipi, NEW.label)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"label_ipi"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_ipi_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(ipi, label) AS (SELECT OLD.ipi, OLD.label)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"label_ipi"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_isni_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(isni, label) AS (SELECT NEW.isni, NEW.label)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"label_isni"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_isni_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(isni, label) AS (SELECT NEW.isni, NEW.label)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"label_isni"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_isni_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(isni, label) AS (SELECT OLD.isni, OLD.label)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"label_isni"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_tag_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(label, tag) AS (SELECT NEW.label, NEW.tag)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"label_tag"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_tag_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(label, tag) AS (SELECT NEW.label, NEW.tag)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"label_tag"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_tag_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(label, tag) AS (SELECT OLD.label, OLD.tag)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"label_tag"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_type_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"label_type"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_type_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"label_type"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_type_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT OLD.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"label_type"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_place_alias_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id, place, type) AS (SELECT NEW.id, NEW.place, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"place_alias"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_place_alias_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id, place, type) AS (SELECT NEW.id, NEW.place, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"place_alias"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_place_alias_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id, place, type) AS (SELECT OLD.id, OLD.place, OLD.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"place_alias"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_place_type_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"place_type"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_place_type_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"place_type"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_place_type_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT OLD.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"place_type"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_alias_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id, recording, type) AS (SELECT NEW.id, NEW.recording, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"recording_alias"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_alias_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id, recording, type) AS (SELECT NEW.id, NEW.recording, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"recording_alias"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_alias_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id, recording, type) AS (SELECT OLD.id, OLD.recording, OLD.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"recording_alias"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_credit_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"artist_credit"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_credit_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"artist_credit"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_credit_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT OLD.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"artist_credit"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_credit_name_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(artist, artist_credit, position) AS (SELECT NEW.artist, NEW.artist_credit, NEW.position)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"artist_credit_name"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_credit_name_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(artist, artist_credit, position) AS (SELECT NEW.artist, NEW.artist_credit, NEW.position)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"artist_credit_name"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_credit_name_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(artist, artist_credit, position) AS (SELECT OLD.artist, OLD.artist_credit, OLD.position)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"artist_credit_name"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_track_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(artist_credit, id, medium, recording) AS (SELECT NEW.artist_credit, NEW.id, NEW.medium, NEW.recording)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"track"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_track_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(artist_credit, id, medium, recording) AS (SELECT NEW.artist_credit, NEW.id, NEW.medium, NEW.recording)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"track"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_track_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(artist_credit, id, medium, recording) AS (SELECT OLD.artist_credit, OLD.id, OLD.medium, OLD.recording)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"track"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_medium_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(format, id, release) AS (SELECT NEW.format, NEW.id, NEW.release)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"medium"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_medium_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(format, id, release) AS (SELECT NEW.format, NEW.id, NEW.release)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"medium"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_medium_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(format, id, release) AS (SELECT OLD.format, OLD.id, OLD.release)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"medium"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_country_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(country, release) AS (SELECT NEW.country, NEW.release)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_country"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_country_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(country, release) AS (SELECT NEW.country, NEW.release)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_country"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_country_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(country, release) AS (SELECT OLD.country, OLD.release)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_country"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_country_area_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(area) AS (SELECT NEW.area)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"country_area"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_country_area_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(area) AS (SELECT NEW.area)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"country_area"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_country_area_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(area) AS (SELECT OLD.area)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"country_area"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_medium_format_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"medium_format"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_medium_format_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"medium_format"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_medium_format_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT OLD.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"medium_format"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_isrc_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id, recording) AS (SELECT NEW.id, NEW.recording)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"isrc"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_isrc_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id, recording) AS (SELECT NEW.id, NEW.recording)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"isrc"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_isrc_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id, recording) AS (SELECT OLD.id, OLD.recording)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"isrc"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_primary_type_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_group_primary_type"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_primary_type_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_group_primary_type"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_primary_type_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT OLD.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_group_primary_type"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_secondary_type_join_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(release_group, secondary_type) AS (SELECT NEW.release_group, NEW.secondary_type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_group_secondary_type_join"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_secondary_type_join_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(release_group, secondary_type) AS (SELECT NEW.release_group, NEW.secondary_type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_group_secondary_type_join"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_secondary_type_join_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(release_group, secondary_type) AS (SELECT OLD.release_group, OLD.secondary_type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_group_secondary_type_join"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_secondary_type_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_group_secondary_type"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_secondary_type_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_group_secondary_type"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_secondary_type_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT OLD.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_group_secondary_type"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_status_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_status"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_status_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_status"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_status_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT OLD.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_status"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_tag_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(recording, tag) AS (SELECT NEW.recording, NEW.tag)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"recording_tag"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_tag_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(recording, tag) AS (SELECT NEW.recording, NEW.tag)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"recording_tag"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_tag_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(recording, tag) AS (SELECT OLD.recording, OLD.tag)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"recording_tag"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_alias_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id, release, type) AS (SELECT NEW.id, NEW.release, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_alias"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_alias_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id, release, type) AS (SELECT NEW.id, NEW.release, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_alias"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_alias_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id, release, type) AS (SELECT OLD.id, OLD.release, OLD.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_alias"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_meta_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_meta"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_meta_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_meta"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_meta_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT OLD.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_meta"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_label_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id, label, release) AS (SELECT NEW.id, NEW.label, NEW.release)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_label"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_label_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id, label, release) AS (SELECT NEW.id, NEW.label, NEW.release)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_label"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_label_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id, label, release) AS (SELECT OLD.id, OLD.label, OLD.release)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_label"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_language_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"language"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_language_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"language"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_language_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT OLD.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"language"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_script_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"script"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_script_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"script"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_script_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT OLD.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"script"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_tag_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(release, tag) AS (SELECT NEW.release, NEW.tag)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_tag"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_tag_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(release, tag) AS (SELECT NEW.release, NEW.tag)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_tag"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_tag_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(release, tag) AS (SELECT OLD.release, OLD.tag)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_tag"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_alias_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id, release_group, type) AS (SELECT NEW.id, NEW.release_group, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_group_alias"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_alias_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id, release_group, type) AS (SELECT NEW.id, NEW.release_group, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_group_alias"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_alias_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id, release_group, type) AS (SELECT OLD.id, OLD.release_group, OLD.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_group_alias"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_tag_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(release_group, tag) AS (SELECT NEW.release_group, NEW.tag)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_group_tag"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_tag_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(release_group, tag) AS (SELECT NEW.release_group, NEW.tag)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_group_tag"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_tag_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(release_group, tag) AS (SELECT OLD.release_group, OLD.tag)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"release_group_tag"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_series_alias_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id, series, type) AS (SELECT NEW.id, NEW.series, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"series_alias"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_series_alias_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id, series, type) AS (SELECT NEW.id, NEW.series, NEW.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"series_alias"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_series_alias_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id, series, type) AS (SELECT OLD.id, OLD.series, OLD.type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"series_alias"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_link_attribute_type_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"link_attribute_type"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_link_attribute_type_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"link_attribute_type"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_link_attribute_type_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT OLD.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"link_attribute_type"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_series_tag_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(series, tag) AS (SELECT NEW.series, NEW.tag)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"series_tag"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_series_tag_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(series, tag) AS (SELECT NEW.series, NEW.tag)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"series_tag"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_series_tag_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(series, tag) AS (SELECT OLD.series, OLD.tag)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"series_tag"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_series_type_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"series_type"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_series_type_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"series_type"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_series_type_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT OLD.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"series_type"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_url_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"url"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_url_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"url"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_url_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'delete', (
            WITH keys(id, gid) AS (SELECT OLD.id, OLD.gid)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"url"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_artist_url_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(entity0, entity1, id, link) AS (SELECT NEW.entity0, NEW.entity1, NEW.id, NEW.link)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"l_artist_url"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_artist_url_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(entity0, entity1, id, link) AS (SELECT NEW.entity0, NEW.entity1, NEW.id, NEW.link)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"l_artist_url"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_artist_url_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(entity0, entity1, id, link) AS (SELECT OLD.entity0, OLD.entity1, OLD.id, OLD.link)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"l_artist_url"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_link_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id, link_type) AS (SELECT NEW.id, NEW.link_type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"link"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_link_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id, link_type) AS (SELECT NEW.id, NEW.link_type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"link"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_link_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id, link_type) AS (SELECT OLD.id, OLD.link_type)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"link"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_link_type_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"link_type"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_link_type_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"link_type"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_link_type_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT OLD.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"link_type"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_release_url_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(entity0, entity1, id, link) AS (SELECT NEW.entity0, NEW.entity1, NEW.id, NEW.link)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"l_release_url"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_release_url_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(entity0, entity1, id, link) AS (SELECT NEW.entity0, NEW.entity1, NEW.id, NEW.link)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"l_release_url"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_release_url_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(entity0, entity1, id, link) AS (SELECT OLD.entity0, OLD.entity1, OLD.id, OLD.link)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"l_release_url"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_alias_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id, type, work) AS (SELECT NEW.id, NEW.type, NEW.work)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"work_alias"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_alias_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id, type, work) AS (SELECT NEW.id, NEW.type, NEW.work)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"work_alias"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_alias_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id, type, work) AS (SELECT OLD.id, OLD.type, OLD.work)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"work_alias"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_artist_work_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(entity0, entity1, id, link) AS (SELECT NEW.entity0, NEW.entity1, NEW.id, NEW.link)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"l_artist_work"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_artist_work_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(entity0, entity1, id, link) AS (SELECT NEW.entity0, NEW.entity1, NEW.id, NEW.link)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"l_artist_work"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_artist_work_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(entity0, entity1, id, link) AS (SELECT OLD.entity0, OLD.entity1, OLD.id, OLD.link)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"l_artist_work"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_iswc_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id, work) AS (SELECT NEW.id, NEW.work)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"iswc"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_iswc_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id, work) AS (SELECT NEW.id, NEW.work)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"iswc"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_iswc_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id, work) AS (SELECT OLD.id, OLD.work)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"iswc"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_language_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(language, work) AS (SELECT NEW.language, NEW.work)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"work_language"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_language_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(language, work) AS (SELECT NEW.language, NEW.work)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"work_language"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_language_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(language, work) AS (SELECT OLD.language, OLD.work)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"work_language"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_recording_work_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(entity0, entity1, id, link) AS (SELECT NEW.entity0, NEW.entity1, NEW.id, NEW.link)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"l_recording_work"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_recording_work_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(entity0, entity1, id, link) AS (SELECT NEW.entity0, NEW.entity1, NEW.id, NEW.link)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"l_recording_work"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_l_recording_work_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(entity0, entity1, id, link) AS (SELECT OLD.entity0, OLD.entity1, OLD.id, OLD.link)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"l_recording_work"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_tag_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(tag, work) AS (SELECT NEW.tag, NEW.work)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"work_tag"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_tag_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(tag, work) AS (SELECT NEW.tag, NEW.work)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"work_tag"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_tag_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(tag, work) AS (SELECT OLD.tag, OLD.work)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"work_tag"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_type_insert() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'index', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"work_type"'),
                             '{_operation}', '"insert"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_type_update() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT NEW.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"work_type"'),
                             '{_operation}', '"update"') FROM keys
        ));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_type_delete() RETURNS trigger
    AS $$
BEGIN
    INSERT INTO sir.message (exchange, routing_key, message) VALUES ('search', 'update', (
            WITH keys(id) AS (SELECT OLD.id)
            SELECT jsonb_set(jsonb_set(to_jsonb(keys), '{_table}', '"work_type"'),
                             '{_operation}', '"delete"') FROM keys
        ));
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

COMMIT;

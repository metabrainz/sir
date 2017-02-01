-- Automatically generated, do not edit
\set ON_ERROR_STOP 1
BEGIN;

CREATE OR REPLACE FUNCTION search_annotation_delete_0() RETURNS trigger
    AS $$
DECLARE
    gids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO gids FROM (SELECT annotation.gid AS id FROM annotation WHERE annotation.id = OLD.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'delete', 'annotation ' || gids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_delete_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_annotation_insert_0() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id = NEW.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_insert_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_annotation_update_0() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id = NEW.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_update_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_annotation_delete_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (OLD.annotation)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_delete_1() IS 'The path for this function is areas';

CREATE OR REPLACE FUNCTION search_annotation_insert_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (NEW.annotation)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_insert_1() IS 'The path for this function is areas';

CREATE OR REPLACE FUNCTION search_annotation_update_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (NEW.annotation)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_update_1() IS 'The path for this function is areas';

CREATE OR REPLACE FUNCTION search_annotation_delete_2() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (SELECT area_annotation.area FROM area_annotation WHERE area_annotation.area IN (OLD.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_delete_2() IS 'The path for this function is areas.area';

CREATE OR REPLACE FUNCTION search_annotation_insert_2() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (SELECT area_annotation.area FROM area_annotation WHERE area_annotation.area IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_insert_2() IS 'The path for this function is areas.area';

CREATE OR REPLACE FUNCTION search_annotation_update_2() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (SELECT area_annotation.area FROM area_annotation WHERE area_annotation.area IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_update_2() IS 'The path for this function is areas.area';

CREATE OR REPLACE FUNCTION search_annotation_delete_3() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (OLD.annotation)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_delete_3() IS 'The path for this function is artists';

CREATE OR REPLACE FUNCTION search_annotation_insert_3() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (NEW.annotation)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_insert_3() IS 'The path for this function is artists';

CREATE OR REPLACE FUNCTION search_annotation_update_3() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (NEW.annotation)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_update_3() IS 'The path for this function is artists';

CREATE OR REPLACE FUNCTION search_annotation_delete_4() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (SELECT artist_annotation.artist FROM artist_annotation WHERE artist_annotation.artist IN (OLD.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_delete_4() IS 'The path for this function is artists.artist';

CREATE OR REPLACE FUNCTION search_annotation_insert_4() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (SELECT artist_annotation.artist FROM artist_annotation WHERE artist_annotation.artist IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_insert_4() IS 'The path for this function is artists.artist';

CREATE OR REPLACE FUNCTION search_annotation_update_4() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (SELECT artist_annotation.artist FROM artist_annotation WHERE artist_annotation.artist IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_update_4() IS 'The path for this function is artists.artist';

CREATE OR REPLACE FUNCTION search_annotation_delete_5() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (OLD.annotation)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_delete_5() IS 'The path for this function is events';

CREATE OR REPLACE FUNCTION search_annotation_insert_5() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (NEW.annotation)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_insert_5() IS 'The path for this function is events';

CREATE OR REPLACE FUNCTION search_annotation_update_5() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (NEW.annotation)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_update_5() IS 'The path for this function is events';

CREATE OR REPLACE FUNCTION search_annotation_delete_6() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (SELECT event_annotation.event FROM event_annotation WHERE event_annotation.event IN (OLD.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_delete_6() IS 'The path for this function is events.event';

CREATE OR REPLACE FUNCTION search_annotation_insert_6() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (SELECT event_annotation.event FROM event_annotation WHERE event_annotation.event IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_insert_6() IS 'The path for this function is events.event';

CREATE OR REPLACE FUNCTION search_annotation_update_6() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (SELECT event_annotation.event FROM event_annotation WHERE event_annotation.event IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_update_6() IS 'The path for this function is events.event';

CREATE OR REPLACE FUNCTION search_annotation_delete_7() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (OLD.annotation)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_delete_7() IS 'The path for this function is instruments';

CREATE OR REPLACE FUNCTION search_annotation_insert_7() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (NEW.annotation)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_insert_7() IS 'The path for this function is instruments';

CREATE OR REPLACE FUNCTION search_annotation_update_7() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (NEW.annotation)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_update_7() IS 'The path for this function is instruments';

CREATE OR REPLACE FUNCTION search_annotation_delete_8() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (SELECT instrument_annotation.instrument FROM instrument_annotation WHERE instrument_annotation.instrument IN (OLD.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_delete_8() IS 'The path for this function is instruments.instrument';

CREATE OR REPLACE FUNCTION search_annotation_insert_8() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (SELECT instrument_annotation.instrument FROM instrument_annotation WHERE instrument_annotation.instrument IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_insert_8() IS 'The path for this function is instruments.instrument';

CREATE OR REPLACE FUNCTION search_annotation_update_8() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (SELECT instrument_annotation.instrument FROM instrument_annotation WHERE instrument_annotation.instrument IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_update_8() IS 'The path for this function is instruments.instrument';

CREATE OR REPLACE FUNCTION search_annotation_delete_9() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (OLD.annotation)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_delete_9() IS 'The path for this function is labels';

CREATE OR REPLACE FUNCTION search_annotation_insert_9() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (NEW.annotation)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_insert_9() IS 'The path for this function is labels';

CREATE OR REPLACE FUNCTION search_annotation_update_9() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (NEW.annotation)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_update_9() IS 'The path for this function is labels';

CREATE OR REPLACE FUNCTION search_annotation_delete_10() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (SELECT label_annotation.label FROM label_annotation WHERE label_annotation.label IN (OLD.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_delete_10() IS 'The path for this function is labels.label';

CREATE OR REPLACE FUNCTION search_annotation_insert_10() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (SELECT label_annotation.label FROM label_annotation WHERE label_annotation.label IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_insert_10() IS 'The path for this function is labels.label';

CREATE OR REPLACE FUNCTION search_annotation_update_10() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (SELECT label_annotation.label FROM label_annotation WHERE label_annotation.label IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_update_10() IS 'The path for this function is labels.label';

CREATE OR REPLACE FUNCTION search_annotation_delete_11() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (OLD.annotation)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_delete_11() IS 'The path for this function is places';

CREATE OR REPLACE FUNCTION search_annotation_insert_11() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (NEW.annotation)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_insert_11() IS 'The path for this function is places';

CREATE OR REPLACE FUNCTION search_annotation_update_11() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (NEW.annotation)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_update_11() IS 'The path for this function is places';

CREATE OR REPLACE FUNCTION search_annotation_delete_12() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (SELECT place_annotation.place FROM place_annotation WHERE place_annotation.place IN (OLD.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_delete_12() IS 'The path for this function is places.place';

CREATE OR REPLACE FUNCTION search_annotation_insert_12() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (SELECT place_annotation.place FROM place_annotation WHERE place_annotation.place IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_insert_12() IS 'The path for this function is places.place';

CREATE OR REPLACE FUNCTION search_annotation_update_12() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (SELECT place_annotation.place FROM place_annotation WHERE place_annotation.place IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_update_12() IS 'The path for this function is places.place';

CREATE OR REPLACE FUNCTION search_annotation_delete_13() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (OLD.annotation)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_delete_13() IS 'The path for this function is recordings';

CREATE OR REPLACE FUNCTION search_annotation_insert_13() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (NEW.annotation)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_insert_13() IS 'The path for this function is recordings';

CREATE OR REPLACE FUNCTION search_annotation_update_13() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (NEW.annotation)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_update_13() IS 'The path for this function is recordings';

CREATE OR REPLACE FUNCTION search_annotation_delete_14() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (SELECT recording_annotation.recording FROM recording_annotation WHERE recording_annotation.recording IN (OLD.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_delete_14() IS 'The path for this function is recordings.recording';

CREATE OR REPLACE FUNCTION search_annotation_insert_14() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (SELECT recording_annotation.recording FROM recording_annotation WHERE recording_annotation.recording IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_insert_14() IS 'The path for this function is recordings.recording';

CREATE OR REPLACE FUNCTION search_annotation_update_14() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (SELECT recording_annotation.recording FROM recording_annotation WHERE recording_annotation.recording IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_update_14() IS 'The path for this function is recordings.recording';

CREATE OR REPLACE FUNCTION search_annotation_delete_15() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (OLD.annotation)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_delete_15() IS 'The path for this function is releases';

CREATE OR REPLACE FUNCTION search_annotation_insert_15() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (NEW.annotation)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_insert_15() IS 'The path for this function is releases';

CREATE OR REPLACE FUNCTION search_annotation_update_15() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (NEW.annotation)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_update_15() IS 'The path for this function is releases';

CREATE OR REPLACE FUNCTION search_annotation_delete_16() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (SELECT release_annotation.release FROM release_annotation WHERE release_annotation.release IN (OLD.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_delete_16() IS 'The path for this function is releases.release';

CREATE OR REPLACE FUNCTION search_annotation_insert_16() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (SELECT release_annotation.release FROM release_annotation WHERE release_annotation.release IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_insert_16() IS 'The path for this function is releases.release';

CREATE OR REPLACE FUNCTION search_annotation_update_16() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (SELECT release_annotation.release FROM release_annotation WHERE release_annotation.release IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_update_16() IS 'The path for this function is releases.release';

CREATE OR REPLACE FUNCTION search_annotation_delete_17() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (OLD.annotation)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_delete_17() IS 'The path for this function is release_groups';

CREATE OR REPLACE FUNCTION search_annotation_insert_17() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (NEW.annotation)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_insert_17() IS 'The path for this function is release_groups';

CREATE OR REPLACE FUNCTION search_annotation_update_17() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (NEW.annotation)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_update_17() IS 'The path for this function is release_groups';

CREATE OR REPLACE FUNCTION search_annotation_delete_18() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (SELECT release_group_annotation.release_group FROM release_group_annotation WHERE release_group_annotation.release_group IN (OLD.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_delete_18() IS 'The path for this function is release_groups.release_group';

CREATE OR REPLACE FUNCTION search_annotation_insert_18() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (SELECT release_group_annotation.release_group FROM release_group_annotation WHERE release_group_annotation.release_group IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_insert_18() IS 'The path for this function is release_groups.release_group';

CREATE OR REPLACE FUNCTION search_annotation_update_18() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (SELECT release_group_annotation.release_group FROM release_group_annotation WHERE release_group_annotation.release_group IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_update_18() IS 'The path for this function is release_groups.release_group';

CREATE OR REPLACE FUNCTION search_annotation_delete_19() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (OLD.annotation)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_delete_19() IS 'The path for this function is series';

CREATE OR REPLACE FUNCTION search_annotation_insert_19() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (NEW.annotation)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_insert_19() IS 'The path for this function is series';

CREATE OR REPLACE FUNCTION search_annotation_update_19() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (NEW.annotation)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_update_19() IS 'The path for this function is series';

CREATE OR REPLACE FUNCTION search_annotation_delete_20() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (SELECT series_annotation.series FROM series_annotation WHERE series_annotation.series IN (OLD.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_delete_20() IS 'The path for this function is series.series';

CREATE OR REPLACE FUNCTION search_annotation_insert_20() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (SELECT series_annotation.series FROM series_annotation WHERE series_annotation.series IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_insert_20() IS 'The path for this function is series.series';

CREATE OR REPLACE FUNCTION search_annotation_update_20() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (SELECT series_annotation.series FROM series_annotation WHERE series_annotation.series IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_update_20() IS 'The path for this function is series.series';

CREATE OR REPLACE FUNCTION search_annotation_delete_21() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (OLD.annotation)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_delete_21() IS 'The path for this function is works';

CREATE OR REPLACE FUNCTION search_annotation_insert_21() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (NEW.annotation)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_insert_21() IS 'The path for this function is works';

CREATE OR REPLACE FUNCTION search_annotation_update_21() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (NEW.annotation)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_update_21() IS 'The path for this function is works';

CREATE OR REPLACE FUNCTION search_annotation_delete_22() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (SELECT work_annotation.work FROM work_annotation WHERE work_annotation.work IN (OLD.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_delete_22() IS 'The path for this function is works.work';

CREATE OR REPLACE FUNCTION search_annotation_insert_22() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (SELECT work_annotation.work FROM work_annotation WHERE work_annotation.work IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_insert_22() IS 'The path for this function is works.work';

CREATE OR REPLACE FUNCTION search_annotation_update_22() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT annotation.id FROM annotation WHERE annotation.id IN (SELECT work_annotation.work FROM work_annotation WHERE work_annotation.work IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'annotation ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_annotation_update_22() IS 'The path for this function is works.work';

CREATE OR REPLACE FUNCTION search_area_delete_0() RETURNS trigger
    AS $$
DECLARE
    gids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO gids FROM (SELECT area.gid AS id FROM area WHERE area.id = OLD.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'delete', 'area ' || gids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_area_delete_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_area_insert_0() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT area.id FROM area WHERE area.id = NEW.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'area ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_area_insert_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_area_update_0() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT area.id FROM area WHERE area.id = NEW.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'area ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_area_update_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_area_delete_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT area.id FROM area WHERE area.id IN (OLD.area)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'area ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_area_delete_1() IS 'The path for this function is aliases';

CREATE OR REPLACE FUNCTION search_area_insert_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT area.id FROM area WHERE area.id IN (NEW.area)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'area ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_area_insert_1() IS 'The path for this function is aliases';

CREATE OR REPLACE FUNCTION search_area_update_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT area.id FROM area WHERE area.id IN (NEW.area)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'area ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_area_update_1() IS 'The path for this function is aliases';

CREATE OR REPLACE FUNCTION search_area_delete_2() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT area.id FROM area WHERE area.id IN (OLD.area)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'area ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_area_delete_2() IS 'The path for this function is iso_3166_1_codes';

CREATE OR REPLACE FUNCTION search_area_insert_2() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT area.id FROM area WHERE area.id IN (NEW.area)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'area ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_area_insert_2() IS 'The path for this function is iso_3166_1_codes';

CREATE OR REPLACE FUNCTION search_area_update_2() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT area.id FROM area WHERE area.id IN (NEW.area)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'area ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_area_update_2() IS 'The path for this function is iso_3166_1_codes';

CREATE OR REPLACE FUNCTION search_area_delete_3() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT area.id FROM area WHERE area.id IN (OLD.area)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'area ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_area_delete_3() IS 'The path for this function is iso_3166_2_codes';

CREATE OR REPLACE FUNCTION search_area_insert_3() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT area.id FROM area WHERE area.id IN (NEW.area)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'area ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_area_insert_3() IS 'The path for this function is iso_3166_2_codes';

CREATE OR REPLACE FUNCTION search_area_update_3() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT area.id FROM area WHERE area.id IN (NEW.area)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'area ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_area_update_3() IS 'The path for this function is iso_3166_2_codes';

CREATE OR REPLACE FUNCTION search_area_delete_4() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT area.id FROM area WHERE area.id IN (OLD.area)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'area ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_area_delete_4() IS 'The path for this function is iso_3166_3_codes';

CREATE OR REPLACE FUNCTION search_area_insert_4() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT area.id FROM area WHERE area.id IN (NEW.area)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'area ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_area_insert_4() IS 'The path for this function is iso_3166_3_codes';

CREATE OR REPLACE FUNCTION search_area_update_4() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT area.id FROM area WHERE area.id IN (NEW.area)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'area ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_area_update_4() IS 'The path for this function is iso_3166_3_codes';

CREATE OR REPLACE FUNCTION search_area_delete_5() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT area.id FROM area WHERE area.type IN (OLD.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'area ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_area_delete_5() IS 'The path for this function is type';

CREATE OR REPLACE FUNCTION search_area_insert_5() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT area.id FROM area WHERE area.type IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'area ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_area_insert_5() IS 'The path for this function is type';

CREATE OR REPLACE FUNCTION search_area_update_5() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT area.id FROM area WHERE area.type IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'area ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_area_update_5() IS 'The path for this function is type';

CREATE OR REPLACE FUNCTION search_artist_delete_0() RETURNS trigger
    AS $$
DECLARE
    gids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO gids FROM (SELECT artist.gid AS id FROM artist WHERE artist.id = OLD.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'delete', 'artist ' || gids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_delete_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_artist_insert_0() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.id = NEW.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_insert_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_artist_update_0() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.id = NEW.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_update_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_artist_delete_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.id IN (OLD.artist)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_delete_1() IS 'The path for this function is aliases';

CREATE OR REPLACE FUNCTION search_artist_insert_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.id IN (NEW.artist)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_insert_1() IS 'The path for this function is aliases';

CREATE OR REPLACE FUNCTION search_artist_update_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.id IN (NEW.artist)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_update_1() IS 'The path for this function is aliases';

CREATE OR REPLACE FUNCTION search_artist_delete_2() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.area IN (OLD.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_delete_2() IS 'The path for this function is area';

CREATE OR REPLACE FUNCTION search_artist_insert_2() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.area IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_insert_2() IS 'The path for this function is area';

CREATE OR REPLACE FUNCTION search_artist_update_2() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.area IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_update_2() IS 'The path for this function is area';

CREATE OR REPLACE FUNCTION search_artist_delete_3() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.area IN (SELECT area.id FROM area WHERE area.id IN (OLD.area))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_delete_3() IS 'The path for this function is area.aliases';

CREATE OR REPLACE FUNCTION search_artist_insert_3() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.area IN (SELECT area.id FROM area WHERE area.id IN (NEW.area))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_insert_3() IS 'The path for this function is area.aliases';

CREATE OR REPLACE FUNCTION search_artist_update_3() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.area IN (SELECT area.id FROM area WHERE area.id IN (NEW.area))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_update_3() IS 'The path for this function is area.aliases';

CREATE OR REPLACE FUNCTION search_artist_delete_4() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.begin_area IN (OLD.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_delete_4() IS 'The path for this function is begin_area';

CREATE OR REPLACE FUNCTION search_artist_insert_4() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.begin_area IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_insert_4() IS 'The path for this function is begin_area';

CREATE OR REPLACE FUNCTION search_artist_update_4() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.begin_area IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_update_4() IS 'The path for this function is begin_area';

CREATE OR REPLACE FUNCTION search_artist_delete_5() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.begin_area IN (SELECT area.id FROM area WHERE area.id IN (OLD.area))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_delete_5() IS 'The path for this function is begin_area.aliases';

CREATE OR REPLACE FUNCTION search_artist_insert_5() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.begin_area IN (SELECT area.id FROM area WHERE area.id IN (NEW.area))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_insert_5() IS 'The path for this function is begin_area.aliases';

CREATE OR REPLACE FUNCTION search_artist_update_5() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.begin_area IN (SELECT area.id FROM area WHERE area.id IN (NEW.area))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_update_5() IS 'The path for this function is begin_area.aliases';

CREATE OR REPLACE FUNCTION search_artist_delete_6() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.area IN (SELECT area.id FROM area WHERE area.id IN (OLD.area))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_delete_6() IS 'The path for this function is area.iso_3166_1_codes';

CREATE OR REPLACE FUNCTION search_artist_insert_6() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.area IN (SELECT area.id FROM area WHERE area.id IN (NEW.area))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_insert_6() IS 'The path for this function is area.iso_3166_1_codes';

CREATE OR REPLACE FUNCTION search_artist_update_6() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.area IN (SELECT area.id FROM area WHERE area.id IN (NEW.area))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_update_6() IS 'The path for this function is area.iso_3166_1_codes';

CREATE OR REPLACE FUNCTION search_artist_delete_7() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.end_area IN (OLD.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_delete_7() IS 'The path for this function is end_area';

CREATE OR REPLACE FUNCTION search_artist_insert_7() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.end_area IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_insert_7() IS 'The path for this function is end_area';

CREATE OR REPLACE FUNCTION search_artist_update_7() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.end_area IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_update_7() IS 'The path for this function is end_area';

CREATE OR REPLACE FUNCTION search_artist_delete_8() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.end_area IN (SELECT area.id FROM area WHERE area.id IN (OLD.area))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_delete_8() IS 'The path for this function is end_area.aliases';

CREATE OR REPLACE FUNCTION search_artist_insert_8() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.end_area IN (SELECT area.id FROM area WHERE area.id IN (NEW.area))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_insert_8() IS 'The path for this function is end_area.aliases';

CREATE OR REPLACE FUNCTION search_artist_update_8() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.end_area IN (SELECT area.id FROM area WHERE area.id IN (NEW.area))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_update_8() IS 'The path for this function is end_area.aliases';

CREATE OR REPLACE FUNCTION search_artist_delete_9() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.gender IN (OLD.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_delete_9() IS 'The path for this function is gender';

CREATE OR REPLACE FUNCTION search_artist_insert_9() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.gender IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_insert_9() IS 'The path for this function is gender';

CREATE OR REPLACE FUNCTION search_artist_update_9() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.gender IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_update_9() IS 'The path for this function is gender';

CREATE OR REPLACE FUNCTION search_artist_delete_10() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.id IN (OLD.artist)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_delete_10() IS 'The path for this function is ipis';

CREATE OR REPLACE FUNCTION search_artist_insert_10() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.id IN (NEW.artist)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_insert_10() IS 'The path for this function is ipis';

CREATE OR REPLACE FUNCTION search_artist_update_10() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.id IN (NEW.artist)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_update_10() IS 'The path for this function is ipis';

CREATE OR REPLACE FUNCTION search_artist_delete_11() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.id IN (OLD.artist)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_delete_11() IS 'The path for this function is isnis';

CREATE OR REPLACE FUNCTION search_artist_insert_11() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.id IN (NEW.artist)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_insert_11() IS 'The path for this function is isnis';

CREATE OR REPLACE FUNCTION search_artist_update_11() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.id IN (NEW.artist)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_update_11() IS 'The path for this function is isnis';

CREATE OR REPLACE FUNCTION search_artist_delete_12() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.id IN (OLD.artist)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_delete_12() IS 'The path for this function is tags';

CREATE OR REPLACE FUNCTION search_artist_insert_12() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.id IN (NEW.artist)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_insert_12() IS 'The path for this function is tags';

CREATE OR REPLACE FUNCTION search_artist_update_12() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.id IN (NEW.artist)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_update_12() IS 'The path for this function is tags';

CREATE OR REPLACE FUNCTION search_artist_delete_13() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.id IN (SELECT artist_tag.artist FROM artist_tag WHERE artist_tag.tag IN (OLD.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_delete_13() IS 'The path for this function is tags.tag';

CREATE OR REPLACE FUNCTION search_artist_insert_13() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.id IN (SELECT artist_tag.artist FROM artist_tag WHERE artist_tag.tag IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_insert_13() IS 'The path for this function is tags.tag';

CREATE OR REPLACE FUNCTION search_artist_update_13() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.id IN (SELECT artist_tag.artist FROM artist_tag WHERE artist_tag.tag IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_update_13() IS 'The path for this function is tags.tag';

CREATE OR REPLACE FUNCTION search_artist_delete_14() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.id IN (OLD.artist)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_delete_14() IS 'The path for this function is artist_credit_names';

CREATE OR REPLACE FUNCTION search_artist_insert_14() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.id IN (NEW.artist)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_insert_14() IS 'The path for this function is artist_credit_names';

CREATE OR REPLACE FUNCTION search_artist_update_14() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.id IN (NEW.artist)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_update_14() IS 'The path for this function is artist_credit_names';

CREATE OR REPLACE FUNCTION search_artist_delete_15() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.id IN (SELECT artist_credit_name.artist_credit FROM artist_credit_name WHERE artist_credit_name.artist_credit IN (OLD.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_delete_15() IS 'The path for this function is artist_credit_names.artist_credit';

CREATE OR REPLACE FUNCTION search_artist_insert_15() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.id IN (SELECT artist_credit_name.artist_credit FROM artist_credit_name WHERE artist_credit_name.artist_credit IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_insert_15() IS 'The path for this function is artist_credit_names.artist_credit';

CREATE OR REPLACE FUNCTION search_artist_update_15() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.id IN (SELECT artist_credit_name.artist_credit FROM artist_credit_name WHERE artist_credit_name.artist_credit IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_update_15() IS 'The path for this function is artist_credit_names.artist_credit';

CREATE OR REPLACE FUNCTION search_artist_delete_16() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.type IN (OLD.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_delete_16() IS 'The path for this function is type';

CREATE OR REPLACE FUNCTION search_artist_insert_16() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.type IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_insert_16() IS 'The path for this function is type';

CREATE OR REPLACE FUNCTION search_artist_update_16() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.type IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_artist_update_16() IS 'The path for this function is type';

CREATE OR REPLACE FUNCTION search_cdstub_delete_0() RETURNS trigger
    AS $$
DECLARE
    gids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO gids FROM (SELECT release_raw.gid AS id FROM release_raw WHERE release_raw.id = OLD.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'delete', 'release_raw ' || gids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_cdstub_delete_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_cdstub_insert_0() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_raw.id FROM release_raw WHERE release_raw.id = NEW.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'release_raw ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_cdstub_insert_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_cdstub_update_0() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_raw.id FROM release_raw WHERE release_raw.id = NEW.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release_raw ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_cdstub_update_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_cdstub_delete_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_raw.id FROM release_raw WHERE release_raw.id IN (OLD.release)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release_raw ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_cdstub_delete_1() IS 'The path for this function is discids';

CREATE OR REPLACE FUNCTION search_cdstub_insert_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_raw.id FROM release_raw WHERE release_raw.id IN (NEW.release)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'release_raw ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_cdstub_insert_1() IS 'The path for this function is discids';

CREATE OR REPLACE FUNCTION search_cdstub_update_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_raw.id FROM release_raw WHERE release_raw.id IN (NEW.release)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release_raw ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_cdstub_update_1() IS 'The path for this function is discids';

CREATE OR REPLACE FUNCTION search_editor_delete_0() RETURNS trigger
    AS $$
DECLARE
    gids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO gids FROM (SELECT editor.gid AS id FROM editor WHERE editor.id = OLD.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'delete', 'editor ' || gids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_editor_delete_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_editor_insert_0() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT editor.id FROM editor WHERE editor.id = NEW.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'editor ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_editor_insert_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_editor_update_0() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT editor.id FROM editor WHERE editor.id = NEW.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'editor ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_editor_update_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_event_delete_0() RETURNS trigger
    AS $$
DECLARE
    gids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO gids FROM (SELECT event.gid AS id FROM event WHERE event.id = OLD.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'delete', 'event ' || gids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_event_delete_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_event_insert_0() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT event.id FROM event WHERE event.id = NEW.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'event ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_event_insert_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_event_update_0() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT event.id FROM event WHERE event.id = NEW.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'event ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_event_update_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_event_delete_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT event.id FROM event WHERE event.id IN (OLD.event)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'event ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_event_delete_1() IS 'The path for this function is aliases';

CREATE OR REPLACE FUNCTION search_event_insert_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT event.id FROM event WHERE event.id IN (NEW.event)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'event ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_event_insert_1() IS 'The path for this function is aliases';

CREATE OR REPLACE FUNCTION search_event_update_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT event.id FROM event WHERE event.id IN (NEW.event)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'event ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_event_update_1() IS 'The path for this function is aliases';

CREATE OR REPLACE FUNCTION search_event_delete_2() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT event.id FROM event WHERE event.id IN (OLD.entity1)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'event ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_event_delete_2() IS 'The path for this function is area_links';

CREATE OR REPLACE FUNCTION search_event_insert_2() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT event.id FROM event WHERE event.id IN (NEW.entity1)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'event ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_event_insert_2() IS 'The path for this function is area_links';

CREATE OR REPLACE FUNCTION search_event_update_2() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT event.id FROM event WHERE event.id IN (NEW.entity1)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'event ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_event_update_2() IS 'The path for this function is area_links';

CREATE OR REPLACE FUNCTION search_event_delete_3() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT event.id FROM event WHERE event.id IN (SELECT l_area_event.id FROM l_area_event WHERE l_area_event.entity0 IN (OLD.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'event ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_event_delete_3() IS 'The path for this function is area_links.entity0';

CREATE OR REPLACE FUNCTION search_event_insert_3() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT event.id FROM event WHERE event.id IN (SELECT l_area_event.id FROM l_area_event WHERE l_area_event.entity0 IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'event ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_event_insert_3() IS 'The path for this function is area_links.entity0';

CREATE OR REPLACE FUNCTION search_event_update_3() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT event.id FROM event WHERE event.id IN (SELECT l_area_event.id FROM l_area_event WHERE l_area_event.entity0 IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'event ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_event_update_3() IS 'The path for this function is area_links.entity0';

CREATE OR REPLACE FUNCTION search_event_delete_4() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT event.id FROM event WHERE event.id IN (OLD.entity1)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'event ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_event_delete_4() IS 'The path for this function is artist_links';

CREATE OR REPLACE FUNCTION search_event_insert_4() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT event.id FROM event WHERE event.id IN (NEW.entity1)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'event ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_event_insert_4() IS 'The path for this function is artist_links';

CREATE OR REPLACE FUNCTION search_event_update_4() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT event.id FROM event WHERE event.id IN (NEW.entity1)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'event ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_event_update_4() IS 'The path for this function is artist_links';

CREATE OR REPLACE FUNCTION search_event_delete_5() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT event.id FROM event WHERE event.id IN (SELECT l_artist_event.id FROM l_artist_event WHERE l_artist_event.entity0 IN (OLD.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'event ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_event_delete_5() IS 'The path for this function is artist_links.entity0';

CREATE OR REPLACE FUNCTION search_event_insert_5() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT event.id FROM event WHERE event.id IN (SELECT l_artist_event.id FROM l_artist_event WHERE l_artist_event.entity0 IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'event ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_event_insert_5() IS 'The path for this function is artist_links.entity0';

CREATE OR REPLACE FUNCTION search_event_update_5() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT event.id FROM event WHERE event.id IN (SELECT l_artist_event.id FROM l_artist_event WHERE l_artist_event.entity0 IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'event ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_event_update_5() IS 'The path for this function is artist_links.entity0';

CREATE OR REPLACE FUNCTION search_event_delete_6() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT event.id FROM event WHERE event.id IN (OLD.entity0)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'event ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_event_delete_6() IS 'The path for this function is place_links';

CREATE OR REPLACE FUNCTION search_event_insert_6() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT event.id FROM event WHERE event.id IN (NEW.entity0)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'event ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_event_insert_6() IS 'The path for this function is place_links';

CREATE OR REPLACE FUNCTION search_event_update_6() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT event.id FROM event WHERE event.id IN (NEW.entity0)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'event ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_event_update_6() IS 'The path for this function is place_links';

CREATE OR REPLACE FUNCTION search_event_delete_7() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT event.id FROM event WHERE event.id IN (SELECT l_event_place.id FROM l_event_place WHERE l_event_place.entity1 IN (OLD.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'event ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_event_delete_7() IS 'The path for this function is place_links.entity1';

CREATE OR REPLACE FUNCTION search_event_insert_7() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT event.id FROM event WHERE event.id IN (SELECT l_event_place.id FROM l_event_place WHERE l_event_place.entity1 IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'event ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_event_insert_7() IS 'The path for this function is place_links.entity1';

CREATE OR REPLACE FUNCTION search_event_update_7() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT event.id FROM event WHERE event.id IN (SELECT l_event_place.id FROM l_event_place WHERE l_event_place.entity1 IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'event ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_event_update_7() IS 'The path for this function is place_links.entity1';

CREATE OR REPLACE FUNCTION search_event_delete_8() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT event.id FROM event WHERE event.id IN (OLD.event)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'event ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_event_delete_8() IS 'The path for this function is tags';

CREATE OR REPLACE FUNCTION search_event_insert_8() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT event.id FROM event WHERE event.id IN (NEW.event)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'event ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_event_insert_8() IS 'The path for this function is tags';

CREATE OR REPLACE FUNCTION search_event_update_8() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT event.id FROM event WHERE event.id IN (NEW.event)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'event ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_event_update_8() IS 'The path for this function is tags';

CREATE OR REPLACE FUNCTION search_event_delete_9() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT event.id FROM event WHERE event.id IN (SELECT event_tag.event FROM event_tag WHERE event_tag.tag IN (OLD.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'event ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_event_delete_9() IS 'The path for this function is tags.tag';

CREATE OR REPLACE FUNCTION search_event_insert_9() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT event.id FROM event WHERE event.id IN (SELECT event_tag.event FROM event_tag WHERE event_tag.tag IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'event ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_event_insert_9() IS 'The path for this function is tags.tag';

CREATE OR REPLACE FUNCTION search_event_update_9() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT event.id FROM event WHERE event.id IN (SELECT event_tag.event FROM event_tag WHERE event_tag.tag IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'event ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_event_update_9() IS 'The path for this function is tags.tag';

CREATE OR REPLACE FUNCTION search_event_delete_10() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT event.id FROM event WHERE event.type IN (OLD.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'event ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_event_delete_10() IS 'The path for this function is type';

CREATE OR REPLACE FUNCTION search_event_insert_10() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT event.id FROM event WHERE event.type IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'event ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_event_insert_10() IS 'The path for this function is type';

CREATE OR REPLACE FUNCTION search_event_update_10() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT event.id FROM event WHERE event.type IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'event ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_event_update_10() IS 'The path for this function is type';

CREATE OR REPLACE FUNCTION search_instrument_delete_0() RETURNS trigger
    AS $$
DECLARE
    gids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO gids FROM (SELECT instrument.gid AS id FROM instrument WHERE instrument.id = OLD.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'delete', 'instrument ' || gids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_instrument_delete_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_instrument_insert_0() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT instrument.id FROM instrument WHERE instrument.id = NEW.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'instrument ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_instrument_insert_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_instrument_update_0() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT instrument.id FROM instrument WHERE instrument.id = NEW.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'instrument ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_instrument_update_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_instrument_delete_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT instrument.id FROM instrument WHERE instrument.id IN (OLD.instrument)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'instrument ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_instrument_delete_1() IS 'The path for this function is aliases';

CREATE OR REPLACE FUNCTION search_instrument_insert_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT instrument.id FROM instrument WHERE instrument.id IN (NEW.instrument)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'instrument ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_instrument_insert_1() IS 'The path for this function is aliases';

CREATE OR REPLACE FUNCTION search_instrument_update_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT instrument.id FROM instrument WHERE instrument.id IN (NEW.instrument)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'instrument ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_instrument_update_1() IS 'The path for this function is aliases';

CREATE OR REPLACE FUNCTION search_instrument_delete_2() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT instrument.id FROM instrument WHERE instrument.id IN (OLD.instrument)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'instrument ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_instrument_delete_2() IS 'The path for this function is tags';

CREATE OR REPLACE FUNCTION search_instrument_insert_2() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT instrument.id FROM instrument WHERE instrument.id IN (NEW.instrument)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'instrument ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_instrument_insert_2() IS 'The path for this function is tags';

CREATE OR REPLACE FUNCTION search_instrument_update_2() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT instrument.id FROM instrument WHERE instrument.id IN (NEW.instrument)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'instrument ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_instrument_update_2() IS 'The path for this function is tags';

CREATE OR REPLACE FUNCTION search_instrument_delete_3() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT instrument.id FROM instrument WHERE instrument.id IN (SELECT instrument_tag.instrument FROM instrument_tag WHERE instrument_tag.tag IN (OLD.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'instrument ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_instrument_delete_3() IS 'The path for this function is tags.tag';

CREATE OR REPLACE FUNCTION search_instrument_insert_3() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT instrument.id FROM instrument WHERE instrument.id IN (SELECT instrument_tag.instrument FROM instrument_tag WHERE instrument_tag.tag IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'instrument ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_instrument_insert_3() IS 'The path for this function is tags.tag';

CREATE OR REPLACE FUNCTION search_instrument_update_3() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT instrument.id FROM instrument WHERE instrument.id IN (SELECT instrument_tag.instrument FROM instrument_tag WHERE instrument_tag.tag IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'instrument ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_instrument_update_3() IS 'The path for this function is tags.tag';

CREATE OR REPLACE FUNCTION search_instrument_delete_4() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT instrument.id FROM instrument WHERE instrument.type IN (OLD.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'instrument ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_instrument_delete_4() IS 'The path for this function is type';

CREATE OR REPLACE FUNCTION search_instrument_insert_4() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT instrument.id FROM instrument WHERE instrument.type IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'instrument ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_instrument_insert_4() IS 'The path for this function is type';

CREATE OR REPLACE FUNCTION search_instrument_update_4() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT instrument.id FROM instrument WHERE instrument.type IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'instrument ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_instrument_update_4() IS 'The path for this function is type';

CREATE OR REPLACE FUNCTION search_label_delete_0() RETURNS trigger
    AS $$
DECLARE
    gids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO gids FROM (SELECT label.gid AS id FROM label WHERE label.id = OLD.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'delete', 'label ' || gids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_label_delete_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_label_insert_0() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.id = NEW.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_label_insert_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_label_update_0() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.id = NEW.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_label_update_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_label_delete_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.id IN (OLD.label)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_label_delete_1() IS 'The path for this function is aliases';

CREATE OR REPLACE FUNCTION search_label_insert_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.id IN (NEW.label)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_label_insert_1() IS 'The path for this function is aliases';

CREATE OR REPLACE FUNCTION search_label_update_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.id IN (NEW.label)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_label_update_1() IS 'The path for this function is aliases';

CREATE OR REPLACE FUNCTION search_label_delete_2() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.area IN (OLD.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_label_delete_2() IS 'The path for this function is area';

CREATE OR REPLACE FUNCTION search_label_insert_2() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.area IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_label_insert_2() IS 'The path for this function is area';

CREATE OR REPLACE FUNCTION search_label_update_2() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.area IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_label_update_2() IS 'The path for this function is area';

CREATE OR REPLACE FUNCTION search_label_delete_3() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.area IN (SELECT area.id FROM area WHERE area.id IN (OLD.area))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_label_delete_3() IS 'The path for this function is area.aliases';

CREATE OR REPLACE FUNCTION search_label_insert_3() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.area IN (SELECT area.id FROM area WHERE area.id IN (NEW.area))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_label_insert_3() IS 'The path for this function is area.aliases';

CREATE OR REPLACE FUNCTION search_label_update_3() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.area IN (SELECT area.id FROM area WHERE area.id IN (NEW.area))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_label_update_3() IS 'The path for this function is area.aliases';

CREATE OR REPLACE FUNCTION search_label_delete_4() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.area IN (SELECT area.id FROM area WHERE area.id IN (OLD.area))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_label_delete_4() IS 'The path for this function is area.iso_3166_1_codes';

CREATE OR REPLACE FUNCTION search_label_insert_4() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.area IN (SELECT area.id FROM area WHERE area.id IN (NEW.area))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_label_insert_4() IS 'The path for this function is area.iso_3166_1_codes';

CREATE OR REPLACE FUNCTION search_label_update_4() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.area IN (SELECT area.id FROM area WHERE area.id IN (NEW.area))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_label_update_4() IS 'The path for this function is area.iso_3166_1_codes';

CREATE OR REPLACE FUNCTION search_label_delete_5() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.id IN (OLD.label)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_label_delete_5() IS 'The path for this function is ipis';

CREATE OR REPLACE FUNCTION search_label_insert_5() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.id IN (NEW.label)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_label_insert_5() IS 'The path for this function is ipis';

CREATE OR REPLACE FUNCTION search_label_update_5() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.id IN (NEW.label)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_label_update_5() IS 'The path for this function is ipis';

CREATE OR REPLACE FUNCTION search_label_delete_6() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.id IN (OLD.label)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_label_delete_6() IS 'The path for this function is tags';

CREATE OR REPLACE FUNCTION search_label_insert_6() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.id IN (NEW.label)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_label_insert_6() IS 'The path for this function is tags';

CREATE OR REPLACE FUNCTION search_label_update_6() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.id IN (NEW.label)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_label_update_6() IS 'The path for this function is tags';

CREATE OR REPLACE FUNCTION search_label_delete_7() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.id IN (SELECT label_tag.label FROM label_tag WHERE label_tag.tag IN (OLD.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_label_delete_7() IS 'The path for this function is tags.tag';

CREATE OR REPLACE FUNCTION search_label_insert_7() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.id IN (SELECT label_tag.label FROM label_tag WHERE label_tag.tag IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_label_insert_7() IS 'The path for this function is tags.tag';

CREATE OR REPLACE FUNCTION search_label_update_7() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.id IN (SELECT label_tag.label FROM label_tag WHERE label_tag.tag IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_label_update_7() IS 'The path for this function is tags.tag';

CREATE OR REPLACE FUNCTION search_label_delete_8() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.type IN (OLD.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_label_delete_8() IS 'The path for this function is type';

CREATE OR REPLACE FUNCTION search_label_insert_8() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.type IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_label_insert_8() IS 'The path for this function is type';

CREATE OR REPLACE FUNCTION search_label_update_8() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.type IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_label_update_8() IS 'The path for this function is type';

CREATE OR REPLACE FUNCTION search_place_delete_0() RETURNS trigger
    AS $$
DECLARE
    gids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO gids FROM (SELECT place.gid AS id FROM place WHERE place.id = OLD.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'delete', 'place ' || gids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_place_delete_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_place_insert_0() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT place.id FROM place WHERE place.id = NEW.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'place ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_place_insert_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_place_update_0() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT place.id FROM place WHERE place.id = NEW.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'place ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_place_update_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_place_delete_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT place.id FROM place WHERE place.id IN (OLD.place)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'place ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_place_delete_1() IS 'The path for this function is aliases';

CREATE OR REPLACE FUNCTION search_place_insert_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT place.id FROM place WHERE place.id IN (NEW.place)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'place ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_place_insert_1() IS 'The path for this function is aliases';

CREATE OR REPLACE FUNCTION search_place_update_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT place.id FROM place WHERE place.id IN (NEW.place)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'place ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_place_update_1() IS 'The path for this function is aliases';

CREATE OR REPLACE FUNCTION search_place_delete_2() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT place.id FROM place WHERE place.area IN (OLD.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'place ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_place_delete_2() IS 'The path for this function is area';

CREATE OR REPLACE FUNCTION search_place_insert_2() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT place.id FROM place WHERE place.area IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'place ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_place_insert_2() IS 'The path for this function is area';

CREATE OR REPLACE FUNCTION search_place_update_2() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT place.id FROM place WHERE place.area IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'place ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_place_update_2() IS 'The path for this function is area';

CREATE OR REPLACE FUNCTION search_place_delete_3() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT place.id FROM place WHERE place.area IN (SELECT area.id FROM area WHERE area.id IN (OLD.area))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'place ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_place_delete_3() IS 'The path for this function is area.aliases';

CREATE OR REPLACE FUNCTION search_place_insert_3() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT place.id FROM place WHERE place.area IN (SELECT area.id FROM area WHERE area.id IN (NEW.area))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'place ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_place_insert_3() IS 'The path for this function is area.aliases';

CREATE OR REPLACE FUNCTION search_place_update_3() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT place.id FROM place WHERE place.area IN (SELECT area.id FROM area WHERE area.id IN (NEW.area))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'place ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_place_update_3() IS 'The path for this function is area.aliases';

CREATE OR REPLACE FUNCTION search_place_delete_4() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT place.id FROM place WHERE place.type IN (OLD.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'place ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_place_delete_4() IS 'The path for this function is type';

CREATE OR REPLACE FUNCTION search_place_insert_4() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT place.id FROM place WHERE place.type IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'place ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_place_insert_4() IS 'The path for this function is type';

CREATE OR REPLACE FUNCTION search_place_update_4() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT place.id FROM place WHERE place.type IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'place ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_place_update_4() IS 'The path for this function is type';

CREATE OR REPLACE FUNCTION search_recording_delete_0() RETURNS trigger
    AS $$
DECLARE
    gids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO gids FROM (SELECT recording.gid AS id FROM recording WHERE recording.id = OLD.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'delete', 'recording ' || gids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_delete_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_recording_insert_0() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id = NEW.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_insert_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_recording_update_0() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id = NEW.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_update_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_recording_delete_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.artist_credit IN (OLD.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_delete_1() IS 'The path for this function is artist_credit';

CREATE OR REPLACE FUNCTION search_recording_insert_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.artist_credit IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_insert_1() IS 'The path for this function is artist_credit';

CREATE OR REPLACE FUNCTION search_recording_update_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.artist_credit IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_update_1() IS 'The path for this function is artist_credit';

CREATE OR REPLACE FUNCTION search_recording_delete_2() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.artist_credit IN (SELECT artist_credit.id FROM artist_credit WHERE artist_credit.id IN (OLD.artist_credit))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_delete_2() IS 'The path for this function is artist_credit.artists';

CREATE OR REPLACE FUNCTION search_recording_insert_2() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.artist_credit IN (SELECT artist_credit.id FROM artist_credit WHERE artist_credit.id IN (NEW.artist_credit))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_insert_2() IS 'The path for this function is artist_credit.artists';

CREATE OR REPLACE FUNCTION search_recording_update_2() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.artist_credit IN (SELECT artist_credit.id FROM artist_credit WHERE artist_credit.id IN (NEW.artist_credit))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_update_2() IS 'The path for this function is artist_credit.artists';

CREATE OR REPLACE FUNCTION search_recording_delete_3() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.artist_credit IN (SELECT artist_credit.id FROM artist_credit WHERE artist_credit.id IN (SELECT artist_credit_name.artist_credit FROM artist_credit_name WHERE artist_credit_name.artist IN (OLD.id)))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_delete_3() IS 'The path for this function is artist_credit.artists.artist';

CREATE OR REPLACE FUNCTION search_recording_insert_3() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.artist_credit IN (SELECT artist_credit.id FROM artist_credit WHERE artist_credit.id IN (SELECT artist_credit_name.artist_credit FROM artist_credit_name WHERE artist_credit_name.artist IN (NEW.id)))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_insert_3() IS 'The path for this function is artist_credit.artists.artist';

CREATE OR REPLACE FUNCTION search_recording_update_3() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.artist_credit IN (SELECT artist_credit.id FROM artist_credit WHERE artist_credit.id IN (SELECT artist_credit_name.artist_credit FROM artist_credit_name WHERE artist_credit_name.artist IN (NEW.id)))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_update_3() IS 'The path for this function is artist_credit.artists.artist';

CREATE OR REPLACE FUNCTION search_recording_delete_4() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (OLD.recording)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_delete_4() IS 'The path for this function is tracks';

CREATE OR REPLACE FUNCTION search_recording_insert_4() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (NEW.recording)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_insert_4() IS 'The path for this function is tracks';

CREATE OR REPLACE FUNCTION search_recording_update_4() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (NEW.recording)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_update_4() IS 'The path for this function is tracks';

CREATE OR REPLACE FUNCTION search_recording_delete_5() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (OLD.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_delete_5() IS 'The path for this function is tracks.medium';

CREATE OR REPLACE FUNCTION search_recording_insert_5() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_insert_5() IS 'The path for this function is tracks.medium';

CREATE OR REPLACE FUNCTION search_recording_update_5() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_update_5() IS 'The path for this function is tracks.medium';

CREATE OR REPLACE FUNCTION search_recording_delete_6() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (OLD.id)))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_delete_6() IS 'The path for this function is tracks.medium.release';

CREATE OR REPLACE FUNCTION search_recording_insert_6() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (NEW.id)))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_insert_6() IS 'The path for this function is tracks.medium.release';

CREATE OR REPLACE FUNCTION search_recording_update_6() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (NEW.id)))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_update_6() IS 'The path for this function is tracks.medium.release';

CREATE OR REPLACE FUNCTION search_recording_delete_7() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.id IN (OLD.release))))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_delete_7() IS 'The path for this function is tracks.medium.release.country_dates';

CREATE OR REPLACE FUNCTION search_recording_insert_7() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.id IN (NEW.release))))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_insert_7() IS 'The path for this function is tracks.medium.release.country_dates';

CREATE OR REPLACE FUNCTION search_recording_update_7() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.id IN (NEW.release))))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_update_7() IS 'The path for this function is tracks.medium.release.country_dates';

CREATE OR REPLACE FUNCTION search_recording_delete_8() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.id IN (SELECT release_country.release FROM release_country WHERE release_country.country IN (OLD.id)))))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_delete_8() IS 'The path for this function is tracks.medium.release.country_dates.country';

CREATE OR REPLACE FUNCTION search_recording_insert_8() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.id IN (SELECT release_country.release FROM release_country WHERE release_country.country IN (NEW.id)))))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_insert_8() IS 'The path for this function is tracks.medium.release.country_dates.country';

CREATE OR REPLACE FUNCTION search_recording_update_8() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.id IN (SELECT release_country.release FROM release_country WHERE release_country.country IN (NEW.id)))))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_update_8() IS 'The path for this function is tracks.medium.release.country_dates.country';

CREATE OR REPLACE FUNCTION search_recording_delete_9() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.id IN (SELECT release_country.release FROM release_country WHERE release_country.country IN (SELECT country_area.area FROM country_area WHERE country_area.area IN (OLD.id))))))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_delete_9() IS 'The path for this function is tracks.medium.release.country_dates.country.area';

CREATE OR REPLACE FUNCTION search_recording_insert_9() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.id IN (SELECT release_country.release FROM release_country WHERE release_country.country IN (SELECT country_area.area FROM country_area WHERE country_area.area IN (NEW.id))))))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_insert_9() IS 'The path for this function is tracks.medium.release.country_dates.country.area';

CREATE OR REPLACE FUNCTION search_recording_update_9() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.id IN (SELECT release_country.release FROM release_country WHERE release_country.country IN (SELECT country_area.area FROM country_area WHERE country_area.area IN (NEW.id))))))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_update_9() IS 'The path for this function is tracks.medium.release.country_dates.country.area';

CREATE OR REPLACE FUNCTION search_recording_delete_10() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.format IN (OLD.id)))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_delete_10() IS 'The path for this function is tracks.medium.format';

CREATE OR REPLACE FUNCTION search_recording_insert_10() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.format IN (NEW.id)))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_insert_10() IS 'The path for this function is tracks.medium.format';

CREATE OR REPLACE FUNCTION search_recording_update_10() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.format IN (NEW.id)))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_update_10() IS 'The path for this function is tracks.medium.format';

CREATE OR REPLACE FUNCTION search_recording_delete_11() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (OLD.recording)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_delete_11() IS 'The path for this function is isrcs';

CREATE OR REPLACE FUNCTION search_recording_insert_11() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (NEW.recording)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_insert_11() IS 'The path for this function is isrcs';

CREATE OR REPLACE FUNCTION search_recording_update_11() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (NEW.recording)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_update_11() IS 'The path for this function is isrcs';

CREATE OR REPLACE FUNCTION search_recording_delete_12() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.release_group IN (OLD.id))))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_delete_12() IS 'The path for this function is tracks.medium.release.release_group';

CREATE OR REPLACE FUNCTION search_recording_insert_12() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.release_group IN (NEW.id))))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_insert_12() IS 'The path for this function is tracks.medium.release.release_group';

CREATE OR REPLACE FUNCTION search_recording_update_12() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.release_group IN (NEW.id))))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_update_12() IS 'The path for this function is tracks.medium.release.release_group';

CREATE OR REPLACE FUNCTION search_recording_delete_13() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.release_group IN (SELECT release_group.id FROM release_group WHERE release_group.type IN (OLD.id)))))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_delete_13() IS 'The path for this function is tracks.medium.release.release_group.type';

CREATE OR REPLACE FUNCTION search_recording_insert_13() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.release_group IN (SELECT release_group.id FROM release_group WHERE release_group.type IN (NEW.id)))))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_insert_13() IS 'The path for this function is tracks.medium.release.release_group.type';

CREATE OR REPLACE FUNCTION search_recording_update_13() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.release_group IN (SELECT release_group.id FROM release_group WHERE release_group.type IN (NEW.id)))))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_update_13() IS 'The path for this function is tracks.medium.release.release_group.type';

CREATE OR REPLACE FUNCTION search_recording_delete_14() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.release_group IN (SELECT release_group.id FROM release_group WHERE release_group.id IN (OLD.release_group)))))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_delete_14() IS 'The path for this function is tracks.medium.release.release_group.secondary_types';

CREATE OR REPLACE FUNCTION search_recording_insert_14() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.release_group IN (SELECT release_group.id FROM release_group WHERE release_group.id IN (NEW.release_group)))))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_insert_14() IS 'The path for this function is tracks.medium.release.release_group.secondary_types';

CREATE OR REPLACE FUNCTION search_recording_update_14() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.release_group IN (SELECT release_group.id FROM release_group WHERE release_group.id IN (NEW.release_group)))))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_update_14() IS 'The path for this function is tracks.medium.release.release_group.secondary_types';

CREATE OR REPLACE FUNCTION search_recording_delete_15() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.release_group IN (SELECT release_group.id FROM release_group WHERE release_group.id IN (SELECT release_group_secondary_type_join.release_group FROM release_group_secondary_type_join WHERE release_group_secondary_type_join.secondary_type IN (OLD.id))))))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_delete_15() IS 'The path for this function is tracks.medium.release.release_group.secondary_types.secondary_type';

CREATE OR REPLACE FUNCTION search_recording_insert_15() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.release_group IN (SELECT release_group.id FROM release_group WHERE release_group.id IN (SELECT release_group_secondary_type_join.release_group FROM release_group_secondary_type_join WHERE release_group_secondary_type_join.secondary_type IN (NEW.id))))))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_insert_15() IS 'The path for this function is tracks.medium.release.release_group.secondary_types.secondary_type';

CREATE OR REPLACE FUNCTION search_recording_update_15() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.release_group IN (SELECT release_group.id FROM release_group WHERE release_group.id IN (SELECT release_group_secondary_type_join.release_group FROM release_group_secondary_type_join WHERE release_group_secondary_type_join.secondary_type IN (NEW.id))))))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_update_15() IS 'The path for this function is tracks.medium.release.release_group.secondary_types.secondary_type';

CREATE OR REPLACE FUNCTION search_recording_delete_16() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.status IN (OLD.id))))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_delete_16() IS 'The path for this function is tracks.medium.release.status';

CREATE OR REPLACE FUNCTION search_recording_insert_16() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.status IN (NEW.id))))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_insert_16() IS 'The path for this function is tracks.medium.release.status';

CREATE OR REPLACE FUNCTION search_recording_update_16() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.status IN (NEW.id))))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_update_16() IS 'The path for this function is tracks.medium.release.status';

CREATE OR REPLACE FUNCTION search_recording_delete_17() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (OLD.recording)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_delete_17() IS 'The path for this function is tags';

CREATE OR REPLACE FUNCTION search_recording_insert_17() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (NEW.recording)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_insert_17() IS 'The path for this function is tags';

CREATE OR REPLACE FUNCTION search_recording_update_17() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (NEW.recording)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_update_17() IS 'The path for this function is tags';

CREATE OR REPLACE FUNCTION search_recording_delete_18() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT recording_tag.recording FROM recording_tag WHERE recording_tag.tag IN (OLD.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_delete_18() IS 'The path for this function is tags.tag';

CREATE OR REPLACE FUNCTION search_recording_insert_18() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT recording_tag.recording FROM recording_tag WHERE recording_tag.tag IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_insert_18() IS 'The path for this function is tags.tag';

CREATE OR REPLACE FUNCTION search_recording_update_18() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT recording_tag.recording FROM recording_tag WHERE recording_tag.tag IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_update_18() IS 'The path for this function is tags.tag';

CREATE OR REPLACE FUNCTION search_recording_delete_19() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.id IN (OLD.release))))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_delete_19() IS 'The path for this function is tracks.medium.release.mediums';

CREATE OR REPLACE FUNCTION search_recording_insert_19() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.id IN (NEW.release))))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_insert_19() IS 'The path for this function is tracks.medium.release.mediums';

CREATE OR REPLACE FUNCTION search_recording_update_19() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.id IN (NEW.release))))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_recording_update_19() IS 'The path for this function is tracks.medium.release.mediums';

CREATE OR REPLACE FUNCTION search_release_delete_0() RETURNS trigger
    AS $$
DECLARE
    gids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO gids FROM (SELECT release.gid AS id FROM release WHERE release.id = OLD.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'delete', 'release ' || gids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_delete_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_release_insert_0() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id = NEW.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_insert_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_release_update_0() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id = NEW.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_update_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_release_delete_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.artist_credit IN (OLD.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_delete_1() IS 'The path for this function is artist_credit';

CREATE OR REPLACE FUNCTION search_release_insert_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.artist_credit IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_insert_1() IS 'The path for this function is artist_credit';

CREATE OR REPLACE FUNCTION search_release_update_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.artist_credit IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_update_1() IS 'The path for this function is artist_credit';

CREATE OR REPLACE FUNCTION search_release_delete_2() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.artist_credit IN (SELECT artist_credit.id FROM artist_credit WHERE artist_credit.id IN (OLD.artist_credit))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_delete_2() IS 'The path for this function is artist_credit.artists';

CREATE OR REPLACE FUNCTION search_release_insert_2() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.artist_credit IN (SELECT artist_credit.id FROM artist_credit WHERE artist_credit.id IN (NEW.artist_credit))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_insert_2() IS 'The path for this function is artist_credit.artists';

CREATE OR REPLACE FUNCTION search_release_update_2() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.artist_credit IN (SELECT artist_credit.id FROM artist_credit WHERE artist_credit.id IN (NEW.artist_credit))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_update_2() IS 'The path for this function is artist_credit.artists';

CREATE OR REPLACE FUNCTION search_release_delete_3() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.artist_credit IN (SELECT artist_credit.id FROM artist_credit WHERE artist_credit.id IN (SELECT artist_credit_name.artist_credit FROM artist_credit_name WHERE artist_credit_name.artist IN (OLD.id)))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_delete_3() IS 'The path for this function is artist_credit.artists.artist';

CREATE OR REPLACE FUNCTION search_release_insert_3() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.artist_credit IN (SELECT artist_credit.id FROM artist_credit WHERE artist_credit.id IN (SELECT artist_credit_name.artist_credit FROM artist_credit_name WHERE artist_credit_name.artist IN (NEW.id)))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_insert_3() IS 'The path for this function is artist_credit.artists.artist';

CREATE OR REPLACE FUNCTION search_release_update_3() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.artist_credit IN (SELECT artist_credit.id FROM artist_credit WHERE artist_credit.id IN (SELECT artist_credit_name.artist_credit FROM artist_credit_name WHERE artist_credit_name.artist IN (NEW.id)))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_update_3() IS 'The path for this function is artist_credit.artists.artist';

CREATE OR REPLACE FUNCTION search_release_delete_4() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (OLD.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_delete_4() IS 'The path for this function is asin';

CREATE OR REPLACE FUNCTION search_release_insert_4() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_insert_4() IS 'The path for this function is asin';

CREATE OR REPLACE FUNCTION search_release_update_4() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_update_4() IS 'The path for this function is asin';

CREATE OR REPLACE FUNCTION search_release_delete_5() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (OLD.release)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_delete_5() IS 'The path for this function is country_dates';

CREATE OR REPLACE FUNCTION search_release_insert_5() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (NEW.release)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_insert_5() IS 'The path for this function is country_dates';

CREATE OR REPLACE FUNCTION search_release_update_5() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (NEW.release)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_update_5() IS 'The path for this function is country_dates';

CREATE OR REPLACE FUNCTION search_release_delete_6() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (SELECT release_country.release FROM release_country WHERE release_country.country IN (OLD.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_delete_6() IS 'The path for this function is country_dates.country';

CREATE OR REPLACE FUNCTION search_release_insert_6() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (SELECT release_country.release FROM release_country WHERE release_country.country IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_insert_6() IS 'The path for this function is country_dates.country';

CREATE OR REPLACE FUNCTION search_release_update_6() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (SELECT release_country.release FROM release_country WHERE release_country.country IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_update_6() IS 'The path for this function is country_dates.country';

CREATE OR REPLACE FUNCTION search_release_delete_7() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (SELECT release_country.release FROM release_country WHERE release_country.country IN (SELECT country_area.area FROM country_area WHERE country_area.area IN (OLD.id)))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_delete_7() IS 'The path for this function is country_dates.country.area';

CREATE OR REPLACE FUNCTION search_release_insert_7() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (SELECT release_country.release FROM release_country WHERE release_country.country IN (SELECT country_area.area FROM country_area WHERE country_area.area IN (NEW.id)))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_insert_7() IS 'The path for this function is country_dates.country.area';

CREATE OR REPLACE FUNCTION search_release_update_7() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (SELECT release_country.release FROM release_country WHERE release_country.country IN (SELECT country_area.area FROM country_area WHERE country_area.area IN (NEW.id)))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_update_7() IS 'The path for this function is country_dates.country.area';

CREATE OR REPLACE FUNCTION search_release_delete_8() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (OLD.release)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_delete_8() IS 'The path for this function is labels';

CREATE OR REPLACE FUNCTION search_release_insert_8() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (NEW.release)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_insert_8() IS 'The path for this function is labels';

CREATE OR REPLACE FUNCTION search_release_update_8() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (NEW.release)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_update_8() IS 'The path for this function is labels';

CREATE OR REPLACE FUNCTION search_release_delete_9() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (OLD.release)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_delete_9() IS 'The path for this function is mediums';

CREATE OR REPLACE FUNCTION search_release_insert_9() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (NEW.release)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_insert_9() IS 'The path for this function is mediums';

CREATE OR REPLACE FUNCTION search_release_update_9() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (NEW.release)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_update_9() IS 'The path for this function is mediums';

CREATE OR REPLACE FUNCTION search_release_delete_10() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (SELECT medium.id FROM medium WHERE medium.id IN (OLD.medium))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_delete_10() IS 'The path for this function is mediums.cdtocs';

CREATE OR REPLACE FUNCTION search_release_insert_10() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (SELECT medium.id FROM medium WHERE medium.id IN (NEW.medium))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_insert_10() IS 'The path for this function is mediums.cdtocs';

CREATE OR REPLACE FUNCTION search_release_update_10() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (SELECT medium.id FROM medium WHERE medium.id IN (NEW.medium))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_update_10() IS 'The path for this function is mediums.cdtocs';

CREATE OR REPLACE FUNCTION search_release_delete_11() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (SELECT medium.id FROM medium WHERE medium.format IN (OLD.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_delete_11() IS 'The path for this function is mediums.format';

CREATE OR REPLACE FUNCTION search_release_insert_11() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (SELECT medium.id FROM medium WHERE medium.format IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_insert_11() IS 'The path for this function is mediums.format';

CREATE OR REPLACE FUNCTION search_release_update_11() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (SELECT medium.id FROM medium WHERE medium.format IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_update_11() IS 'The path for this function is mediums.format';

CREATE OR REPLACE FUNCTION search_release_delete_12() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (SELECT release_label.id FROM release_label WHERE release_label.label IN (OLD.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_delete_12() IS 'The path for this function is labels.label';

CREATE OR REPLACE FUNCTION search_release_insert_12() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (SELECT release_label.id FROM release_label WHERE release_label.label IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_insert_12() IS 'The path for this function is labels.label';

CREATE OR REPLACE FUNCTION search_release_update_12() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (SELECT release_label.id FROM release_label WHERE release_label.label IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_update_12() IS 'The path for this function is labels.label';

CREATE OR REPLACE FUNCTION search_release_delete_13() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.language IN (OLD.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_delete_13() IS 'The path for this function is language';

CREATE OR REPLACE FUNCTION search_release_insert_13() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.language IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_insert_13() IS 'The path for this function is language';

CREATE OR REPLACE FUNCTION search_release_update_13() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.language IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_update_13() IS 'The path for this function is language';

CREATE OR REPLACE FUNCTION search_release_delete_14() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.release_group IN (OLD.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_delete_14() IS 'The path for this function is release_group';

CREATE OR REPLACE FUNCTION search_release_insert_14() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.release_group IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_insert_14() IS 'The path for this function is release_group';

CREATE OR REPLACE FUNCTION search_release_update_14() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.release_group IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_update_14() IS 'The path for this function is release_group';

CREATE OR REPLACE FUNCTION search_release_delete_15() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.release_group IN (SELECT release_group.id FROM release_group WHERE release_group.type IN (OLD.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_delete_15() IS 'The path for this function is release_group.type';

CREATE OR REPLACE FUNCTION search_release_insert_15() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.release_group IN (SELECT release_group.id FROM release_group WHERE release_group.type IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_insert_15() IS 'The path for this function is release_group.type';

CREATE OR REPLACE FUNCTION search_release_update_15() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.release_group IN (SELECT release_group.id FROM release_group WHERE release_group.type IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_update_15() IS 'The path for this function is release_group.type';

CREATE OR REPLACE FUNCTION search_release_delete_16() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.script IN (OLD.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_delete_16() IS 'The path for this function is script';

CREATE OR REPLACE FUNCTION search_release_insert_16() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.script IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_insert_16() IS 'The path for this function is script';

CREATE OR REPLACE FUNCTION search_release_update_16() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.script IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_update_16() IS 'The path for this function is script';

CREATE OR REPLACE FUNCTION search_release_delete_17() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.release_group IN (SELECT release_group.id FROM release_group WHERE release_group.id IN (OLD.release_group))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_delete_17() IS 'The path for this function is release_group.secondary_types';

CREATE OR REPLACE FUNCTION search_release_insert_17() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.release_group IN (SELECT release_group.id FROM release_group WHERE release_group.id IN (NEW.release_group))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_insert_17() IS 'The path for this function is release_group.secondary_types';

CREATE OR REPLACE FUNCTION search_release_update_17() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.release_group IN (SELECT release_group.id FROM release_group WHERE release_group.id IN (NEW.release_group))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_update_17() IS 'The path for this function is release_group.secondary_types';

CREATE OR REPLACE FUNCTION search_release_delete_18() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.release_group IN (SELECT release_group.id FROM release_group WHERE release_group.id IN (SELECT release_group_secondary_type_join.release_group FROM release_group_secondary_type_join WHERE release_group_secondary_type_join.secondary_type IN (OLD.id)))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_delete_18() IS 'The path for this function is release_group.secondary_types.secondary_type';

CREATE OR REPLACE FUNCTION search_release_insert_18() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.release_group IN (SELECT release_group.id FROM release_group WHERE release_group.id IN (SELECT release_group_secondary_type_join.release_group FROM release_group_secondary_type_join WHERE release_group_secondary_type_join.secondary_type IN (NEW.id)))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_insert_18() IS 'The path for this function is release_group.secondary_types.secondary_type';

CREATE OR REPLACE FUNCTION search_release_update_18() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.release_group IN (SELECT release_group.id FROM release_group WHERE release_group.id IN (SELECT release_group_secondary_type_join.release_group FROM release_group_secondary_type_join WHERE release_group_secondary_type_join.secondary_type IN (NEW.id)))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_update_18() IS 'The path for this function is release_group.secondary_types.secondary_type';

CREATE OR REPLACE FUNCTION search_release_delete_19() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.status IN (OLD.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_delete_19() IS 'The path for this function is status';

CREATE OR REPLACE FUNCTION search_release_insert_19() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.status IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_insert_19() IS 'The path for this function is status';

CREATE OR REPLACE FUNCTION search_release_update_19() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.status IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_update_19() IS 'The path for this function is status';

CREATE OR REPLACE FUNCTION search_release_delete_20() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (OLD.release)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_delete_20() IS 'The path for this function is tags';

CREATE OR REPLACE FUNCTION search_release_insert_20() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (NEW.release)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_insert_20() IS 'The path for this function is tags';

CREATE OR REPLACE FUNCTION search_release_update_20() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (NEW.release)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_update_20() IS 'The path for this function is tags';

CREATE OR REPLACE FUNCTION search_release_delete_21() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (SELECT release_tag.release FROM release_tag WHERE release_tag.tag IN (OLD.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_delete_21() IS 'The path for this function is tags.tag';

CREATE OR REPLACE FUNCTION search_release_insert_21() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (SELECT release_tag.release FROM release_tag WHERE release_tag.tag IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_insert_21() IS 'The path for this function is tags.tag';

CREATE OR REPLACE FUNCTION search_release_update_21() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (SELECT release_tag.release FROM release_tag WHERE release_tag.tag IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_update_21() IS 'The path for this function is tags.tag';

CREATE OR REPLACE FUNCTION search_release_group_delete_0() RETURNS trigger
    AS $$
DECLARE
    gids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO gids FROM (SELECT release_group.gid AS id FROM release_group WHERE release_group.id = OLD.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'delete', 'release_group ' || gids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_group_delete_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_release_group_insert_0() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.id = NEW.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_group_insert_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_release_group_update_0() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.id = NEW.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_group_update_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_release_group_delete_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.artist_credit IN (OLD.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_group_delete_1() IS 'The path for this function is artist_credit';

CREATE OR REPLACE FUNCTION search_release_group_insert_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.artist_credit IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_group_insert_1() IS 'The path for this function is artist_credit';

CREATE OR REPLACE FUNCTION search_release_group_update_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.artist_credit IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_group_update_1() IS 'The path for this function is artist_credit';

CREATE OR REPLACE FUNCTION search_release_group_delete_2() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.artist_credit IN (SELECT artist_credit.id FROM artist_credit WHERE artist_credit.id IN (OLD.artist_credit))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_group_delete_2() IS 'The path for this function is artist_credit.artists';

CREATE OR REPLACE FUNCTION search_release_group_insert_2() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.artist_credit IN (SELECT artist_credit.id FROM artist_credit WHERE artist_credit.id IN (NEW.artist_credit))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_group_insert_2() IS 'The path for this function is artist_credit.artists';

CREATE OR REPLACE FUNCTION search_release_group_update_2() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.artist_credit IN (SELECT artist_credit.id FROM artist_credit WHERE artist_credit.id IN (NEW.artist_credit))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_group_update_2() IS 'The path for this function is artist_credit.artists';

CREATE OR REPLACE FUNCTION search_release_group_delete_3() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.artist_credit IN (SELECT artist_credit.id FROM artist_credit WHERE artist_credit.id IN (SELECT artist_credit_name.artist_credit FROM artist_credit_name WHERE artist_credit_name.artist IN (OLD.id)))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_group_delete_3() IS 'The path for this function is artist_credit.artists.artist';

CREATE OR REPLACE FUNCTION search_release_group_insert_3() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.artist_credit IN (SELECT artist_credit.id FROM artist_credit WHERE artist_credit.id IN (SELECT artist_credit_name.artist_credit FROM artist_credit_name WHERE artist_credit_name.artist IN (NEW.id)))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_group_insert_3() IS 'The path for this function is artist_credit.artists.artist';

CREATE OR REPLACE FUNCTION search_release_group_update_3() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.artist_credit IN (SELECT artist_credit.id FROM artist_credit WHERE artist_credit.id IN (SELECT artist_credit_name.artist_credit FROM artist_credit_name WHERE artist_credit_name.artist IN (NEW.id)))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_group_update_3() IS 'The path for this function is artist_credit.artists.artist';

CREATE OR REPLACE FUNCTION search_release_group_delete_4() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.id IN (OLD.release_group)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_group_delete_4() IS 'The path for this function is releases';

CREATE OR REPLACE FUNCTION search_release_group_insert_4() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.id IN (NEW.release_group)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_group_insert_4() IS 'The path for this function is releases';

CREATE OR REPLACE FUNCTION search_release_group_update_4() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.id IN (NEW.release_group)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_group_update_4() IS 'The path for this function is releases';

CREATE OR REPLACE FUNCTION search_release_group_delete_5() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.id IN (SELECT release.id FROM release WHERE release.status IN (OLD.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_group_delete_5() IS 'The path for this function is releases.status';

CREATE OR REPLACE FUNCTION search_release_group_insert_5() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.id IN (SELECT release.id FROM release WHERE release.status IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_group_insert_5() IS 'The path for this function is releases.status';

CREATE OR REPLACE FUNCTION search_release_group_update_5() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.id IN (SELECT release.id FROM release WHERE release.status IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_group_update_5() IS 'The path for this function is releases.status';

CREATE OR REPLACE FUNCTION search_release_group_delete_6() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.id IN (OLD.release_group)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_group_delete_6() IS 'The path for this function is tags';

CREATE OR REPLACE FUNCTION search_release_group_insert_6() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.id IN (NEW.release_group)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_group_insert_6() IS 'The path for this function is tags';

CREATE OR REPLACE FUNCTION search_release_group_update_6() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.id IN (NEW.release_group)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_group_update_6() IS 'The path for this function is tags';

CREATE OR REPLACE FUNCTION search_release_group_delete_7() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.id IN (SELECT release_group_tag.release_group FROM release_group_tag WHERE release_group_tag.tag IN (OLD.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_group_delete_7() IS 'The path for this function is tags.tag';

CREATE OR REPLACE FUNCTION search_release_group_insert_7() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.id IN (SELECT release_group_tag.release_group FROM release_group_tag WHERE release_group_tag.tag IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_group_insert_7() IS 'The path for this function is tags.tag';

CREATE OR REPLACE FUNCTION search_release_group_update_7() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.id IN (SELECT release_group_tag.release_group FROM release_group_tag WHERE release_group_tag.tag IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_group_update_7() IS 'The path for this function is tags.tag';

CREATE OR REPLACE FUNCTION search_release_group_delete_8() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.type IN (OLD.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_group_delete_8() IS 'The path for this function is type';

CREATE OR REPLACE FUNCTION search_release_group_insert_8() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.type IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_group_insert_8() IS 'The path for this function is type';

CREATE OR REPLACE FUNCTION search_release_group_update_8() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.type IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_group_update_8() IS 'The path for this function is type';

CREATE OR REPLACE FUNCTION search_release_group_delete_9() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.id IN (OLD.release_group)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_group_delete_9() IS 'The path for this function is secondary_types';

CREATE OR REPLACE FUNCTION search_release_group_insert_9() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.id IN (NEW.release_group)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_group_insert_9() IS 'The path for this function is secondary_types';

CREATE OR REPLACE FUNCTION search_release_group_update_9() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.id IN (NEW.release_group)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_group_update_9() IS 'The path for this function is secondary_types';

CREATE OR REPLACE FUNCTION search_release_group_delete_10() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.id IN (SELECT release_group_secondary_type_join.release_group FROM release_group_secondary_type_join WHERE release_group_secondary_type_join.secondary_type IN (OLD.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_group_delete_10() IS 'The path for this function is secondary_types.secondary_type';

CREATE OR REPLACE FUNCTION search_release_group_insert_10() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.id IN (SELECT release_group_secondary_type_join.release_group FROM release_group_secondary_type_join WHERE release_group_secondary_type_join.secondary_type IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_group_insert_10() IS 'The path for this function is secondary_types.secondary_type';

CREATE OR REPLACE FUNCTION search_release_group_update_10() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.id IN (SELECT release_group_secondary_type_join.release_group FROM release_group_secondary_type_join WHERE release_group_secondary_type_join.secondary_type IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_release_group_update_10() IS 'The path for this function is secondary_types.secondary_type';

CREATE OR REPLACE FUNCTION search_series_delete_0() RETURNS trigger
    AS $$
DECLARE
    gids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO gids FROM (SELECT series.gid AS id FROM series WHERE series.id = OLD.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'delete', 'series ' || gids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_series_delete_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_series_insert_0() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT series.id FROM series WHERE series.id = NEW.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'series ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_series_insert_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_series_update_0() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT series.id FROM series WHERE series.id = NEW.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'series ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_series_update_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_series_delete_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT series.id FROM series WHERE series.id IN (OLD.series)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'series ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_series_delete_1() IS 'The path for this function is aliases';

CREATE OR REPLACE FUNCTION search_series_insert_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT series.id FROM series WHERE series.id IN (NEW.series)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'series ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_series_insert_1() IS 'The path for this function is aliases';

CREATE OR REPLACE FUNCTION search_series_update_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT series.id FROM series WHERE series.id IN (NEW.series)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'series ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_series_update_1() IS 'The path for this function is aliases';

CREATE OR REPLACE FUNCTION search_series_delete_2() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT series.id FROM series WHERE series.link_attribute_type IN (OLD.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'series ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_series_delete_2() IS 'The path for this function is link_attribute_type';

CREATE OR REPLACE FUNCTION search_series_insert_2() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT series.id FROM series WHERE series.link_attribute_type IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'series ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_series_insert_2() IS 'The path for this function is link_attribute_type';

CREATE OR REPLACE FUNCTION search_series_update_2() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT series.id FROM series WHERE series.link_attribute_type IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'series ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_series_update_2() IS 'The path for this function is link_attribute_type';

CREATE OR REPLACE FUNCTION search_series_delete_3() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT series.id FROM series WHERE series.id IN (OLD.series)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'series ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_series_delete_3() IS 'The path for this function is tags';

CREATE OR REPLACE FUNCTION search_series_insert_3() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT series.id FROM series WHERE series.id IN (NEW.series)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'series ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_series_insert_3() IS 'The path for this function is tags';

CREATE OR REPLACE FUNCTION search_series_update_3() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT series.id FROM series WHERE series.id IN (NEW.series)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'series ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_series_update_3() IS 'The path for this function is tags';

CREATE OR REPLACE FUNCTION search_series_delete_4() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT series.id FROM series WHERE series.id IN (SELECT series_tag.series FROM series_tag WHERE series_tag.tag IN (OLD.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'series ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_series_delete_4() IS 'The path for this function is tags.tag';

CREATE OR REPLACE FUNCTION search_series_insert_4() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT series.id FROM series WHERE series.id IN (SELECT series_tag.series FROM series_tag WHERE series_tag.tag IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'series ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_series_insert_4() IS 'The path for this function is tags.tag';

CREATE OR REPLACE FUNCTION search_series_update_4() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT series.id FROM series WHERE series.id IN (SELECT series_tag.series FROM series_tag WHERE series_tag.tag IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'series ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_series_update_4() IS 'The path for this function is tags.tag';

CREATE OR REPLACE FUNCTION search_series_delete_5() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT series.id FROM series WHERE series.type IN (OLD.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'series ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_series_delete_5() IS 'The path for this function is type';

CREATE OR REPLACE FUNCTION search_series_insert_5() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT series.id FROM series WHERE series.type IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'series ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_series_insert_5() IS 'The path for this function is type';

CREATE OR REPLACE FUNCTION search_series_update_5() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT series.id FROM series WHERE series.type IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'series ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_series_update_5() IS 'The path for this function is type';

CREATE OR REPLACE FUNCTION search_tag_delete_0() RETURNS trigger
    AS $$
DECLARE
    gids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO gids FROM (SELECT tag.gid AS id FROM tag WHERE tag.id = OLD.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'delete', 'tag ' || gids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_tag_delete_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_tag_insert_0() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT tag.id FROM tag WHERE tag.id = NEW.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'tag ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_tag_insert_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_tag_update_0() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT tag.id FROM tag WHERE tag.id = NEW.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'tag ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_tag_update_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_url_delete_0() RETURNS trigger
    AS $$
DECLARE
    gids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO gids FROM (SELECT url.gid AS id FROM url WHERE url.id = OLD.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'delete', 'url ' || gids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_url_delete_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_url_insert_0() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT url.id FROM url WHERE url.id = NEW.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'url ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_url_insert_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_url_update_0() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT url.id FROM url WHERE url.id = NEW.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'url ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_url_update_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_work_delete_0() RETURNS trigger
    AS $$
DECLARE
    gids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO gids FROM (SELECT work.gid AS id FROM work WHERE work.id = OLD.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'delete', 'work ' || gids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_work_delete_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_work_insert_0() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.id = NEW.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_work_insert_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_work_update_0() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.id = NEW.id) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_work_update_0() IS 'The path for this function is direct';

CREATE OR REPLACE FUNCTION search_work_delete_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.id IN (OLD.work)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_work_delete_1() IS 'The path for this function is aliases';

CREATE OR REPLACE FUNCTION search_work_insert_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.id IN (NEW.work)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_work_insert_1() IS 'The path for this function is aliases';

CREATE OR REPLACE FUNCTION search_work_update_1() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.id IN (NEW.work)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_work_update_1() IS 'The path for this function is aliases';

CREATE OR REPLACE FUNCTION search_work_delete_2() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.id IN (OLD.entity1)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_work_delete_2() IS 'The path for this function is artist_links';

CREATE OR REPLACE FUNCTION search_work_insert_2() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.id IN (NEW.entity1)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_work_insert_2() IS 'The path for this function is artist_links';

CREATE OR REPLACE FUNCTION search_work_update_2() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.id IN (NEW.entity1)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_work_update_2() IS 'The path for this function is artist_links';

CREATE OR REPLACE FUNCTION search_work_delete_3() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.id IN (SELECT l_artist_work.id FROM l_artist_work WHERE l_artist_work.entity0 IN (OLD.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_work_delete_3() IS 'The path for this function is artist_links.artist';

CREATE OR REPLACE FUNCTION search_work_insert_3() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.id IN (SELECT l_artist_work.id FROM l_artist_work WHERE l_artist_work.entity0 IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_work_insert_3() IS 'The path for this function is artist_links.artist';

CREATE OR REPLACE FUNCTION search_work_update_3() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.id IN (SELECT l_artist_work.id FROM l_artist_work WHERE l_artist_work.entity0 IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_work_update_3() IS 'The path for this function is artist_links.artist';

CREATE OR REPLACE FUNCTION search_work_delete_4() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.id IN (OLD.work)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_work_delete_4() IS 'The path for this function is iswcs';

CREATE OR REPLACE FUNCTION search_work_insert_4() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.id IN (NEW.work)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_work_insert_4() IS 'The path for this function is iswcs';

CREATE OR REPLACE FUNCTION search_work_update_4() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.id IN (NEW.work)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_work_update_4() IS 'The path for this function is iswcs';

CREATE OR REPLACE FUNCTION search_work_delete_5() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.language IN (OLD.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_work_delete_5() IS 'The path for this function is language';

CREATE OR REPLACE FUNCTION search_work_insert_5() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.language IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_work_insert_5() IS 'The path for this function is language';

CREATE OR REPLACE FUNCTION search_work_update_5() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.language IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_work_update_5() IS 'The path for this function is language';

CREATE OR REPLACE FUNCTION search_work_delete_6() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.id IN (OLD.work)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_work_delete_6() IS 'The path for this function is tags';

CREATE OR REPLACE FUNCTION search_work_insert_6() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.id IN (NEW.work)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_work_insert_6() IS 'The path for this function is tags';

CREATE OR REPLACE FUNCTION search_work_update_6() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.id IN (NEW.work)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_work_update_6() IS 'The path for this function is tags';

CREATE OR REPLACE FUNCTION search_work_delete_7() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.id IN (SELECT work_tag.work FROM work_tag WHERE work_tag.tag IN (OLD.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_work_delete_7() IS 'The path for this function is tags.tag';

CREATE OR REPLACE FUNCTION search_work_insert_7() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.id IN (SELECT work_tag.work FROM work_tag WHERE work_tag.tag IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_work_insert_7() IS 'The path for this function is tags.tag';

CREATE OR REPLACE FUNCTION search_work_update_7() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.id IN (SELECT work_tag.work FROM work_tag WHERE work_tag.tag IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_work_update_7() IS 'The path for this function is tags.tag';

CREATE OR REPLACE FUNCTION search_work_delete_8() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.type IN (OLD.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_work_delete_8() IS 'The path for this function is type';

CREATE OR REPLACE FUNCTION search_work_insert_8() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.type IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'index', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_work_insert_8() IS 'The path for this function is type';

CREATE OR REPLACE FUNCTION search_work_update_8() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.type IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(2, 'search', 'update', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION search_work_update_8() IS 'The path for this function is type';
COMMIT;

-- Automatically generated, do not edit
\set ON_ERROR_STOP 1
BEGIN;

CREATE OR REPLACE FUNCTION search_artist_delete_direct() RETURNS trigger
    AS $$
DECLARE
    gids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO gids FROM (SELECT artist.gid AS id FROM artist WHERE artist.id = OLD.id) AS tmp;
    PERFORM amqp.publish(1, 'search', 'delete', 'artist ' || gids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_insert_direct() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.id = NEW.id) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_update_direct() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.id = NEW.id) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_delete_2_aliases() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.id IN (OLD.artist)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_insert_2_aliases() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.id IN (NEW.artist)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_update_2_aliases() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.id IN (NEW.artist)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_delete_4_area() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.area IN (OLD.id)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_insert_4_area() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.area IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_update_4_area() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.area IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_delete_6_area_aliases() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.area IN (SELECT area.id FROM area WHERE area.id IN (OLD.area))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_insert_6_area_aliases() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.area IN (SELECT area.id FROM area WHERE area.id IN (NEW.area))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_update_6_area_aliases() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.area IN (SELECT area.id FROM area WHERE area.id IN (NEW.area))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_delete_8_begin_area() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.begin_area IN (OLD.id)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_insert_8_begin_area() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.begin_area IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_update_8_begin_area() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.begin_area IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_delete_10_begin_area_aliases() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.begin_area IN (SELECT area.id FROM area WHERE area.id IN (OLD.area))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_insert_10_begin_area_aliases() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.begin_area IN (SELECT area.id FROM area WHERE area.id IN (NEW.area))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_update_10_begin_area_aliases() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.begin_area IN (SELECT area.id FROM area WHERE area.id IN (NEW.area))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_delete_12_end_area() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.end_area IN (OLD.id)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_insert_12_end_area() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.end_area IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_update_12_end_area() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.end_area IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_delete_14_end_area_aliases() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.end_area IN (SELECT area.id FROM area WHERE area.id IN (OLD.area))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_insert_14_end_area_aliases() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.end_area IN (SELECT area.id FROM area WHERE area.id IN (NEW.area))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_update_14_end_area_aliases() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.end_area IN (SELECT area.id FROM area WHERE area.id IN (NEW.area))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_delete_17_ipis() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.id IN (OLD.artist)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_insert_17_ipis() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.id IN (NEW.artist)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_update_17_ipis() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.id IN (NEW.artist)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_delete_19_type() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.type IN (OLD.id)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_insert_19_type() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.type IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_artist_update_19_type() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT artist.id FROM artist WHERE artist.type IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'artist ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_delete_direct() RETURNS trigger
    AS $$
DECLARE
    gids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO gids FROM (SELECT work.gid AS id FROM work WHERE work.id = OLD.id) AS tmp;
    PERFORM amqp.publish(1, 'search', 'delete', 'work ' || gids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_insert_direct() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.id = NEW.id) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_update_direct() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.id = NEW.id) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_delete_2_aliases() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.id IN (OLD.work)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_insert_2_aliases() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.id IN (NEW.work)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_update_2_aliases() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.id IN (NEW.work)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_delete_4_artist_links() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.id IN (OLD.entity1)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_insert_4_artist_links() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.id IN (NEW.entity1)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_update_4_artist_links() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.id IN (NEW.entity1)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_delete_5_artist_links_artist() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.id IN (SELECT l_artist_work.id FROM l_artist_work WHERE l_artist_work.entity0 IN (OLD.id))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_insert_5_artist_links_artist() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.id IN (SELECT l_artist_work.id FROM l_artist_work WHERE l_artist_work.entity0 IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_update_5_artist_links_artist() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.id IN (SELECT l_artist_work.id FROM l_artist_work WHERE l_artist_work.entity0 IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_delete_9_iswcs() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.id IN (OLD.work)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_insert_9_iswcs() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.id IN (NEW.work)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_update_9_iswcs() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.id IN (NEW.work)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_delete_11_language() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.language IN (OLD.id)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_insert_11_language() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.language IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_work_update_11_language() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT work.id FROM work WHERE work.language IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'work ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_delete_direct() RETURNS trigger
    AS $$
DECLARE
    gids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO gids FROM (SELECT label.gid AS id FROM label WHERE label.id = OLD.id) AS tmp;
    PERFORM amqp.publish(1, 'search', 'delete', 'label ' || gids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_insert_direct() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.id = NEW.id) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_update_direct() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.id = NEW.id) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_delete_2_aliases() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.id IN (OLD.label)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_insert_2_aliases() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.id IN (NEW.label)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_update_2_aliases() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.id IN (NEW.label)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_delete_4_area() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.area IN (OLD.id)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_insert_4_area() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.area IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_update_4_area() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.area IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_delete_7_ipis() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.id IN (OLD.label)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_insert_7_ipis() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.id IN (NEW.label)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_update_7_ipis() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.id IN (NEW.label)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_delete_9_type() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.type IN (OLD.id)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_insert_9_type() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.type IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_label_update_9_type() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT label.id FROM label WHERE label.type IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'label ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_delete_direct() RETURNS trigger
    AS $$
DECLARE
    gids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO gids FROM (SELECT recording.gid AS id FROM recording WHERE recording.id = OLD.id) AS tmp;
    PERFORM amqp.publish(1, 'search', 'delete', 'recording ' || gids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_insert_direct() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id = NEW.id) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_update_direct() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id = NEW.id) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_delete_0_artist_credit() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.artist_credit IN (OLD.id)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_insert_0_artist_credit() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.artist_credit IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_update_0_artist_credit() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.artist_credit IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_delete_1_artist_credit_artists() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.artist_credit IN (SELECT artist_credit.id FROM artist_credit WHERE artist_credit.id IN (OLD.artist_credit))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_insert_1_artist_credit_artists() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.artist_credit IN (SELECT artist_credit.id FROM artist_credit WHERE artist_credit.id IN (NEW.artist_credit))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_update_1_artist_credit_artists() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.artist_credit IN (SELECT artist_credit.id FROM artist_credit WHERE artist_credit.id IN (NEW.artist_credit))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_delete_2_artist_credit_artists_artist() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.artist_credit IN (SELECT artist_credit.id FROM artist_credit WHERE artist_credit.id IN (SELECT artist_credit_name.artist_credit FROM artist_credit_name WHERE artist_credit_name.artist IN (OLD.id)))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_insert_2_artist_credit_artists_artist() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.artist_credit IN (SELECT artist_credit.id FROM artist_credit WHERE artist_credit.id IN (SELECT artist_credit_name.artist_credit FROM artist_credit_name WHERE artist_credit_name.artist IN (NEW.id)))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_update_2_artist_credit_artists_artist() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.artist_credit IN (SELECT artist_credit.id FROM artist_credit WHERE artist_credit.id IN (SELECT artist_credit_name.artist_credit FROM artist_credit_name WHERE artist_credit_name.artist IN (NEW.id)))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_delete_7_tracks() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (OLD.recording)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_insert_7_tracks() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (NEW.recording)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_update_7_tracks() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (NEW.recording)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_delete_8_tracks_medium() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (OLD.id))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_insert_8_tracks_medium() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_update_8_tracks_medium() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_delete_9_tracks_medium_release() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (OLD.id)))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_insert_9_tracks_medium_release() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (NEW.id)))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_update_9_tracks_medium_release() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (NEW.id)))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_delete_10_tracks_medium_release_country_dates() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.id IN (OLD.release))))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_insert_10_tracks_medium_release_country_dates() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.id IN (NEW.release))))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_update_10_tracks_medium_release_country_dates() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.id IN (NEW.release))))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_delete_11_tracks_medium_release_country_dates_country() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.id IN (SELECT release_country.release FROM release_country WHERE release_country.country IN (OLD.id)))))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_insert_11_tracks_medium_release_country_dates_country() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.id IN (SELECT release_country.release FROM release_country WHERE release_country.country IN (NEW.id)))))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_update_11_tracks_medium_release_country_dates_country() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.id IN (SELECT release_country.release FROM release_country WHERE release_country.country IN (NEW.id)))))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_delete_12_tracks_medium_release_country_dates_country_area() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.id IN (SELECT release_country.release FROM release_country WHERE release_country.country IN (SELECT country_area.area FROM country_area WHERE country_area.area IN (OLD.id))))))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_insert_12_tracks_medium_release_country_dates_country_area() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.id IN (SELECT release_country.release FROM release_country WHERE release_country.country IN (SELECT country_area.area FROM country_area WHERE country_area.area IN (NEW.id))))))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_update_12_tracks_medium_release_country_dates_country_area() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.id IN (SELECT release_country.release FROM release_country WHERE release_country.country IN (SELECT country_area.area FROM country_area WHERE country_area.area IN (NEW.id))))))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_delete_16_tracks_medium_format() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.format IN (OLD.id)))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_insert_16_tracks_medium_format() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.format IN (NEW.id)))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_update_16_tracks_medium_format() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.format IN (NEW.id)))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_delete_18_isrcs() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (OLD.recording)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_insert_18_isrcs() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (NEW.recording)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_update_18_isrcs() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (NEW.recording)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_delete_23_tracks_medium_release_release_group() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.release_group IN (OLD.id))))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_insert_23_tracks_medium_release_release_group() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.release_group IN (NEW.id))))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_update_23_tracks_medium_release_release_group() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.release_group IN (NEW.id))))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_delete_24_tracks_medium_release_release_group_type() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.release_group IN (SELECT release_group.id FROM release_group WHERE release_group.type IN (OLD.id)))))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_insert_24_tracks_medium_release_release_group_type() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.release_group IN (SELECT release_group.id FROM release_group WHERE release_group.type IN (NEW.id)))))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_update_24_tracks_medium_release_release_group_type() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.release_group IN (SELECT release_group.id FROM release_group WHERE release_group.type IN (NEW.id)))))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_delete_30_tracks_medium_release_release_group_secondary_types() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.release_group IN (SELECT release_group.id FROM release_group WHERE release_group.id IN (OLD.release_group)))))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_insert_30_tracks_medium_release_release_group_secondary_types() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.release_group IN (SELECT release_group.id FROM release_group WHERE release_group.id IN (NEW.release_group)))))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_update_30_tracks_medium_release_release_group_secondary_types() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.release_group IN (SELECT release_group.id FROM release_group WHERE release_group.id IN (NEW.release_group)))))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_delete_31_tracks_medium_release_release_group_secondary_types_secondary_type() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.release_group IN (SELECT release_group.id FROM release_group WHERE release_group.id IN (SELECT release_group_secondary_type_join.release_group FROM release_group_secondary_type_join WHERE release_group_secondary_type_join.secondary_type IN (OLD.id))))))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_insert_31_tracks_medium_release_release_group_secondary_types_secondary_type() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.release_group IN (SELECT release_group.id FROM release_group WHERE release_group.id IN (SELECT release_group_secondary_type_join.release_group FROM release_group_secondary_type_join WHERE release_group_secondary_type_join.secondary_type IN (NEW.id))))))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_update_31_tracks_medium_release_release_group_secondary_types_secondary_type() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.release_group IN (SELECT release_group.id FROM release_group WHERE release_group.id IN (SELECT release_group_secondary_type_join.release_group FROM release_group_secondary_type_join WHERE release_group_secondary_type_join.secondary_type IN (NEW.id))))))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_delete_33_tracks_medium_release_status() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.status IN (OLD.id))))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_insert_33_tracks_medium_release_status() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.status IN (NEW.id))))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_update_33_tracks_medium_release_status() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.status IN (NEW.id))))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_delete_38_tracks_medium_release_mediums() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.id IN (OLD.release))))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_insert_38_tracks_medium_release_mediums() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.id IN (NEW.release))))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_recording_update_38_tracks_medium_release_mediums() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT recording.id FROM recording WHERE recording.id IN (SELECT track.id FROM track WHERE track.medium IN (SELECT medium.id FROM medium WHERE medium.release IN (SELECT release.id FROM release WHERE release.id IN (NEW.release))))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'recording ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_delete_direct() RETURNS trigger
    AS $$
DECLARE
    gids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO gids FROM (SELECT release.gid AS id FROM release WHERE release.id = OLD.id) AS tmp;
    PERFORM amqp.publish(1, 'search', 'delete', 'release ' || gids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_insert_direct() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id = NEW.id) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_update_direct() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id = NEW.id) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_delete_2_artist_credit() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.artist_credit IN (OLD.id)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_insert_2_artist_credit() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.artist_credit IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_update_2_artist_credit() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.artist_credit IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_delete_3_artist_credit_artists() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.artist_credit IN (SELECT artist_credit.id FROM artist_credit WHERE artist_credit.id IN (OLD.artist_credit))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_insert_3_artist_credit_artists() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.artist_credit IN (SELECT artist_credit.id FROM artist_credit WHERE artist_credit.id IN (NEW.artist_credit))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_update_3_artist_credit_artists() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.artist_credit IN (SELECT artist_credit.id FROM artist_credit WHERE artist_credit.id IN (NEW.artist_credit))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_delete_4_artist_credit_artists_artist() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.artist_credit IN (SELECT artist_credit.id FROM artist_credit WHERE artist_credit.id IN (SELECT artist_credit_name.artist_credit FROM artist_credit_name WHERE artist_credit_name.artist IN (OLD.id)))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_insert_4_artist_credit_artists_artist() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.artist_credit IN (SELECT artist_credit.id FROM artist_credit WHERE artist_credit.id IN (SELECT artist_credit_name.artist_credit FROM artist_credit_name WHERE artist_credit_name.artist IN (NEW.id)))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_update_4_artist_credit_artists_artist() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.artist_credit IN (SELECT artist_credit.id FROM artist_credit WHERE artist_credit.id IN (SELECT artist_credit_name.artist_credit FROM artist_credit_name WHERE artist_credit_name.artist IN (NEW.id)))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_delete_6_country_dates() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (OLD.release)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_insert_6_country_dates() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (NEW.release)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_update_6_country_dates() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (NEW.release)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_delete_7_country_dates_country() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (SELECT release_country.release FROM release_country WHERE release_country.country IN (OLD.id))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_insert_7_country_dates_country() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (SELECT release_country.release FROM release_country WHERE release_country.country IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_update_7_country_dates_country() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (SELECT release_country.release FROM release_country WHERE release_country.country IN (NEW.id))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_delete_8_country_dates_country_area() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (SELECT release_country.release FROM release_country WHERE release_country.country IN (SELECT country_area.area FROM country_area WHERE country_area.area IN (OLD.id)))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_insert_8_country_dates_country_area() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (SELECT release_country.release FROM release_country WHERE release_country.country IN (SELECT country_area.area FROM country_area WHERE country_area.area IN (NEW.id)))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_update_8_country_dates_country_area() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.id IN (SELECT release_country.release FROM release_country WHERE release_country.country IN (SELECT country_area.area FROM country_area WHERE country_area.area IN (NEW.id)))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_delete_11_language() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.language IN (OLD.id)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_insert_11_language() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.language IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_update_11_language() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.language IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_delete_13_script() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.script IN (OLD.id)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_insert_13_script() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.script IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_update_13_script() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release.id FROM release WHERE release.script IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'release ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_delete_direct() RETURNS trigger
    AS $$
DECLARE
    gids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO gids FROM (SELECT release_group.gid AS id FROM release_group WHERE release_group.id = OLD.id) AS tmp;
    PERFORM amqp.publish(1, 'search', 'delete', 'release_group ' || gids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_insert_direct() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.id = NEW.id) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_update_direct() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.id = NEW.id) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_delete_2_releases() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.id IN (OLD.release_group)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_insert_2_releases() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.id IN (NEW.release_group)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_update_2_releases() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.id IN (NEW.release_group)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_delete_4_artist_credit() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.artist_credit IN (OLD.id)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_insert_4_artist_credit() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.artist_credit IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_update_4_artist_credit() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.artist_credit IN (NEW.id)) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_delete_5_artist_credit_artists() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.artist_credit IN (SELECT artist_credit.id FROM artist_credit WHERE artist_credit.id IN (OLD.artist_credit))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_insert_5_artist_credit_artists() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.artist_credit IN (SELECT artist_credit.id FROM artist_credit WHERE artist_credit.id IN (NEW.artist_credit))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_update_5_artist_credit_artists() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.artist_credit IN (SELECT artist_credit.id FROM artist_credit WHERE artist_credit.id IN (NEW.artist_credit))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_delete_6_artist_credit_artists_artist() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.artist_credit IN (SELECT artist_credit.id FROM artist_credit WHERE artist_credit.id IN (SELECT artist_credit_name.artist_credit FROM artist_credit_name WHERE artist_credit_name.artist IN (OLD.id)))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_insert_6_artist_credit_artists_artist() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.artist_credit IN (SELECT artist_credit.id FROM artist_credit WHERE artist_credit.id IN (SELECT artist_credit_name.artist_credit FROM artist_credit_name WHERE artist_credit_name.artist IN (NEW.id)))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'index', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_release_group_update_6_artist_credit_artists_artist() RETURNS trigger
    AS $$
DECLARE
    ids TEXT;
BEGIN
    SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECT release_group.id FROM release_group WHERE release_group.artist_credit IN (SELECT artist_credit.id FROM artist_credit WHERE artist_credit.id IN (SELECT artist_credit_name.artist_credit FROM artist_credit_name WHERE artist_credit_name.artist IN (NEW.id)))) AS tmp;
    PERFORM amqp.publish(1, 'search', 'update', 'release_group ' || ids);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMIT;

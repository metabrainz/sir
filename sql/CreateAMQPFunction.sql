-- Automatically generated, do not edit!
\set ON_ERROR_STOP 1
BEGIN;

CREATE OR REPLACE FUNCTION search_message_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(1, NEW.exchange, NEW.routing_key, NEW.message::text);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

COMMIT;

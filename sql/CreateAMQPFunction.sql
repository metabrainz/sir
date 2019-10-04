-- Automatically generated, do not edit!
\set ON_ERROR_STOP 1
BEGIN;

CREATE OR REPLACE FUNCTION search_sir_message_insert() RETURNS trigger
    AS $$
BEGIN
    PERFORM amqp.publish(1, NEW.channel, NEW.routing_key, NEW.message::text);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

COMMIT;

-- Automatically generated, do not edit!
\set ON_ERROR_STOP 1
BEGIN;

CREATE TRIGGER search_sir_message_insert AFTER INSERT ON musicbrainz.sir_message
    FOR EACH ROW EXECUTE PROCEDURE search_sir_message_insert();

COMMIT;

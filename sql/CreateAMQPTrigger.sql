-- Automatically generated, do not edit!
\set ON_ERROR_STOP 1
BEGIN;

CREATE TRIGGER search_message_insert BEFORE INSERT ON sir.message
    FOR EACH ROW EXECUTE PROCEDURE search_message_insert();

COMMIT;

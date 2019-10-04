-- Automatically generated, do not edit!
\set ON_ERROR_STOP 1
BEGIN;

CREATE TABLE musicbrainz.sir_message (
    id          serial PRIMARY KEY,
    channel     varchar(40),
    routing_key varchar(40),
    message     jsonb,
    created     timestamp DEFAULT current_timestamp
);

COMMIT;

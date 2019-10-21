-- Automatically generated, do not edit!
\set ON_ERROR_STOP 1
BEGIN;

CREATE SCHEMA sir;
CREATE TABLE sir.message (
    id                  serial      PRIMARY KEY,
    exchange            varchar(40) NOT NULL,
    routing_key         varchar(40) NOT NULL,
    message             jsonb       NOT NULL,
    created             timestamptz DEFAULT current_timestamp
);

COMMIT;

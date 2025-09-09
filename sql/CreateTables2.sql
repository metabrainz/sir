\set ON_ERROR_STOP 1
BEGIN;

CREATE SCHEMA IF NOT EXISTS sir;

CREATE TABLE sir.control (
    indexing_enabled BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE UNIQUE INDEX control_one_row_idx
    ON sir.control ((indexing_enabled IS NOT NULL));

INSERT INTO sir.control (indexing_enabled)
    VALUES (FALSE);

CREATE TABLE sir.pending_data (
    seqid       	BIGINT NOT NULL,
    xid         	BIGINT NOT NULL,
    tablename   	TEXT NOT NULL,
    op          	"char" NOT NULL,
    olddata     	JSON,
    newdata     	JSON,
    attempts    	SMALLINT NOT NULL DEFAULT 0,
    last_attempted	TIMESTAMP WITH TIME ZONE,
    failure_reason  TEXT NOT NULL DEFAULT ''
);

ALTER TABLE sir.pending_data
    ADD CONSTRAINT pending_data_pkey
    PRIMARY KEY (seqid);

COMMIT;

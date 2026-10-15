\set ON_ERROR_STOP 1
BEGIN;

CREATE SCHEMA IF NOT EXISTS sir;

CREATE TABLE sir.control (
    indexing_enabled BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE UNIQUE INDEX control_one_row_idx
    ON sir.control ((indexing_enabled IS NOT NULL));

INSERT INTO sir.control (indexing_enabled)
    VALUES (TRUE);

CREATE TABLE sir.pending_data (
    seqid       	BIGINT NOT NULL,
    xid         	BIGINT NOT NULL,
    tablename   	TEXT NOT NULL,
    op          	"char" NOT NULL,
    olddata     	JSON,
    newdata     	JSON
);

ALTER TABLE sir.pending_data
    ADD CONSTRAINT pending_data_pkey
    PRIMARY KEY (seqid);

CREATE TABLE sir.pending_data_slot (
    id SMALLINT NOT NULL,
    seqid BIGINT NOT NULL,
    description TEXT NOT NULL
);

ALTER TABLE sir.pending_data_slot
    ADD CONSTRAINT pending_data_slot_pkey
    PRIMARY KEY (id);

CREATE TABLE sir.pending_data_failure (
    slot            SMALLINT NOT NULL,
    seqid           BIGINT NOT NULL,
    attempts        SMALLINT NOT NULL DEFAULT 0,
    last_attempted  TIMESTAMP WITH TIME ZONE,
    failure_reason  TEXT NOT NULL DEFAULT ''
);

ALTER TABLE sir.pending_data_failure
    ADD CONSTRAINT pending_data_failure_pkey
    PRIMARY KEY (slot, seqid);

ALTER TABLE sir.pending_data_failure
    ADD CONSTRAINT pending_data_failure_fk_slot
    FOREIGN KEY (slot)
    REFERENCES sir.pending_data_slot(id)
    ON DELETE CASCADE;

ALTER TABLE sir.pending_data_failure
    ADD CONSTRAINT pending_data_failure_fk_seqid
    FOREIGN KEY (seqid)
    REFERENCES sir.pending_data(seqid)
    ON DELETE CASCADE;

COMMIT;

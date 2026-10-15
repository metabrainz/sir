-- Moves sir.pending_data's failure columns to the new
-- sir.pending_data_failure table, and adds sir.pending_data_slot.
--
-- Stop SIR before running this, then start it again with
-- `pending_data_slot = 1` in config.ini.

\set ON_ERROR_STOP 1
BEGIN;

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

-- Processed rows were deleted, so every remaining row is still pending for
-- the existing instance. Start its slot at 0 to fetch all of them.
INSERT INTO sir.pending_data_slot (id, seqid, description)
    VALUES (1, 0, 'Default');

INSERT INTO sir.pending_data_failure
        (slot, seqid, attempts, last_attempted, failure_reason)
    SELECT 1, seqid, attempts, last_attempted, failure_reason
      FROM sir.pending_data
     WHERE attempts > 0;

ALTER TABLE sir.pending_data
    DROP COLUMN attempts,
    DROP COLUMN last_attempted,
    DROP COLUMN failure_reason;

-- The copy function must change in the same transaction as the columns are
-- dropped, or MusicBrainz writes would fail in between.
CREATE OR REPLACE FUNCTION sir.a_ins_dbmirror2_pending_data() RETURNS trigger AS $$
DECLARE
    row_count INTEGER;
BEGIN
    INSERT INTO sir.pending_data
            (seqid, xid, tablename, op, olddata, newdata)
        SELECT ir.seqid, ir.xid, ir.tablename, ir.op,
               ir.olddata, ir.newdata
        FROM inserted_rows ir;

    GET DIAGNOSTICS row_count = ROW_COUNT;
    RAISE DEBUG 'sir.a_ins_dbmirror2_pending_data: copied % rows to sir.pending_data', row_count;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Copy of sir.a_upd_dbmirror2_pending_data from CreateFunctions.sql.
CREATE OR REPLACE FUNCTION sir.a_upd_dbmirror2_pending_data() RETURNS trigger AS $$
BEGIN
    UPDATE sir.pending_data
       SET seqid = NEW.seqid
     WHERE seqid = OLD.seqid;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_pending_data_seqid_sir
    AFTER UPDATE OF seqid ON dbmirror2.pending_data
    FOR EACH ROW
    WHEN (OLD.seqid IS DISTINCT FROM NEW.seqid)
    EXECUTE FUNCTION sir.a_upd_dbmirror2_pending_data();

COMMIT;

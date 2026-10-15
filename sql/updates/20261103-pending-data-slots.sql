-- Adds `sir.pending_data_slot` and `sir.pending_data_queue`, and moves
-- `sir.pending_data`'s failure columns to the queue.
--
-- Stop SIR before running this, then start it again with
-- `pending_data_slot = 1` in config.ini.
--
-- MusicBrainz writes pause until this finishes, for a time that grows with
-- the size of `sir.pending_data`. Run it soon after stopping SIR.

\set ON_ERROR_STOP 1
BEGIN;

SET LOCAL lock_timeout = '10s';
LOCK TABLE dbmirror2.pending_data IN SHARE ROW EXCLUSIVE MODE;
LOCK TABLE sir.pending_data IN ACCESS EXCLUSIVE MODE;

SELECT EXISTS (SELECT 1
                 FROM pg_trigger
                WHERE tgrelid = 'sir.pending_data'::regclass
                  AND tgname = 'cleanup_dbmirror2_pending_data_sir')
       AS has_standalone_cleanup_trigger \gset

CREATE TEMPORARY TABLE pending_data_old ON COMMIT DROP AS
    SELECT * FROM sir.pending_data;

DROP TABLE sir.pending_data;

CREATE TABLE sir.pending_data (
    seqid       BIGINT NOT NULL,
    xid         BIGINT NOT NULL,
    tablename   TEXT NOT NULL,
    op          "char" NOT NULL,
    olddata     JSON,
    newdata     JSON
);

INSERT INTO sir.pending_data (seqid, xid, tablename, op, olddata, newdata)
    SELECT seqid, xid, tablename, op, olddata, newdata
      FROM pending_data_old;

ALTER TABLE sir.pending_data
    ADD CONSTRAINT pending_data_pkey
    PRIMARY KEY (seqid);

CREATE TABLE sir.pending_data_slot (
    id          SMALLINT NOT NULL,
    description TEXT NOT NULL
);

ALTER TABLE sir.pending_data_slot
    ADD CONSTRAINT pending_data_slot_pkey
    PRIMARY KEY (id);

INSERT INTO sir.pending_data_slot (id, description)
    VALUES (1, 'Default');

CREATE TABLE sir.pending_data_queue (
    slot            SMALLINT NOT NULL,
    seqid           BIGINT NOT NULL,
    attempts        SMALLINT NOT NULL DEFAULT 0,
    last_attempted  TIMESTAMP WITH TIME ZONE,
    failure_reason  TEXT NOT NULL DEFAULT ''
);

INSERT INTO sir.pending_data_queue
        (slot, seqid, attempts, last_attempted, failure_reason)
    SELECT 1, seqid, attempts, last_attempted, failure_reason
      FROM pending_data_old;

ALTER TABLE sir.pending_data_queue
    ADD CONSTRAINT pending_data_queue_pkey
    PRIMARY KEY (slot, seqid);

CREATE INDEX pending_data_queue_idx_seqid
    ON sir.pending_data_queue (seqid);

ALTER TABLE sir.pending_data_queue
    ADD CONSTRAINT pending_data_queue_fk_slot
    FOREIGN KEY (slot)
    REFERENCES sir.pending_data_slot(id)
    ON DELETE CASCADE;

ALTER TABLE sir.pending_data_queue
    ADD CONSTRAINT pending_data_queue_fk_seqid
    FOREIGN KEY (seqid)
    REFERENCES sir.pending_data(seqid)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

\if :has_standalone_cleanup_trigger
CREATE TRIGGER cleanup_dbmirror2_pending_data_sir
    AFTER DELETE ON sir.pending_data
    REFERENCING OLD TABLE AS deleted_rows
    FOR EACH STATEMENT
    EXECUTE FUNCTION sir.a_del_sir_pending_data();
\endif

CREATE OR REPLACE FUNCTION sir.a_ins_dbmirror2_pending_data() RETURNS trigger AS $$
DECLARE
    slots SMALLINT[];
    row_count INTEGER;
BEGIN
    SELECT array_agg(id) INTO slots
      FROM (SELECT id FROM sir.pending_data_slot FOR KEY SHARE) s;

    IF slots IS NULL THEN
        RETURN NULL;
    END IF;

    INSERT INTO sir.pending_data
            (seqid, xid, tablename, op, olddata, newdata)
        SELECT ir.seqid, ir.xid, ir.tablename, ir.op,
               ir.olddata, ir.newdata
        FROM inserted_rows ir;

    GET DIAGNOSTICS row_count = ROW_COUNT;

    INSERT INTO sir.pending_data_queue (slot, seqid)
        SELECT s.id, ir.seqid
        FROM inserted_rows ir
        CROSS JOIN unnest(slots) AS s (id);

    RAISE DEBUG 'sir.a_ins_dbmirror2_pending_data: copied % rows to sir.pending_data', row_count;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION sir.a_upd_dbmirror2_pending_data() RETURNS trigger AS $$
BEGIN
    UPDATE sir.pending_data
       SET seqid = NEW.seqid
     WHERE seqid = OLD.seqid;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION sir.a_del_pending_data_queue() RETURNS trigger AS $$
BEGIN
    PERFORM 1
       FROM sir.pending_data
      WHERE seqid IN (SELECT seqid FROM deleted_rows)
      ORDER BY seqid
        FOR UPDATE;

    DELETE FROM sir.pending_data pd
     WHERE pd.seqid IN (SELECT seqid FROM deleted_rows)
       AND NOT EXISTS (SELECT 1
                         FROM sir.pending_data_queue q
                        WHERE q.seqid = pd.seqid);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_pending_data_seqid_sir
    AFTER UPDATE OF seqid ON dbmirror2.pending_data
    FOR EACH ROW
    WHEN (OLD.seqid IS DISTINCT FROM NEW.seqid)
    EXECUTE FUNCTION sir.a_upd_dbmirror2_pending_data();

CREATE TRIGGER delete_pending_data_sir
    AFTER DELETE ON sir.pending_data_queue
    REFERENCING OLD TABLE AS deleted_rows
    FOR EACH STATEMENT
    EXECUTE FUNCTION sir.a_del_pending_data_queue();

COMMIT;

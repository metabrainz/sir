-- Script to rollback 20261103-pending-data-slots.sql in case of unforeseen
-- consequences.
--
-- Stop SIR before running this, then start the previous version of SIR.
--
-- Rows still queued for any slot are kept, so rows that some slots already
-- processed will be indexed again. Each row keeps the failure state of the
-- slot with the fewest attempts, so it's retried unless every slot gave up
-- on it.
--
-- MusicBrainz writes pause until this finishes, for a time that grows with
-- the size of `sir.pending_data`. Run it soon after stopping SIR.

\set ON_ERROR_STOP 1
BEGIN;

SET LOCAL lock_timeout = '10s';
LOCK TABLE dbmirror2.pending_data IN SHARE ROW EXCLUSIVE MODE;
LOCK TABLE sir.pending_data IN ACCESS EXCLUSIVE MODE;
LOCK TABLE sir.pending_data_queue IN ACCESS EXCLUSIVE MODE;
LOCK TABLE sir.pending_data_slot IN ACCESS EXCLUSIVE MODE;

DROP TRIGGER update_pending_data_seqid_sir ON dbmirror2.pending_data;
DROP TRIGGER delete_pending_data_sir ON sir.pending_data_queue;

DROP FUNCTION sir.a_upd_dbmirror2_pending_data();
DROP FUNCTION sir.a_del_pending_data_queue();

SELECT EXISTS (SELECT 1
                 FROM pg_trigger
                WHERE tgrelid = 'sir.pending_data'::regclass
                  AND tgname = 'cleanup_dbmirror2_pending_data_sir')
       AS has_standalone_cleanup_trigger \gset

CREATE TEMPORARY TABLE pending_data_old ON COMMIT DROP AS
    SELECT pd.seqid, pd.xid, pd.tablename, pd.op, pd.olddata, pd.newdata,
           COALESCE(q.attempts, 0) AS attempts, q.last_attempted,
           COALESCE(q.failure_reason, '') AS failure_reason
      FROM sir.pending_data pd
      LEFT JOIN (SELECT DISTINCT ON (seqid)
                        seqid, attempts, last_attempted, failure_reason
                   FROM sir.pending_data_queue
                  ORDER BY seqid, attempts, last_attempted NULLS FIRST) q
             ON q.seqid = pd.seqid;

DROP TABLE sir.pending_data_queue;
DROP TABLE sir.pending_data_slot;
DROP TABLE sir.pending_data;

CREATE TABLE sir.pending_data (
    seqid           BIGINT NOT NULL,
    xid             BIGINT NOT NULL,
    tablename       TEXT NOT NULL,
    op              "char" NOT NULL,
    olddata         JSON,
    newdata         JSON,
    attempts        SMALLINT NOT NULL DEFAULT 0,
    last_attempted  TIMESTAMP WITH TIME ZONE,
    failure_reason  TEXT NOT NULL DEFAULT ''
);

INSERT INTO sir.pending_data
        (seqid, xid, tablename, op, olddata, newdata,
         attempts, last_attempted, failure_reason)
    SELECT seqid, xid, tablename, op, olddata, newdata,
           attempts, last_attempted, failure_reason
      FROM pending_data_old;

ALTER TABLE sir.pending_data
    ADD CONSTRAINT pending_data_pkey
    PRIMARY KEY (seqid);

\if :has_standalone_cleanup_trigger
CREATE TRIGGER cleanup_dbmirror2_pending_data_sir
    AFTER DELETE ON sir.pending_data
    REFERENCING OLD TABLE AS deleted_rows
    FOR EACH STATEMENT
    EXECUTE FUNCTION sir.a_del_sir_pending_data();
\endif

CREATE OR REPLACE FUNCTION sir.a_ins_dbmirror2_pending_data() RETURNS trigger AS $$
DECLARE
    row_count INTEGER;
BEGIN
    INSERT INTO sir.pending_data
            (seqid, xid, tablename, op, olddata, newdata,
             attempts, last_attempted, failure_reason)
        SELECT ir.seqid, ir.xid, ir.tablename, ir.op,
               ir.olddata, ir.newdata, 0, NULL, ''
        FROM inserted_rows ir;

    GET DIAGNOSTICS row_count = ROW_COUNT;
    RAISE DEBUG 'sir.a_ins_dbmirror2_pending_data: copied % rows to sir.pending_data', row_count;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

COMMIT;

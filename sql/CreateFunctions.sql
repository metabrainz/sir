\set ON_ERROR_STOP 1
BEGIN;

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

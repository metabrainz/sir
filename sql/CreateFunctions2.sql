\set ON_ERROR_STOP 1
BEGIN;

CREATE OR REPLACE FUNCTION sir.a_ins_dbmirror2_pending_data() RETURNS trigger AS $$
BEGIN
    INSERT INTO sir.pending_data (seqid, tablename, op, xid, olddata, newdata)
        SELECT seqid, tablename, op, xid, olddata, newdata
        FROM inserted_rows;
    SELECT NULL;
END;
$$ LANGUAGE SQL;

COMMIT;

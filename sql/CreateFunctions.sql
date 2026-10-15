\set ON_ERROR_STOP 1
BEGIN;

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

-- dbmirror2.recordchange() shifts the seqids of rows previously inserted by
-- the current transaction when it detects out-of-order operations (caused by
-- cascading triggers). Mirror those changes so that our copies don't
-- conflict with the reassigned seqids.
--
-- recordchange() shifts one row at a time, from the highest seqid down, and
-- always into a seqid that's unused, so applying each update as it happens
-- can't violate sir.pending_data_pkey.
CREATE OR REPLACE FUNCTION sir.a_upd_dbmirror2_pending_data() RETURNS trigger AS $$
BEGIN
    UPDATE sir.pending_data
       SET seqid = NEW.seqid
     WHERE seqid = OLD.seqid;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

COMMIT;

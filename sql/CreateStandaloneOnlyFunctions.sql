\set ON_ERROR_STOP 1
BEGIN;

CREATE OR REPLACE FUNCTION sir.a_del_sir_pending_data() RETURNS trigger AS $$
BEGIN
    DELETE FROM dbmirror2.pending_data pd
          USING deleted_rows
          WHERE pd.seqid = deleted_rows.seqid;
    DELETE FROM dbmirror2.pending_ts pt
          USING deleted_rows
          WHERE pt.xid = deleted_rows.xid;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

COMMIT;

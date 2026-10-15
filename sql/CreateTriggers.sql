\set ON_ERROR_STOP 1
BEGIN;

CREATE TRIGGER copy_pending_data_sir
    AFTER INSERT ON dbmirror2.pending_data
    REFERENCING NEW TABLE AS inserted_rows
    FOR EACH STATEMENT
    EXECUTE FUNCTION sir.a_ins_dbmirror2_pending_data();

CREATE TRIGGER update_pending_data_seqid_sir
    AFTER UPDATE OF seqid ON dbmirror2.pending_data
    FOR EACH ROW
    WHEN (OLD.seqid IS DISTINCT FROM NEW.seqid)
    EXECUTE FUNCTION sir.a_upd_dbmirror2_pending_data();

COMMIT;

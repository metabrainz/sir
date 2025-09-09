\set ON_ERROR_STOP 1
BEGIN;

CREATE TRIGGER copy_pending_data_sir
    AFTER INSERT ON dbmirror2.pending_data
    REFERENCING NEW TABLE AS inserted_rows
    FOR EACH STATEMENT
    EXECUTE FUNCTION sir.a_ins_dbmirror2_pending_data();

COMMIT;

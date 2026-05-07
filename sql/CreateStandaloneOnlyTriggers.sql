\set ON_ERROR_STOP 1
BEGIN;

CREATE TRIGGER cleanup_dbmirror2_pending_data_sir
    AFTER DELETE ON sir.pending_data
    REFERENCING OLD TABLE AS deleted_rows
    FOR EACH STATEMENT
    EXECUTE FUNCTION sir.a_del_sir_pending_data();

COMMIT;

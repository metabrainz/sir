\set ON_ERROR_STOP 1
BEGIN;

-- Copies new rows to `sir.pending_data`, and queues them for every slot.
-- Nothing is copied if there are no slots.
--
-- The `FOR KEY SHARE` lock query at the start waits for any slot that's
-- being dropped. Otherwise we'd queue rows for it and violate
-- `pending_data_queue_fk_slot`, causing the MusicBrainz write to fail.
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

-- `dbmirror2.recordchange()` shifts the seqids of rows previously inserted
-- by the current transaction when it detects out-of-order operations caused
-- by cascading triggers. Mirror those changes so that our copies don't
-- conflict with the reassigned seqids. (Queued rows are updated via
-- `pending_data_queue_fk_seqid`'s `ON UPDATE CASCADE`.)
--
-- `recordchange()` shifts one row at a time, from the highest seqid down,
-- and always into a seqid that's unused, so applying each update as it
-- happens can't violate `sir.pending_data_pkey` or
-- `sir.pending_data_queue_pkey`.
CREATE OR REPLACE FUNCTION sir.a_upd_dbmirror2_pending_data() RETURNS trigger AS $$
BEGIN
    UPDATE sir.pending_data
       SET seqid = NEW.seqid
     WHERE seqid = OLD.seqid;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Deletes `sir.pending_data` rows once no slot has them queued.
--
-- The row locks ensure a row is deleted even when several slots finish it
-- concurrently. Locking in seqid order avoids deadlocks.
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

COMMIT;

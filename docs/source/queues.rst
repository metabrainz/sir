.. _queue_setup:

Queues
======

All messages are stored in the ``sir.pending_data`` table, and most of the
columns mirror those in the ``dbmirror2.pending_data`` table, which is where
the messages originate from; each message corresponds to a database change,
with ``op`` indicating an insertion, update, or deletion.

Deletion operations are performed on the Solr index without any additional
database queries by simply calling :meth:`solr.Solr.delete` with the id
contained in the message. For insertions and updates, additional database
queries have to be made to update the data.

Each SIR instance consumes messages through a slot in the
``sir.pending_data_slot`` table, configured via ``pending_data_slot`` under the
``[sir]`` section of ``config.ini``. This allows multiple SIR instances to each
update a different Solr instance, while reading from the same
``sir.pending_data`` table. Every new message is queued for each slot in the
``sir.pending_data_queue`` table, and is deleted from ``sir.pending_data``
once every slot has processed it. Slot 1 is created by default; others can be
created and dropped with ``python -m sir create_slot`` and
``python -m sir drop_slot``. A new slot only receives messages for changes
made after it was created. Note that an unused slot will prevent rows in
``sir.pending_data`` from being deleted; and no messages are stored at all
if there are no slots.

Each SIR instance builds its Solr documents independently, so the database
queries made for insertions and updates are repeated for every slot. With
two slots, SIR puts twice the query load on the database. This is not ideal,
but it means each instance can use a different search schema or document
format, and can be stopped or fail without affecting the others. Keep the
number of slots small, and drop slots once they're no longer needed.

On standalone databases, rows in ``dbmirror2.pending_data`` and
``dbmirror2.pending_ts`` are deleted only when the matching rows in
``sir.pending_data`` are deleted. If there are no slots, nothing is copied
to ``sir.pending_data``, so the dbmirror2 rows grow indefinitely.

If processing any message fails, the ``sir.pending_data_queue`` columns
``attempts``, ``last_attempted``, and ``failure_reason`` will be updated for
manual inspection and intervention, if necessary. Failed messages are
automatically retried up to four times by default, though this can be
configued via ``max_retries`` under the ``[sir]`` section of ``config.ini``.
The delay between each retry is an increasing multiple of 5 minutes.
Messages which have exhausted their retries are kept until their queue rows
are removed.

Note that all messages are processed by default, but it is possible to
optionally focus on processing message for a specified set of entity
types only, through the option ``--entity-type``.

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
``[sir]`` section of ``config.ini``. Similar to PostgreSQL replication slots,
this allows multiple SIR instances to each update a different Solr
instance, while reading from the same ``sir.pending_data`` table. Slots can be
created and dropped with ``python -m sir create_slot`` and
``python -m sir drop_slot``. Note that an unused slot will prevent rows in
``sir.pending_data`` from being deleted.

If processing any message fails, a row is added to the
``sir.pending_data_failure`` table for the failed ``(slot, seqid)``.
The columns ``attempts``, ``last_attempted``, and ``failure_reason`` are
available for manual inspection and intervention, if necessary.
Failed messages are automatically retried up
to four times by default, though this can be configued via ``max_retries``
under the ``[sir]`` section of ``config.ini``. The delay between each retry
is an increasing multiple of 5 minutes.
Messages which have exhausted their retries are kept in ``sir.pending_data``
until their failure rows are removed.

Note that all messages are processed by default, but it is possible to
optionally focus on processing message for a specified set of entity
types only, through the option ``--entity-type``.

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

If processing any message failed, the ``sir.pending_data`` columns ``attemps``,
``last_attempted``, and ``failure_reason`` will be updated for manual inspection
and intervention, if necessary. Failed messages are automatically retried up
to four times by default, though this can be configued via ``max_retries``
under the ``[sir]`` section of ``config.ini``. The delay between each retry
is an increasing multiple of 5 minutes.

Note that all messages are processed by default, but it is possible to
optionally focus on processing message for a specified set of entity
types only, through the option ``--entity-type``.

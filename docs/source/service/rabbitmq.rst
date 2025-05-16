.. _rabbitmq:

RabbitMQ
--------

Maintenance
~~~~~~~~~~~

Requirements
++++++++++++

* Tolerance to connectivity issues:
  When running in watch mode, losing connection to RabbitMQ can make the indexer
  to stale indefinitely.
  To recover, the container running the indexer has to be manually restarted.
  See the ticket `SEARCH-678 <https://tickets.metabrainz.org/browse/SEARCH-678>`_
  for follow-up on improving tolerance.
* Maintenance mode:
  It doesn’t exist.
  To perform maintenance operations, it requires switching to another instance
  of RabbitMQ to prevent any data loss, even for a short period of time.
* Data importance:
  The RabbitMQ instance is conveying notification messages about changes that
  must be made to the search indexes.
  If any message is lost, all search indexes would have to be rebuilt,
  which currently takes hours and implies a downtime for searches.
  See the ticket `SEARCH-674 <https://tickets.metabrainz.org/browse/SEARCH-674>`_
  for follow-up on rebuilding with zero-downtime.
* Data persistence:
  Messages are expected to be processed within seconds (or minutes during
  activity peaks), so there is no need for persistent volumes.
  Losing these messages isn’t critical either as search indexes can be
  rebuilt in hours, so there is no need for backups either.

Procedures
++++++++++


* Start service:

  See :ref:`amqp`

* Reload service configuration:

  After:

  * Check the indexer logs to ensure that it did not stale and that it continues
    to process new messages.

* Stop service:

  Before:

  * Uninstall search triggers
  * Stop the live indexer

  It implies that search indexes will be outdated for good.
  Updating search indexes requires to rebuild these and takes hours of downtime.

* Restart service:

  It implies that search indexes will be likely missing some updates.
  Updating search indexes requires to rebuild these and takes hours of downtime.

* Move service:

  * Create vhost, user, permissions, queues in the new instance
  * Declare exchanges and queues as described in :ref:`amqp`
  * Update broker in PostgreSQL to point to the new instance
  * Once the queues in the old instance are empty,
    switch the live indexer to the new instance

  Neiher data loss nor downtime will occur.

* Remove service:

  Before:

  * Uninstall search triggers
  * Stop the live indexer

  It implies that search indexes will be outdated for good.
  Updating search indexes requires to rebuild these and takes hours of downtime.

Implementation details
~~~~~~~~~~~~~~~~~~~~~~

* Connectivity issues are reported through both Docker logs and Sentry.
* Producer and consumer are separate as follows:

  * Producer is `pg_amqp` used by triggers in Postgres database.

    * ack mode: transactional
    * heartbeat timeout: (not using 0.8 version)
    * message protocol version: 0.8

  * Consumer is `sir` running in watch mode for live indexing.

    * ack mode: basic/manual
    * heartbeat timeout: (not configured/server’s default)
    * message protocol version: 0.9.1

* There are known issues related to queues declaration; See :ref:`amqp`
* Connections are not named properly (just using proxy interface IP and port)


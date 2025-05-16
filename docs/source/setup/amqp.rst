.. _amqp:

AMQP Setup
----------

RabbitMQ Server
~~~~~~~~~~~~~~~

To set up the exchanges and queues on your RabbitMQ server,

* install `RabbitMQ <https://rabbitmq.com/>`_ (if you have not already done so)
* start RabbitMQ
* configure your AMQP access data in ``config.ini``
* run ``python -m sir amqp_setup`` to configure the necessary exchanges and
  queues on your AMQP server.

The default values for the RabbitMQ configuration options can be found in `the
RabbitMQ documentation`_.

Database
~~~~~~~~

Sir requires that you both install an extension into your MusicBrainz database
and add triggers to it.

It also requires to have built the materialized (or denormalized) tables
for the MusicBrainz database.

AMQP Extension
++++++++++++++

* Install `pg_amqp <https://github.com/omniti-labs/pg_amqp>`_.
* Check values for the following keys in the file ``config.ini``:

=================== ===========
Keys                Description
=================== ===========
[database] user     Name of the PostgreSQL user the MusicBrainz Server uses
[rabbitmq] host     The hostname that's running your RabbitMQ server
[rabbitmq] user     The username with which to connect to your RabbitMQ server
[rabbitmq] password The password with which to connect to your RabbitMQ server
[rabbitmq] vhost    The vhost on your RabbitMQ server
=================== ===========

The default values for the RabbitMQ configuration options can be found in `the
RabbitMQ documentation`_.

* Run ``python -m sir extension`` once to generate the file ``sql/CreateExtension.sql``.
* Connect to your database as a superuser with ``psql`` to execute from this file.

.. _triggers:

Triggers
++++++++

In addition to the steps above, it is necessary to install functions and
triggers into the database to send messages via AMQP after a change has been
applied to the database. Those can be found in the ``sql`` directory and will
send messages for all entity types by default.

If you just want search indices to be updated for a limited set of entity types,
for example artists and works, you can regenerated those by running

.. code-block:: shell

     python -m sir triggers --entity-type artist --entity-type work

Once you are satisfied with the (default or generated) SQL triggers, those can
be installed with

.. code-block:: shell

     MB_SERVER_PATH=<mb_path> make installsql

where ``<mb_path>`` is the path to your clone of the MusicBrainz server.

.. _the RabbitMQ documentation: https://www.rabbitmq.com/configure.html

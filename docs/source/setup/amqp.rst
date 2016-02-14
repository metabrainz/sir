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

AMQP Extension
++++++++++++++

* Install `pg_amqp <https://github.com/omniti-labs/pg_amqp>`_.
* Connect to your database as a superuser with ``psql`` and execute

.. code-block:: sql

    CREATE EXTENSION amqp;
    ALTER SCHEMA amqp OWNER TO <musicbrainz>;
    ALTER TABLE amqp.broker OWNER TO <musicbrainz>;
    INSERT INTO amqp.broker (host, vhost, username, password)
        VALUES (<host>, <vhost>, <username>, <password>);

applying the following replacements:

============= ===========
What          Description
============= ===========
<musicbrainz> Name of the PostgreSQL user the MusicBrainz Server uses
<host>        The hostname that's running your RabbitMQ server
<vhost>       The vhost of your RabbitMQ server
<user>        The username with which to connect to your RabbitMQ server
<password>    The password of <user>
============= ===========

The default values for the RabbitMQ configuration options can be found in `the
RabbitMQ documentation`_.

Triggers
++++++++

In addition to the steps above, it is necessary to install functions and
triggers into the database to send messages via AMQP after a change has been
applied to the database. Those can be found in the ``sql`` directory and can be
installed with

.. code-block:: shell

     MB_SERVER_PATH=<mb_path> make installsql

where ``<mb_path>`` is the path to your clone of the MusicBrainz server.


.. _the RabbitMQ documentation: https://www.rabbitmq.com/configure.html

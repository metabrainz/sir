AMQP Setup
==========

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


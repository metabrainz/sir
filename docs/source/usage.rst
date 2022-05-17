Usage
=====

As already mentioned in :ref:`setup`, ``python -m sir`` is the entry point for the
command line interface which provides several subcommands:

.. program:: python -m sir

.. option:: reindex

   This subcommand allows reindexing data for specific or all entity types (see
   :ref:`import` for more information).

.. option:: triggers

   This subcommand regenerates the trigger files in the ``sql/`` directory (see
   :ref:`amqp` for more information).

.. option:: amqp_setup

   This subcommand sets up AMQP exchanges and queues (see :ref:`triggers` for
   more information).

.. option:: amqp_publish

   This subcommand starts a process that fetches changes from the ``sir.message``
   database table and publishes them on the configured queues (see :ref:`queue_setup`
   for more information).

.. option:: amqp_watch

   This subcommand starts a process that listens on the configured queues and
   regenerates the index data (see :ref:`queue_setup` for more information).

All of them support the ``--help`` option that prints further information about
the available options.

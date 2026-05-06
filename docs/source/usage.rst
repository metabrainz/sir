Usage
=====

As already mentioned in :ref:`setup`, ``python -m sir`` is the entry point for the
command line interface which provides several subcommands:

.. program:: python -m sir

.. option:: reindex

   This subcommand allows reindexing data for specific or all entity types (see
   :ref:`import` for more information).

.. option:: setup

   This subcommand sets up the `sir` schema used to store messages.

.. option:: live

   This subcommand starts a process that listens on the configured queues and
   regenerates the index data (see :ref:`queue_setup` for more information).

All of them support the ``--help`` option that prints further information about
the available options.

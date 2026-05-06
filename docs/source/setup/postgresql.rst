.. _postgresql:

PostgreSQL Setup
----------------

Database
~~~~~~~~

Sir requires that you install the `sir` schema into your MusicBrainz database:

  # From the sir checkout.
  python -m sir setup

It also requires to have built the materialized (or denormalized) tables
for the MusicBrainz database:

  # From the musicbrainz-server checkout.
  ./admin/BuildMaterializedTables --database=MAINTENANCE all

For *standalone* databases, it requires that you install dbmirror2
replication triggers. (These should *not* be installed on mirrors.)
If you're running MusicBrainz Docker, follow the setup instructions
there. For MusicBrainz Server setups outside of Docker, run these
commands:

  # From the musicbrainz-server checkout.
  admin/psql MAINTENANCE < admin/sql/CreateAllReplicationTriggers2.sql

  # From the sir checkout.
  python -m sir setup_standalone_only

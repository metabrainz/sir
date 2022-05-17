MusicBrainz Database Schema
----

Of course you'll need a MusicBrainz database somewhere to read the data from.
The active database schema sequence must be `27` (or any future schema version
if still compatible). Follow `announcements`_ from the MetaBrainz blog.

Only Sir `3.y.z` is able to read from database of schema sequence `27`
(or any future schema if still compatible, but it reads and sends the
data made available from schema sequence `27` only).

.. _announcements: https://blog.metabrainz.org/category/schema-change-release/

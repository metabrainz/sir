Web Service Compatibility
-------------------------

If you have applications that are already able to parse search results from
search.musicbrainz.org in the `mmd-schema`_ XML or the `derived JSON`_ format,
you can enable the `wscompat` setting in the configuration file. This will
store an mmd-compatible XML document in a field called `_store` for each
Solr document.
Installing `mb-solrquerywriter`_ on your Solr server will then allow you to
retrieve responses as mmd-compatible XML or the derived JSON.

.. _mmd-schema: https://github.com/metabrainz/mmd-schema
.. _derived JSON: https://musicbrainz.org/doc/Development/JSON_Web_Service
.. _mb-solrquerywriter: https://github.com/metabrainz/mb-solrquerywriter/

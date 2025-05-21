Solr
----

Of course you'll need a Solr server somewhere to send the data to. The
`mbsssss`_ repository contains instructions on how to add the MusicBrainz
schemas to a Solr server.

Also check values for the following keys in the file ``config.ini``:

===================== ===========
Keys                  Description
===================== ===========
[solr] uri            The URI to Solr top-level V1 API (ending with ``/solr``)
[solr] batch_size     The number of Solr documents to submit at once
[solr] retries        Optional, the number of retries for connecting to Solr
                      (default is ``3``)
[solr] backoff_factor Optional, the `backoff factor`_ of the waiting
                      time between two retries for connecting to Solr
                      (default is ``1``)
===================== ===========

.. _backoff factor: https://urllib3.readthedocs.io/en/2.4.0/reference/urllib3.util.html#urllib3.util.Retry
.. _mbsssss: https://github.com/metabrainz/mbsssss

.. _queue_setup:

Queues
======

The queue setup is similar to the one used by the `CAA indexer
<https://github.com/metabrainz/CAA-indexer>`_:

.. graphviz::

    digraph queues {
    graph [rankdir=LR];

    search_exchange [shape=ellipse label="\"search\" exchange"];
    delqueue [shape=record label="search.delete | { ... | ... | ... }"];
    insqueue [shape=record label="search.index | { ... | ... | ... }"];



    search_exchange -> delqueue [label="delete"];
    search_exchange -> insqueue [label="insert"];
    search_exchange -> insqueue [label="update"];
    }

The ``search`` exchange is the entry point for new messages. It will route them
to either the ``search.delete`` queue or the ``search.index`` one.

Messages in ``search.delete`` are used to delete documents from the Solr index
without any additional queries by simply calling :meth:`solr.Solr.delete_many`
with the ids contained in the message.

For messages in ``search.index``, additional queries have to be made to update
the data.

.. graphviz::

    digraph retry {
    graph [rankdir=LR];

    retry_exchange [shape=ellipse label="\"search.retry\" fanout exchange"];
    retryqueue [shape=record label="search.retry | { ... | ... | ... }"];

    retry_exchange -> retryqueue;
    }

If processing any message failed, it will be sent to the ``search.retry``
queue, which automatically dead-letters them back to ``search`` after 4 hours
for another try.

.. graphviz::

    digraph failed {
    graph [rankdir=LR];

    failed_exchange [shape=ellipse label="\"search.failed\" fanout exchange"];
    failed_queue [shape=record label="search.failed | { ... | ... | ... }"];

    failed_exchange -> failed_queue;
    }

If processing a message failed too often, it will be put into ``search.failed``
for manual inspection and intervention.

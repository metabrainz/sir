The import process
==================

The process to import data into Solr is relatively straightforward.
There's a :class:`~sir.schema.searchentities.SearchEntity` object for each
entity type that can be imported which keeps track of the indexable fields and
the model in mbdata for that entity type.

Once it's known which entities to import (for example from command line
arguments), :func:`~sir.indexing.index_entity` can use
:func:`~sir.querying.build_entity_query` to build a
:class:`~sqla:sqlalchemy.orm.query.Query` object for the
:class:`~sir.schema.searchentities.SearchEntity` object. This Query object
will eagerly load the data from the database.
With the help of a :class:`~sir.querying.QueryIterator` object,
:func:`~sir.indexing.index_entity` will iterate over all database rows and add
the data to Solr.
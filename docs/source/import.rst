The import process
==================

The process to import data into Solr is relatively straightforward.
There's a :class:`~sir.schema.searchentities.SearchEntity` object for each
entity type that can be imported which keeps track of the indexable fields and
the model in mbdata for that entity type.

Once it's known which entities to import (for example from command line
arguments), :func:`~sir.querying.build_entity_query` can
build a :class:`~sqla:sqlalchemy.orm.query.Query` object for the
:class:`~sir.schema.searchentities.SearchEntity` object. This Query object will
eagerly load the data from the database.

The Query object is then passed to :func:`~sir.indexing.index_entity`, along
with other parameters like an actual database session (in the form of a :class:`~sqla:sqlalchemy.orm.scoping.scoped_session` object) and a
connection to the appropriate Solr cor (in the form of a
:class:`solr:solr.Solr` object). :func:`~sir.indexing.index_entity` will
then iterate over the results from the Query object, transform them into a
dictionary (using :func:`~sir.indexing.query_result_to_dict`) and send the
data to Solr.
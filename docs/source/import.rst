.. _import:

The import process
==================

The process to import data into Solr is relatively straightforward.
There's a :class:`~sir.schema.searchentities.SearchEntity` object for each
entity type that can be imported which keeps track of the indexable fields and
the model in mbdata for that entity type.

Once its known which entity types will be imported,
:func:`sir.indexing._multiprocessed_import` will successivey spawn
:class:`multiprocessing.Process` es via :mod:`multiprocessing.pool` .
Each of the processes will retrieve one batch of entities from the database via
a query built from
:func:`~sir.schema.searchentities.SearchEntity.build_entity_query` and convert
them
into regular dicts via
:func:`~sir.schema.searchentities.SearchEntity.query_result_to_dict`.
The result of the conversion will be passed into a
:class:`multiprocessing.Queue`.
On the other end of the queue, another process running
:func:`sir.indexing.queue_to_solr` will send them to Solr in batches.

.. graphviz::

   digraph indexing {
   graph [rankdir=TB]

   subgraph cluster_processes {
       graph [rankdir=LR]
       p_n [label="Process n"]
       p_dot [label="Process ..."]
       p_2 [label="Process #2"]
       p_1 [label="Process #1"]
       color = lightgrey
   }

   mb [label="MusicBrainz DB"]
   push_proc [label="Push process"]
   queue [label="Data queue" shape=diamond]
   solr [label="Solr server"]

   mb -> p_1;
   mb -> p_2;
   mb -> p_dot;
   mb -> p_n;
   p_n -> queue;
   p_dot -> queue;
   p_1 -> queue;
   p_2 -> queue;
   queue -> push_proc;
   push_proc -> solr;
   }

Paths
-----

Each :class:`~sir.schema.searchentities.SearchEntity` is assigned a
:ref:`declarative <sqla:declarative_toplevel>` via its **model** attribute and a
collection of :class:`~sir.schema.searchentities.SearchField` objects, each
corresponding to a field in the entities Solr core. Those fields each have one
or more paths that "lead" to the values that will be put into the field in
Solr. :func:`~sir.querying.iterate_path_values` is a method that returns an
iterator over all values for a specific field from an instance of a
:ref:`declarative <sqla:declarative_toplevel>` class and its docstring describes
how that works, so here's a verbatim copy of it:

.. automethod:: sir.querying.iterate_path_values
                :noindex:


:data:`sir.schema.SCHEMA` is a dictionary mapping core names to
:class:`~sir.schema.searchentities.SearchEntity` objects.

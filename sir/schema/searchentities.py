# Copyright (c) 2014, 2015 Lukas Lalinsky, Wieland Hoffmann
# License: MIT, see LICENSE for details
from sir import config
from sir.querying import iterate_path_values
from collections import defaultdict
from functools import partial
from itertools import chain
from logging import getLogger
try:
    from xml.etree.cElementTree import tostring
except ImportError:
    from xml.etree.ElementTree import tostring
from sqlalchemy.orm import class_mapper, Load
from sqlalchemy.orm.attributes import InstrumentedAttribute
from sqlalchemy.orm.descriptor_props import CompositeProperty
from sqlalchemy.orm.interfaces import ONETOMANY, MANYTOONE
from sqlalchemy.orm.properties import RelationshipProperty
from sqlalchemy.orm.query import Query


logger = getLogger("sir")


def is_composite_column(model, colname):
    """
    Checks if a models attribute is a composite column.

    :param model: A :ref:`declarative <sqla:declarative_toplevel>` class.
    :param str colname: The column name.
    :rtype: bool
    """
    attr = getattr(model, colname)
    return (hasattr(attr, "property") and
            isinstance(attr.property, CompositeProperty))


def merge_paths(field_paths):
    """
    Given a list of paths as ``field_paths``, return a dict that, for each
    level of the path, includes a dictionary whose keys are the columns to load
    and the values are other dictionaries of the described structure.


    :param field_paths:
    :type field_paths: [[str]]
    :rtype: dict
    """
    paths = defaultdict(set)
    for path_list in field_paths:
        for path in path_list:
            path_length = path.count(".")
            current_path_dict = paths
            for i, pathelem in enumerate(path.split(".")):
                # Build a new dict for the next level, if there is one
                if i >= path_length:
                    # If not, still add the current element as a key so its
                    # column gets loaded
                    current_path_dict[pathelem] = ""
                    break

                if pathelem in current_path_dict:
                    new_path_dict = current_path_dict[pathelem]
                else:
                    new_path_dict = defaultdict(set)
                current_path_dict[pathelem] = new_path_dict
                current_path_dict = new_path_dict
    return paths


def defer_everything_but(mapper, load, *columns):
    primary_keys = [c.name for c in mapper.primary_key]
    for prop in mapper.iterate_properties:
        if hasattr(prop, "columns"):
            key = prop.key
            if (key not in columns and key[:-3] not in columns and
                key[-3:] != "_id" and key != "position" and
                key not in primary_keys):
                # We need the _id columns for subqueries and joins
                # Position is needed because sqla automatically orders by
                # artist_credit_name.position
                logger.debug("Deferring %s on %s", key, mapper)
                load.defer(key)
    return load


class SearchField(object):
    """Represents a searchable field."""
    def __init__(self, name, paths, transformfunc=None):
        """
        :param str name: The name of the field
        :param str path: A dot-delimited path (or a list of them) along which
                         the value of this field can be found, beginning at
                         an instance of the model class this field is bound to.
        :param method transformfunc: An optional function to transform the
                         value before sending it to Solr.
        """
        self.name = name
        if not isinstance(paths, list):
            paths = [paths]
        self.paths = paths
        self.transformfunc = transformfunc


class SearchEntity(object):
    """An entity with searchable fields."""
    def __init__(self, model, fields, version, compatconverter=None,
                 extrapaths=None, extraquery=None):
        """
        :param model: A :ref:`declarative <sqla:declarative_toplevel>` class.
        :param list fields: A list of :class:`SearchField` objects.
        :param float version: The supported schema version of this entity.
        :param compatconverter: A function to convert this object into an XML
                                document compliant with the MMD schema version
                                2
        :param [str] extrapaths: A list of paths that don't correspond to any
                                 field but are used by the compatibility
                                 conversion
        :param extraquery: A function to apply to the object returned by
                           :meth:`query`.
        """
        self.model = model
        self.fields = fields
        self.extrapaths = extrapaths
        self.extraquery = extraquery
        self._query = None
        self.version = version
        self.compatconverter = compatconverter

    @property
    def query(self):
        """
        See :meth:`build_entity_query`.
        """
        if self._query is None:
            self._query = self.build_entity_query()

        return self._query

    def build_entity_query(self):
        """
        Builds a :class:`sqla:sqlalchemy.orm.query.Query` object for this
        entity (an instance of :class:`sir.schema.searchentities.SearchEntity`)
        that eagerly loads the values of all search fields.

        :rtype: :class:`sqla:sqlalchemy.orm.query.Query`
        """
        root_model = self.model
        query = Query(root_model)
        paths = [field.paths for field in self.fields]

        if (config.CFG.getboolean("sir", "wscompat") and
            self.extrapaths is not None):
            paths.extend([self.extrapaths])

        merged_paths = merge_paths(paths)

        for field_paths in paths:
            for path in field_paths:
                current_merged_path = merged_paths
                model = root_model
                load = Load(model)
                split_path = path.split(".")
                for pathelem in split_path:
                    current_merged_path = current_merged_path[pathelem]
                    column = getattr(model, pathelem)

                    # __tablename__s in annotation paths
                    if (not isinstance(column, InstrumentedAttribute) and not
                        isinstance(column, CompositeProperty)):
                        break

                    prop = column.property
                    if isinstance(prop, RelationshipProperty):
                        pk = column.mapper.primary_key[0].name
                        if prop.direction == ONETOMANY:
                            load = load.subqueryload(pathelem)
                        elif prop.direction == MANYTOONE:
                            load = load.joinedload(pathelem)
                        else:
                            load = load.defaultload(pathelem)
                        required_columns = current_merged_path.keys()
                        required_columns.append(pk)

                        # Get the mapper class of the current element of the
                        # path so the next iteration can access it.
                        model = prop.mapper.class_

                        # For composite properties, load the columns they
                        # consist of because eagerly loading a composite
                        # property doesn't load automatically load them.
                        composite_columns = filter(
                            partial(is_composite_column, model),
                            required_columns)
                        for composite_column in composite_columns:
                            composite_parts = (c.name for c in
                                               getattr(model,
                                                       composite_column).
                                               property.columns)
                            logger.debug("Loading %s instead of %s on %s",
                                         composite_parts,
                                         composite_column,
                                         model)
                            required_columns.remove(composite_column)
                            required_columns.extend(composite_parts)

                        logger.debug("Loading only %s on %s",
                                     required_columns,
                                     model)
                        load = defer_everything_but(class_mapper(model),
                                                    load,
                                                    *required_columns)
                query = query.options(load)
        if self.extraquery is not None:
            query = self.extraquery(query)
        return query

    def query_result_to_dict(self, obj):
        """
        Converts the result of single ``query`` result into a dictionary via the
        field specification of this entity.

        :param obj: A :ref:`declarative <sqla:declarative_toplevel>` object.
        :rtype: dict
        """
        data = {}
        for field in self.fields:
            fieldname = field.name
            for path in field.paths:
                tempvals = set(chain(iter for iter in iterate_path_values(path, obj) if iter is not None))  # noqa
            if field.transformfunc is not None:
                tempvals = field.transformfunc(tempvals)
            if isinstance(tempvals, set) and len(tempvals) == 1:
                tempvals = tempvals.pop()
            if tempvals is not None and tempvals:
                data[fieldname] = tempvals

        if (config.CFG.getboolean("sir", "wscompat") and self.compatconverter is
            not None):
            data["_store"] = tostring(self.compatconverter(obj).to_etree())

        return data

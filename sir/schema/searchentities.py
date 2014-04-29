class SearchField(object):
    """Represents a searchable field."""
    def __init__(self, name, path, transformfunc=None):
        """
        :param str name: The name of the field
        :param str path: A dot-delimited-path along which the value of this 
                         field can be found, beginning at an instance of the
                         model class this field is bound to.
        :param method transformfunc: An optional function to transform the value
                         before sending it to Solr.
        """
        self.name = name
        self.path = path
        self.transformfunc = transformfunc


class SearchEntity(object):
    """An an entity with searchable fields."""
    def __init__(self, model, fields):
        """
        :param model: A :ref:`declarative <sqla:declarative_toplevel>` class.
        :param list fields: A list of :class:`SearchField` objects.
        """
        self.model = model
        self.fields = fields
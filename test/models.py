from collections import namedtuple
from sqlalchemy import Column, ForeignKey, Integer
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import composite, relationship

Base = declarative_base()


Comp = namedtuple("Comp", ["foo", "c_id"])


class B(Base):
    """
    A class with a many-to-one relationship to :class:`.C` via its ``c``
    attribute.
    """
    __tablename__ = "table_b"
    id = Column(Integer, primary_key=True)
    foo = Column(Integer)
    c_id = Column('c', Integer, ForeignKey("table_c.id"))
    composite_column = composite(Comp, foo, c_id)


class C(Base):
    """
    A class with a one-to-many relationship to :class:`.B` via its ``bs``
    attribute.
    """
    __tablename__ = "table_c"
    id = Column(Integer, primary_key=True)
    bar = Column(Integer)
    bs = relationship("B", backref="c")

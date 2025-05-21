from collections import namedtuple
from sqlalchemy import Column, ForeignKey, Integer, String
from sqlalchemy.orm import composite, relationship, declarative_base

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


class D(Base):
    __tablename__ = "table_d"

    pk1 = Column(Integer, primary_key=True)
    pk2 = Column(Integer, primary_key=True)
    foo = Column(String)
    key = Column(String)
    key2 = Column(String)
    foo_id = Column(Integer)
    position = Column(Integer)

from sqlalchemy import Column, ForeignKey, Integer
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship

Base = declarative_base()


class B(Base):
    """
    A class with a many-to-one relationship to :class:`.C` via its ``c``
    attribute.
    """
    __tablename__ = "table_b"
    id = Column(Integer, primary_key=True)
    c_id = Column(Integer, ForeignKey("table_c.id"))
    c = relationship("C")


class C(Base):
    """
    A class with a one-to-many relationship to :class:`.B` via its ``bs``
    attribute.
    """
    __tablename__ = "table_c"
    id = Column(Integer, primary_key=True)
    bs = relationship("B")
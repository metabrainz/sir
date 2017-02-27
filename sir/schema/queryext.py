#!/usr/bin/env python
# coding: utf-8
# Copyright (c) 2015 Wieland Hoffmann
# License: MIT, see LICENSE for details
from mbdata.models import (Annotation, AreaAnnotation, ArtistAnnotation,
                           EventAnnotation, InstrumentAnnotation, LabelAnnotation,
                           PlaceAnnotation, RecordingAnnotation, ReleaseAnnotation,
                           ReleaseGroupAnnotation, SeriesAnnotation, WorkAnnotation)
from sqlalchemy import func
from sqlalchemy.orm.query import Query

models = [
    AreaAnnotation,
    ArtistAnnotation,
    EventAnnotation,
    InstrumentAnnotation,
    LabelAnnotation,
    PlaceAnnotation,
    RecordingAnnotation,
    ReleaseAnnotation,
    ReleaseGroupAnnotation,
    SeriesAnnotation,
    WorkAnnotation,
]


def filter_valid_annotations(query):
    # TODO: Document this. What's going on in this filter?
    queries = [Query(func.max(getattr(m, "annotation_id"))).
               group_by(
                   getattr(m,
                           # Automatically turn (for example) ReleaseAnnotation
                           # into release_id
                           m.__tablename__.replace("_annotation", "_id")))
               for m in models]
    filter_query = queries[0].union_all(*queries[1:])
    return query.filter(Annotation.id.in_(filter_query))

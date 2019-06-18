ARG PYTHON_VERSION=2.7
FROM metabrainz/python:$PYTHON_VERSION

ARG SIR_VERSION

ARG PYTHON_VERSION

ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=${BUILD_DATE} \
      org.label-schema.schema-version="1.0.0-rc1" \
      org.label-schema.vcs-url="https://github.com/metabrainz/sir.git" \
      org.label-schema.vcs-ref=${VCS_REF} \
      org.label-schema.vendor="MetaBrainz Foundation" \
      org.metabrainz.based-on-image="metabrainz/python:${PYTHON_VERSION}" \
      org.metabrainz.sir.version=${SIR_VERSION}

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                    build-essential \
                    ca-certificates \
                    cron \
                    git \
                    libpq-dev \
                    libffi-dev \
                    libssl-dev \
                    libxml2-dev \
                    libxslt1-dev && \
    rm -rf /var/lib/apt/lists/*

# PostgreSQL client
RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8
ENV PG_MAJOR 9.5
RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main' $PG_MAJOR > /etc/apt/sources.list.d/pgdg.list
RUN apt-get update && \
    apt-get install -y postgresql-client-$PG_MAJOR && \
    rm -rf /var/lib/apt/lists/*
# Specifying password so that client doesn't ask scripts for it...
ENV PGPASSWORD "sir"

RUN mkdir /code
WORKDIR /code

# Python dependencies
COPY ./requirements.txt /code/
RUN pip install -r requirements.txt

COPY . /code/

############
# Services #
############

# Consul Template service is already set up with the base image.
# Just need to copy the configuration.
COPY ./docker/prod/consul-template.conf /etc/consul-template.conf

COPY ./docker/prod/indexer/indexer.service /etc/service/indexer/run
RUN chmod 755 /etc/service/indexer/run

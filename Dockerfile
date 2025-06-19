ARG PYTHON_VERSION=3.13
ARG BASE_IMAGE_DATE=20250313
FROM metabrainz/python:$PYTHON_VERSION-$BASE_IMAGE_DATE

ARG SIR_VERSION

ARG PYTHON_VERSION
ARG BASE_IMAGE_DATE

ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=${BUILD_DATE} \
      org.label-schema.schema-version="1.0.0-rc1" \
      org.label-schema.vcs-url="https://github.com/metabrainz/sir.git" \
      org.label-schema.vcs-ref=${VCS_REF} \
      org.label-schema.vendor="MetaBrainz Foundation" \
      org.metabrainz.based-on-image="metabrainz/python:${PYTHON_VERSION}-${BASE_IMAGE_DATE}" \
      org.metabrainz.sir.version=${SIR_VERSION}

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                    build-essential \
                    ca-certificates \
                    curl \
                    gnupg && \
    rm -rf /var/lib/apt/lists/*

# PostgreSQL client
RUN mkdir -p /usr/local/share/keyrings && \
    curl -sSL --retry 5 https://www.postgresql.org/media/keys/ACCC4CF8.asc > /tmp/postgres-key.asc && \
    gpg --no-default-keyring --keyring /tmp/postgres-keyring.gpg --import /tmp/postgres-key.asc && \
    gpg --no-default-keyring --keyring /tmp/postgres-keyring.gpg --export --output /usr/local/share/keyrings/apt.postgresql.org.gpg && \
    rm -f /tmp/postgres-key.asc /tmp/postgres-keyring.gpg
ENV PG_MAJOR 17
RUN . /etc/os-release && \
    echo "deb [signed-by=/usr/local/share/keyrings/apt.postgresql.org.gpg] https://apt.postgresql.org/pub/repos/apt/ ${VERSION_CODENAME}-pgdg main ${PG_MAJOR}" > /etc/apt/sources.list.d/pgdg.list && \
    apt-get update && \
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

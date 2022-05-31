#!/usr/bin/env bash
#
# Run tests and return 0 if these passed successfully.
#
# Usage:
#     ./test.sh
# Or:
#      DOCKER_COMPOSE_CMD='sudo docker-compose' ./test.sh

set -o errexit -o nounset

cd "$(dirname "${BASH_SOURCE[0]}")/"

DOCKER_COMPOSE_CMD=${DOCKER_COMPOSE_CMD:-docker-compose}

$DOCKER_COMPOSE_CMD -f docker/docker-compose.test.yml -p sir-test up -d musicbrainz_db
$DOCKER_COMPOSE_CMD -f docker/docker-compose.test.yml -p sir-test build
set +o errexit
$DOCKER_COMPOSE_CMD -f docker/docker-compose.test.yml -p sir-test run test \
    dockerize -wait tcp://musicbrainz_db:5432 -timeout 600s \
        bash -c "py.test --junitxml=/data/test_report.xml \
            --cov=sir \
            --cov-report xml:/data/coverage.xml \
            --cov-report html:/data/coverage-html \
            $*"
RET=$?
$DOCKER_COMPOSE_CMD -f docker/docker-compose.test.yml -p sir-test down
exit $RET

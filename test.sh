#!/usr/bin/env bash
#
# Run tests and return 0 if these passed successfully.
#
# Usage:
#     ./test.sh
# Or:
#      DOCKER_CMD='sudo podman' ./test.sh
# Or:
#      DOCKER_COMPOSE_CMD='sudo docker compose' ./test.sh

set -o errexit -o nounset

cd "$(dirname "${BASH_SOURCE[0]}")/"

SCRIPT_NAME=$(basename "$0")

# Set Docker/Compose commands

if [ -z ${DOCKER_CMD:+smt} ]
then
case "$OSTYPE" in
  darwin*) # Mac OS X
    DOCKER_CMD='docker'
    ;;
  linux*)
    if groups | grep -Eqw 'docker|root'
    then
      DOCKER_CMD='docker'
    elif groups | grep -Eqw 'sudo|wheel'
    then
      DOCKER_CMD='sudo docker'
    else
      echo >&2 "$SCRIPT_NAME: cannot set docker command: please either"
      echo >&2 "  * add the user '$USER' to the group 'docker' or 'sudo'"
      echo >&2 "  * or set the variable \$DOCKER_CMD"
      exit 77 # EX_NOPERM
    fi
    ;;
  *)
    echo >&2 "$SCRIPT_NAME: cannot detect platform to set docker command"
    echo >&2 "Try setting the variable \$DOCKER_CMD appropriately"
    exit 71 # EX_OSERR
    ;;
  esac
fi

DOCKER_COMPOSE_CMD=${DOCKER_COMPOSE_CMD:-${DOCKER_CMD} compose}

# Run tests

$DOCKER_COMPOSE_CMD -f docker/docker-compose.test.yml -p sir-test up -d musicbrainz_db
$DOCKER_COMPOSE_CMD -f docker/docker-compose.test.yml -p sir-test build
set +o errexit
$DOCKER_COMPOSE_CMD -f docker/docker-compose.test.yml -p sir-test run test \
    dockerize -wait tcp://musicbrainz_db:5432 -timeout 600s \
        bash -c "pytest --junitxml=/data/test_report.xml \
            --cov=sir \
            --cov-report xml:/data/coverage.xml \
            --cov-report html:/data/coverage-html \
            $*"
RET=$?
$DOCKER_COMPOSE_CMD -f docker/docker-compose.test.yml -p sir-test down
exit $RET

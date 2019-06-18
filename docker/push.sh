#!/bin/bash
#
# Build image from the currently checked out version of SIR
# and push it to the Docker Hub, tagged with version.
#
# Usage:
#   $ ./push.sh

set -e -u

vcs_ref=`git describe --always --broken --dirty --tags`
version=${vcs_ref#v}
deployment=git2consul
tag=${version}-${deployment}

cd "$(dirname "${BASH_SOURCE[0]}")/../"

docker build \
  --build-arg SIR_VERSION=${version} \
  --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
  --build-arg VCS_REF=${vcs_ref} \
  --tag metabrainz/sir:${tag} .
docker push metabrainz/sir:${tag}

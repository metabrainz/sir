#!/bin/sh

# This script MUST be executed from the root directory of the SIR repository!

docker build -t metabrainz/sir .
docker push metabrainz/sir

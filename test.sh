docker-compose -f docker/docker-compose.test.yml -p sir-test up -d musicbrainz_db
docker-compose -f docker/docker-compose.test.yml -p sir-test build
docker-compose -f docker/docker-compose.test.yml -p sir-test run test \
    dockerize -wait tcp://musicbrainz_db:5432 -timeout 600s \
        bash -c "py.test --junitxml=/data/test_report.xml \
            --cov=sir \
            --cov-report xml:/data/coverage.xml \
            --cov-report html:/data/coverage-html \
            $*"
RET=$?
docker-compose -f docker/docker-compose.test.yml -p sir-test down
exit $RET

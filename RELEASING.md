# Search Index Rebuilder (SIR) release process

> Preamble:
> This document covers steps for releasing new versions of Search Index
> Rebuilder which is performed by maintainers only.
> It includes discussion about private servers, repositories and tools which
> other contributors don’t have access to.
> It is made public for transparency and to allow for improvement suggestions.

## Table of contents

<!-- toc -->

- [Prerequisites](#prerequisites)
- [Interdependencies](#interdependencies)
- [Update SQL trigger files](#update-sql-trigger-files)
- [Prepare Jira tickets](#prepare-jira-tickets)
- [Prepare GitHub release notes](#prepare-github-release-notes)
- [Add Git tag](#add-git-tag)
- [Build Docker image](#build-docker-image)
- [Deploy to production](#deploy-to-production)
- [Push Git tag](#push-git-tag)
- [Publish GitHub release notes](#publish-github-release-notes)
- [Update Jira tickets](#update-jira-tickets)

<!-- tocstop -->

## Prerequisites

* Docker
* Git

## Interdependencies

Both repositories [`mb-solr`](https://github.com/metabrainz/mb-solr)
and [`mbsssss`](https://github.com/metabrainz/mbsssss)
may have to be updated at the same time.
Make sure to keep those working with SIR in any case.

The repository [`musicbrainz-docker`](https://github.com/metabrainz/musicbrainz-docker)
can be used to test everything together locally.
The website [`test.mb.o`](https://test.musicbrainz.org/)
can be used to get community feedback as well if needed.

## Update SQL trigger files

Assuming that you followed development setup for
[local development of Search Index Rebuilder](https://github.com/metabrainz/musicbrainz-docker#local-development-of-search-index-rebuilder),
run the following commands in the `indexer` service:

```sh
python -m sir triggers -bid 2
./GenerateDropSql.pl
```

## Prepare Jira tickets

* Make sure that `sir-next` is an unreleased version of “Indexer” component in
  [SEARCH component versions](https://tickets.metabrainz.org/projects/SEARCH?selectedItem=net.brokenbuild.subcomponents:component-versions-organizer);
  Otherwise add it with “next release” as description.
* Make sure that noticeable changes are covered by appropriate
[tickets in the “Indexer” component of the “SEARCH” project marked as “In Development Branch”](https://tickets.metabrainz.org/issues/?jql=project%20%3D%20SEARCH%20AND%20component%20%3D%20Indexer%20AND%20status%20%3D%20%22In%20Development%20Branch%22);
  Otherwise create/split/update tickets as needed.
* Set their _Fix Version_ field to `sir-next`.

## Prepare GitHub release notes

* Draft a new release at <https://github.com/metabrainz/sir/releases>;
* Set [semantic version](https://semver.org/) number `M.m.p` for release title.
  A new major version `M` is required when SIR cannot be updated independently of other search components (See below);
* Copy the formatted list of resolved tickets from [unreleased SEARCH versions](https://tickets.metabrainz.org/projects/SEARCH?selectedItem=com.atlassian.jira.jira-projects-plugin%3Arelease-page&status=unreleased) (by clicking on `sir-next`, then on “Release Notes“) to the description;
* Add an introductive section “New Requirements” i,
  especially if a new version is required for any of the following:
  - MusicBrainz database schema (`musicbrainz-server` [schema-change code](https://github.com/metabrainz/musicbrainz-server/tree/master/admin/sql/updates/schema-change) and MBDB schema [documentation](https://musicbrainz.org/doc/MusicBrainz_Database/Schema)),
  - MusicBrainz XML metadata schema (`mmd-schema` [releases](https://github.com/metabrainz/mmd-schema/releases)),
  - its associated Python bindings (`mb-rngpy` [tags](https://github.com/metabrainz/mb-rngpy/tags)),
  - MusicBrainz Solr search schema (`mbsssss` [releases](https://github.com/metabrainz/mbsssss/releases)),
  - and its associated MusicBrainz Solr query response writer (`mb-solr` [releases](https://github.com/metabrainz/mb-solr/releases));
* Add update instructions if needed (to reinstall triggers or rebuild any search index);
* Add task list items to cover other (supposedly unnoticeable) changes.

## Add Git tag

For version `M.m.p`:

```sh
git status
# Please verify that the clone is on branch master without any local change
git pull --ff-only
git tag 'vM.m.p' -m 'One-line summary'
```

## Build Docker image

```sh
docker/push.sh
```

Please verify that a new image tag (_M.m.p_`-git2consul`) is available from
from <https://hub.docker.com/r/metabrainz/sir/tags>.

## Deploy to production

Point deployment configuration to the new image and follow update instructions if any.

## Push Git tag

```sh
git push origin 'vM.m.d'
```

## Publish GitHub release notes

Choose the above pushed tag for the above drafted release and publish it.

## Update Jira tickets

1. Edit `sir-next` from [SEARCH component versions](https://tickets.metabrainz.org/projects/SEARCH?selectedItem=net.brokenbuild.subcomponents:component-versions-organizer) (in “Indexer” component) as follows:
   - Change name to `sir-`_M.m.p_
   - Set release date
   - Replace description with the GitHub release URL;
2. Close tickets for this version from [SEARCH releases](https://tickets.metabrainz.org/projects/SEARCH?selectedItem=com.atlassian.jira.jira-projects-plugin:release-page&status=released-unreleased);
3. Mark it as released;
4. Archive the previous `sir-`_*_ version.

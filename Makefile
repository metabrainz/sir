.PHONY: docs createextension createsql dropsql installsql installamqp onlinedocs test triggers index

docs:
	cd docs && make html

test:
	python -m unittest discover

triggers: createextension createsql createdropsql

createextension:
	mkdir sql
	python -m sir extension

createsql:
	python -m sir triggers --entity-type artist --entity-type release-group

createdropsql:
	./GenerateDropSql.pl

installsql:
	sql/psql -f sql/CreateExtension.sql
	sql/psql -f sql/CreateFunctions.sql
	sql/psql -f sql/CreateTriggers.sql

dropsql:
	sql/psql -f sql/DropTriggers.sql
	sql/psql -f sql/DropFunctions.sql

installamqp:
	python -m sir amqp_setup

install: installamqp triggers installsql

index:
	python -m sir reindex --entity-type artist --entity-type release-group

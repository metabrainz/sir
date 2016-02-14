.PHONY: docs createsql dropsql onlinedocs test triggers

docs:
	cd docs && make html

test:
	python -m unittest discover

triggers: createsql createdropsql

createsql:
	python -m sir triggers

createdropsql:
	$(MB_SERVER_PATH)/admin/GenerateSQLScripts.pl sql/

installsql:
	$(MB_SERVER_PATH)/admin/psql -f sql/CreateFunctions.sql
	$(MB_SERVER_PATH)/admin/psql -f sql/CreateTriggers.sql

dropsql:
	$(MB_SERVER_PATH)/admin/psql -f sql/DropTriggers.sql
	$(MB_SERVER_PATH)/admin/psql -f sql/DropFunctions.sql

.PHONY: docs installsql dropsql test

docs:
	cd docs && make html

test:
	python -m unittest discover

installsql:
	$(MB_SERVER_PATH)/admin/psql -f sql/CreateTables.sql
	$(MB_SERVER_PATH)/admin/psql -f sql/CreateFunctions.sql
	$(MB_SERVER_PATH)/admin/psql -f sql/CreateTriggers.sql

dropsql:
	$(MB_SERVER_PATH)/admin/psql -f sql/DropTriggers.sql
	$(MB_SERVER_PATH)/admin/psql -f sql/DropFunctions.sql
	$(MB_SERVER_PATH)/admin/psql -f sql/DropTables.sql

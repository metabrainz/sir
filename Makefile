.PHONY: docs installsql dropsql test

docs:
	cd docs && make html

test:
	python -m unittest discover

installsql:
	$(MB_SERVER_PATH)/admin/psql -f sql/CreateTables2.sql
	$(MB_SERVER_PATH)/admin/psql -f sql/CreateFunctions2.sql
	$(MB_SERVER_PATH)/admin/psql -f sql/CreateTriggers2.sql

dropsql:
	$(MB_SERVER_PATH)/admin/psql -f sql/DropTriggers2.sql
	$(MB_SERVER_PATH)/admin/psql -f sql/DropFunctions2.sql
	$(MB_SERVER_PATH)/admin/psql -f sql/DropTables2.sql

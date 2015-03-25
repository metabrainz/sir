.PHONY: docs createsql dropsql onlinedocs test triggers

docs:
	cd docs && make html

test:
	python -m unittest discover

triggers: createsql dropsql

createsql:
	python -m sir triggers

dropsql:
	$(MB_SERVER_PATH)/admin/GenerateSQLScripts.pl sql/

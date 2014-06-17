.PHONY: docs test

docs:
	cd docs && make html

test:
	python -m unittest discover

triggers:
	python -m sir triggers

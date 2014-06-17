.PHONY: docs onlinedocs test

docs:
	cd docs && make html

onlinedocs: docs
	cd docs/build && scp -r html rika:/home/mineo/public_html/sir

test:
	python -m unittest discover

triggers:
	python -m sir triggers

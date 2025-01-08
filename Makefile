PYTHON=python3
# pyenv is not a python package, so it can't be installed via pip\pip3 tool. 
# The way that how to install pyenv is in "https://github.com/pyenv/pyenv".  
PYENV=pyenv
RM=rm -rf


all: clean build_bins build_packs


run:
	$(PYTHON) -m poetry run $(PYTHON) src/python_develop_template/main.py

run_release:
	$(PYTHON) -m poetry run $(PYTHON) -O src/python_develop_template/main.py
	# $(PYTHON) -O0 main.py

build_bins:
	$(PYTHON) -m poetry run pyinstaller -y --distpath bins .pyinstaller.spec

rebuild_bins: clean build_bins

build_packs:
	$(PYTHON) -m poetry build -o packs
	
rebuild_packs: clean build_packs


envset:
	$(PYENV) install -s
	$(PYENV) local
	# $(PYTHON) --version
	$(PYTHON) -m pip install --upgrade poetry
	$(PYTHON) -m poetry config virtualenvs.create true
	$(PYTHON) -m poetry config virtualenvs.in-project true

install:
	$(PYTHON) -m poetry install
	# $(PYTHON) -m poetry add --group=dev pyinstaller
	# $(PYTHON) -m poetry add --group=dev setuptools
	# $(PYTHON) -m poetry add --group=dev black
	# # $(PYTHON) -m poetry add --group=dev yapf
	# $(PYTHON) -m poetry add --group=dev pylint
	# $(PYTHON) -m poetry add --group=dev mypy
	# $(PYTHON) -m poetry add --group=dev pycodestyle
	# $(PYTHON) -m poetry add python-dotenv
    # $(PYTHON) -m poetry add --group=dev pyclean
	# $(PYTHON) -m poetry add --group=test python-dotenv
	# $(PYTHON) -m poetry add --group=test pytest
	# $(PYTHON) -m poetry add --group=test pytest-mock
	# $(PYTHON) -m poetry add --group=test pytest-sugar
	# $(PYTHON) -m poetry add --group=test pytest-rerunfailures
	# $(PYTHON) -m poetry add --group=test pytest-xdist
	# $(PYTHON) -m poetry add --group=test pytest-assume
	# $(PYTHON) -m poetry add --group=test pytest-html
	# $(PYTHON) -m pyi-makespec -D -n .pyinstaller src/python_develop_template/main.py

update:
	$(PYTHON) -m poetry update

clean:
	- $(PYTHON) -m poetry run $(RM) build
	- $(PYTHON) -m poetry run $(RM) bins
	- $(PYTHON) -m poetry run $(RM) packs
	# - $(PYTHON) -m poetry run $(RM) dist
	- $(PYTHON) -m poetry run $(RM) .mypy_cache
	- $(PYTHON) -m poetry run $(RM) .pytest_cache
	- $(PYTHON) -m poetry run pyclean .
	- $(PYTHON) -m poetry cache clear pypi --all -n
	- $(PYTHON) -m poetry cache clear _default_cache --all -n

fmt:
	$(PYTHON) -m poetry run isort -v --sp .isort.cfg src
	$(PYTHON) -m poetry run isort -v --sp .isort.cfg tests
	$(PYTHON) -m poetry run black -v --config .black.toml src
	$(PYTHON) -m poetry run black -v --config .black.toml tests

lint:
	$(PYTHON) -m poetry run mypy -v --pretty --config-file .mypy.ini src
	$(PYTHON) -m poetry run mypy -v --pretty --config-file .mypy.ini tests
	$(PYTHON) -m poetry run pylint -v --rcfile .pylintrc src
	$(PYTHON) -m poetry run pylint -v --rcfile .pylintrc tests
	$(PYTHON) -m poetry run pycodestyle -v --config .pycodestyle --first --show-source --show-pep8 src
	$(PYTHON) -m poetry run pycodestyle -v --config .pycodestyle --first --show-source --show-pep8 tests

test:
	$(PYTHON) -m poetry run pytest -v -c .pytest.ini tests

bench:

coverage:

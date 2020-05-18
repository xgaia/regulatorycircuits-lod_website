SHELL := /bin/bash

PYTHON=python3
PIP=pip3
PIPENV=pipenv
TESTPYTHON:=$(shell $(PYTHON) --version 2>/dev/null)
PIPENVOPTS=

NIKOLA?=nikola

PORT?=8000

BASEDIR=$(CURDIR)
VENVDIR=$(BASEDIR)/venv
ACTIVATE=$(VENVDIR)/bin/activate

MODE?=dev
ifeq ($(MODE), dev)
	PIPENVOPTS+=--dev
endif

help:
	@echo 'Makefile for Nikola website'
	@echo ''
	@echo 'Usage:'
	@echo '    make help                           Display help'
	@echo '    make install [MODE=dev]             Install Python dependencies in a virtual environment'
	@echo '    make build                          (Re)generate the web site                           '
	@echo '    make clean                          Remove the generated files                          '
	@echo '    make serve [PORT=8000]              Serve site at http://localhost:8000                 '
	@echo '    make uninstall                      Uninstall python dependencies'

check-python:
ifndef TESTPYTHON
	$(error $(PYTHON) not found. Abording)
endif

check-venv:
	test -s $(ACTIVATE) || { echo "$(ACTIVATE) not found. Run make install first"; exit 1; }

install: check-python
	@echo -n 'Building python virtual environment...                       '
	$(PYTHON) -m venv $(VENVDIR)
	@echo 'Done'
	@echo -n 'Sourcing Python virtual environment...                       '
	. $(ACTIVATE)
	@echo 'Done'
	@echo -n 'Upgrading pip...                                             '
	$(PIP) install --upgrade pip > /dev/null
	@echo 'Done'
	@echo 'Installing Python dependencies inside virtual environment... '
	$(PIP) install -e . > /dev/null
	PIPENV_VERBOSITY=-1 $(PIPENV) install $(PIPENVOPTS)
	@echo '                                                             Done'

uninstall:
	@echo -n 'Uninstall python files...                                     '
	$(RM) -rf $(VENVDIR)
	$(RM) -rf $(PYCACHE)
	@echo 'Done'

build: check-venv
	. $(ACTIVATE)
	$(NIKOLA) build

post: check-venv
	. $(ACTIVATE)
	$(NIKOLA) new_post -f markdown

page: check-venv
	. $(ACTIVATE)
	$(NIKOLA) new_page -f markdown

clean: check-venv
	[ ! -d $(OUTPUTDIR) ] || rm -rf $(OUTPUTDIR)

serve: check-venv
	. $(ACTIVATE)
	$(NIKOLA) auto -p $(PORT)


.PHONY: help check-python check-venv install uninstall build clean serve
.SILENT: help check-python check-venv install uninstall build clean serve
.ONESHELL:

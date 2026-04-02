SHELL := /bin/bash

REPO_SOURCE ?= $(CURDIR)
SKILL ?= *
AGENTS ?= codex openclaw

.PHONY: help install install-all sync-codex list-skills

help:
	@printf "Targets:\n"
	@printf "  make install [SKILL=prompt-authoring] [AGENTS=\"codex openclaw\"] [REPO_SOURCE=%s]\n" "$(CURDIR)"
	@printf "  make install-all\n"
	@printf "  make sync-codex [SKILL=prompt-authoring]\n"
	@printf "  make list-skills\n"

install:
	@REPO_SOURCE="$(REPO_SOURCE)" SKILL="$(SKILL)" AGENTS="$(AGENTS)" ./scripts/install-global.sh

install-all:
	@REPO_SOURCE="$(REPO_SOURCE)" SKILL="*" AGENTS="$(AGENTS)" ./scripts/install-global.sh

sync-codex:
	@./scripts/sync-codex-skills.sh "$(SKILL)"

list-skills:
	@find "$(CURDIR)/skills" -mindepth 1 -maxdepth 1 -type d -exec test -f "{}/SKILL.md" ';' -print | xargs -n 1 basename

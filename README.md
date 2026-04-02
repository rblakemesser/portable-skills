# Portable Skills

Personal portable skill repository for `rblakemesser`.

Current packaged skills:
- `prompt-authoring`
- `agents-md-authoring`
- `skill-authoring`

Repo layout:
- `skills/<skill-name>/...` contains each portable skill payload
- `scripts/install-global.sh` installs repo skills with the upstream `skills` manager
- `scripts/sync-codex-skills.sh` links installed skills into `~/.codex/skills`
- `Makefile` wraps the common install and sync flows

The initial `prompt-authoring` payload was copied from:
- `/Users/blake/.agents/skills/prompt-authoring`

## Usage

Clone the repo on another machine, then install everything:

```bash
git clone git@github.com:rblakemesser/portable-skills.git
cd portable-skills
make install
```

Install a single skill:

```bash
make install SKILL=prompt-authoring
```

Only refresh the Codex symlinks after an install:

```bash
make sync-codex
```

Useful overrides:

```bash
make install AGENTS="codex"
make install REPO_SOURCE=git@github.com:rblakemesser/portable-skills.git
```

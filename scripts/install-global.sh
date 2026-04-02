#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd -- "$script_dir/.." && pwd)"

repo_source="${REPO_SOURCE:-$repo_root}"
skill_selector="${SKILL:-*}"
agents="${AGENTS:-codex openclaw}"

declare -a agent_args=()
for agent in $agents; do
  agent_args+=(-a "$agent")
done

npx skills add "$repo_source" -g "${agent_args[@]}" --skill "$skill_selector" -y

if [[ "$skill_selector" == "*" ]]; then
  "$script_dir/sync-codex-skills.sh"
else
  "$script_dir/sync-codex-skills.sh" "$skill_selector"
fi

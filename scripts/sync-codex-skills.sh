#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd -- "$script_dir/.." && pwd)"

agents_skills_dir="${AGENTS_SKILLS_DIR:-$HOME/.agents/skills}"
codex_home="${CODEX_HOME:-$HOME/.codex}"
codex_skills_dir="${CODEX_SKILLS_DIR:-$codex_home/skills}"

declare -a skill_names=()

if [[ "$#" -gt 0 ]]; then
  for skill_name in "$@"; do
    if [[ ! -f "$repo_root/skills/$skill_name/SKILL.md" ]]; then
      echo "Unknown repo skill: $skill_name" >&2
      exit 1
    fi

    skill_names+=("$skill_name")
  done
else
  while IFS= read -r skill_dir; do
    skill_names+=("$(basename "$skill_dir")")
  done < <(find "$repo_root/skills" -mindepth 1 -maxdepth 1 -type d -exec test -f "{}/SKILL.md" ';' -print | sort)
fi

if [[ "${#skill_names[@]}" -eq 0 ]]; then
  echo "No repo skills found under $repo_root/skills" >&2
  exit 1
fi

mkdir -p "$codex_skills_dir"

declare -a linked=()
declare -a skipped=()
declare -a missing=()

for skill_name in "${skill_names[@]}"; do
  source_dir="$agents_skills_dir/$skill_name"
  target_dir="$codex_skills_dir/$skill_name"

  if [[ ! -e "$source_dir" ]]; then
    missing+=("$skill_name")
    continue
  fi

  if [[ -L "$target_dir" ]]; then
    if [[ "$(readlink "$target_dir")" == "$source_dir" ]]; then
      skipped+=("$skill_name")
      continue
    fi

    echo "Conflict: $target_dir already points somewhere else" >&2
    exit 1
  fi

  if [[ -e "$target_dir" ]]; then
    echo "Conflict: $target_dir already exists and is not a managed symlink" >&2
    exit 1
  fi

  ln -s "$source_dir" "$target_dir"
  linked+=("$skill_name")
done

if [[ "${#linked[@]}" -gt 0 ]]; then
  printf 'Linked into %s:\n' "$codex_skills_dir"
  printf '  %s\n' "${linked[@]}"
fi

if [[ "${#skipped[@]}" -gt 0 ]]; then
  printf 'Already linked:\n'
  printf '  %s\n' "${skipped[@]}"
fi

if [[ "${#missing[@]}" -gt 0 ]]; then
  printf 'Missing from %s:\n' "$agents_skills_dir" >&2
  printf '  %s\n' "${missing[@]}" >&2
  exit 1
fi

#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

found=0
failed=0

while IFS= read -r skill_md; do
  skill_dir="$(dirname "$skill_md")"

  found=1

  skill_name="$(basename "$skill_dir")"
  refs_dir="$skill_dir/references"

  echo "Checking reference index for $skill_name"

  if [ ! -d "$refs_dir" ]; then
    # Skills without references/ and without reference links are valid (e.g. index skills)
    if grep -qE '\./references/[^)]*\.md' "$skill_md"; then
      echo "ERROR: $skill_name has reference links in SKILL.md but no references directory at $refs_dir" >&2
      failed=1
    fi
    continue
  fi

  listed_tmp="$tmp_dir/$skill_name.listed"
  actual_tmp="$tmp_dir/$skill_name.actual"

  { grep -oE '\./references/[^)]*\.md' "$skill_md" || true; } \
    | sed 's#^\./references/##' \
    | sort > "$listed_tmp"

  find "$refs_dir" -maxdepth 1 -type f -name '*.md' -exec basename {} \; \
    | sort > "$actual_tmp"

  duplicate_listings="$(uniq -d "$listed_tmp" || true)"
  if [ -n "$duplicate_listings" ]; then
    echo "ERROR: duplicate reference entries in $skill_md" >&2
    while IFS= read -r ref; do
      [ -n "$ref" ] || continue
      echo "  - ./references/$ref" >&2
    done <<< "$duplicate_listings"
    failed=1
  fi

  missing_on_disk="$(comm -23 "$listed_tmp" "$actual_tmp" || true)"
  if [ -n "$missing_on_disk" ]; then
    echo "ERROR: references listed in $skill_md but missing on disk" >&2
    while IFS= read -r ref; do
      [ -n "$ref" ] || continue
      echo "  - $refs_dir/$ref" >&2
    done <<< "$missing_on_disk"
    failed=1
  fi

  orphaned_on_disk="$(comm -13 "$listed_tmp" "$actual_tmp" || true)"
  if [ -n "$orphaned_on_disk" ]; then
    echo "ERROR: reference files exist on disk but are not listed in $skill_md" >&2
    while IFS= read -r ref; do
      [ -n "$ref" ] || continue
      echo "  - $refs_dir/$ref" >&2
    done <<< "$orphaned_on_disk"
    failed=1
  fi

  while IFS= read -r ref; do
    [ -n "$ref" ] || continue

    if grep -n 'Sub-lenses:' "$refs_dir/$ref" >/dev/null; then
      echo "ERROR: stale combined-lens marker found in $refs_dir/$ref" >&2
      grep -n 'Sub-lenses:' "$refs_dir/$ref" | sed 's/^/  /' >&2
      failed=1
    fi
  done < "$actual_tmp"
done < <(find skills -name SKILL.md -type f)

if [ "$found" -eq 0 ]; then
  echo "ERROR: no skill directories with SKILL.md found under skills/" >&2
  exit 1
fi

if [ "$failed" -ne 0 ]; then
  exit 1
fi

echo "Reference index checks passed."
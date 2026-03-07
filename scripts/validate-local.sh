#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

require_cmd() {
  local cmd="$1"

  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "ERROR: missing required command: $cmd" >&2
    exit 1
  fi
}

require_cmd claude
require_cmd skills-ref

echo "==> Validate reference index"
bash ./scripts/validate-reference-index.sh

echo "==> Validate Claude plugin packaging"
claude plugin validate .

echo "==> Validate Agent Skills"
found=0
for dir in skills/*; do
  if [ -d "$dir" ] && [ -f "$dir/SKILL.md" ]; then
    found=1
    echo "Validating $dir"
    skills-ref validate "$dir"
  fi
done

if [ "$found" -eq 0 ]; then
  echo "ERROR: no skill directories found under skills/" >&2
  exit 1
fi

echo "All local validation checks passed."
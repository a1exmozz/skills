#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

git rev-parse --is-inside-work-tree >/dev/null 2>&1
git config core.hooksPath .githooks

echo "Configured git hooks path to .githooks"
echo "Pre-push will now run ./scripts/validate-local.sh"
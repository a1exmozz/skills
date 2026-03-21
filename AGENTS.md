# AGENTS.md

Guidelines for AI agents working in this repository.

## Where things go

- User-facing overview: `README.md`
- Maintainer / contributor / agent notes: this file
- Skills: `skills/<name>/`

Keep skill content in the skill directory.

## Validation

- Main local gate: `./scripts/validate-local.sh`
- Agent Skills: `skills-ref validate <skill-dir>`
- Hook install: `./scripts/install-git-hooks.sh`

## Writing style

- Prefer constraints + checks over step-by-step recipes.
- If a sequence matters, keep it short and explicit.
- Avoid duplicating the same rule in multiple files.
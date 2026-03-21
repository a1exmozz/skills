# skills

Portable software engineering skills for tools that support the [Agent Skills](https://agentskills.io/) standard.

## Install with `npx skills`

```bash
# List available skills
npx skills add a1exmozz/skills --list

# Install one skill
npx skills add a1exmozz/skills --skill audit-codebase-integrity
```

This installs into the right skills directory for the target agent. For supported agents and install targets, see [`npx skills add --help`](https://github.com/vercel-labs/skills).

## Local validation

```bash
./scripts/validate-local.sh
```

This runs:

- reference index validation: `scripts/validate-reference-index.sh`
- Agent Skills validation for every skill under `skills/`

To install the repo hook:

```bash
./scripts/install-git-hooks.sh
```

## Current skills

| Skill | Description |
|---|---|
| [audit-codebase-integrity](skills/audit-codebase-integrity/) | Integrity audit across 19 focused lenses covering data, contracts, timing, tests, state, reliability, failure handling, security, caches, migrations and time/locale behavior. |

## License

[MIT](LICENSE)
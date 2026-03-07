# skills

Portable software engineering skills for tools that support the [Agent Skills](https://agentskills.io/) standard.

## Install with `npx skills`

```bash
# List available skills
npx skills add a1exmozz/skills --list

# Install one skill
npx skills add a1exmozz/skills --skill code-correctness
```

This installs into the right skills directory for the target agent. For supported agents and install targets, see [`npx skills add --help`](https://github.com/vercel-labs/skills).

## Install as a Claude Code plugin

This repo is also published as a Claude Code plugin and as a self-hosted marketplace.

### From GitHub

```text
/plugin marketplace add a1exmozz/skills
/plugin install a1exmozz-skills@a1exmozz
```

### From a local checkout

```text
/plugin marketplace add ./path/to/skills
/plugin install a1exmozz-skills@a1exmozz
```

This exposes the skills under the plugin namespace:

```text
/a1exmozz-skills:code-correctness [scope]
```

## Local validation

```bash
./scripts/validate-local.sh
```

This runs:

- reference index validation: `scripts/validate-reference-index.sh`.
- Claude plugin packaging validation
- agent Skills validation for every skill under `skills/`

To install the repo hook:

```bash
./scripts/install-git-hooks.sh
```

## Current skills

| Skill | Description |
|---|---|
| [code-correctness](skills/code-correctness/) | Correctness review across 19 focused lenses covering data, contracts, timing, tests, state, reliability, failure handling, security, caches, migrations, and time/locale behavior. |

## License

[MIT](LICENSE)
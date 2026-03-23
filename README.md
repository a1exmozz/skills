# skills

Portable software engineering skills for tools that support the [Agent Skills](https://agentskills.io/) standard.

## Install with `npx skills`

```bash
# List available skills
npx skills add a1exmozz/skills --list

# Install one skill
npx skills add a1exmozz/skills --skill audit-codebase-integrity

# Install the devflow workflow (brief, map, plan, raise, ship)
npx skills add a1exmozz/skills --skill devflow
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
| [audit-codebase-integrity](skills/audit-codebase-integrity/) | Structured 19-area integrity audit for subtle bugs, design flaws and operational correctness risks. |
| [devflow](skills/devflow/) | Five-stage software delivery workflow: brief, map, plan, raise, ship. Install once to get all stages. |
| [dev-brief](skills/devflow/dev-brief/) | Structured discovery process for starting new work. Aligns on goals, success criteria and key design decisions. |
| [dev-map](skills/devflow/dev-map/) | Turns a Brief into a domain-driven design Map: ubiquitous language, subdomains, bounded contexts and key domain flows. |
| [dev-plan](skills/devflow/dev-plan/) | Turns a Map into a Plan using dependency-aware thin vertical implementation slices. |
| [dev-raise](skills/devflow/dev-raise/) | Turns a Plan into dependency-aware beads issues. |
| [dev-ship](skills/devflow/dev-ship/) | Implement beads issues using test-driven development. |

## License

[MIT](LICENSE)
# Beads Cheat Sheet

## Daily flow

```bash
br ready
br show <id>
br update <id> --status in_progress
br comments add <id> "Progress note"
br close <id> --reason "What changed"
br sync --flush-only
git add .beads/ && git commit -m "Update issues"
```

## Where data lives

```text
.beads/beads.db      primary working DB
.beads/issues.jsonl  git-friendly export/import file
.beads/config.yaml   project config
```

## Create work

```bash
br create "Fix login timeout" --type bug --priority 1
br create "Implement auth" --type feature --priority 1
```

- priority: `0` critical -> `4` backlog

## Inspect work

```bash
br show bd-abc123
br list --status open --priority 0-1
br list --json
br search "auth"
```

## See what to work on next

```bash
br ready
br blocked
br stale --days 30
```

## Update while working

```bash
br update bd-abc123 --status in_progress
br update bd-abc123 --assignee "$(git config user.email)"
br update bd-abc123 --priority 0
```

## Change status

```bash
br close bd-abc123 --reason "Implemented and tested"
br reopen bd-abc123
br delete bd-abc123
```

## Labels

```bash
br label add bd-abc123 backend auth urgent
br label remove bd-abc123 urgent
br label list bd-abc123
br label list-all
```

## Comments

```bash
br comments add bd-abc123 "Found root cause"
br comments list bd-abc123
```

## Dependencies

```bash
br dep add bd-child bd-parent
br dep remove bd-child bd-parent
br dep list bd-child
br dep tree bd-child
br dep cycles # checks bad dependency loops
```

## Reporting

```bash
br count --by status
br count --by priority
br stats # project summary
```

## Sync rules

DB is primary while you work.
JSONL is for git exchange.

After local changes, export DB -> JSONL:

```bash
br sync --flush-only
git add .beads/
git commit -m "Update issues"
```

After `git pull`, import JSONL -> DB:

```bash
br sync --import-only
```

Check state first if unsure:

```bash
br sync --status
```

Daily rule:
- before commit: `br sync --flush-only`
- after pull/merge: `br sync --import-only`

## Troubleshooting

### Database locked (another process probably has the DB open)

```bash
pgrep -f "br "
br sync --status
```

### Issue not found

```bash
br show bd-abc123
br list | grep -i "abc"
br search "part of title"
```

### Stale database

```bash
br sync --status
br sync --import-only
```

If local state and JSONL diverged, import again.

### After git merge conflicts in `.beads/issues.jsonl`

```bash
git status .beads/
# resolve issues.jsonl conflicts manually
git add .beads/issues.jsonl
br sync --import-only
```

## Config

```bash
br config list
br config get id.prefix
br config set defaults.priority=1
br config edit
```

Minimal useful config example:

```yaml
id:
  prefix: "proj"
defaults:
  priority: 2
  type: "task"
  assignee: "team@example.com"
```

## env vars worth knowing

```text
BD_DB / BD_DATABASE   override DB path
BEADS_JSONL           override JSONL path
RUST_LOG              logging level
```


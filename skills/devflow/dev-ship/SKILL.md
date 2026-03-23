---
name: dev-ship
description: "Implement beads issues using test-driven development. Use after 'dev-raise'. Use when the user has open beads issues and wants to start coding."
---

# Follow these steps in order, one at a time.

1. Read the [cheat sheet](./references/beads-cheat-sheet.md) to understand how beads works.
2. Locate the `.beads/` directory and `cd` into the directory that contains it.
3. Run `br list`
4. Run `br ready` to see which issues are unblocked.
5. Pick the next unblocked issue and run `br update <id> --status in_progress`.
6. Read the issue's "Implementation rules" section. These rules apply to every line of code you write.
7. For each acceptance criterion in the issue, follow one [red, green refactor loop](./references/red-green-refactor.md) cycle: failing test → minimum code → green → commit. Do not implement multiple criteria at once.
8. Run `br close <id> --reason "<what changed>"`.
9. Run `br sync --flush-only`, then `git add .beads/` and commit.
10. Repeat from step 1 until all issues are completed.

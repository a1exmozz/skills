---
name: dev-raise
description: "Turns a Plan into dependency-aware beads issues. Use after 'dev-plan' and before 'dev-ship'. Use when the user has a completed Plan and wants to create trackable issues."
---

# Follow these steps in order, one at a time.

## Input

1. If there is no `Plan` at `.devflow/dev-plan.md` in the repository root. Ask for the completed `Plan`.
2. _After_ receiving the `Plan`, read the [cheat sheet](./references/beads-cheat-sheet.md) to understand how beads works.
3. Read the rules below for how we will convert the `Plan` into beads issues.

### Rules

- Convert each slice from 'Section 4: Slice Breakdown' into an epic.
- `br create "<Slice Name>" --type epic --priority <P> --labels "<context labels>"`
- Create child issues under each epic using `--parent <epic-id>`.
- Each child issue must represent one smallest executable observable behavior that can be implemented and proved through the supported entry points.
- Write each child issue description using the [issue template](./references/issue-template.md).
- Order child issues so the simplest happy-path behaviour comes first.
- Child issues must be suitable for TDD red-green-refactor execution.
- Every child issue description must include the "Implementation rules" section verbatim from the issue template.
- The "Validation approach" section must include at least one automated test assertion.
- Add blocking dependencies with: `br dep add <blocked-id> <blocking-id>`
- Use 'Section 5: Delivery Sequence Summary' to add dependencies between epics in execution order.
- Use labels to encode bounded context and issue category.

## Output

1. Init with beads:

```bash
cd my-project
br init
```

2. Turn the entire `Plan` into beads issues.
3. _After_ turning the plan into beads issues, inform the user and list them with `br list`.

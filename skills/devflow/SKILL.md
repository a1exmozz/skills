---
name: devflow
description: "Five-stage software delivery workflow: dev-brief (discover goals), dev-map (domain design), dev-plan (slice into work), dev-raise (create issues), dev-ship (TDD implementation)."
---

# Follow these steps in order, one at a time.

## Input

- Ask the user which stage they want to run. Inform them that they should ideally start a new context window for each stage and then run that stage manually eg. `/dev-brief`.

## Stages

| Stage | Skill                             | Input        | Output       |
| ----- | --------------------------------- | ------------ | ------------ |
| 1     | [dev-brief](./dev-brief/SKILL.md) | Conversation | Brief        |
| 2     | [dev-map](./dev-map/SKILL.md)     | Brief        | Map          |
| 3     | [dev-plan](./dev-plan/SKILL.md)   | Map          | Plan         |
| 4     | [dev-raise](./dev-raise/SKILL.md) | Plan         | Beads issues |
| 5     | [dev-ship](./dev-ship/SKILL.md)   | Beads issues | Working code |

## Rules

- Each stage produces an artifact that the user should review before proceeding to the next.
- If the user already has an artifact (Brief, Map, Plan or beads issues), direct them to the appropriate next stage.

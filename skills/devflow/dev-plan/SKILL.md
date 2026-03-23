---
name: dev-plan
description: "Turns a Map into a Plan using dependency-aware thin vertical implementation slices. Use after 'dev-map' and before 'dev-raise'. Use when the user has a completed Map and wants to break it into ordered slices."
---

# Follow these steps in order, one at a time.

## Input

1. If there is no `Map` at `devflow/dev-map.md` in the repository root. Ask for the completed `Map`.

## Output

1. _After_ receiving the `Map`, produce the `Plan` using the template [here](./references/plan-template.md). Filling in every section, including all [placeholder text].
2. Save the completed `Plan` to `devflow/dev-plan.md` in the repository root.

### Questions

1. _If_ any unresolved ambiguity would change slice boundaries, dependencies or acceptance criteria: ask about it. Otherwise, give the user a link to the `Plan`

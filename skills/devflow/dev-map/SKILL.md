---
name: dev-map
description: "Turns a Brief into a Map using domain-driven design: ubiquitous language, subdomains, bounded contexts, context map, key domain flows, per-context design and architecture decisions. Use after 'dev-brief' and before 'dev-plan'. Use when the user has a completed Brief and wants to map out the domain."
---

# Follow these steps in order, one at a time.

## Input

1. If there is no `Brief` at `.devflow/dev-brief.md` in the repository root. Ask for the completed `Brief`.

## Output

1. _After_ receiving the `Brief`, produce the `Map` using the template [here](./references/map-template.md). Filling in every section, including all [placeholder text].
2. Save the completed `Map` to `.devflow/dev-map.md` in the repository root.

### Questions

1. _If_ any unresolved ambiguity would change a subdomain, context, relationship or flow: ask about it. Otherwise, give the user a link to the `Map` and provide a concise summary of it.

---
name: dev-brief
description: "Structured discovery process for starting new work. Aligns on goals, success criteria, and key design decisions through a two-phase interview: goal clarification then systematic resolution of design questions with options, tradeoffs and recommendations. Use when kicking off a new project or feature."
---

# Follow these instructions in order, one at a time.

## Vibe Check

1. Ask: "What are we doing and why?"
2. Restate the goal in your own words, then ask: "Is this correct?"
3. Ask: "What does success or 'good enough' look like?"

## Questions

1. Identify key design questions, prioritising the most constraining or irreversible decisions. Output the full list under "Key Design Questions".
2. For each, ask whether it is a real constraint, a preference, or process baggage. Remove or downgrade anything that doesn't materially affect the design.
3. Research answers yourself before asking any.
4. For each remaining question, ask one at a time and:
   i. State the design question clearly
   ii. Present 3 viable options
   iii. Give your recommendation with reasoning
   iv. List the main tradeoffs
   v. State whether the decision is reversible or hard to unwind
   vi. If confidence is low, say so and explain how the uncertainty should be resolved
5. Treat answers as provisional decisions, not fixed doctrine. Revisit earlier decisions if later answers materially change the design.
6. Review decisions for ambiguity, conflicts, hidden dependencies, or unnecessary constraints. Ask clarifying follow-ups.

## Output

1. _After_ completing the above, produce the `Brief` using the template [here](./references/brief-template.md).
2. Save the `Brief` to `.devflow/dev-brief.md` in the repository root. Create the directory if needed.

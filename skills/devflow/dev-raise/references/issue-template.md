# Beads Issue Description Template
> *Replace all [bracketed placeholders] with real content for each issue.*

## Objective
- [One observable behavior this issue adds or changes]

## Public interface
- [Function / endpoint / command / UI action / event handler]

## Trigger / input
- [What starts this behavior]

## Observable outcome
- [What the caller/user can observe when it works]

## Key rules / invariants
[Rules that must hold]
[Include: what properties of input must be preserved in output and what all the boundary/edge cases are]

## Scope
- [What is included to make this behavior work]

## Out of scope
- [What is intentionally excluded]

## Dependencies
- [Blocking prerequisites]

## Validation approach
- [Automated test that proves this behavior — always required, never omit this]
- [For visual behavior: use available tools (screenshots, browser automation etc.) to verify: do not leave visual validation to manual inspection]

## Acceptance criteria
- [Happy-path behavior works]
- [Each invariant and edge case from above is verified]

## Implementation rules
> *Copy this section verbatim into every issue — do not edit or remove.*

- Write ONE failing test before ANY production code.
- Confirm the test fails for the RIGHT reason (assertion, not syntax/import error).
- Write MINIMUM code to pass that one test only.
- If a test passes immediately, the behavior already exists or the test is wrong. Investigate which. If the behavior exists, delete the test and move to the next acceptance criterion. If the test is wrong, fix it until it fails for the right reason, then continue.
- Each acceptance criterion above is a separate RED-GREEN cycle.
- Test observable outcomes, not implementation mechanisms. If the behavior is "prints X and exits," assert X appeared and exit was clean — do not just assert an internal function raised or returned.
- If a behavior seems untestable, test what your code produces rather than what an external system does with it, test through a higher-level caller or test through the system's supported external interface. Do not skip the test.
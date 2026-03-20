# Single Source of Truth

Related lenses: [Global State](./global-state.md), [Schema Evolution](./schema-evolution.md)

## Terms

- same rule: same decision procedure or semantic contract, even if expressed in different layers or languages
- authority: place where that rule is defined
- consumers: every path or workflow that depends on the rule
- forked truth: correctness depends on multiple copies staying aligned

## Review points

### 1. Classify the rule before choosing authority

Common cases: business policy, validation, mapping and serialization, security policy and derived computation.

Preferred authorities: domain module or policy service; shared schema or validators with server authority; schema or IDL plus generation and fixtures; server-side security evaluation; and one authoritative implementation or persisted derivation with provenance.

### 2. Use the smallest authority that prevents drift

A single authority can be a shared module, service, schema or IDL, data-layer constraint or generated or computed column. Do not centralize more than needed.

### 3. Some duplication is acceptable; silent divergence is not

Usually acceptable: client-side validation only for quick feedback, generated duplication from one source and temporary compatibility shims with drift checks.

Not acceptable: client-side authorization as authority, duplicated authorization logic that can drift, financial or policy computation duplicated without compatibility checks and protocol handling with divergent edge cases.

### 4. Version skew can create effective drift

If old and new consumers coexist, define the skew window, use additive-first contract changes and verify compatibility with canonical fixtures or golden vectors.

### 5. Tests must not become a rival authority

Flag tests reimplementing the algorithm under test, expected values produced by the same logic as production and fixtures encoding business rules with no known owner.

Prefer curated canonical examples, invariants and differential tests during replacement work.

### 6. Config semantics can fork too

If multiple components interpret the same config differently, the config has forked truth.

Shared config needs one evaluator or one executable specification with explicit schema and precedence rules.

## Temporary duplication

Temporary duplication is acceptable only if the duplicate rule is named, one owner is responsible, drift is measurable, scope is bounded, the sunset condition is clear and new clones are blocked during cleanup.

## Accept only if

- the authority is identifiable
- consumers are identifiable
- two valid paths cannot silently return different answers for the same input
- supported version skew is intentional and safe
- tests validate the authority rather than clone it

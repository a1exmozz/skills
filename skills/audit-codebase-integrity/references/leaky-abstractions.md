# Leaky Abstractions

Related lenses: [Contract Invariants](./contract-invariants.md), [Single Source of Truth](./single-source-of-truth.md)

## Review points

### 1. Safe usage should be the easy path

Flag APIs that require a hidden order, setup step or ritual.

Prefer:
- one safe operation instead of a fragile sequence
- builders, typed state transitions, scoped resource management or explicit handles

If callers need to read internals to use the API safely, the boundary is weak.

### 2. Thin wrappers need an honest contract

A pass-through wrapper is fine if it is explicit about being a pass-through.

It is not a useful abstraction if it only renames vendor calls while still forcing callers to understand vendor error modes, retry rules or quirks.

Stronger boundaries are needed when callers need domain outcomes, stability across vendor changes or insulation from vendor behavior.

### 3. Public constraints are fine; hidden rituals are not

It is fine to expose explicit, stable constraints such as consistency model, latency or cost class, rate limits, retry safety, idempotency requirements, ordering guarantees or pagination rules.

A leak exists when callers must discover these by accident or infer them from implementation details.

### 4. Do not leak required protocol knowledge

Flag:
- sentinel values that trigger internal modes
- callers forced to close, flush, finalize or commit with no scoped enforcement
- "if you see error X, do Y" when the owning layer could do Y
- undocumented polling rituals for long-running work

Prefer a single operation, explicit state models, language-appropriate scoped cleanup or job handles, status resources, streams, callbacks or webhooks for long-running work.

### 5. Keep observability without breaking the boundary

When callers or tests reach into internals, the public surface is too opaque.

Prefer status or probe APIs, structured logs in domain terms, metrics for externally meaningful states and correlation IDs that cross boundaries.

Observability should describe contract-visible reality, not force inspection of wiring.

## Temporary exceptions

A temporary boundary leak is acceptable only if it states what is exposed, who may depend on it, guardrails, how usage is measured, the compatibility plan during migration and the removal condition.

## Accept only if

- callers can use the boundary safely without reading internals
- required constraints are explicit and stable
- cleanup, retries and long-running behavior are encoded in the contract, not hidden rituals
- observability exists without forcing callers into implementation details

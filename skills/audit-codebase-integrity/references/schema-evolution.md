# Schema Evolution

Related lenses: [Data Representation](./data-representation.md), [Online Migrations](./online-migrations.md)

## Review points

### 1. State the compatibility target

For each change, name the required safe reader and writer pairs, for example old readers reading new writes or new readers reading old writes.

Do not hide behind generic compatibility labels alone.

Each API surface should use one versioning strategy: path versioning, header or content-type versioning, schema ID in payload or envelope or additive-only versionless evolution. For each supported version, define support status, removal policy and discovery path.

### 2. Additive first

Default plan: add the new field, endpoint, event or variant; teach consumers to handle old and new forms; deprecate the old form with visible signals; then remove only after usage evidence says it is safe.

### 3. Semantic changes are breaking changes

Shape staying the same does not make a change safe.

If meaning changes, use a new field, new event type, new version or new representation.

### 4. Unknown and optional data need explicit handling

Consumers should tolerate unknown fields and missing optional fields where the format allows it.

Unknown values must not be collapsed into a normal business value. If round-trip fidelity matters, preserve unknown fields where possible or provide an opaque passthrough map.

### 5. Deprecation is not done until it is measured

A deprecated field, endpoint or event needs documented support policy, measurable usage, caller-visible migration signal where practical and a removal condition or long-term-support decision.

Useful checks: consumer-driven contract tests, provider-side compatibility tests against locked fixtures, schema-registry validation in CI and golden vectors tied to a published baseline.

### 6. Events are published APIs

Event contracts need explicit versioning or schema identity, a policy for unknown event types, stable meaning and compatibility validation in CI and release review.

### 7. Assume mixed versions

Skew, lag, stale readers and stale writers are normal.

Flag plans that assume synchronized rollout, immediate convergence, instant backfill completion or consumers updating before providers ship breaking changes.

### 8. Use expand, migrate, contract

When old and new code coexist: expand with a form old code tolerates, migrate while both forms stay valid and contract only after evidence says the old path is unused.

Before contract, require expand complete everywhere that can serve traffic, overlap verified, cutovers staged and monitored and telemetry evidence rather than code search alone.

### 9. Format-specific checks

Protocol Buffers and gRPC: never reuse field numbers, never change wire type, reserve removed numbers and names, treat enum growth as a compatibility event and prefer additive changes.

JSON and REST: do not remove or rename fields without deprecation, keep new response fields optional for existing clients, avoid making new request fields mandatory unless safely defaulted or versioned, define `null`, absent and empty semantics and do not change units, timezone rules or identifier meaning in place.

Avro and schema registry: register and validate schemas before publishing, state compatibility in reader and writer terms, provide defaults where needed and do not treat registry mode as a substitute for semantic review.

Events and messages: include explicit schema identity or equivalent, define policy for unknown event types, keep event meaning stable and do not silently drop fields in transformation pipelines when downstream compatibility depends on them.

## Temporary exceptions

If a breaking change is unavoidable, require what breaks, who is affected, migration path, bounded coexistence window, visibility and exit plan.

## Accept only if

- required reader and writer pairs stay safe during rollout and support
- the change is additive first or properly versioned
- semantic changes use new fields, versions or representations
- unknown values are handled safely
- deprecations are measured and policy-backed
- mixed versions can coexist safely

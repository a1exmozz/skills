# Global State

Related lenses: [Flag Debt](./flag-debt.md), [Single Source of Truth](./single-source-of-truth.md)

## Terms

- ambient state: state code can observe without that dependency appearing in the local API
- owner: component that initializes, mutates, validates and tears down mutable state
- snapshot: immutable value published to readers

## Review points

### 1. Hidden mutable context is a correctness risk

Flag unrelated code changing behavior through shared state, import order affecting behavior, tests that pass alone but fail in suite and functions depending on invisible current user, tenant, locale or timezone.

Hidden mutable ambient state should not be authoritative for business correctness.

### 2. Every mutable state needs one owner

One owner should define initialization, invariants, mutation rules, lifecycle and teardown.

Everyone else should get snapshots, read-only views or narrow capability methods.

### 3. Make dependencies explicit

Prefer constructor injection, parameter injection, small typed context objects and factory or builder wiring at the composition root.

Avoid service-locator lookups in business logic.

### 4. Default immutable, mutate locally, publish snapshots

Flag functions mutating input parameters, shared maps or lists handed to multiple consumers and memoization implemented by mutating domain objects.

Prefer builder then freeze, copy-on-write, returning new values and explicit mutation APIs when mutation is required.

### 5. Initialization must be explicit

Flag imports triggering I/O, env parsing or background work, lazy global init guarded by ad hoc booleans and invalid config discovered after dependent work has already started.

Require explicit initialization, idempotent init where repeated entry is possible, composition-root-owned init order and fail-fast behavior for invalid config.

### 6. Tests should build fresh worlds

Flag teardown that says "reset singleton", test suites that require serial order and tests whose outcome depends on prior state.

Require isolated mutable state, fresh component graphs for testable paths and no cross-test mutation through globals on business-critical paths.

### 7. Shared config globals are a footgun

Prefer immutable config snapshots.

If config changes at runtime, access it through an explicit dependency, scope it, validate it and make it observable. Do not scatter raw global reads throughout the codebase.

## Temporary exceptions

Shared or hidden state is acceptable only if it states what is shared, why it is needed, who may read and write it, the concurrency model, the cleanup path, especially for tests and the exit plan.

## Accept only if

- business behavior does not depend on import order
- required dependencies are visible in constructors, parameters or typed context
- each mutable state has a clear owner
- readers cannot mutate state they do not own
- initialization happens explicitly before dependent work
- tests remain stable in isolation and in parallel

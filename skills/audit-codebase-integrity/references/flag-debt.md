# Flag Debt

Related lenses: [Global State](./global-state.md), [Online Migrations](./online-migrations.md)

## Review points

### 1. Pick the narrowest control that matches the job

Common control types: release flag, kill switch, experiment flag, durable entitlement or capability, operational config and migration bridge flag.

Do not leave rollout scaffolding in place as the permanent product mechanism.

### 2. Define runtime semantics

Each control needs type, default, scope, precedence order, evaluation model and outage behavior. Defaults should be intentional and safe.

If values can change at runtime, state whether mid-request change is allowed. Experiments that affect user-visible behavior usually need sticky assignment.

### 3. Keep the state space small enough to reason about

Prefer one mode enum such as `off | shadow | on` over several booleans.

Flag nested conditionals that combine flags, env vars, tenant overrides and defaults and bugs that appear only under rare combinations. If more than a few controls shape one behavior, require a design note for the allowed state space.

### 4. Validate config before it changes behavior

Require schema or type validation, numeric bounds, enum validation for closed sets, cross-field validation where fields interact and staged rollout and rollback for risky changes.

### 5. Telemetry should explain active behavior

Emit enough signal to distinguish disabled, enabled, partially enabled, degraded and enabled only for some scope.

Keep telemetry bounded. Do not explode cardinality just to explain flag state.

### 6. Persisted-data transitions need an end state

For migration bridge flags, define the target steady state, read and write behavior during overlap, completion criteria and cleanup owner. Do not leave stored data split across formats by accident.

### 7. Release flags are temporary

Temporary rollout flags need a removal condition. Durable config and entitlements still need a review condition.

### 8. Kill switches must reduce risk

A kill switch needs clear purpose, blast radius, owner, tested activation path and verification that activation does not trigger secondary failures such as retry storms or fallback overload.

## Lifecycle

For temporary rollout flags: proposed, implemented, rolling out, locked for a short confirmation window, then removed.

## Temporary exceptions

A flag or config exception is acceptable only if type and purpose are declared, an owner is named, a review or removal condition exists, defaults and outage behavior are documented, observability is sufficient and cleanup is enforceable.

## Accept only if

- each control has a type, owner, lifecycle state and review or removal condition
- default, scope, precedence, evaluation timing and outage behavior are explicit
- unsupported combinations are rejected, guarded or tested
- validation prevents unsafe values
- behavior can be explained from telemetry
- migration bridge flags have completion criteria and cleanup ownership

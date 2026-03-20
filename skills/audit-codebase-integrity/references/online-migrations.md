# Online Migrations

Related lenses: [Schema Evolution](./schema-evolution.md), [Reliability](./reliability.md)

## Review points

### 1. Rollback is not undo

Assume database changes are forward-only unless reversibility is proven.

Good planning includes safe stop points, roll-forward plan, deferred destructive work, read-path or feature gating that can revert safely and tested backup and restore for disaster recovery rather than normal migration flow.

### 2. Online work must be bounded

Flag unbounded full-table updates, long transactions, disruptive locks under traffic, index creation without required online mode and backfills competing with serving traffic with no throttle.

Require bounded batch size and time, health-based throttling, pause and abort conditions and idempotent resumable jobs.

### 3. Backfills must handle concurrent writes

A backfill is not done when the script exits.

Require idempotent batches, persistent checkpoints, resumability, bounded work per batch, throttling, metrics for progress and lag, validation by invariants, counts, samples or checksums and an explicit design for writes landing during the backfill window.

### 4. Migration state must be explicit

Track durable monotonic gates such as schema expanded everywhere, backfill running and verified, concurrent writes reconciled, read cutover staged and monitored, write cutover staged and monitored, old path disabled and contract completed and verified.

Require durable migration state, monotonic transitions, automated gates between phases and a runbook with prechecks, monitors, abort thresholds and roll-forward steps.

### 5. Enforce invariants where the database can help

Prefer `NOT NULL`, `UNIQUE`, foreign keys and `CHECK` constraints where feasible.

Validate existing data before tightening constraints. Triggers are a last resort and require performance testing, lock-impact testing, observability and a removal condition.

### 6. Renames are breaking under skew

If old and new code may coexist, do not rename in place.

Prefer add new representation, migrate readers, migrate writers, verify old readers and writers are gone, then remove the old representation.

### 7. Cutover must follow production evidence

Do not contract based on code search alone, assumptions about deploy order, assumptions that old clients are gone or assumptions that backfill must have finished.

Use telemetry and migration state.

## Minimal procedure

Expand without breaking old code, run the migration with bounded resumable work, capture and reconcile concurrent writes, cut over reads and writes in stages and contract only after evidence shows the old path is unused.

## Temporary exceptions

A risky migration workaround is acceptable only if it states the risk, hard bounds such as throttle, timeout, batch cap or abort threshold, evidence to watch, safe stop point, roll-forward plan, cleanup owner and removal condition.

## Accept only if

- online work is bounded, throttled, idempotent and resumable
- lock behavior, transaction time and replication impact are understood
- concurrent writes during migration are captured or reconciled
- migration state is explicit and durable
- cutover is based on telemetry

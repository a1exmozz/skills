# Idempotency

Related lenses: [Reliability](./reliability.md), [Silent Failure](./silent-failure.md)

## Review points

### 1. Exactly once is not the transport default

Do not rely on exactly-once delivery, clients never retrying, FIFO preventing duplicates, timeout implying failure, same message body meaning same intent or "retry with a new ID" after an unknown outcome.

Treat exactly-once as an application-level effect guarantee.

### 2. Classify the operation first

Distinguish natural idempotency from synthetic idempotency. Classify by the real effect, not by the endpoint shape.

### 3. Deduplication keys identify logical intent

Every non-naturally-idempotent operation needs a stable key that is unique per logical operation, stable across retries, different for different intents, scoped correctly and bound to the original request parameters or business intent.

For consumers, prefer message IDs or business operation keys over body equality.

### 4. Record the first outcome durably enough

Store at least the deduplication key, request fingerprint or equivalent intent binding, execution state such as `in_progress`, `succeeded`, `failed` or `unknown`, a response or resolvable outcome reference, timestamps and lease or owner metadata for in-progress work when needed.

Durability should match the cost of duplication.

### 5. Keep failure classes distinct

At minimum, separate pre-execution rejection, definitive business outcome, transient execution failure and unknown outcome.

Do not trap a key forever in a failed state unless that is the explicit contract.

### 6. In-progress means one live execution

A duplicate request must not start a second execution while the first is active.

Valid duplicate behavior during active execution: return `processing`, ask the caller to retry later or wait for completion and return the stored result.

`in_progress` needs recovery: lease expiry, heartbeat, owner token or reconciliation.

### 7. Deduplication windows need a contract

Define how long a key remains valid, whether the window covers realistic retries, redelivery and manual replay and what happens after expiry.

### 8. Timeout means unknown outcome

If the caller cannot prove non-execution, the result is `unknown`, not `failed`.

Require retries to reuse the same key, callers to query final state when sync completion is not guaranteed and caller state to keep `unknown` distinct from `failed`.

Acceptable resolution paths: status endpoint, operation resource, workflow state store, callback or webhook and reconciliation query.

### 9. Workflows need per-step idempotency

For multi-step work, checkpoint steps durably, derive per-step keys from workflow and step identity, make completion checks cheap and define compensation for non-idempotent external effects.

### 10. At-least-once consumers must deduplicate

Consumers must be naturally idempotent or record handled work safely under concurrency.

Prefer business state and processed-message record in one transaction where possible, plus outbox for reliable downstream emission after state change.

## Minimal procedure

Determine the logical operation identity, bind a stable deduplication key to that identity and the original parameters, reserve or look up the key before executing the side effect, execute only if this attempt owns the reservation, persist the final outcome or explicit `unknown` and recover abandoned `in_progress` work using the defined lease or reconciliation rule.

## Temporary exceptions

An idempotency workaround is acceptable only if it states what can duplicate, blast radius, detection, reconciliation path, owner and exit condition.

## Accept only if

- the same logical request with the same key produces one effect
- a duplicate during active execution does not start another execution
- reusing a key with different parameters is rejected
- window-expiry behavior is explicit
- unknown outcomes are visible and resolvable

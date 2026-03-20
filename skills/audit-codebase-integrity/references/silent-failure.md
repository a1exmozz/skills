# Silent Failure

Related lenses: [Reliability](./reliability.md), [Observability Gaps](./observability-gaps.md), [Idempotency](./idempotency.md)

## Outcome model

Cross-boundary operations should expose the relevant states directly: `Success`, `Accepted(tracking)`, `Partial(details)`, `Failed(code)` and `Unknown(tracking)`.

Do not force callers to infer these from logs.

## Review points

### 1. Failure semantics are part of the contract

Flag `ok=true` after dropping work, transport success with business failure hidden in an ad hoc payload unless that is the stated contract and async "it will retry later" with no durable tracking handle.

### 2. Do not swallow exceptions

Caught errors must be propagated, converted to an explicit outcome, retried within a visible budget or compensated with explicit signaling.

Flag `catch { log; continue }` on correctness-sensitive paths, detached async tasks with no error sink and repeated terminal logging at every layer.

### 3. Silent fallback changes meaning

Fallbacks are acceptable only when declared invariants still hold and the degraded path is visible.

Flag `[]` meaning both "no results" and "failed to compute", stale data returned as if current and default values hiding upstream failure.

### 4. Best-effort writes need a receipt

A write path should produce durable success, explicit failure, accepted plus durable tracking handle, structured partial success or explicit unknown outcome.

Flag batch success with hidden item failures, enqueue reported as success even when full queues can drop and timeout treated as definite failure when the real outcome is unknown.

### 5. Retries must not erase the original failure

Require retry only for retryable classes, explicit retry budgets, visible terminal artifact after exhaustion and metrics for retry attempts and exhausted retries.

Timeout or lost acknowledgement means `Unknown` unless non-execution is proven.

### 6. Do not turn errors into empty values

`[]`, `0`, `false`, `null` and similar sentinels should not double as failure markers unless the contract says so and callers can still distinguish the states they need.

### 7. Async work needs a durable error sink

Every async execution context must define where failures go, how operators or callers inspect terminal state, the retry bound and escalation behavior.

## Temporary exceptions

A degraded path may ship only if it states the blind spot or semantic downgrade, risk, bounds, mitigation, missing contract or instrumentation, owner and removal condition.

## Accept only if

- callers can distinguish success, accepted, partial, failed and unknown where needed
- exceptions are not swallowed
- fallback does not silently impersonate success
- retries are bounded and visible after exhaustion

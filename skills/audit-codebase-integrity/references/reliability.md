# Reliability

Related lenses: [Idempotency](./idempotency.md), [Silent Failure](./silent-failure.md)

## Review points

### 1. Bound work before expensive execution

Require concurrency to be capped before costly work starts, queues, pools and in-flight work to have hard limits and saturation behavior to be explicit.

Valid saturation policies: reject, shed, degrade or bounded spill to another path that is itself observable and bounded.

An unbounded in-memory queue is delayed failure, not backpressure.

### 2. Every resource needs ownership and cleanup

Flag cleanup only on the happy path, reliance on GC while native resources are open, pools with no max size or leak detection and background work outliving the parent request with no explicit ownership transfer.

Prefer RAII, `defer`, `try-finally` or context managers, plus central resource creation with limits and instrumentation.

### 3. Every external wait needs a deadline

Require every external call and queue wait to have a deadline, per-hop budgets to be smaller than the end-to-end budget, retries to consume the same budget and cancellation to stop further work and trigger cleanup.

For streams, use idle timeouts, heartbeats, max lifetime and explicit flow control.

### 4. Isolate sick dependencies

Use circuit breakers per dependency or operation class, meaningful trip signals such as timeouts, connect failures or dependency `5xx`, minimum volume before tripping, sane half-open probes and bulkheads with per-dependency concurrency limits.

When a breaker is open, fail fast; do not queue doomed work.

### 5. Retry control matters

Require backoff with jitter, bounded retry count or budget, one retry owner layer and no retries for non-retryable classes.

Never retry side effects unless the operation is duplicate-safe.

### 6. Connection and handle hygiene is part of correctness

Flag one client or pool per request, pool saturation with no acquisition timeout and response bodies or streams left unread and unclosed.

Prefer client reuse, capped pools, acquisition timeouts, explicit close or discard rules and pool instrumentation.

### 7. Observe resource pressure

At minimum, track in-flight requests, queue depth, oldest queued age or enqueue-to-start delay, pool utilization, acquisition wait time and timeouts, deadline counts, breaker transitions, retry counts, memory, file descriptors, open connections and thread or task counts.

Prefer state-transition logs over per-request noise.

## Temporary exceptions

A reliability workaround is acceptable only if it states what can saturate, drop, delay or leak, blast radius, bounds, detection, mitigation or rollback, owner and exit condition.

## Accept only if

- queues, pools and in-flight work are bounded
- saturation behavior is explicit
- every resource has an owner and unskippable cleanup path
- external calls and queue waits have deadlines
- cancellation releases resources promptly
- breakers and bulkheads isolate bad dependencies
- retries are bounded, jittered and owned by one layer
- pressure and leak signals are observable

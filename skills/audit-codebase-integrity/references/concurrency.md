# Concurrency

Related lenses: [Timing Correctness](./timing-correctness.md), [Global State](./global-state.md), [Reliability](./reliability.md)

## Review points

### 1. Pick an ownership model before a primitive

Prefer single-writer or actor ownership, thread or task confinement, immutability with snapshot replacement or shared mutable state behind one documented synchronization boundary.

Do not start with "add a lock" before deciding who owns the state.

### 2. Every cross-thread read and write needs a visibility story

A delay does not create a happens-before edge.

Use primitives that do: lock and unlock, release and acquire atomics, condition variables, semaphores, channels or queues, joins or barriers.

If readers depend on immutable snapshots, publish them through a mechanism that establishes visibility on the target runtime.

### 3. Prefer blocking coordination over busy-wait

Default to condition variables, semaphores, channels, futures or awaitables.

Spinning is acceptable only if the wait is very short, the spin is bounded, there is a fallback to blocking and spin behavior is instrumented.

### 4. Keep locks small and legible

Require a clear statement of what each lock protects, minimal critical sections, no blocking I/O, sleep or `await` while holding an unsafe lock and no arbitrary callback or user code while locked.

A giant lock is acceptable only when measured contention is acceptable and redesign criteria are defined.

### 5. Write down lock ordering

If multiple locks can be held together, define a global order, enforce it in review, assertions or tooling and reject nested locking that violates the order.

### 6. Atomics need a documented protocol

Use locks or message passing when invariants span multiple fields.

If atomics are used, document the publish and consume protocol, memory ordering, lifetime and reclamation strategy for lock-free structures and ABA handling where CAS-based algorithms need it.

Do not use atomic flags in polling loops as hand-rolled condition variables.

### 7. Keep async and blocking separate unless bridged on purpose

Require async-aware primitives in async code, blocking or CPU-heavy work isolated from the event loop, no unsafe `await` while holding a lock and structured-concurrency mechanisms so lifetimes and cancellation are explicit.

### 8. Liveness is part of correctness

Review for deadlock, livelock, starvation, hot locks and shutdown hangs.

Use lock ordering, bounded waits for detection and recovery, fair queues or locks where starvation is plausible and partitioning or sharding where one hotspot dominates. Timeouts detect or bound a hang; they do not fix the underlying bug.

## Minimal procedures

When notification depends on shared state, capture the needed snapshot while holding the lock, release the lock, then notify or call back using the snapshot.

When a timeout exists in a liveness path, wait using the normal synchronization mechanism, emit stacks, lock graph or state on timeout, then fail or recover according to policy.

## Temporary exceptions

A concurrency workaround is acceptable only if it states who may call concurrently, which invariant it protects, how progress is guaranteed or bounded, which diagnostics appear on failure, how contention or timeout rate is measured and the removal condition.

## Accept only if

- ownership of each mutable state is explicit
- each cross-thread or cross-task read or write has a defined synchronization edge
- locks state what they protect
- multi-lock paths follow a documented order
- spinning is bounded and justified
- atomics use a documented protocol
- async code does not block the event loop or await inside unsafe critical sections

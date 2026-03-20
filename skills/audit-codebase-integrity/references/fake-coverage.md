# Fake Coverage

## Review points

### 1. Green must mean something real

A test should fail under a plausible defect in the behavior it claims to check.

Weak signals include "did not crash" as the main assertion, tests that pass under obvious real bugs, mocks that hard-code the answer and snapshots updated without semantic review.

### 2. Flakiness is a bug

Common causes: races, uncontrolled time, nondeterministic ordering, real network or DNS, shared mutable state, leaked environment and parallel tests without isolation.

Bad fixes: sleeps, hidden retries, timeout inflation and quarantine with no path to removal.

Prefer explicit completion conditions, controlled clocks, isolated state per run and hermetic dependencies by default.

### 3. Mock boundaries, not truth

Use mocks for boundaries you do not own or cannot make cheap and deterministic.

Prefer assertions on observable outcomes, fakes that preserve the relevant contract and boundary contract tests where auth, schema, serialization or protocol drift matters.

Be skeptical when a test passes because the mock was told to return the expected result.

### 4. Snapshots are diffs, not proof

Snapshot tests are acceptable only when they are small, stable and intentional.

Also require at least one semantic assertion when correctness matters. Normalize non-semantic fields, sort collections before snapshotting and explain why a snapshot change is correct.

### 5. Default to hermetic tests

Order of preference: in-process or in-memory dependency; local ephemeral dependency; controlled fake server; isolated environment per run; record or replay with strict versioning; real external system only for labeled smoke, E2E, provider-contract, certification or sandbox checks.

If a test is non-hermetic, label it and explain why.

### 6. Assertion strength matters

Every test should assert at least one correctness-relevant invariant such as a domain, structural or behavioral invariant.

### 7. Control nondeterminism

Control time, randomness, ordering and environment. Waiting and timeouts may bound a test; they do not prove correctness.

### 8. Failure output should shorten debugging

A failing test should make the broken invariant obvious.

Useful failure detail includes the invariant, expected versus actual and for waiting tests the last observed state, elapsed time and attempt count.

## Temporary exceptions

A weak or non-hermetic test is acceptable only if the test type is explicit, stronger isolation is not practical or not enough, waiting is bounded, failures are actionable, flake rate is visible and there is an exit condition for replacement or tightening.

## Accept only if

- the test would fail under a plausible real bug
- the test checks production-relevant behavior, not just lack of an exception
- sleeps, retries and timeouts are bounds, not proof
- mocks sit at a boundary rather than replace the truth under test
- snapshots are paired with semantic checks
- relevant nondeterminism is controlled

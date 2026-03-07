---
name: code-correctness
description: "Review code against 19 reference files. Run one pass per reference. Emit one report per reference."
license: MIT
compatibility: "Designed for Agent Skills-compatible coding agents that can inspect repositories and read referenced markdown files."
metadata:
  author: a1exmozz
  version: "1.0.0"
---

# Correctness

Run the review once per reference file. Do not merge lenses.

## Scope

1. If the user names files or directories, use that scope.
2. Otherwise review the whole codebase.

## References

1. [Data Representation](./references/data-representation.md)
2. [Contract Invariants](./references/contract-invariants.md)
3. [Leaky Abstractions](./references/leaky-abstractions.md)
4. [Timing Correctness](./references/timing-correctness.md)
5. [Concurrency](./references/concurrency.md)
6. [Build Reproducibility](./references/build-reproducibility.md)
7. [Fake Coverage](./references/fake-coverage.md)
8. [Flag Debt](./references/flag-debt.md)
9. [Global State](./references/global-state.md)
10. [Idempotency](./references/idempotency.md)
11. [Reliability](./references/reliability.md)
12. [Silent Failure](./references/silent-failure.md)
13. [Observability Gaps](./references/observability-gaps.md)
14. [Security & Trust Boundaries](./references/security-boundaries.md)
15. [Cache & Freshness](./references/cache-freshness.md)
16. [Single Source of Truth](./references/single-source-of-truth.md)
17. [Schema Evolution](./references/schema-evolution.md)
18. [Online Migrations](./references/online-migrations.md)
19. [Time & Locale](./references/time-locale.md)

## Process

1. Pick the review scope.
2. Read one reference file.
3. Review the chosen scope only against that reference.
4. Repeat for every reference file in order.
5. Keep each reference as its own report.
6. If a reference has nothing material, write `No findings`.

## Output

Emit one section per reference, in the same order as the list above.

Each section must include:

- `Reference:` the reference title
- `Scope checked:` files, directories, or areas reviewed for that reference
- `Result:` findings or `No findings`

For each finding, include:

- what is wrong
- evidence
- impact
- recommended fix

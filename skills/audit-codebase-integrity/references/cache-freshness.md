# Cache & Freshness

Related lenses: [Reliability](./reliability.md), [Silent Failure](./silent-failure.md), [Schema Evolution](./schema-evolution.md)

## Review points

### 1. State the read contract

Every cached read path needs a contract for read scope, what may be stale, maximum staleness by time or version and invariants that still hold.

Auth, privacy, entitlements, money and inventory should usually not be stale. Post-save UX should at least give read-your-writes to the saving client or session.

### 2. Cache keys are part of correctness

The key must include every input that can change the result.

Common misses: tenant, org, user, role or auth scope, locale, timezone, currency, request-shaping fields and schema or API version.

Prefer central key construction, version tokens in the key, normalized params and shared base data plus per-user overlay instead of fully personalized cache entries.

### 3. Invalidation is the hard part

Every write that changes what a read should return needs an invalidation or version-advance path.

Flag TTL used where prompt visibility matters, only some write paths invalidating, one cache layer invalidated while another still serves old data and negative caching of "not found" with no safe create-visibility story.

Common approaches: write-through, cache-aside with explicit invalidation, versioned or generation keys and durable event-driven invalidation when fanout must be reliable.

### 4. Serving stale data changes semantics

Stale-on-error and degraded modes are acceptable only under an explicit contract.

Origin failures must not be hidden, `max_stale` must be bounded and degraded responses must not break auth, privacy, revocation, money or inventory rules.

### 5. Stampedes are correctness and reliability issues

Watch for many misses for the same key, synchronized expiry and refresh traffic that amplifies an outage.

Mitigate with jittered TTLs, single-flight or request coalescing, stale-while-revalidate only when the contract allows it and justified pre-warming of hot keys.

### 6. Authorization and privacy override convenience

Never let caches leak data across principals.

Flag shared caches serving user-specific responses, cached personalized renderings without principal-aware keying and slow revocation because cache entries outlive access changes.

### 7. Multi-layer caches need traceability

If multiple layers can serve the response, be able to tell which layer won.

Useful debug fields include `X-Cache-Layer`, `X-Cache`, `X-Data-As-Of` or `X-Data-Version` and `X-Cache-Key-Hash`. Do not expose raw keys or PII.

## Measurements to expect

At minimum: hit and miss rate by endpoint or read class, served-stale rate, invalidation success rate, write-to-invalidation lag, data age distribution and replica lag or watermark where replicas or materialized views are involved.

## Accept only if

- the freshness guarantee is explicit
- the staleness bound or reconciliation rule is explicit
- keying and invalidation are defined
- stale or degraded serving is visible
- cross-principal leakage is blocked

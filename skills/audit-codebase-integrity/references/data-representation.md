# Data Representation

Related lenses: [Schema Evolution](./schema-evolution.md), [Cache & Freshness](./cache-freshness.md)

## Terms

- authoritative source: system of record for a concept
- canonical representation: internal form business logic should use
- derived representation: recomputable copy for indexing, performance or presentation
- trust boundary: where data must be parsed and validated before use
- missing, unknown, invalid and conflicting are distinct states

## Review points

### 1. Meaning must be explicit

Flag overloaded values, special sentinels such as `0`, `-1`, empty string or `NULL`, business logic based on string parsing and product logic keyed to specific IDs.

If legacy ambiguity exists, keep it only for compatibility, add a typed canonical projection, confine parsing to adapters and require business logic to use the canonical form.

### 2. Types are contracts

Where distinctions matter, use distinct types or fields, especially for money, identity, permissions, time, scheduling, lifecycle and state.

Prefer domain types over generic `string` or `int`, named enums over raw codes, tagged unions when only one shape is valid, separate fields when multiple facts may be true and nullable fields only when `null` has one meaning.

### 3. Sentinel values hide state

Common sentinels: `0` for unlimited or none, `-1` for unknown, empty string for missing, `NULL` for several different states and `9999-12-31` for never.

Represent `missing`, `unknown`, `invalid` and `not_applicable` distinctly when product logic depends on the difference.

For partial updates, distinguish field omitted, field set to `null` and field set to a value.

### 4. One field, one concept

Flag `status` driving unrelated subsystems, `type` as ad hoc schema switching, unbounded JSON blobs carrying core semantics and foreign keys whose target kind depends on hidden context.

Prefer explicit status fields, real discriminators for polymorphism and bounded validated JSON only for flexible metadata.

### 5. Codes need ownership and safe unknown handling

Flag raw codes such as `if status == 7`, duplicated code tables and scattered partner mappings.

Require one owner, centralized mappings, shared generation or validation where possible and preservation of unknown external values instead of collapsing them to a meaningful default.

### 6. IDs are identifiers, not policy

Flag behavior keyed to hard-coded IDs such as "admin is 1" or "tenant 999 is special". Special behavior should come from roles, policy or explicit config.

### 7. One authority per concept

For each important concept, define the authoritative source, canonical representation, derived forms and rebuild path. If derived values are stored, record provenance such as rule version, input hash or derivation time.

### 8. Representation changes need transition rules

When old and new forms overlap, define authority, business-logic form, precedence, mismatch handling and removal timing. Use add-first, read-both, remove-last. Do not prefer the new form only because it is present.

### 9. Validation is part of correctness

Validate at every trust boundary using API or consumer validation, ETL checks, storage constraints such as `NOT NULL`, `CHECK`, `FOREIGN KEY` or `UNIQUE` and domain checks in application code.

Flag best-effort coercion, unknown external values mapped to normal business values, partially valid records written for later repair and raw strings re-parsed deep in business logic.

## Canonical rules

Money should use integer minor units plus currency, or exact decimal with explicit scale when variable precision is required. Do not use binary floating point for canonical money.

Time should use UTC instants or explicit epoch fields with units in the name. For wall-clock semantics such as schedules or local dates, store the local value plus IANA time zone when future interpretation depends on civil time.

Identifiers may include prefixes for interoperability, but business logic should not parse identifier strings to recover hidden meaning.

Display strings should not be canonical machine-interpreted storage.

Numeric semantics must match the domain: flag binary float in exact-decimal domains, unchecked overflow, `NaN` or `Infinity` in business logic, implicit rounding, mixed units and exact float equality after approximate math.

## Temporary exceptions

A temporary representation hack is acceptable only if the ambiguity is documented, business logic stays behind a typed canonical layer, unknown values remain safe, visibility exists and removal is planned.

## Accept only if

- each field has one stable meaning
- high-risk concepts use explicit types or equivalent invariant checks
- internal logic consumes validated values
- unknown external values are preserved or surfaced safely
- authoritative and canonical forms are clear
- overlap during transitions has explicit precedence and mismatch handling

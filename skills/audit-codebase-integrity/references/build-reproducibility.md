# Build Reproducibility

## Terms

- release mode: strict mode for verifying or producing release artifacts; exact versions and sources, pinned toolchain, no undeclared network, no hidden host state
- hermetic step: step with no undeclared files, environment, network or host tools
- provenance: evidence of source revision, dependency identities, toolchain, resolver, recipe and builder identity

## Review points

### 1. Same inputs, same build result

A clean checkout with empty caches must build.

Prefer lockfiles or resolved manifests, pinned toolchain and resolver versions, explicit build flags, controlled environment variables and deterministic generators.

Do not rely on `PATH`, `$HOME`, host locale, timezone, umask, filesystem ordering, current time or undeclared network access.

If byte-for-byte identity is not possible, the remaining variance must be named, bounded, justified and checked.

### 2. Forks are local ownership

A fork is acceptable only when the reason is documented, the delta from upstream is visible, the source is verifiable, upstream status is known and there is a path for upstream security fixes.

Flag ad hoc changes on long-lived fork branches, different fork sources in CI and local builds and multiple unexplained forks of the same upstream.

### 3. Pins need intent and maintenance

Every pin needs rationale, scope, owner, review date or expiry and removal condition where possible. Prefer narrow pins over freezing large parts of the graph.

### 4. CI must run the real recipe

CI and local development may use different wrappers, but they must drive the same underlying recipe.

Flag CI installing undeclared tools, setting undeclared environment variables, relying on pre-warmed runners or testing a different recipe from the one release uses.

### 5. Control the dependency graph

Where the ecosystem allows it, lock the full transitive graph, pin resolver version and config and fetch through approved registries, mirrors or proxies.

If full locking is unavailable, require pinned resolver version, controlled registry path, graph snapshot and diff, explicit drift policy and owner for exceptions.

### 6. Undeclared inputs are bugs

Build steps must not depend on home-directory content, global config, unpinned host packages or binaries, hostname, username, git dirtiness unless declared and normalized or undeclared network calls.

Normalize locale, encoding, timezone, umask, file permissions, filesystem ordering, archive metadata, absolute paths, stable timestamps or `SOURCE_DATE_EPOCH` and fixed random seeds where randomness affects output.

### 7. Caches speed builds; they do not prove builds

Builds must still work with caches disabled, cache keys must include all correctness-relevant inputs, cache use must be visible and there must be a clean-room path in CI or release checks.

Flag warm caches masking fresh-checkout failures, skipped steps after real input changes or green CI when a fresh clone fails.

### 8. Verify sources and artifacts

Prefer signatures, checksums, pinned commits and digests.

Flag unauthenticated dependency fetches, mixed registries with unclear precedence, unverifiable artifacts and hand-downloaded binaries committed only to fix CI.

### 9. Test the thing you ship

Prefer build once, test that artifact, then promote that artifact.

Avoid release-only flags or steps not covered by tests, manual release edits or floating inputs such as `latest`.

## Temporary exceptions

A workaround is acceptable only if it states the assumption and reason, tight bounds, visibility, owner, review date and exit path.

## Accept only if

- a fresh checkout builds with caches disabled
- toolchain and resolver behavior is deterministic
- release inputs resolve to exact versions and sources
- release mode is network-hermetic unless an exception is documented
- forks, pins and workarounds have owner, scope and review cadence
- CI and release use the same real recipe
- provenance exists where required

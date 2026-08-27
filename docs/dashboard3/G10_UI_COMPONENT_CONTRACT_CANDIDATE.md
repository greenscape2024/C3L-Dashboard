# PRJ-004 — G10 UI Component Contract Candidate

Status: SPECIFICATION ONLY / NOT IMPLEMENTED / NO PRODUCTION DEPLOY

Locked baseline: `b7d46b80a72772ebc16bc557500eb63916a1d63c`
Accepted G09 candidate: `c81e7581477ac8e9eeab0fe439400a9a71a5f87a`

## Accepted design input

G09 IA and Lite/Full wireframe are accepted as the design input for reusable component definition. This does **not** approve final visual design, production component code, or deployment.

## Shared rule

Every component consumes the same normalized metric/source/evidence model. Components may render or navigate; they may not create a second source of truth, recompute severity/freshness, fabricate evidence, or expose C2 mutation controls.

`UNKNOWN / STALE / UNAVAILABLE / NOT_EVALUATED / BLOCKED` must never be rendered as verified green.

## Reusable components

1. **StatusCard** — state/severity/freshness projection for existing metric IDs only.
2. **EvidenceDrawer** — read-only provenance and independent read-back context.
3. **ModuleGraph** — read-only module node/edge visualization; no graph-owned routing/orchestration.
4. **AlertRow** — canonical alert/event row; legacy events cannot become VERIFIED_ALERT.
5. **LiteFullModeSwitch** — presentation-density switch only; same metric semantics in both modes.
6. **OwnershipBadge** — explicit owner marker; unknown owner is never inferred from placement.
7. **OrganizerAgentBoundary** — persistent `OWNERSHIP BOUNDARY — VIEW ONLY`; cross-lane write and authority merging forbidden.

## ORGANIZATOR / AGENT boundary

ORGANIZATOR and AGENT remain separate ownership lanes. Cross-lane navigation may correlate read-only evidence, but may not merge ownership, state identity, write authority, or route authority.

## Implementation hold

G10 creates contracts only. `index.html`, AppDeploy runtime, security/auth contracts, source authority registry and production remain unchanged. Any actual component implementation requires a subsequent development slice and a fresh G08 guard PASS.

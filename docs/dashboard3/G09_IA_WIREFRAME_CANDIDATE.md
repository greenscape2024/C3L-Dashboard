# PRJ-004 — Dashboard 3.0 IA + Wireframe Candidate v0.1

Status: **LOW-FIDELITY CANDIDATE / NOT IMPLEMENTATION**  
Baseline: `b7d46b80a72772ebc16bc557500eb63916a1d63c`  
Slice: `G09-IA-WF-001`

## 1. Information Architecture

Full navigation order:

1. System Overview
2. Integrity
3. Security
4. Modules + Graph
5. Routing
6. Repository + Release
7. Evaluation
8. Snapshots
9. Alerts + Evidence
10. Unified ORGANIZATOR / AGENT
11. View Contract

The Full view covers all 45 approved metric IDs. Lite is a projection of the same normalized metric state and does not own, recompute, or rename operational state.

## 2. Lite wireframe

```text
┌──────────────────────────────────────────────────────────────────────────────┐
│ C3L Dashboard 3.0       [LITE | FULL]       Freshness: <state>   Alerts: <n> │
├────────────────┬────────────────┬────────────────┬───────────────────────────┤
│ Overall Health │ Integrity      │ Security       │ Critical Alerts           │
│ SYS-01         │ INT-01         │ SEC-01/02      │ ALT-02                    │
├────────────────┼────────────────┼────────────────┼───────────────────────────┤
│ Modules        │ Routing        │ Release        │ Drift                     │
│ MOD-01/02      │ ROU-01/02/04   │ REP-01/02/03/05│ INT-04                    │
├────────────────┼────────────────┼────────────────┴───────────────────────────┤
│ Last Evaluation│ Confidence / Freshness       │ New Alerts                  │
│ SYS-03/EVA-01  │ SYS-04/EVA-04                │ ALT-01/03                   │
└────────────────┴───────────────────────────────┴─────────────────────────────┘
```

Each card displays the same semantic fields used by Full:

`metric_id | display_state | severity | last_updated | freshness | source | evidence_reference`

A Lite card may expose less detail, but it may not alter state, severity, freshness, source, evidence or ownership.

## 3. Full wireframe

```text
┌──────────────────────────────────────────────────────────────────────────────┐
│ C3L Dashboard 3.0  [LITE | FULL]  HEALTH | INTEGRITY | SECURITY | FRESHNESS │
├───────────────────────┬──────────────────────────────────────┬───────────────┤
│ SECTION NAVIGATION    │ MAIN DETAIL CANVAS                   │ EVIDENCE      │
│                       │                                      │ DRAWER        │
│ System Overview       │ Metric group                         │ source        │
│ Integrity             │ state / severity / freshness         │ timestamp     │
│ Security              │ provenance                           │ read-back     │
│ Modules + Graph       │ validation                           │ evidence ref  │
│ Routing               │                                      │               │
│ Repository + Release  │                                      │               │
│ Evaluation            │                                      │               │
│ Snapshots             │                                      │               │
│ Alerts + Evidence     │                                      │               │
│ Unified O/A           │                                      │               │
│ View Contract         │                                      │               │
└───────────────────────┴──────────────────────────────────────┴───────────────┘
```

The module graph is read-only visualization. It may show existing `DEPENDS_ON`, `ROUTES_TO`, `READS_FROM`, `EVALUATES`, and `REPORTS_TO` relations but does not own routing, scheduling or orchestration.

## 4. Unified ORGANIZATOR / AGENT panel

```text
┌────────────────────────────┬─────────────────────────────────────────────────┐
│ ORGANIZATOR                │ AGENT                                           │
│ owner: ORGANIZATOR         │ owner: AGENT                                    │
│                            │                                                 │
│ system                     │ agent state                                     │
│ routing                    │ evaluation                                      │
│ modules                    │ execution state                                 │
│ repository / release       │ alerts / evidence                               │
│                            │                                                 │
├────────────────────────────┴─────────────────────────────────────────────────┤
│ OWNERSHIP BOUNDARY — VIEW ONLY — UNI-03                                      │
│ Cross-lane correlation is allowed. Cross-lane ownership/write authority is   │
│ forbidden.                                                                   │
└──────────────────────────────────────────────────────────────────────────────┘
```

The boundary remains visible when the layout stacks on narrow screens.

## 5. Semantic parity contract

- Lite and Full use the same `metric_id`.
- Lite and Full use the same normalized state object.
- Severity cannot change with mode.
- Freshness cannot change with mode.
- Evidence reference cannot change with mode.
- Permission-aware visibility may hide detail but cannot fabricate PASS.
- `UNKNOWN`, `STALE`, `UNAVAILABLE`, and `NOT EVALUATED` never render as verified green.
- Mode switching is a presentation change, not a data-state mutation.

## 6. G09 scope boundary

G09 does **not** implement production components, alter `index.html`, mutate AppDeploy runtime, change security/RBAC, change source authority, introduce a new router/scheduler/registry, or expose C2 mutation controls.

Any later UI/component implementation must first receive a fresh G08 guard PASS for the exact candidate SHA derived from this locked baseline.

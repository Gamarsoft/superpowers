# Lean risk-scaled delivery behavior evidence

The immutable runs below test planning, SDD, fallback execution, and finishing
with fresh Codex contexts. Raw actor responses and controller-visible event
counts are retained beside every score.

| Run | Purpose | Result |
| --- | --- | --- |
| [baseline-d9a937091926](runs/baseline-d9a937091926/summary.md) | Fork behavior before skill edits | 0/5 in each of eight scenarios |
| [baseline-fallback-v2](runs/baseline-fallback-v2/summary.md) | Corrected no-subagent prompt against the old fallback | 0/5 |
| [candidate-02-writing-plans-r1](runs/candidate-02-writing-plans-r1/summary.md) | Bounded holistic plan readiness | 5/5 |
| [candidate-04-sdd](runs/candidate-04-sdd/summary.md) | Preflight, cadence, authority, scope, and breaker controller | 20/20 |
| [candidate-05-review-boundaries](runs/candidate-05-review-boundaries/summary.md) | Initial public-review boundary wording | 4/5; exposed approved-behavior classification ambiguity |
| [candidate-05-review-boundaries-r1](runs/candidate-05-review-boundaries-r1/summary.md) | Corrected public-review boundary wording | 5/5 |
| [candidate-06-executing-plans](runs/candidate-06-executing-plans/summary.md) | Honest no-subagent execution handoff | 5/5 |
| [candidate-07-finishing](runs/candidate-07-finishing/summary.md) | Exact-HEAD finishing and report-only commit | 5/5 |
| [candidate-08-role-fallback](runs/candidate-08-role-fallback/summary.md) | Missing typed-role fallback after role consolidation | 5/5 |
| [candidate-final](runs/candidate-final/AUDIT.md) | First combined record | Rejected by independent evidence audit |
| [candidate-final-r1](runs/candidate-final-r1/AUDIT.md) | Corrected traces with incomplete fallback reports | Rejected by independent evidence audit (35/40) |
| [candidate-final-r2](runs/candidate-final-r2/AUDIT.md) | Complete paths but incomplete exact evidence | Rejected by independent evidence audit (35/40) |
| [candidate-final-r3](runs/candidate-final-r3/AUDIT.md) | Per-scenario-matched final candidate and successful smoke | Independently audited READY (40/40) |
| [baseline-finishing-return-v2](runs/baseline-finishing-return-v2/summary.md) | Revised failed-suite producer-return behavior against the old fork | 0/5 |
| [candidate-final-r4-paired](runs/candidate-final-r4-paired/summary.md) | Revised failed-suite producer-return behavior | 5/5 against paired 0/5 baseline |
| [candidate-final-r4](runs/candidate-final-r4/AUDIT.md) | Typed-role runtime, final review gates, Java taxonomy, and retained smoke | Independently audited READY (15/15 plus smoke) |
| [candidate-final-r5](runs/candidate-final-r5/AUDIT.md) | Operational generic fallback from the retained, provenance-checked role-free package | Independently audited READY (5/5) |

The production thread `codex://threads/01a068c6-ec3d-7773-96cd-11e0c684ad77`
motivated the hypotheses tested here. It is observational evidence, not a
controlled sample, and is excluded from all pass rates.

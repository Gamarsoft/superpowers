# Paper workflow adoption assessment

Decision: **retain candidate**. The installed defaults remain unchanged. The
Branding pilot demonstrates the complete design-to-application path, but the
available behavior and regression evidence does not yet justify default adoption.

## Identities and authority

- Candidate implementation: `e09373208591b6350a05fddfdfb3b566931fea3c`, branch
  `codex/paper-frontend-candidate`; this assessment changes documentation only.
- Active specification SHA-256:
  `79210adbc34c4e83ed0536a957937d04424237e20cf51d3c4ccbd0fd6522dfe8`.
- Gateway application: `0b7102db237119a7e6f8767ed8d05929c1be4eab`, branch
  `codex/paper-branding-pilot`.
- Human-approved design: `branding-paper-r2-a-20261026`; final descriptor
  `0436139781584b476eee5a1eb93be826828517f636fc4e269a2d01abaf0f7bcd`.
  Approval metadata was independently corrected without changing approved images
  or probe payloads. The rejected first design remains historical evidence.
- Installed checkout: `b97ddc0f5205c36185bce8dd555ea2db58c3bac3`.
  All 172 installed skill files match the before manifest. No promotion occurred.

Evidence workspace (preserved with the candidate):
`/private/tmp/paper-frontend-candidate/.superpowers/sdd/2026-10-23-paper-frontend-workflow`.
Paths below beginning with `W/` refer to that directory.

## Outcomes and evidence

| Outcome | Assessment | Evidence and limits |
| --- | --- | --- |
| Version-2 cutover | Implemented and independently reviewed | 53 packet tests pass, retaining file identity, path containment and state/reference checks. Version1 is unsupported; historical bytes remain reference material. No migration or dual-format branch. `W/task-2-report.md`, `W/u2-review-r0.md`. |
| Medium roles and design reasoning | Implemented in candidate | Paper composes substantial screens; actual components establish behavior; Companion retains diagrams/comparisons; image generation retains assets/explicit exploration. Task-to-layout, copy, accessibility, critique and exact approval remain binding. |
| Initial policy campaign | Pass at its recorded source | Baseline109/140, candidate-r1 135/140, candidate-r2 140/140 across ten fresh samples at `099e1087`. Complete outputs and failed runs remain under `tests/codex/paper-frontend-behavior/results/runs/`. These are policy-application checks, not implicit skill-discovery or usability evidence. |
| Experience amendment | Mixed; adoption gap | At `3ad8a83`, final samples score6/6 and5/6. Sample2 does not clearly bind revised-design approval to the revised artifact. The original five design-handoff samples score75/75 at earlier `0da9cdd`; they were not rerun at `3ad8a83`. `tests/codex/paper-experience-behavior/judgments.md` and `W/experience-correction-report.md`. |
| Export and implementation fidelity | Demonstrated for selected A | Real Paper exports, frozen source/captures, component feasibility, exact human approval and Angular/Nebular implementation. Independent reviewer verified served source and1440/1024/1280/390 layouts. See `W/u5-independent-runtime/review.md`, `W/u5-correction1-review-result.md`, Gateway `docs/design/paper/branding-pilot.md`. |
| Publication and recovery | Demonstrated on isolated local fixture | Initial/draft/invalid/pending/error/success, real local-storage failure, retained draft, retry, persisted reload and keyboard publication. `W/u5-runtime-proof.md`; no writes to parking104. |
| Logo and mobile checks | Pass within inspected viewports | Synthetic wide and light wordmarks plus a repository logo containing its name; full identity remains separately rendered. Mobile scrolling, wrapping and publication access checked. These assets are representative fixtures, not a customer-logo survey. |
| Publish versus Terminer | Preserved, with explicit proof boundary | Publication remains independent. Terminer's source binding and valid-form unit test retain `finish()`/`save(true)`; the live fixture remained invalid for parking completion. No successful live Terminer save was claimed or new user association created. |
| Library reconciliation | Useful bounded example | Distinct editable Paper color-control entry reconciled to actual247px row,44px swatch,10px gap and193px field. Checked against application `8a220f90`; later focus correction does not affect it. Whole-screen coverage remains pending/unknown with no invented verified revision. Gateway `docs/design/paper/library.json` and its evidence folder. |
| Human outcomes | Unmeasured | Human selected A and approved the exact design; no observed human task-use study or demonstrated repeat-use savings. |

## Fidelity, rework and effort

The first design was rejected by the human despite earlier geometry checks. The
revised flow used the confirmed occasional-setup task and supplied assets, compared
structures, and selected form beside preview. This is evidence that design
decisions required improvement; packet validity alone did not supply quality.

Implementation exposed three bounded corrections: a visible background for light
artwork, wider wordmarks wrapping above the separate name on mobile, and explicit
publication success. Independent review then caught unreadable publication-button
focus styling. The corrected keyboard/hover/active states retain dark text at
approximately5.70:1 contrast and a visible focus outline. No broad redesign or
publication-rule change followed approval.

First-use setup included about38m44s of accumulated fixture/runtime preparation.
The first design's27-minute estimate separates source/context6, Paper10,
component proof4, export/report7. The selected-A phase was conservatively32m49s,
combining parallel Paper iteration, component checks and export/handoff once.
Approved-snapshot line-ending and approval-authority repairs were additional
handoff friction, not evidence of design benefit. These phase estimates are not
additive to the conservative total; concurrent work is counted once.

Library upkeep was approximately4minutes:97seconds measured in Paper plus a
conservative143seconds for exports/index/report. The20-minute cap remains intact.
Only the affected color-control entry was updated. Pending whole-screen upkeep
retains unknown coverage and does not block verified application delivery.
The conservative active pilot tally is3h15m43s, including one minute for final
result inspection after the cleanup report; its records are in
`W/pilot-effort-live.json`. The authorized ceiling is3h20, including the final
20-minute extension for review, corrections and restoration. Broader workflow
assessment and passive automated-test waiting are separate from pilot work.

## Verification and restoration

Focused Gateway verification passed17tests in4suites. Formatting, lint and Sass
checks passed. TypeScript LSP was running under an unsuitable Node version, so a
Node12 production build supplied the documented fallback; no qualifying clean
TypeScript-LSP result is claimed. The final correction changed only SCSS and
passed focused style checks plus fresh independent interaction inspection.

The pre-adoption complete checks bind candidate `e0937320` and Gateway `0b7102db`.
The Companion suite initially exited1 because its existing declared `ws`
dependency was absent; installing the unchanged lockfile's one dependency repaired
that prerequisite without a source change. The failed run remains recorded.
Claude's runner exited1 because Claude CLI is unavailable; Quorum is also absent.
No Claude/Quorum coverage is claimed. Gateway full Jest passed143suites/1874tests in324.151seconds under Node12,
with exit0 at application `0b7102db`. Exact results and the final finishing
disposition are recorded in `W/finishing-*.json` and the execution handoff.

Worktree diff checks pass. Cumulative checks report whitespace in retained raw
actor output, approved packet prose and generated probe bundles. Their immutable
bytes are preserved; this is not a claim of a clean cumulative whitespace check.

Fixture restoration is independently recorded in
`W/pilot-prerequisites/u5-final-cleanup-report.md`: guarded deletion of the exact
test branding row, tenant-only storage reset,404 on the authenticated read, and
ordinary Customer startup with its original configuration. The inactive dedicated
parking/group remain, without user associations. User-owned Gateway/UAA/Angular
are preserved. Original-mode Customer must not be used for another fixture publish.

## Adoption boundary

Application evidence, library status and default adoption are separate outcomes.
The maintained entry is sufficient for the bounded reconciliation requirement;
full-screen housekeeping is not an adoption blocker. Current reasons to retain the
candidate are mixed revised-artifact approval evidence and incomplete complete-suite
coverage. First-use cost also prevents a credible efficiency claim from one screen.

Before adoption, resolve the observed approval-linkage omission, rerun the affected
fresh-session checks at the resulting exact source, finish required regression
coverage and inspect the resulting evidence. Preserve failed runs and existing
review/correction budgets. Promotion then needs an exact source/path check; it
must not introduce new skill changes, compatibility support or automatic backfill.
No promotion, implicit loading claim, usability claim or long-term maintenance
saving is authorized by this assessment.

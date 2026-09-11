# Frontend-direction rework evaluation

The reworked skills passed the matched decision probes and produced a Credipark dialog prototype that the user reviewed, corrected and approved. This demonstrates the intended exploration and handoff behavior in this case. It does not measure general visual quality, production integration or task-completion performance.

## Scope and changes

The [approved spec](../specs/2026-09-10--frontend-direction-visual-exploration.md) and [execution plan](../plans/2026-09-11-frontend-direction-rework.md) address a reported failure: brownfield feature implementations repeatedly inherit poor legacy layouts despite detailed requirements.

`frontend-direction` now supports a standalone brief and a follow-on entry. Substantial unresolved design leads to three comparable rendered UI concepts, selection/refinement, an interactive prototype and approval of an exact version. Existing approved direction and mechanical work bypass unnecessary exploration. The approved feature delta can change composition while retaining business constraints, brand and shell.

`implementing-frontend-design` replaces `gsd-frontend-design`. It consumes the exact approved evidence without requiring GSD or regenerating a packet, preserves historical artifact authority and requires independent runtime recapture for non-trivial UI. Active local callers were migrated. Saved invocations outside this repository must use the new name; no compatibility alias remains.

Upload-pack authoring was retired. Existing approved packets and images remain readable. Optional Impeccable guidance is shared and scoped; its absence does not block the core workflow. No third-party runtime dependency was added.

## Matched decision evidence

Each skill comparison used five no-guidance controls, five frozen pre-change skill samples and five frozen candidate samples: 30 responses total. Actors were fresh Sol/low contexts with the same scenario and evidence within each comparison. Tools were forbidden in these response-only probes. All responses were read manually and scored with quoted evidence before advancing. Six direction boundaries and four forward-handoff boundaries were also read.

| Observation | Control | Previous skill | Candidate |
| --- | --- | --- | --- |
| Direction: proposes three actual concepts before selection | 0/5 | 0/5 | 5/5 |
| Direction: standalone without another spec-equivalent approval | 5/5 | 0/5 | 5/5 |
| Direction: retains a selected interactive prototype as binding evidence | One prototype proposed, no selected alternatives | 0/5 | 5/5 |
| Direction: makes optional Impeccable a prerequisite | 3/5 | Not consistently discussed | 0/5 |
| Implementation: preserves the explicit approved feature delta and blocks approval when runtime is unreachable | 5/5 | 5/5 | 5/5 |
| Implementation: demotes the approved prototype | 0/5 | 4/5 (2 explicitly temporary/non-durable) | 0/5 |

The previous implementation guidance already preserved several important safeguards; the rework does not claim to have introduced them. The supported failures concerned deliverable shape, conditional entry and artifact authority. Changes use a positive recipe and explicit artifact fields rather than adding generic prohibitions.

Boundary cases cover mechanical changes, unresolved business rules, unavailable tools, mixed concept feedback, full follow-on scope, absent Impeccable, historical image-only packets, required-pending direction, exact task inputs and separate follow-on approval. These responses test decisions, not execution. Some candidate concepts echoed the example and one retained a fixed footer without evidence that it was required. Those remain observations rather than a quantified quality gain.

Raw evidence is retained locally at `.superpowers/evals/frontend-direction-20260911/`: `manifest.json`, frozen snapshots, scenarios, individual responses, `results.md`, `implementation/results.md` and boundary responses. Earlier pending lines in these append-only records describe checkpoints, not final status.

## Actual image and browser pilot

After the user started DashPark services, the controller inspected the running customer detail dialog and current Angular source. Source/runtime included independent lifecycle states absent from the historical screenshot. The review used the existing authenticated session, entered no credentials and made no live data writes.

Built-in imagegen produced three separate same-content, 1536×1024 concepts: A (account statement), B (persistent summary with tabbed ledger) and C (ledger with selected-detail pane). The user chose B. A refined B-v2 image improved identity hierarchy before the first working prototype. Generated background navigation was inaccurate and excluded from the binding target.

The prototype uses real HTML controls and synthetic data, with local fonts and no backend connection. Browser checks covered pagination and its end boundary, parking/lifecycle/rules, independent adjustments, loading/empty/permission/error/retry states, keyboard tabs, Escape/focus return and narrow long-content scrolling. The packet distinguishes exercised states from additional authored scenarios.

The first review missed a usability problem: pagination required scrolling down and then returned the user upward. Human feedback led to prototype-v2: parking breakdown moved to its own tab, the ledger alone scrolls within remaining dialog height, and pagination remains visible with stable focus. A browser annotation then renamed the first column from Mouvement to Type. On 2026-09-11 the user said “I approve this prototype”; approval is pinned to **prototype-v2 revision v2.1** and its source manifest. Earlier images and captures are history where this version supersedes them.

Installed DashPark Impeccable v4.3.1 was actually read and invoked: its context command targeted the Gateway component, then its JSON detector scanned the first prototype's HTML/CSS/JS. Context resolved gateway PRODUCT.md and DESIGN.md. The detector returned exit 2 for retained Open Sans and a rounded-card false positive on a square tab underline; these were rejected with scoped evidence. Manual source/browser assessment and supported font, focus, scroll and contrast corrections are recorded in `pilot/impeccable-audit.md`. No hooks, dependencies or repair configuration were installed. This was not an independent Impeccable critique run or accessibility certification.

The historical baseline and generated concepts have different viewports. There is no controlled before/after full visual-generation comparison, comparative beauty score or measured usability improvement. Human approval establishes the selected direction for this feature.

## Fresh forward implementation

A fresh `sp_implementer` actor consumed the exact approved v2.1 source, manifest, packet and captures in an isolated runnable fixture on port 8767. All eight source hashes match. `node --check` passed. Its actual 1154×1324 capture is byte-identical to the approved desktop capture (SHA-256 `a851dd6e22644cc7c4d51aa4fe79a86b6e0f0adb839337676897587ba6daf593`).

The actor exercised pages 1/2/3 (10/10/4 rows), stable pagination bounds, forward/end-page focus, parking and lifecycle tabs, and independent lifecycle failure/loading/retry. Account identity and balance remained available during that failure. Captured console warning/error records were empty. Browser network tracing was unavailable; the fixture server reported successful document/script/style/font requests and an optional favicon 404. The actor did not grant visual approval; the independent final reviewer still owns that gate.

The report, captures, source hashes and runtime observations are under `pilot/forward-implementation/`. This is approved-code assembly and runtime preservation, not an independent Angular recreation. Narrow source was copied unchanged; this actor did not claim a fresh narrow runtime check. The final reviewer must independently open and capture desktop/narrow scope. CUA captures have historical .png filenames but JPEG image bytes; they remain readable image artifacts, not evidence of PNG encoding.

## Durable DashPark handoff

At the user's explicit request, the approved source and supporting history were copied to:

`/Volumes/Workspace/Development/SolutionPark/DashPark/docs/superpowers/specs/2026-09-11--credipark-detail--frontend/`

The bundle includes a clean README, binding packet, implementation guide with a ready-to-use prompt, exact approval and source manifests, all concept/refinement images and prompts, both prototype versions, local fonts, baseline and review captures, and bounded audit/history notes. All 39 files listed in `ARTIFACTS.json` passed SHA-256 verification at the destination. The manifest hash is `04d39e05467fbfc7b8ecc4c77c6221d0ef98980c349704428a7b7b545c436d33`. The narrow v2 capture predates the final header-only edit; approved source and v2.1 desktop capture resolve that supersession.

This is a documentation-only addition to DashPark, not a committed application implementation. The implementation guide identifies the existing `customer-loyalty-detail-dialog.component.{ts,html,scss}` and French copy file and preserves Angular/Nebular service, paging and retry contracts. Keep this folder and the local evaluation evidence after finishing.

## Verification and remaining limits

Focused checks passed: four frontend resource/discoverability/link checks, no-pencil policy and route scanner, independent visual-review policy, brainstorming artifact checks, visual-companion contract checks, and skill-creator validation of six changed skill directories. PyYAML was supplied only in a temporary validation directory. Structural checks protect package contracts; they do not demonstrate agent behavior or design fidelity.

One final independent review and finishing's complete available deterministic suite remain pending at this report's implementation checkpoint. Their exact revision and results belong to the subsequent execution report. The plan lists exact available commands and records the unavailable Claude live harness and prior official packaging metadata separately.

Production Angular integration, device testing, full accessibility review, real backend failures and persistence remain future DashPark implementation work. Synthetic balances are display fixtures; they are not a financial reconciliation model.

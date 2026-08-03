# Visual Companion Design Kit Verification

Date: 2026-08-03
Base commit: `6f9bffa`

## Verdict

The Task 7 runtime, accessibility, responsive, and visual matrix passes. The complete Brainstorm Companion test suite is green, exactly 18 implementation PNGs exist, and an independent fresh-context visual re-review returned `APPROVE` after both of its original findings were fixed and recaptured.

On 2026-08-03, the human explicitly approved all 18 captures. They are now approved `visual-truth` for this implementation. The original baseline/problem-evidence assets remain preserved and were not renamed or replaced.

## Automated verification

| Check | Command / action | Observed result |
|---|---|---|
| Focused design-kit contract | `node tests/brainstorm-server/visual-companion-design-kit.test.js` | PASS after three RED/GREEN integration fixes: 200% narrow shrink, waiting dark palette, and narrow policy text spacing |
| Full suite | `cd tests/brainstorm-server && npm test` | PASS, exit 0; runtime, auth, branding, server, lifecycle, custom contracts, live acceptance, design kit, and Windows lifecycle all green |
| Candidate count | `find ... -name 'candidate-visual-truth-*.png'` | Exactly 18 files |
| PNG validity | `file .../candidate-visual-truth-*.png` | All 18 are valid 8-bit RGB PNGs; desktop/waiting are 1440×1000 and narrow captures are 390×844 |
| Dependency manifests | `git diff --exit-code 6f9bffa -- package.json tests/brainstorm-server/package.json tests/brainstorm-server/package-lock.json` | Exit 0; Task 7 adds no manifest or dependency change |
| Runtime dependency additions | Inspected the Task 7 source diff for added `http://`, `https://`, `@import`, and remote `url(...)` references | None added |
| Stale Impeccable setup wording | `rg -n '/impeccable teach' . --glob '!node_modules/**' --glob '!.git/**'` | No active setup reference; remaining matches are a negative regression assertion and historical planning/handoff prose |
| Server scope from feature baseline | `git diff 661fa797 -- skills/brainstorming/scripts/server.cjs` | Exactly two human-authorized waiting-page exceptions: the exact copy replacement plus the CSS-only dark media block |
| Server scope from Task 7 base | `git diff 6f9bffa -- skills/brainstorming/scripts/server.cjs` | Only the six-line authorized waiting-page dark media block |

The first non-escalated full-suite attempt failed because the sandbox denied local bind on `127.0.0.1:3335` with `EPERM`. The required rerun was performed with local-port approval and passed; this was an infrastructure permission failure, not a product failure.

## TDD integration fixes

1. The live acceptance test first reproduced the known timeout after three earlier steps passed: it waited for stale `Decision checkpoint: export flow`. The smallest fix changes that assertion to the actual refreshed checkpoint, `Chosen direction: drawer-based export flow`. The acceptance flow then passed all six steps, including event persistence, full-document passthrough, and teardown.
2. At 390px with 200% text zoom, the retry-review body grid forced document overflow. A focused contract failed first, then the exemplar added `min-width: 0` to the narrow body and children plus local overflow on the dense proposed table. Live browser proof: document width 390px; the table alone scrolls locally (`clientWidth` 181px, `scrollWidth` 345px).
3. Independent visual review measured a 0px gap between `MAXIMUM BACKOFF` and `5 min`. A focused contract failed first; the narrow current-policy value cell then received 12px left padding. Final live Range measurement is exactly 12px in both light and dark at 390×844, with no viewport overflow.
4. Independent visual review found waiting-light and waiting-dark byte-identical because the real waiting page ignored dark preference. The human authorized a CSS-only exception to the original `server.cjs` constraint. A focused contract failed first; the waiting page then received only the approved palette: canvas `#151614`, ink `#F2F1EC`, muted/brand `#B6B8B1`, and unfiltered dark logo. Fresh keyed-browser captures are now semantically and byte-wise distinct.

## Real-browser matrix

The real keyed server was used throughout. The Codex in-app browser supplied the initial runtime/DOM interaction pass after its required fresh-tab connection retry. Its documented surface did not expose color-scheme or reduced-motion emulation, so the documented headed `playwright-cli` fallback supplied media emulation, exact viewport capture, geometry, and focused rechecks. No static-file substitute was used and no session key is recorded here.

| Area | Observed evidence |
|---|---|
| Mouse and keyboard | Mouse selection worked. Tab reached the evidence region and then Approve; Shift+Tab returned to evidence and Tab restored Approve. Focus computed as a 3px solid `rgb(36, 87, 214)` outline with 2px offset. Enter selected Approve; Space selected Reject. Native paths emitted exactly one state transition. |
| Single and multiselect | Single choice synchronized `aria-pressed` and exact `Selected: Approve change. Return to the conversation to continue.` copy. A real-server supported multiselect fixture selected Alpha and Beta and produced exact `2 options selected. Return to the conversation to continue.` copy; both events persisted. |
| Persistence and recovery | Real `state/events` contained the authored choice events. A real server stop produced Reconnecting then Disconnected, disabled choices, preserved recovery copy, and displayed the paused tombstone. Restart inside the recovery window restored Connected, enabled controls, selected state, exact footer copy, and the product screen. |
| Compatibility | A real legacy fragment retained the fragment shell and interaction/footer behavior. A real full HTML document preserved its authored title/root colors and received no fragment shell, header, or indicator contamination while still receiving the helper. |
| 320px / reduced motion | At 320×844, document width remained 320px, choice transitions computed to `0s`, choice target was 44px high, status/footer stayed within the viewport, and there was no horizontal overflow. |
| 200% text zoom | At 390×844 with root text at 32px, the document remained 390px wide. The dense proposed table used labeled local scrolling; the viewport did not scroll horizontally. |
| Light/dark contrast | Product surface ink contrast measured 16.93:1 light and 14.68:1 dark; muted context measured 5.98:1 light and 8.28:1 dark. Waiting dark computed to the authorized colors and remained readable. |
| Headings and live status | Product headings were H2 followed by the two H3 choice labels; diagram and editorial each used a single H2 in the shell. Product `Ready for review` and conditional selection guidance were polite live status regions. |
| SVG and non-color meaning | Diagram SVG exposed exact nonempty title/description, ordered Browser → API → Queue → Worker → Retry/Dead-letter → Database content, and a labeled trust boundary. Text, symbols, focus outline, check state, `aria-pressed`, and unavailable wording carry meaning in addition to color. |
| Targets and overflow | Both product choices measured 44px high. Desktop, 390px, 320px, waiting, diagram, product, editorial, and compatibility states showed no viewport horizontal overflow. |
| Conditional footer | Interactive product showed exact default/selected/recovery copy as state changed. Diagram, editorial, full-document, and noninteractive disconnected states had no visible choice footer. |
| Register intent | Diagram spatially exposes sequence, retry, dead-letter, and trust boundary; product reads as an honestly labeled simulated operator surface with evidence/guardrails and real Approve/Reject actions; editorial leads with conclusion, then evidence, open questions, and deferred assumptions in read-only rhythm. |

## Candidate captures

1. `docs/superpowers/specs/2026-07-31--visual-companion-design-kit--frontend/screenshots/candidate-visual-truth-diagram-desktop-light.png`
2. `docs/superpowers/specs/2026-07-31--visual-companion-design-kit--frontend/screenshots/candidate-visual-truth-diagram-desktop-dark.png`
3. `docs/superpowers/specs/2026-07-31--visual-companion-design-kit--frontend/screenshots/candidate-visual-truth-diagram-narrow-light.png`
4. `docs/superpowers/specs/2026-07-31--visual-companion-design-kit--frontend/screenshots/candidate-visual-truth-diagram-narrow-dark.png`
5. `docs/superpowers/specs/2026-07-31--visual-companion-design-kit--frontend/screenshots/candidate-visual-truth-product-unselected-desktop-light.png`
6. `docs/superpowers/specs/2026-07-31--visual-companion-design-kit--frontend/screenshots/candidate-visual-truth-product-unselected-desktop-dark.png`
7. `docs/superpowers/specs/2026-07-31--visual-companion-design-kit--frontend/screenshots/candidate-visual-truth-product-unselected-narrow-light.png`
8. `docs/superpowers/specs/2026-07-31--visual-companion-design-kit--frontend/screenshots/candidate-visual-truth-product-unselected-narrow-dark.png`
9. `docs/superpowers/specs/2026-07-31--visual-companion-design-kit--frontend/screenshots/candidate-visual-truth-product-desktop-light-visible-focus.png`
10. `docs/superpowers/specs/2026-07-31--visual-companion-design-kit--frontend/screenshots/candidate-visual-truth-product-enter-selected.png`
11. `docs/superpowers/specs/2026-07-31--visual-companion-design-kit--frontend/screenshots/candidate-visual-truth-product-disconnected.png`
12. `docs/superpowers/specs/2026-07-31--visual-companion-design-kit--frontend/screenshots/candidate-visual-truth-editorial-desktop-light.png`
13. `docs/superpowers/specs/2026-07-31--visual-companion-design-kit--frontend/screenshots/candidate-visual-truth-editorial-desktop-dark.png`
14. `docs/superpowers/specs/2026-07-31--visual-companion-design-kit--frontend/screenshots/candidate-visual-truth-editorial-narrow-light.png`
15. `docs/superpowers/specs/2026-07-31--visual-companion-design-kit--frontend/screenshots/candidate-visual-truth-editorial-narrow-dark.png`
16. `docs/superpowers/specs/2026-07-31--visual-companion-design-kit--frontend/screenshots/candidate-visual-truth-waiting-light.png`
17. `docs/superpowers/specs/2026-07-31--visual-companion-design-kit--frontend/screenshots/candidate-visual-truth-waiting-dark.png`
18. `docs/superpowers/specs/2026-07-31--visual-companion-design-kit--frontend/screenshots/candidate-visual-truth-noninteractive-reconnecting-no-footer.png`

Waiting evidence is distinct: light SHA-256 `ab747ee4be247d8bd452d9aced77f1d270f60590dd4e0d865975ea9da88c56fd` (20,973 bytes); dark SHA-256 `daaf455928d0c081ea50b3d45e3115a583d686e6cd82990a2b0021a0ad0f72f6` (23,079 bytes).

## Eval and review gates

Task 6 eval verdict: **ship the positive three-register recipe**. The no-guidance control demonstrated 0/5 native/register compliance; the candidate and after-guidance sets achieved 5/5 on register, composition, interaction boundary, narrow/accessibility, and optional-Impeccable criteria. One compressed after sample abbreviated the explicit question-tool/fallback phrase without reversing behavior; the deterministic contract retains the full rule.

Fresh visual review initially returned `ESCALATE` for the identical waiting pair and `MAJOR` for the 0px narrow policy gap. Both findings received RED/GREEN fixes, real-browser remeasurement, recapture, and a focused fresh keyed-runtime re-review. Updated visual verdict: **APPROVE**, no new findings or waivers. Human visual approval followed on 2026-08-03.

Independent implementation review first returned `REQUEST_CHANGES` because it evaluated the superseded server constraint and inspected before the two reports existed. A focused re-review received the later human authorization, read both current reports, and returned **APPROVE** with no Critical or Important issues. Its only Minor request was to replace the reports' pending-review notes; this sentence and the Task 7 report make that update.

## Commits available at authoring time

- Task 1: `1ec870a` and `97a9cf5`
- Task 2: `6d92670` and `36b1c92`
- Task 3: `4336f98` and `e27729c`
- Task 4: `ea44612` and `3a195bf`
- Task 5: `3a75515`
- Task 6: `6f9bffa`
- Task 7: `af0f9dc`

## Remaining risks and human approval

- Highly compressed authoring responses may abbreviate the explicit platform-question/degraded-fallback wording; the deterministic skill contract guards the full behavior.
- The human approved all 18 implementation captures on 2026-08-03. The retained baseline assets remain separate historical problem evidence.
- No push or pull request was performed.

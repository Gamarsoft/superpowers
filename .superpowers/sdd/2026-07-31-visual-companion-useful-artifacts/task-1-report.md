# Task 1 Report: Useful-Artifact Guidance and Operational Parity

## Status

Complete. Task 1 broadens the visual companion from a comparison-only contract to a useful-artifact contract while preserving comparison patterns, runtime boundaries, and existing protocol behavior.

## Owned files

- `skills/brainstorming/SKILL.md`
- `skills/brainstorming/visual-companion.md`
- `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`
- `skills/brainstorming/examples/visual-companion/architecture-data-flow.html`
- `skills/webapp-testing/SKILL.md`
- `skills/frontend-direction/references/browser-surface-selection.md`
- `skills/frontend-direction/references/use-cases-prompts-and-flows.md`
- `tests/brainstorm-server/visual-companion-contract.test.js`
- `.superpowers/sdd/2026-07-31-visual-companion-useful-artifacts/task-1-report.md`

No server, authentication, protocol, dependency, helper, frame, theme, or Task 2 files were changed.

## Implementation

- Added five non-exhaustive artifact intents: `compare`, `explain`, `map`, `experience`, and `synthesize`.
- Kept side-by-side comparison, ranked alternatives, annotated recommendation, and carry-forward summary as first-class recommendations without forcing fake alternatives.
- Required each artifact to name a viewing task and pass a generalized five-part quality gate; irrelevant decoration remains terminal-only and weak artifacts are revised or omitted.
- Preserved explicit degraded mode for missing design context and kept `data-choice` optional, bounded, and the only supported interaction metadata when selection is useful.
- Added a non-interactive architecture/data-flow fragment covering Browser, API, Queue, Worker, Database, retry, dead-letter handling, and the trust boundary. It deliberately omits `data-choice`, `toggleSelect`, and all `data-*` runtime metadata.
- Restored operational parity from `origin/main:skills/brainstorming/visual-companion.md`: complete keyed URL guidance, `--open`, project persistence and same-port restart, platform lifecycle notes, remote binding with `--host`/`--url-host`, and cleanup behavior.
- Updated active browser-routing docs to use `browser:control-in-app-browser`, with installed capability discovery or `playwright-cli` fallback where the in-app capability is unavailable.
- Extended the contract test for the useful-artifact taxonomy, generalized quality gate, operational parity, browser routing, non-interactive architecture example, and the existing protocol assertions.

## RED evidence

I created an isolated `/private/tmp` snapshot from `git archive HEAD`, overlaid only the new contract test, and ran:

```text
node tests/brainstorm-server/visual-companion-contract.test.js
```

The preimplementation snapshot exited 1 with:

```text
FAIL: visual companion useful-artifact contract assertions failed
Expected visual-companion.md useful-artifact contract to include start marker "## useful-artifact authoring contract"
```

The temporary fixture was removed after the run. The working tree was never reverted or modified for RED reproduction.

Separately, the prior worker checkpoint reported that RED had been captured before implementation and that the focused test was green afterward. This report does not treat that unrecorded checkpoint as my evidence; the isolated snapshot result above and the fresh GREEN result below are independently reproducible.

## GREEN verification

Fresh focused verification:

```text
$ node tests/brainstorm-server/visual-companion-contract.test.js
PASS: visual companion useful-artifact contract assertions passed
```

Exit code: 0. Output contained no warnings or incidental noise.

## Self-review

- Reviewed every owned diff against the brief and the upstream operational source.
- Corrected an inherited gap where the architecture example described a Database outcome but did not render a Database node; added the node, flow edge, and contract assertion.
- Confirmed the architecture example is fragment-first, non-interactive, and contains no `data-*` metadata.
- Confirmed the four comparison patterns remain explicitly recommended and the five intents are examples rather than a whitelist.
- Confirmed active browser docs no longer contain `browser-use:browser`.
- Confirmed `git diff --check` reports no whitespace errors.

## Concerns

None.

## Fix Round 1

Review found that `skills/webapp-testing/SKILL.md` and `skills/frontend-direction/references/use-cases-prompts-and-flows.md` named the current Codex App browser capability but skipped installed-capability discovery when that capability was unavailable.

Changes:

- Updated both documents to use `browser:control-in-app-browser`, discover installed browser capabilities if it is unavailable, and only then fall back to `playwright-cli`.
- Updated the webapp-testing overview, browser-selection section, and skill description so the fallback rule is consistent at every active entry point.
- Strengthened `tests/brainstorm-server/visual-companion-contract.test.js` to assert the discovery-before-Playwright order in both webapp-testing routing sections and the frontend-direction shared rules.

RED command and output:

```text
$ node tests/brainstorm-server/visual-companion-contract.test.js
FAIL: visual companion useful-artifact contract assertions failed
Expected webapp-testing/SKILL.md discovery-before-playwright fallback to include "discover installed browser capabilities"
```

Exit code: 1. The failure was the expected missing-discovery contract.

GREEN command and output:

```text
$ node tests/brainstorm-server/visual-companion-contract.test.js
PASS: visual companion useful-artifact contract assertions passed
```

Exit code: 0. Output contained no warnings or incidental noise.

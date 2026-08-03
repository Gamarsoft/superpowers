# Visual Companion Useful Artifacts Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Broaden the Visual Companion into a safe, accessible useful-artifact surface while preserving its secure runtime and comparison strengths.

**Architecture:** Keep the server/protocol untouched. Extend the skill contract and example kit, progressively enhance existing `data-choice` markup in the helper, and activate shared frame accessibility/theme styles under the canonical test runner.

**Tech Stack:** Markdown skills, HTML/CSS/inline SVG, zero-dependency browser JavaScript, Node.js tests, shell tests.

**Global Constraints:**

- No new runtime dependencies, required metadata, persistence, auth, or server protocol.
- Consent, per-question visual fit, artifact-first ordering, terminal-primary feedback, and non-durable artifacts remain mandatory.
- Fragment-first and full-document compatibility remain intact.
- Existing comparison archetypes and authored `onclick="toggleSelect(this)"` screens remain valid.

---

## Plan Context

**Invariants:** Secure runtime behavior stays unchanged; `data-choice` is optional per artifact and remains the only interaction boundary when selection is useful; useful artifact intents are examples, not a whitelist.

**Non-goals:** Diagram DSL, Mermaid/runtime library, polished final UI, browser-only conversation, server refactor.

**Backward compatibility:** Existing fragments, full documents, selection indicator behavior, click events, carry-forward screens, and platform lifecycle remain green.

**Adversarial / Boundary Cases:** non-interactive diagrams; irrelevant decoration; pre-auth/bare URLs; explicit authored roles/tab indexes; Enter/Space repeated keys; multi-select state; dark-mode focus contrast.

## Chunk 1: Skill and Artifact Contract

### Task 1: Useful-Artifact Guidance and Operational Parity

**Files:**

- Modify: `skills/brainstorming/SKILL.md`
- Modify: `skills/brainstorming/visual-companion.md`
- Modify: `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`
- Create: `skills/brainstorming/examples/visual-companion/architecture-data-flow.html`
- Modify: `skills/webapp-testing/SKILL.md`
- Modify: `skills/frontend-direction/references/browser-surface-selection.md`
- Modify: `skills/frontend-direction/references/use-cases-prompts-and-flows.md`
- Test: `tests/brainstorm-server/visual-companion-contract.test.js`

**Interfaces and contracts:** Five non-exhaustive artifact intents (`compare`, `explain`, `map`, `experience`, `synthesize`); current Codex App browser capability `browser:control-in-app-browser`; existing server flags and keyed startup URL.

**Acceptance criteria:** Non-comparative relevant diagrams are allowed; comparison patterns remain first-class; every artifact names a viewing task and passes the generalized quality gate; irrelevant decoration stays terminal-only; operational guidance covers complete keyed URL, `--open`, persistence/restart, platform lifecycle, remote binding, and cleanup; active browser docs no longer require `browser-use:browser`; the architecture/data-flow example is intentionally non-interactive, omits `data-choice`, and uses no new runtime metadata.

**Error handling:** Missing design context uses explicit degraded mode; unavailable in-app browser capability falls back to installed capability discovery or `playwright-cli`; unreachable URLs use documented host/url-host guidance; a weak artifact is revised or omitted.

**Verification:** Run `node tests/brainstorm-server/visual-companion-contract.test.js`; expected all artifact, operational, browser-routing, example, and legacy protocol assertions pass.

**Codebase pointers:** Current guide and examples; `origin/main:skills/brainstorming/visual-companion.md` for the upstream operational sections; existing pressure scenarios; browser routing references listed above.

- [ ] Step 1: Read codebase pointers and understand existing patterns
- [ ] Step 2: Write failing tests from acceptance criteria
- [ ] Step 3: Run tests to verify they fail
- [ ] Step 4: Write minimal implementation to pass tests
- [ ] Step 5: Run tests, self-review, commit

## Chunk 2: Accessible and Theme-Aware Interaction

### Task 2: Keyboard Choices and Active Dark Theme

**Files:**

- Modify: `skills/brainstorming/scripts/helper.js`
- Modify: `skills/brainstorming/scripts/frame-template.html`
- Modify: `skills/brainstorming/examples/visual-companion/*.html`
- Modify: `skills/brainstorming/visual-companion.md`
- Test: `tests/brainstorm-server/helper-selection-clarity.test.js`
- Test: `tests/brainstorm-server/fragment-comparison-defaults.test.js`
- Test: `tests/brainstorm-server/visual-companion-contract.test.js`

**Interfaces and contracts:** Progressive accessibility on `[data-choice]`: focusability, button semantics, Enter/Space activation through the click path, and `aria-pressed` synchronized with `.selected`; active `prefers-color-scheme: dark` token override; visible `:focus-visible` treatment.

**Acceptance criteria:** Existing pointer selection stays unchanged; keyboard activation sends exactly one event and produces the same selection state; initial authored selections expose pressed state; multi-select remains container-scoped; the helper injects `role="button"` and `tabindex="0"` only when absent, preserves authored role/tabindex values, and always synchronizes `aria-pressed` from `.selected` during initial hydration and every update; light/dark focus remains visible; examples using `[data-choice]` consume shared color tokens or otherwise avoid fixed light-only foreground/background combinations that break dark-mode contrast; existing examples and fragments remain valid.

**Error handling:** Ignore key events outside `[data-choice]`; ignore keys other than Enter/Space; prevent Space scrolling during activation; tolerate minimal/full-document DOMs without a frame indicator; avoid workflow or carry-forward state in the helper.

**Verification:** Run `node tests/brainstorm-server/helper-selection-clarity.test.js`, `node tests/brainstorm-server/fragment-comparison-defaults.test.js`, and `node tests/brainstorm-server/visual-companion-contract.test.js`; expected all accessibility, theme, artifact, and legacy assertions pass.

**Codebase pointers:** Existing helper DOM test doubles and selection tests; current frame tokens and commented dark block; example kit's `data-choice` markup.

- [ ] Step 1: Read codebase pointers and understand existing patterns
- [ ] Step 2: Write failing tests from acceptance criteria
- [ ] Step 3: Run tests to verify they fail
- [ ] Step 4: Write minimal implementation to pass tests
- [ ] Step 5: Run tests, self-review, commit

## Chunk 3: Whole-Feature Verification

### Task 3: Pressure-Test, Regression Matrix, and Review

**Files:**

- Modify if required by failures: files from Tasks 1–2 only
- Verify: `docs/superpowers/specs/2026-07-31--visual-companion-useful-artifacts.md`

**Interfaces and contracts:** N/A — verification task; it introduces no new public interface.

**Acceptance criteria:** Five fresh agents using the revised skill choose a direct relevant diagram rather than terminal fallback or fake comparison under the fixed pressure scenario below; all canonical brainstorm runtime/custom tests pass; auth, lifecycle, full-document, carry-forward, platform, and packaging behavior remains unchanged; final review has no open Critical or Important findings.

**Error handling:** Fix only failures caused by this scope; record environmental sandbox bind failures separately and rerun outside the sandbox; do not weaken assertions to make tests pass.

**Fixed pressure scenario and rubric:** Give each fresh agent the revised `skills/brainstorming/SKILL.md` and `skills/brainstorming/visual-companion.md`, then ask it to choose exactly one route for: “The user has consented to the Visual Companion and asks how a proposed payment flow crosses Browser → API → Queue → Worker → Database, including retry, dead-letter, and trust-boundary behavior. There are no competing options.” Choices: **A** terminal prose only; **B** invent two alternatives and compare them; **C** display one subject-specific architecture/data-flow diagram in the companion, then continue the terminal discussion. Pass only when all five independently choose **C** and justify it using visual fit, subject relevance, useful relational/sequence encoding, a clear viewing task, and honest assumptions. Record each choice and rationale in the task evidence; any A/B choice is a failure requiring guidance revision and a five-agent rerun.

**Verification:** In order: run the three focused Node suites from Tasks 1–2; run `npm test` in `tests/brainstorm-server` (including `live-companion-acceptance.test.js` through the package runner); run `bash tests/claude-code/test-custom-policy-contracts.sh` and `bash tests/claude-code/test-sdd-custom-contracts.sh`; run the fixed five-agent pressure scenario; run `git diff --check`; dispatch `sp_code_reviewer` over the feature range and require no Critical or Important findings.

**Codebase pointers:** `tests/brainstorm-server/package.json`, integration spec/plan, and verification-before-completion skill.

- [ ] Step 1: Run the three focused Node suites and fix only regressions caused by Tasks 1–2
- [ ] Step 2: Run the full brainstorm-server suite, then the two named policy/platform suites; record commands and outcomes
- [ ] Step 3: Run the fixed scenario with five fresh agents, record each route/rationale, and revise then rerun all five if any agent chooses A or B
- [ ] Step 4: Run `git diff --check`, inspect the feature diff, and dispatch `sp_code_reviewer` over the feature range
- [ ] Step 5: Resolve every Critical/Important finding, rerun affected checks, obtain a clean review, and commit final corrections

## Invariant-to-Task Mapping

| Invariant | Implemented by | Re-verified by | Omission failure |
|---|---|---|---|
| Consent remains required and visual use is decided per question | Task 1 skill/guide contract | Task 1 static contract and Task 3 policy suites | The companion becomes an automatic parallel UI |
| Seeing must materially improve understanding or a decision | Task 1 viewing task and quality gate | Task 1 static contract and Task 3 five-agent rubric | Decorative or wasteful artifacts are shown |
| Artifact-first sequencing precedes the terminal question | Task 1 workflow wording | Task 1 static contract and Task 3 policy suites | The browser arrives after the decision it should inform |
| Terminal feedback remains authoritative and click events supplemental | Task 1 boundary wording; Task 2 keeps click transport unchanged | Task 1 helper/static contracts and Task 3 full suite | Browser interaction starts owning workflow state |
| Fragment-first authoring remains default and full documents remain compatible | Task 1 example/guide; no server change in Tasks 1–2 | Task 2 fragment/full-document suite and Task 3 full suite | Existing authored documents or fragment ergonomics regress |
| `data-choice` is optional per artifact and the only supported interaction boundary when selection is useful | Task 1 non-interactive example and guidance; Task 2 only enhances `[data-choice]` | Task 1 static/example contract, Task 2 helper suite, and Task 3 full suite | Non-interactive artifacts are rejected or new hidden metadata leaks in |
| Existing authored `onclick="toggleSelect(this)"` screens continue to work | Task 2 activation-through-click-path implementation | Task 2 helper suite and Task 3 full suite | Pointer behavior or event counts regress |
| Artifact intents stay open but relevance-gated | Task 1 intent and quality-gate wording | Task 1 static contract and Task 3 pressure scenario | Guidance becomes either a closed taxonomy or an unrestricted canvas |
| Secure runtime, file containment, restart, and lifecycle behavior stay unchanged | No server/protocol edits in Tasks 1–2; Task 1 restores operational guidance | Task 3 auth/lifecycle/full suite | Screens/events can leak or sessions stop recovering safely |
| Dark and keyboard improvements preserve authored semantics | Task 2 progressive enhancement and shared tokens | Task 2 helper/frame/example suites and Task 3 full suite | Choice semantics, contrast, or authored behavior regresses |
| Artifacts remain temporary and non-durable | Task 1 lifecycle/boundary guidance | Task 1 static contract and Task 3 policy suites | Companion output is mistaken for durable product evidence |

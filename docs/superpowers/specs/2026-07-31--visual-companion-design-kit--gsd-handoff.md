# GSD Handoff — Visual Companion Design Kit

## 1. Project Brief

### Vision

Make temporary Visual Companion artifacts feel deliberately designed for their
cognitive task while preserving the secure, build-free runtime.

### Primary user-visible outcome

Humans see clearer, more polished diagrams, realistic product mockups, and
decision summaries. Agents author them from a reusable system rather than
inventing an unrelated CSS treatment on every turn.

### Why now

The useful-artifact expansion proved the Companion can show the right kinds of
content. The live demonstration exposed visual hierarchy and consistency as the
next quality bottleneck.

## 2. Requirements Seed

### Active

- R1. Provide a dependency-free shared HTML/CSS design kit for fragment-first
  Companion artifacts.
- R2. Provide distinct diagram, product-mockup, and editorial/synthesis registers
  on one semantic foundation.
- R3. Make shell footer guidance conditional on actual interaction and connection
  state.
- R4. Deliver one browser-verified exemplar for each register.
- R5. Preserve all runtime, security, compatibility, accessibility, and
  terminal-primary invariants.
- R6. Document Impeccable as an optional authoring/review layer that never becomes
  a runtime or required test dependency.
- R7. Complete behavior-shaping skill evaluation with before/after evidence.

### Deferred

- D1. Restyle the remaining comparison and annotation examples after the first
  three exemplars prove the system.
- D2. Add additional registers only when repeated authoring needs justify them.
- D3. Consider optional Impeccable hooks, CI, or Live Mode in a separate scope.
- D4. Consider generated images only when a future viewing task benefits and the
  references receive explicit intent approval.

### Out of Scope

- O1. React, shadcn, Tailwind, CDN assets, remote fonts, or a new build pipeline.
- O2. Server, HTTP, WebSocket, authentication, persistence, or lifecycle changes.
- O3. New required metadata beyond `data-choice`.
- O4. A generic artifact schema, diagram DSL, or renderer.
- O5. Treating temporary Companion screens as durable product UI evidence.

## 2a. Requirements Reconciliation

### Reused unchanged

- The secure runtime requirements in
  `docs/superpowers/specs/2026-07-31-origin-main-integration.md` remain unchanged.
- The open useful-artifact taxonomy, non-interactive artifact support, and
  terminal-primary workflow in
  `docs/superpowers/specs/2026-07-31--visual-companion-useful-artifacts.md` remain
  unchanged.
- `.gsd/REQUIREMENTS.md` R001-R006 preserve comparison legibility,
  carry-forward meaning, the terminal-primary boundary, and the HTML/runtime
  contract.
- R007-R010 preserve the bounded screen-structuring/design-context workflow and
  explicit degraded mode. Optional Impeccable review does not replace it.
- R011-R015 preserve existing-screen compatibility, genuinely visual routing,
  the pre-display gate, and the prohibition on placeholder artifacts.
- R017-R018 preserve decision-capable example quality and the rule that flow
  artifacts must remain genuinely visual.
- R034-R037 preserve first-visual-turn startup, artifact-first sequencing,
  question-tool continuity, and explicitly named degraded fallback.
- R038-R040 preserve the named protocol pressure scenarios, their review gate,
  and the writing-skills plus TDD behavior-evaluation requirement.

### Reactivated from deferred

- R020 is reactivated only for the diagram register and its first exemplar. The
  broader diagram-pattern catalog, a DSL, and a renderer remain deferred.

### Narrowed / split / clarified

- Visual-quality work is narrowed to a shared foundation and three exemplars in
  the first delivery. Remaining historical examples stay available and are not
  silently included.
- Impeccable is clarified as optional authoring/review support, not a runtime
  dependency or replacement source of truth.
- R043 remains deferred: the three registers are presentation/composition modes
  inside the already approved useful-artifact intents, not new browser workflow
  archetypes or a browser-native confirmation flow.

### Superseded for this scope

- The unconditional generic footer instruction is superseded by the state-aware
  copy contract in the design spec.
- Stale `/impeccable teach` terminology is superseded by the current
  `/impeccable init` command where the existing reference discusses setup.
- Milestone-specific R016 is superseded for this scope only, allowing
  `carry-forward-summary.html` to become the editorial exemplar.
- Milestone-specific R019 is superseded for this scope only. Its runtime and
  `data-choice` invariants remain binding, but its four-archetype/no-presentation-
  change boundary does not block the approved register expansion and bounded
  helper/frame presentation work.
- Milestone-specific R045 is superseded for this scope only: bounded changes to
  `helper.js` and `frame-template.html` are active; `server.cjs` stays unchanged.

### Still deferred

- R021-R023 and R042-R044 remain deferred, including richer session memory,
  workflow orchestration, full-document helper parity, runtime enforcement,
  new workflow archetypes, and a broader wireframe catalog.
- Automatic Impeccable integration, complete example restyling, and extra
  presentation registers remain deferred.

### Still out of scope

- R030-R033 and R046-R047 remain out of scope: no server rewrite, mandatory DSL,
  terminal replacement, automatic full-document defaults, new required metadata,
  or browser-primary confirmation.

## 3. Milestone Recommendation

### First milestone

Approve the frontend-direction packet, then deliver the native design kit,
state-aware shell guidance, three exemplars, documentation, deterministic tests,
browser evidence, and behavior eval evidence as one bounded milestone.

### Why first

The system must prove both reusable foundations and real output quality. A kit
without exemplars is too abstract; a broad restyle before direction approval is
too risky.

### Success criteria

- The three registers look distinct but related and satisfy their viewing tasks.
- Existing artifacts remain compatible and all security/runtime tests pass.
- Non-interactive artifacts show no misleading choice footer.
- Desktop, narrow, light, dark, keyboard, focus, selection, and disconnect states
  have retained evidence.
- Fresh-agent before/after evals show the revised guidance produces stronger,
  register-appropriate artifacts without forcing browser use or fake choices.

### Key risks / unknowns

- Exact visual tokens and reference examples require frontend-direction approval.
- Excessive guidance could reduce author compliance; evals must test usability.
- The design kit could regress into generic cards unless the exemplars and review
  rubric enforce register-specific composition.

## 4. Context Seed

### Relevant codebase / prior art

- `skills/brainstorming/scripts/frame-template.html` — shared fragment shell and
  current visual tokens.
- `skills/brainstorming/scripts/helper.js` — connection, selection, accessibility,
  and footer behavior.
- `skills/brainstorming/visual-companion.md` — authoring and routing contract.
- `skills/brainstorming/examples/visual-companion/architecture-data-flow.html` —
  diagram exemplar candidate.
- `skills/brainstorming/examples/visual-companion/carry-forward-summary.html` —
  synthesis exemplar candidate.
- `skills/frontend-direction/references/impeccable-brownfield-quality-layer.md` —
  existing optional Impeccable guidance; contains stale setup terminology.
- `tests/brainstorm-server/` — canonical contract, accessibility, branding,
  security, lifecycle, and acceptance coverage.

### Constraints

- Core remains dependency-free and build-free.
- Skill changes must use `superpowers:writing-skills` and include adversarial
  before/after evaluation evidence.
- Frontend UI work cannot start before the separate frontend-direction packet is
  approved.
- Preserve current selectors and behaviors unless tests and the spec explicitly
  authorize a change.

### Integration points

- Fragment wrapping in `server.cjs`.
- Shared shell tokens and selectors in `frame-template.html`.
- Progressive enhancement and event behavior in `helper.js`.
- Example registry and quality gate in `visual-companion.md`.
- Existing brainstorm-server test runners and live acceptance checks.

### Open questions

No product questions block the frontend-direction phase. That phase owns exact
tokens, type treatment, motion, icon policy, responsive layouts, and retained
visual references.

## 5. Frontend Build Inputs

### Packet status

`required`

### Frontend direction packet

- `docs/superpowers/specs/2026-07-31--visual-companion-design-kit--frontend-direction.md`
  — not created yet; implementation gate.

### Frontend-direction follow-on prompt

- `docs/superpowers/specs/2026-07-31--visual-companion-design-kit--frontend-direction-prompt.md`

### Supporting frontend artifacts

- `brownfield-ui-extraction.md`: required in the packet.
- `screen-index.md`: required in the packet.
- retained current UI screenshots: use the three demo captures as
  `reference-only` problem evidence until the packet retains approved copies.
- implementation runtime screenshots: required after implementation.
- approved generated image references: none.
- reference intent: every retained screenshot or generated reference must be
  labeled `visual-truth`, `semantic-guidance`, or `reference-only`.

### Downstream frontend guidance

- Load `superpowers:frontend-direction`, the approved spec, this handoff, current
  runtime evidence, and the existing Impeccable brownfield-quality reference.
- Use current code and screenshots as brownfield truth before proposing changes.
- When Impeccable is available, use it only after baseline extraction and within
  the approved scope.

### UX implementation contract

- **Must preserve:** status accessibility, keyboard behavior, terminal-primary
  flow, first-visual-turn startup after consent, artifact-first sequencing,
  dedicated terminal question-tool continuity, explicitly named degraded fallback,
  honest fidelity labels, `data-choice`, and existing terminology where not
  superseded.
- **May adapt:** shell density, token values, typography, composition primitives,
  exemplar structure, and contextual footer visibility.
- **Explicit no-gos:** generic card grids, decorative gradients/grids, remote
  assets, framework dependencies, or technical implementation terms in copy.
- **Copy source:** the inline copy deck in section 5 of the design spec.
- **Missing copy states:** none for the first delivery.
- **i18n:** English source locale; preserve variable escaping, plural-ready count
  handling, text expansion, and accessible announcements.

### Frontend implementation gate

Do not implement UI changes until the separate frontend-direction packet and its
implementation-facing reference intents are approved. Temporary demo screenshots
and Companion artifacts are not visual truth by themselves.

## 6. Roadmap Seed

### Slice candidates

1. Frontend-direction packet, current-state captures, and approved references.
2. Shared kit plus state-aware shell/footer behavior.
3. Diagram, product-mockup, and editorial exemplars plus authoring guidance.
4. Deterministic verification, browser evidence, and writing-skills evals.

### Risk order

Approve visual direction first, then implement the shared shell before migrating
examples. Verify behavior on each slice; run fresh-agent evals after guidance is
complete.

### Depends-on notes

- Slice 2 depends on the approved frontend-direction packet.
- Slice 3 depends on stable shared primitives from slice 2.
- Slice 4 depends on all authored guidance and exemplars.

### Boundary map hints

- Frontend-direction produces approved visual tokens, references, and state rules.
- The frame consumes tokens/primitives; exemplar fragments consume shared classes.
- `helper.js` produces state classes/copy; the frame consumes them visually.
- Tests consume structural contracts and browser-visible behavior.

## 7. Acceptance Seed

### Rules

- No production dependency or build pipeline is added.
- No existing runtime/security/interaction behavior regresses.
- The first later genuinely visual turn after consent starts the Companion; every
  qualifying visual turn remains artifact-first and retains a dedicated terminal
  question, with plain text named as degraded when the question tool is absent.
- Non-interactive artifacts have no choice instruction.
- Every exemplar has a named viewing task and register-specific composition.
- Impeccable remains optional and advisory.

### Examples

1. Given a non-interactive architecture flow, when it is served as a fragment,
   then it uses diagram primitives, remains readable at narrow width, and shows no
   selection footer.
2. Given a selectable product mockup, when a keyboard user focuses and selects an
   option, then visible focus, `aria-pressed`, selection styling, event logging,
   and confirmation copy remain synchronized.
3. Given Impeccable is not installed, when an agent authors from the guide, then
   the complete native workflow and verification suite still work.

### Validation ideas

- Existing and new Node/shell contract tests under `tests/brainstorm-server/`.
- Real-browser desktop/narrow and light/dark captures.
- Keyboard and reconnect/disconnect scenarios.
- Fresh-agent before/after pressure tests following `writing-skills`.
- Optional advisory Impeccable critique/detector report.

### UAT notes

- The human should compare all three exemplars together, not judge one in
  isolation.
- UAT should explicitly answer whether the artifacts feel authored for different
  cognitive tasks and whether any still reads as generic AI-generated SaaS.

## 8. Decisions Register Seed

### Chosen direction

Native dependency-free kit, three visual registers, technical-editorial thesis,
three first-slice exemplars, optional Impeccable quality layer.

### Alternatives rejected

- Tailwind build layer — useful utilities do not justify a build path for dynamic
  temporary fragments.
- React plus shadcn — mature components but disproportionate renderer,
  dependency, and packaging cost.
- One universal house layout — consistent but repeats the current problem of
  making different artifact types look the same.
- Open art direction per artifact — expressive but unreliable and difficult to
  evaluate.

### Trade-offs accepted

- Fewer ready-made components in exchange for portability and control.
- Only three exemplars in the first delivery in exchange for validating the
  direction before broad migration.
- Impeccable benefits are optional so normal operation remains self-contained.

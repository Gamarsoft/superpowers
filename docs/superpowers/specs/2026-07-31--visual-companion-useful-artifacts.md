# Visual Companion Useful Artifacts and Usability Hardening

## 1. Executive Summary

- Extend the Visual Companion from an exclusively comparison-first surface into a general visual-thinking surface for brainstorming.
- Preserve comparison as a first-class optimized lane while allowing mockups, diagrams, annotated screenshots, maps, timelines, and other subject-relevant artifacts when seeing them materially improves understanding or decision quality.
- Close four integration gaps identified after the `origin/main` merge: operational guidance, Codex browser routing, keyboard accessibility, and active dark theming.
- Keep the existing secure server, fragment/full-document runtime, terminal-primary feedback loop, and `data-choice` compatibility boundary unchanged.

## 2. Framing Brief

- **Primary user / operator:** an agent facilitating brainstorming and the human inspecting browser artifacts.
- **Job / problem:** use the browser whenever spatial, structural, visual, or relational information is easier to understand by seeing it, without forcing every useful artifact into a fake comparison.
- **Current behavior:** the runtime can display arbitrary HTML, SVG, images, and mockups, but the skill says every screen must use one of four comparison archetypes. The operational guide also omits important keyed-session and restart behavior now present in the merged runtime.
- **Desired outcome:** agents can choose a relevant visual artifact based on the user's current cognitive task, operate the companion correctly, and offer keyboard-usable choices in light or dark mode.
- **Success signal:** a non-comparative architecture-flow scenario is routed to a direct companion diagram; comparison scenarios retain the existing strong archetypes; irrelevant decoration remains terminal-only.
- **Constraints:** no runtime dependency, protocol, auth, persistence, or required-metadata expansion.
- **Non-goals:** polished final UI production, a diagram DSL, Mermaid/runtime library adoption, browser-only conversation, or durable frontend-direction evidence.

## 3. Chosen Direction

Adopt a **useful-artifact model with comparison-first optimization**.

The companion may show any concrete artifact that materially improves the current brainstorming step. Named artifact intents provide a positive selection recipe rather than an exhaustive whitelist:

1. **Compare** — side-by-side directions or ranked alternatives.
2. **Explain** — annotated recommendation, screenshot, evidence board, or focused visual callout.
3. **Map** — architecture, data flow, state machine, sequence, dependency, journey, or relationship diagram.
4. **Experience** — mockup, wireframe, prototype fragment, layout, or interaction-state preview.
5. **Synthesize** — chosen direction, still-open questions, or carry-forward summary.

An artifact does not need a browser choice. `data-choice` remains the only supported interaction metadata when selection is useful, but non-interactive artifacts are valid and terminal feedback stays primary.

This wins because it matches the runtime's real capabilities, removes a demonstrated workflow contradiction, preserves the high-value comparison patterns, and remains reversible documentation/template work rather than a server redesign.

## 4. Scope and Boundaries

### In scope

- Rewrite the Visual Companion purpose and quality gate around useful, relevant artifacts rather than mandatory comparison.
- Retain the four existing comparison/carry-forward archetypes as recommended patterns, not a closed taxonomy.
- Add a concrete non-comparative architecture/data-flow example using fragment HTML and inline SVG/CSS only.
- Restore upstream operational instructions for `--open`, keyed URLs, session persistence, restart/reconnect, platform lifecycle, remote binding, and cleanup.
- Route Codex App browser use through `browser:control-in-app-browser`, with capability discovery/fallback language.
- Add keyboard activation and accessible state to injected `data-choice` elements without requiring authored metadata changes.
- Activate dark theme variables and add visible focus treatment.
- Update regression and pressure-scenario coverage.

### Out of scope

- Changes to `server.cjs`, authentication, WebSocket framing, event persistence, or lifecycle behavior.
- New required attributes beyond `data-choice`.
- A generic diagram renderer, external CDN/library, or structured artifact DSL.
- Making every brainstorming turn visual or treating temporary HTML as durable product direction.

### Invariants

- Consent remains required and use remains per-question.
- The browser is used only when seeing the artifact materially improves understanding or a decision.
- Artifact-first sequencing precedes the terminal question on qualifying visual turns.
- Terminal feedback remains authoritative; click events are supplemental.
- Fragment-first authoring remains default; full documents remain compatible.
- Existing authored `onclick="toggleSelect(this)"` screens continue to work.
- Security, file containment, restart, and lifecycle tests must remain green.

## 5. User Experience and Behavior

### Artifact routing

Before authoring, the agent states the viewing task: what the user should be able to understand, inspect, compare, or decide after seeing the artifact. It then chooses the smallest useful artifact intent. If prose or a small table is clearer, it stays in terminal.

The pre-display gate requires:

1. visual fit — seeing is materially better than reading;
2. subject relevance — real project concepts, content, evidence, or relationships;
3. useful visual encoding — the artifact exposes the differences, structure, sequence, state, evidence, or spatial relationship that matters;
4. clear viewing task — the user knows what to inspect, understand, or decide;
5. honest fidelity — assumptions, degraded context, and unresolved details are visible.

### Accessible choices

- Injected helpers make every `[data-choice]` element keyboard focusable.
- Enter and Space activate the same click path as pointer use.
- Elements expose button semantics and `aria-pressed` matching selected state.
- Existing selection indicator behavior and single/multi-select scoping remain unchanged.
- Visible focus styling works in light and dark themes.

### Operational flow

- The agent starts the server only after consent and uses `--open` when the platform should launch the user's browser.
- The complete keyed URL is preserved for first load; the bootstrap then removes the key from the visible URL.
- Project sessions persist under `.superpowers/brainstorm/`, reuse the preferred port/key on safe restart, and reconnect an open tab.
- Platform-specific foreground/background behavior and remote binds follow the upstream runtime contract.

## 6. System Design

- `skills/brainstorming/SKILL.md` owns per-turn routing and the terminal-primary invariant.
- `skills/brainstorming/visual-companion.md` owns artifact selection, authoring quality, operational use, and examples.
- `skills/brainstorming/examples/visual-companion/architecture-data-flow.html` demonstrates a useful non-interactive map artifact.
- `skills/brainstorming/scripts/helper.js` owns progressive accessibility for `data-choice` elements and keeps workflow semantics out of the client.
- `skills/brainstorming/scripts/frame-template.html` owns focus styles and active light/dark variables.
- Existing browser-surface references use the current Codex App capability name consistently.
- Existing Node and shell test runners remain canonical; no dependency is added.

## 7. Risks and Unknowns

- Broad wording could encourage decorative or low-value browser output. The viewing-task recipe and five-part quality gate mitigate this.
- A taxonomy could become another whitelist. The guide must call intents examples, not exhaustive archetypes.
- Keyboard handling could double-send events. Activation must route through the existing click path exactly once.
- Authored roles or tab indexes could be overwritten. Progressive enhancement should preserve explicit semantics where possible while guaranteeing operability.
- Dark theme could reduce contrast in custom inline styles. The shared tokens and example should avoid fixed light-only foreground colors.

## 8. Validation Plan

- RED pressure baseline: five agents using current guidance chose terminal-only for a useful non-comparative topology, while five no-guidance controls chose the direct browser diagram.
- Static/process contracts must prove the taxonomy is open, comparison patterns remain, irrelevant artifacts are rejected, and the architecture example is registered.
- Helper behavior tests must prove initial semantics, Enter/Space activation, one event per activation, and synchronized `aria-pressed` state.
- Frame tests must prove the dark variable override is active rather than commented and focus-visible styling exists.
- Operational guidance tests must cover keyed URL, `--open`, restart/reconnect, platform behavior, and remote bind language.
- Run the complete `tests/brainstorm-server` suite and all existing policy/platform tests affected by browser-route wording.

## 9. Open Questions

None blocking. Additional reusable diagram helpers may be added later only after real artifact authoring demonstrates repetition.

## Appendix A. Options Considered

- **Chosen: useful-artifact model with comparison-first optimization.** Broad capability, bounded by relevance and quality gates.
- **Fallback: comparison-only plus operational/accessibility fixes.** Lower documentation change, but preserves the proven diagram-routing failure.
- **Rejected: general-purpose visual canvas with no routing discipline.** Maximizes flexibility but invites decoration, token waste, and weak artifacts.

## Appendix B. Example Mapping

- Architecture explanation with no alternatives → direct map artifact; no forced `data-choice`.
- Two dashboard layouts → existing side-by-side comparison pattern.
- Existing screen with usability evidence → annotated screenshot/explanation artifact.
- Journey with failure states → sequence/state map, followed by terminal confirmation.
- Textual API trade-off → terminal table, not the companion.
- Decorative hero concept unrelated to the current question → reject or revise before display.

# Visual Companion Guide (comparison-first contract)

Use the visual companion to help the user decide between alternatives, not to generate polished mockups.

## v1 authoring contract

The companion is **comparison-first**. Every screen should map to exactly one of these four archetypes:

1. **side-by-side comparison**
   - Use when two directions are both credible and the user needs visual contrast.
   - Keep both options visible at once and comparable on the same decision axis.
2. **ranked alternatives**
   - Use when 3+ options are valid but one is currently strongest.
   - Keep all options visible and clearly show the current winner without hiding trade-offs.
3. **annotated recommendation**
   - Use when you have a recommended direction and need visual callouts explaining why.
   - Show recommendation + rationale + known constraints on one screen.
4. **carry-forward summary**
   - Use after a decision checkpoint.
   - Show both **Chosen direction** and **Still open** so downstream work does not assume unresolved items are settled.
   - If the screen is being authored in degraded mode, show that visibly in the screen copy instead of implying richer design context existed.

Do not invent extra archetypes in v1.

### Carry-forward authoring rule

Carry-forward continuity must live in visible authored copy, not in helper state, hidden metadata, or persisted browser events.

- Use **Chosen direction** when a recommendation or decision is being carried forward to the next screen.
- Use **Still open** when comparison work remains unresolved and should stay visibly unsettled.
- Use **Degraded mode** when richer design context was unavailable, declined, or insufficient so the screen remains honest about its low-assumption status.
- These labels should stay correct whether `state/events` exists, is empty, or was cleared on a newer screen.

### Copyable archetype example kit

Start from these authored fragments before inventing new structure:

- **side-by-side comparison** → [`examples/visual-companion/side-by-side-comparison.html`](examples/visual-companion/side-by-side-comparison.html)
  - Copy when exactly two directions are both credible and you need direct visual contrast on the same decision axis.
- **ranked alternatives** → [`examples/visual-companion/ranked-alternatives.html`](examples/visual-companion/ranked-alternatives.html)
  - Copy when three or more options are viable and you must show a visible current winner while keeping lower-ranked options visible.
- **annotated recommendation** → [`examples/visual-companion/annotated-recommendation.html`](examples/visual-companion/annotated-recommendation.html)
  - Copy when one recommendation is emerging and you need rationale plus known constraints on the same screen.
- **carry-forward summary** → [`examples/visual-companion/carry-forward-summary.html`](examples/visual-companion/carry-forward-summary.html)
  - Copy after a checkpoint so downstream work can see both what is decided and what remains unresolved.

### Active example refresh boundary (M002)

Refresh only `side-by-side-comparison.html`, `ranked-alternatives.html`, and `annotated-recommendation.html` in M002.
`carry-forward-summary.html` stays outside this refresh boundary unless a direct contradiction is found.

All examples stay fragment-first and use only the existing `data-choice` interaction boundary.

## Screen creation rule

When creating or revising companion screens, route the structuring step through **`/frontend-design`** or **`$frontend-design`**.

This is a **brainstorming structuring pass**, not a requirement for near-final visual polish. The purpose is:

- clear layout hierarchy
- comparable alternatives
- readable decision annotations
- reusable fragment structure

If a screen does not improve decision clarity, stay in terminal mode.

## First-use design-context workflow (bounded, required order)

Before the first companion screen in a session, follow this exact order:

1. **Instruction context first**
   - Reuse constraints already present in system/developer/user instructions.
2. **Repo design-context source if present**
   - Reuse repository context files (for example `.impeccable.md`) if they exist.
3. **One-time minimal session capture**
   - If context is still missing, capture only the minimum needed design cues once, then reuse for the session.
4. **Explicit degraded mode**
   - If context is unavailable, declined, or insufficient, proceed in **degraded mode** and say so explicitly.

Degraded mode means: keep screens low-assumption, emphasize structure over style, and avoid pretending project-specific design context exists.

## Offer rule

Offer the companion once for consent only when the upcoming question is genuinely visual.

Suggested offer message:

> Some of what we're working on might be easier to explain if I can show it to you in a web browser. I can put together mockups, diagrams, comparisons, and other visuals as we go. This feature is still new and can be token-intensive. Want to try it? (Requires opening a local URL)

Wait for acceptance before browser work.

## Per-question decision rule

Even after acceptance, decide per turn whether browser output helps more than text.

Test: **Is this materially easier to judge by seeing than by reading?**

If yes, the first later genuinely visual question starts the companion path instead of remaining terminal-only, and each qualifying visual turn stays artifact-first: author or refresh the visual artifact first, make it viewable, tell the user what they are viewing and what decision it supports, then ask the decision or confirmation in terminal with the platform question tool when available.
Even after earlier browser use, that terminal decision prompt still applies on later qualifying visual turns.
If the platform question tool is unavailable, fall back to plain terminal text with the same framing, and name that as degraded behavior instead of normalizing it.

For conceptual, scope, and text-first turns, stay in terminal.

## Pre-display quality gate

Before showing a screen, verify all four checks in order:

1. **Genuinely visual fit**
   - The decision must be materially easier to judge by seeing than by reading.
2. **Concrete subject-specific visual content**
   - The screen must show artifacts tied to the actual subject, workflow, or options under discussion.
3. **Visible differences that support the decision**
   - The compared directions must differ visually on the axis the user is choosing between.
4. **Clear recommendation or comparison legibility**
   - The current winner, rationale, or comparison labels must be readable without narration doing all the work.

No placeholder screens.
If any checklist item fails, revise the artifact or stay in terminal.

## Runtime compatibility boundary (do not exceed)

The current runtime contract is intentionally small:

- Fragment-first authoring is default.
- `full-document` screens remain supported for compatibility, but they are not the v1 default surface.
- Required interaction metadata stays bounded to `data-choice`.
- Use `toggleSelect(this)` on selectable cards/options so helper state and indicator text stay consistent.
- `.options` and `.cards` are recognized selection containers.
- `data-multiselect` is optional and only for true multi-select behavior.

Do not introduce new required metadata keys beyond `data-choice` in v1.

## How the server behaves

- Server serves the newest `.html` in `screen_dir`.
- If content is a fragment, runtime wraps it in the shared frame template.
- If content is a `full-document`, runtime serves it as-is (plus helper injection).
- Browser clicks with `data-choice` are appended to `state_dir/events`.

## Start and loop

### Start session

```bash
scripts/start-server.sh --project-dir /path/to/project
```

Capture:

- `url`
- `screen_dir`
- `state_dir`

### Iteration loop

1. Confirm server is alive (`state_dir/server-info`; restart if `state_dir/server-stopped` exists).
2. Write a new `.html` file into `screen_dir` (never reuse filenames).
3. Tell the user what they are viewing and what decision it supports.
4. On the next turn, combine terminal feedback with `state_dir/events` (terminal feedback remains primary).
5. Iterate or move forward with a new file name (`*-v2.html`, etc.).
6. When returning to terminal-only discussion, push a waiting/transition screen.

## Fragment authoring baseline

Minimal selectable fragment:

```html
<h2>Which direction should we carry forward?</h2>
<p class="subtitle">Compare clarity, implementation risk, and extensibility.</p>

<div class="options">
  <div class="option" data-choice="a" onclick="toggleSelect(this)">
    <div class="letter">A</div>
    <div class="content">
      <h3>Option A</h3>
      <p>Short explanation.</p>
    </div>
  </div>

  <div class="option" data-choice="b" onclick="toggleSelect(this)">
    <div class="letter">B</div>
    <div class="content">
      <h3>Option B</h3>
      <p>Short explanation.</p>
    </div>
  </div>
</div>
```

## Diagnostic references

- Frame template: `skills/brainstorming/scripts/frame-template.html`
- Helper behavior + `data-choice` handling: `skills/brainstorming/scripts/helper.js`
- Runtime fragment/full-document behavior: `skills/brainstorming/scripts/server.cjs`
- Runtime regressions: `tests/brainstorm-server/server.test.js`, `tests/brainstorm-server/ws-protocol.test.js`

## Cleanup

```bash
scripts/stop-server.sh /path/to/session-dir
```

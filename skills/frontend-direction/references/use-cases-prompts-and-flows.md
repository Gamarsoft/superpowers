# Use Cases, Prompts, and Flows

Use this file when you need a concrete frontend workflow shape instead of only the abstract skill rules.

The scenarios below are intentionally short. Adapt them to the current repo and scope.

## Shared Rules

- Brownfield default: preserve first, improve second.
- For browser interaction, use `browser-use:browser` in Codex App and `playwright-cli` otherwise.
- If no durable design evidence exists yet, create a faithful baseline from the running product before exploring variants.
- Use HTML companion artifacts for comparison only.
- Converge durable truth into screenshots, packet prose, and either approved ChatGPT Images 2 files or `.pen` files.
- In the split workflow, use `brainstorming` first to approve the spec and GSD handoff, then start `frontend-direction` from the follow-on prompt in a fresh or compacted session.
- If a project-level `PRODUCT.md` already exists and is still accurate, do not re-run `/impeccable teach`.
- If the repo has Impeccable v3, read `PRODUCT.md` and `DESIGN.md` before refinement. Treat `DESIGN.json` as auxiliary tooling output, not the primary contract.

## 1. Brownfield: New Feature on an Existing Screen

### When this applies

- one existing route or screen is being extended
- there is no approved frontend packet yet
- the running app is the real visual source of truth

### Prompt shape

Use `brainstorming` first for the product spec and GSD handoff. Then use the follow-on prompt with `frontend-direction`: the screen already exists in the running app, but there is no durable design evidence yet. Preserve the current shell and product language, capture a faithful runtime baseline first, then produce the frontend packet and choose whether approved ChatGPT Images 2 references or Pencil boards are the implementation visual truth.

### Flow

1. choose brownfield-small-feature or brownfield-major-feature in brainstorming
2. approve the design spec and GSD handoff
3. start a new or compacted frontend-direction session from the follow-on prompt
4. capture current runtime baseline:
   - desktop screenshot
   - narrow/mobile screenshot
   - key state screenshots for the changed area
5. write `brownfield-ui-extraction.md`
6. create `screen-index.md`
7. use ChatGPT Images 2 prompts when image-native references are needed
8. ask the human to select ChatGPT Images 2 image-only visual truth or Pencil translation
9. if Pencil is selected, recreate the existing screen baseline in Pencil
10. explore only the approved delta
11. finalize packet and selected visual-truth references
12. implement with `gsd-frontend-design`

### Main risk

Jumping from code inspection to improved mockups without first reproducing the actual screen.

## 2. Brownfield: New Screen in an Existing Product

### When this applies

- a new route or page is being added
- the product system already exists
- there may be screenshots of neighboring screens but no workset for the new feature yet

### Prompt shape

Use `brainstorming` first, then run `frontend-direction` from the follow-on prompt for the new screen in a brownfield product. Preserve the existing shell, navigation rhythm, component language, and density. Build a packet and selected visual-truth references that show how the new screen fits the current system before implementation.

### Flow

1. classify scope and affected workflow in brainstorming
2. approve the design spec and GSD handoff
3. start frontend-direction from the follow-on prompt
4. extract shell, shared patterns, and neighboring screens
5. document `Must preserve`, `May adapt`, and `Explicit no-gos`
6. create `brownfield-ui-extraction.md`
7. create the new screen inventory and key states
8. create ChatGPT Images 2 references if useful, then ask for the visual-truth choice
9. build shared `.pen` boards first, then the feature board only if Pencil is selected
10. explore 1-2 bounded variants if needed
11. finalize packet and implement conservatively

### Main risk

Treating the new screen as greenfield and accidentally breaking family resemblance.

## 3. Brownfield: Specific Existing Screen Improvement

### When this applies

- the request is improvement-focused, not feature-heavy
- examples: hierarchy cleanup, copy clarity, error handling, responsive adaptation, accessibility fixes

### Prompt shape

Use `frontend-direction` for a brownfield improvement pass on an existing screen. Start from a faithful runtime baseline, then separate conservative normalization from any directional change. If design-quality work is needed, use Impeccable as a refinement layer after the baseline exists.

### Flow

1. capture the current screen and key states
2. write observed current truth
3. list conservative normalization targets
4. run bounded quality analysis:
   - `/impeccable critique`
   - `/impeccable audit`
5. approve only the improvements that fit the current scope
6. update packet, screenshots, and approved image or `.pen` references
7. implement and verify

### Main risk

Using quality feedback as permission to redesign the product.

## 4. Greenfield: New Feature with UI Contract Needed

### When this applies

- no meaningful legacy screen exists for this scope
- layout, states, and interaction detail will materially shape implementation

### Prompt shape

Use `brainstorming` for greenfield work, then start a separate `frontend-direction` session from the follow-on prompt to create a durable frontend contract before implementation. Converge the chosen direction into approved ChatGPT Images 2 references or a Pencil workset plus an implementation-ready packet instead of relying on loose screenshots.

### Flow

1. choose the greenfield track
2. stabilize the first delivery boundary and key flows
3. approve the design spec and GSD handoff
4. start frontend-direction from the follow-on prompt
5. create the screen index and key states
6. create ChatGPT Images 2 references when useful
7. ask the human to select image-only visual truth or Pencil
8. build the Pencil workset only if Pencil is selected
9. explore baseline plus 1-2 variants on the real decision axis
10. finalize the packet
11. implement with `gsd-frontend-design`

### Main risk

Leaving too much visual direction implicit and forcing implementation to invent UI.

## 5. Greenfield: New Product or New Area with Strong Design Ambition

### When this applies

- greenfield scope
- the user explicitly wants stronger visual direction or quality

### Prompt shape

Use `brainstorming` to define the product, then use a separate `frontend-direction` session to define the frontend contract. If design-quality refinement is needed, use Impeccable after product framing is stable. Keep the result grounded in the chosen audience, use case, and tone, then converge the winning direction into packet prose and the selected visual-truth source.

### Flow

1. stabilize product framing in brainstorming
2. approve the design spec and GSD handoff
3. start frontend-direction from the follow-on prompt
4. if needed, ensure `PRODUCT.md` exists or run `/impeccable teach`
5. create ChatGPT Images 2 references or the baseline design direction in Pencil
6. if present, read `DESIGN.md`; use `/impeccable critique` or `/impeccable audit` to pressure-test quality
7. refine with bounded improvements
8. finalize the packet and selected visual-truth references
9. implement from the approved contract

### Main risk

Using high-design exploration without locking the product or interaction contract first.

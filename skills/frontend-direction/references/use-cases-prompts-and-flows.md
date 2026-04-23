# Use Cases, Prompts, and Flows

Use this file when you need a concrete frontend workflow shape instead of only the abstract skill rules.

The scenarios below are intentionally short. Adapt them to the current repo and scope.

## Shared Rules

- Brownfield default: preserve first, improve second.
- For browser interaction, use `browser-use:browser` in Codex App and `playwright-cli` otherwise.
- If no durable design evidence exists yet, create a faithful baseline from the running product before exploring variants.
- Use HTML companion artifacts for comparison only.
- Converge durable truth into screenshots, packet prose, and `.pen` files.
- If a project-level `.impeccable.md` already exists, do not re-run `impeccable teach`.

## 1. Brownfield: New Feature on an Existing Screen

### When this applies

- one existing route or screen is being extended
- there is no approved frontend packet yet
- the running app is the real visual source of truth

### Prompt shape

Use `brainstorming` for a brownfield existing-screen feature. The screen already exists in the running app, but there is no durable design evidence yet. Preserve the current shell and product language, capture a faithful runtime baseline first, then produce the frontend packet and Pencil workset before implementation.

### Flow

1. choose brownfield-small-feature or brownfield-major-feature
2. capture current runtime baseline:
   - desktop screenshot
   - narrow/mobile screenshot
   - key state screenshots for the changed area
3. write `brownfield-ui-extraction.md`
4. create `screen-index.md`
5. recreate the existing screen baseline in Pencil
6. explore only the approved delta
7. finalize packet and workset
8. implement with `gsd-frontend-design`

### Main risk

Jumping from code inspection to improved mockups without first reproducing the actual screen.

## 2. Brownfield: New Screen in an Existing Product

### When this applies

- a new route or page is being added
- the product system already exists
- there may be screenshots of neighboring screens but no workset for the new feature yet

### Prompt shape

Use `brainstorming` and `frontend-direction` for a new screen in a brownfield product. Preserve the existing shell, navigation rhythm, component language, and density. Build a packet and Pencil workset that show how the new screen fits the current system before implementation.

### Flow

1. classify scope and affected workflow
2. extract shell, shared patterns, and neighboring screens
3. document `Must preserve`, `May adapt`, and `Explicit no-gos`
4. create `brownfield-ui-extraction.md`
5. create the new screen inventory and key states
6. build shared `.pen` boards first, then the feature board
7. explore 1-2 bounded variants if needed
8. finalize packet and implement conservatively

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
   - `critique`
   - `audit`
5. approve only the improvements that fit the current scope
6. update packet, screenshots, and `.pen` boards
7. implement and verify

### Main risk

Using quality feedback as permission to redesign the product.

## 4. Greenfield: New Feature with UI Contract Needed

### When this applies

- no meaningful legacy screen exists for this scope
- layout, states, and interaction detail will materially shape implementation

### Prompt shape

Use `brainstorming` for greenfield work, then `frontend-direction` to create a durable frontend contract before implementation. Converge the chosen direction into a Pencil workset and implementation-ready packet instead of relying on loose screenshots.

### Flow

1. choose the greenfield track
2. stabilize the first delivery boundary and key flows
3. create the screen index and key states
4. build the Pencil workset
5. explore baseline plus 1-2 variants on the real decision axis
6. finalize the packet
7. implement with `gsd-frontend-design`

### Main risk

Leaving too much visual direction implicit and forcing implementation to invent UI.

## 5. Greenfield: New Product or New Area with Strong Design Ambition

### When this applies

- greenfield scope
- the user explicitly wants stronger visual direction or quality

### Prompt shape

Use `brainstorming` and `frontend-direction` to define the product and frontend contract. If design-quality refinement is needed, use Impeccable after product framing is stable. Keep the result grounded in the chosen audience, use case, and tone, then converge the winning direction into packet prose and `.pen` files.

### Flow

1. stabilize product framing
2. if needed, ensure `.impeccable.md` exists or run `impeccable teach`
3. create the baseline design direction in Pencil
4. use `critique` or `audit` to pressure-test quality
5. refine with bounded improvements
6. finalize the packet and workset
7. implement from the approved contract

### Main risk

Using high-design exploration without locking the product or interaction contract first.

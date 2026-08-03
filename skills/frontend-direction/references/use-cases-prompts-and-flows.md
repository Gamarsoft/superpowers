# Use Cases, Prompts, And Flows

Use when a concrete frontend workflow shape is useful.

## Shared Rules

- Brownfield default: preserve first, improve second.
- For browser interaction in Codex App, use `browser:control-in-app-browser`; if unavailable, discover installed browser capabilities, then fall back to `playwright-cli`. Outside Codex App, use `playwright-cli`.
- If no durable visual evidence exists, capture a faithful runtime baseline before exploring variants.
- HTML companion artifacts are temporary useful-artifact surfaces, not durable frontend-direction evidence.
- Durable truth lives in concise packet prose, `screen-index.md`, `brownfield-ui-extraction.md`, retained screenshots/browser captures, and optional approved ChatGPT Images 2 files.
- In the split workflow, use `brainstorming` first for spec and GSD handoff, then start `frontend-direction` from the follow-on prompt.
- If `PRODUCT.md` and `DESIGN.md` already exist and are current, read them; do not regenerate them by default.

## 1. Brownfield: New Feature On Existing Screen

Prompt shape:

Use `brainstorming` first for the product spec and GSD handoff. Then use the follow-on prompt with `frontend-direction`: the screen already exists in the running app, but durable visual evidence is missing. Preserve current shell and product language, capture runtime baseline screenshots first, then produce the frontend packet with source evidence, reference intent, preserve/adapt/no-go boundaries, UX copy source, and verification gates.

Flow:

1. approve spec and GSD handoff
2. start `frontend-direction` from the follow-on prompt
3. capture desktop, narrow/mobile, and key-state screenshots
4. write `brownfield-ui-extraction.md`
5. create `screen-index.md`
6. use ChatGPT Images 2 prompts only when image-native references would clarify a real decision
7. finalize approved references and packet
8. implement with `gsd-frontend-design`

Main risk: improving from code inspection without first reproducing the actual screen.

## 2. Brownfield: New Screen In Existing Product

Prompt shape:

Use `frontend-direction` for the new screen in a brownfield product. Preserve shell, navigation rhythm, component language, density, and visual family unless the packet explicitly changes them.

Flow:

1. extract shell, shared patterns, neighboring screens, and current captures
2. document `Must preserve`, `May adapt`, and `Explicit no-gos`
3. create `brownfield-ui-extraction.md`
4. create the screen inventory and key states
5. create optional ChatGPT Images 2 references if useful
6. finalize packet and implement conservatively

Main risk: treating the new screen as greenfield and breaking family resemblance.

## 3. Brownfield: Specific Existing Screen Improvement

Prompt shape:

Use `frontend-direction` for a brownfield improvement pass. Start from a faithful runtime baseline, then separate conservative normalization from any directional change.

Flow:

1. capture current screen and key states
2. write observed current truth
3. list conservative normalization targets
4. run bounded quality analysis if useful
5. approve only in-scope improvements
6. update packet, screenshots, and approved references
7. implement and verify

Main risk: using quality feedback as permission to redesign.

## 4. Greenfield: New Feature With UI Contract Needed

Prompt shape:

Use `brainstorming` for product direction, then start `frontend-direction` to create a durable frontend contract before implementation.

Flow:

1. stabilize first delivery boundary and key flows
2. approve spec and GSD handoff
3. create screen index and key states
4. create optional ChatGPT Images 2 references when useful
5. finalize packet with source evidence, reference intent, implementation contract, verification, and open questions
6. implement with `gsd-frontend-design`

Main risk: leaving visual direction implicit and forcing implementation to invent UI.

## 5. Greenfield: Strong Design Ambition

Prompt shape:

Use `brainstorming` to define the product, then `frontend-direction` to define the frontend contract. Keep exploration grounded in audience, use case, tone, copy, states, and implementation boundaries.

Flow:

1. stabilize product framing
2. approve spec and GSD handoff
3. start `frontend-direction`
4. create optional ChatGPT Images 2 references if they improve the decision
5. pressure-test quality against product and interaction constraints
6. finalize packet and approved references
7. implement from the approved contract

Main risk: high-design exploration without locked product or interaction contract.

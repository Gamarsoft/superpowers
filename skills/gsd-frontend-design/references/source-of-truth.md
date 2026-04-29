# Source of Truth

Read this before planning, designing, or changing UI code.

## Precedence order

Use the strongest available source in this order.

### Functional contract

1. **Approved spec, approved handoff, and acceptance criteria**
2. **Current product behavior** when the spec is silent

### Visual contract

For brownfield work, think in layers instead of only a flat ranking:

1. **Existing product UI and design system** as the baseline system truth
2. **Approved frontend direction packet** for the intentional in-scope change
3. **Declared implementation visual-truth source** in the packet: `chatgpt-image-2`, `pencil`, or `current-ui/degraded`
4. **Approved visual-reference intent metadata** for relevant ChatGPT Images 2 images, `.pen` boards, screenshots, browser captures, or Pencil exports
5. **Approved ChatGPT Images 2 generated image files** when `chatgpt-image-2` is selected
6. **`pencil-workset.md` and relevant `.pen` files** when `pencil` is selected
7. **`brownfield-ui-extraction.md` and `screen-index.md`** as the packet’s implementation evidence
8. **Retained screenshots, browser captures, or Pencil exports** according to their approved intent mode
9. **Project-level `PRODUCT.md` and current `DESIGN.md`** as product/register context and documented system guidance
10. **Existing component library, tokens, and app-shell conventions**
11. **This skill’s implementation-quality references and Pencil skills when Pencil is selected**
12. **Freeform invention** only for genuinely unspecified gaps

Later items do not overrule earlier items without an explicit reason.

`DESIGN.json` is auxiliary Impeccable tooling output, not a stronger source than the packet, `.pen` files, or retained browser evidence.

## Brownfield baseline rule

If no durable frontend packet or approved visual-truth baseline exists yet for the changed screen, treat retained browser evidence from the running app as mandatory input.

Do not rely on code-only visual inference for:

- spacing rhythm
- shell hierarchy
- responsive breakpoints
- empty/loading/error state treatment
- action placement
- density and scan path

## Pencil skill rule

`pencil-design-core` and any stack adapter are **interpretation tools**.
They help you consume and translate the approved evidence.
They do not outrank the packet, approved generated images, `.pen` files, or the current product system.

When the packet declares `chatgpt-image-2` visual truth, Pencil skills are not part of the source chain for that scope. Use the approved generated image files as binding visual screenshots and omit `.pen` expectations.

## What to extract before coding

Capture these before you edit code:

- linked spec, route, flow, or slice scope
- the affected screens or components
- chosen direction for each key screen
- responsive contract
- state coverage
- accessibility constraints
- **Must preserve**
- **May adapt**
- **Explicit no-gos**
- approved generated image files when ChatGPT Images 2 is selected
- exact `.pen` files when Pencil is selected
- screenshots that are in scope
- approved reference intent for each implementation-facing image, board, or screenshot
- which Pencil skills should be loaded, only when Pencil is selected
- verification plan

## Brownfield rule

Brownfield default is preservation.

Preserve unless the packet explicitly changes them:

- navigation patterns
- shell structure
- tokens and spacing rhythm
- component APIs and affordances
- copy conventions and interaction expectations
- operator density when the screen is operationally dense

## When sources disagree

### Packet vs current code
1. Check whether the packet intentionally calls for a change.
2. Check whether the current code pattern is a system rule or just a local inconsistency.
3. Prefer the packet for intentional new direction inside the approved scope.
4. Prefer the existing system when the packet is silent.
5. Use the approved reference intent, generated image, `.pen` file, or retained screenshot to resolve ambiguity before acting.
6. If the conflict remains material, surface it instead of silently choosing.

### Approved visual reference vs current code
1. Confirm that you opened the correct approved ChatGPT Images 2 file or `.pen` file for the current task.
2. Check the approved reference intent.
3. If intent is missing or pending, ask for confirmation before visual changes.
4. If confirmation is unavailable, do not treat the image or board as visual truth; record degraded mode or a blocker.
5. If the approved image or `.pen` file expresses an approved local screen change, implement the in-scope change while preserving shared system rules.
6. If it looks like a system-wide pattern change but the packet does not authorize it, do not expand the change silently.
7. Record any mismatch that should trigger a packet, image set, or workset refresh.

### Stack adapter vs repo reality
1. The adapter may suggest a translation pattern.
2. If that pattern conflicts with the repo’s proven shared primitives, prefer the repo.
3. If the adapter exposes a repeated repo weakness, improve conservatively instead of redesigning broadly.

### HTML companion artifact vs selected visual truth
1. The HTML companion is a temporary decision surface.
2. Once the chosen direction is translated into approved images, `.pen` files, or packet prose, the durable selected visual-truth source wins.
3. Do not implement directly from stale HTML companion screens when the packet and selected visual-truth source already converged.

## Degraded mode

If no packet or no approved visual-truth source exists, say so explicitly.

Then use, in order:

- existing product UI
- existing component library and tokens
- current browser captures or screenshots
- this skill’s reference files

Keep invention conservative and avoid accidental redesign.

## Deviation rule

If you must deviate from the packet, the workset, or the current system, record:

- what changed
- why the original direction could not be implemented as written
- whether the deviation is visual only or behavior-affecting
- whether approved ChatGPT Images 2 files, `.pen` files, or retained screenshots were consulted
- which Pencil skills were loaded, if any
- whether the packet, image references, or workset should be updated after implementation

# ChatGPT Images 2 Source Consumption

Use this when the frontend direction packet declares `chatgpt-image-2` as the implementation visual-truth source.

## Retrieval ladder

1. Read the frontend direction packet.
2. Read `screen-index.md`.
3. Open `chatgpt-image-2/README.md` and `attachment-map.md`.
4. Open every approved generated image file named by the packet or screen index.
5. Read `00-shared-image-context.md` only for reference-role and no-go context.
6. Inspect current product UI, tokens, shell, and components for brownfield fit.

Do not require `pencil-workset.md`, `.pen` files, Pencil exports, or Pencil skills for this scope.

## How to use approved images

Treat approved generated images as binding visual screenshots, not production code.

Extract:

- shell and layout continuity
- major surfaces and containers
- section order and visual weight
- control emphasis and action hierarchy
- density, spacing rhythm, and alignment
- typography emphasis and numeric treatment
- state treatment and responsive flow

Translate the image into the repo's real framework, components, tokens, and accessibility constraints. Preserve brownfield behavior and contracts even when the image is visually binding.

## Verification

For each `visual-truth` image, compare runtime screenshots and record `pass`, `mismatch`, or `waived` for:

- page background and major containers
- cards, panes, borders, radius, padding, and elevation
- primary, secondary, neutral, and destructive control priority
- typography scale, weight, and density
- section order and scan path
- named desktop/mobile states

Waivers must name the source image, mismatch, implementation constraint, accepted fallback, and follow-up.

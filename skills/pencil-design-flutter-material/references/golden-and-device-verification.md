# Golden And Device Verification

Use this to prove Flutter UI matches approved Pencil intent.

## Evidence Types

Native Flutter runtime proof may include:

- `flutter analyze` or repo-level Melos analysis
- `flutter test` or repo-level Melos tests
- widget tests for state rendering and interactions
- golden tests for stable visual variants
- simulator/device screenshots for approved visual-truth screens
- UI gallery or catalog verification for `app_ui` components
- accessibility guideline tests or manual accessibility checks

Do not require browser evidence for native Flutter screens unless the target is Flutter Web.

## Reference-Intent Verification

For every approved `visual-truth` board or screenshot, record pass/mismatch/waived for:

- surface hierarchy and background treatment
- primary/secondary action priority
- typography hierarchy
- spacing rhythm and alignment
- component variants and states
- responsive/mobile flow
- safe-area and keyboard behavior where relevant

For every `semantic-guidance` board, record pass/mismatch/waived for:

- behavior or workflow
- content priority
- state coverage
- adaptation into the app's Flutter design system

Screenshots alone are not proof. The agent must state what was compared and what matched.

## Golden Tests

Use goldens when:

- the repo already supports golden testing
- the component or screen is visually stable enough
- the board is `visual-truth` or the shared component is design-system-critical
- fonts/assets can be loaded consistently in the test harness

Avoid goldens as the only evidence for flows with live maps, camera, remote images, animations, or platform rendering that is intentionally variable.

## Widget Tests

Widget tests should cover:

- state rendering
- empty/error/loading variants
- disabled and selected states
- callbacks and navigation triggers
- localized labels when practical
- accessibility expectations supported by the repo

## Simulator Or Device Screenshots

Capture target devices named by the packet. If none are named, use compact iPhone, compact Android, and large phone when practical.

Review:

- no clipping or overlap
- visible content at text scale
- keyboard inset behavior for forms
- safe-area behavior
- action reachability
- parity with approved board intent

## Completion Gate

Before reporting done, include:

- commands run and result
- tests/goldens added or updated
- devices/viewports checked
- reference-intent checklist result
- waivers with source board, mismatch, constraint, accepted fallback, and follow-up owner

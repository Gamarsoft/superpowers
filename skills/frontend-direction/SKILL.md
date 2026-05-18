---
name: frontend-direction
description: Use after product direction is stable but visual direction is not, especially when brownfield UI work needs a durable frontend contract, screen inventory, visual-truth source, or repo-local design evidence before implementation.
---

# Frontend Direction

Create explicit visual direction before production frontend code is written.

This skill is for the design-direction step between product discovery and implementation. It usually starts from an approved design spec, approved GSD handoff, and frontend-direction follow-on prompt produced by `brainstorming`.
It produces the packet and reference assets that later implementation agents should follow.
For downstream GSD workflows, assume Pencil CLI interactive mode is the only allowed Pencil transport when the human chooses Pencil as the visual-truth source.

Do **not** use this skill as a frontend coding skill.

## Outputs

Write:

- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend-direction.md`
- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/screen-index.md`
- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/brownfield-ui-extraction.md` _(brownfield default)_

When ChatGPT Images 2 references are requested or needed before selecting implementation visual truth, write:

- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/chatgpt-image-2/`

When the human selects Pencil as the implementation visual-truth source, also write:

- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/pencil-workset.md`

When you generated or gathered reference imagery, also write:

- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/screenshots/`

When the human selects Pencil as the implementation visual-truth source, also maintain:

- `design/pencil/_shared/00-foundations.pen`
- `design/pencil/_shared/10-shell.pen`
- `design/pencil/_shared/20-patterns.pen`
- `design/pencil/{slug}/30-{slug}.pen`

## Read order

1. Read `references/design-source-priority.md`.
2. Read `references/use-cases-prompts-and-flows.md` when you need a concrete scenario flow or prompt shape.
3. Read `../mobile-product-direction/SKILL.md` when the target is native mobile, mobile-first, or a greenfield app where mobile flow and screen direction are not already settled.
4. Read `../mobile-interaction-and-usability/SKILL.md` when mobile navigation, forms, gestures, permissions, state behavior, text scaling, or accessibility materially shapes the packet.
5. Read `../mobile-visual-design/SKILL.md` when mobile visual quality, native polish, hierarchy, or aesthetic direction is part of the packet.
6. Read `references/pencil-skill-selection.md`.
7. Read `references/browser-surface-selection.md` when browser interaction is needed.
8. Read `references/impeccable-brownfield-quality-layer.md` when brownfield quality refinement is in scope.
9. Read `references/frontend-packet-folder-template.md`.
10. Read `references/brownfield-ui-extraction-template.md` when the work is brownfield.
11. Read `references/screen-index-template.md`.
12. Read `../creating-chatgpt-image-upload-packs/SKILL.md` when ChatGPT Images 2 references are requested, useful, or required to stabilize visual-truth candidates before implementation.
13. Read `references/pencil-workset-template.md` when Pencil remains a possible or selected visual-truth source.
14. Read `references/frontend-direction-template.md`.
15. Read `../mobile-design-review/SKILL.md` before finalizing non-trivial native/mobile-first packets.
16. Read `references/frontend-review-checklist.md`.
17. Read `references/frontend-packet-completeness-checklist.md` before finalizing.

## Workflow

1. Gather the approved spec, approved GSD handoff, frontend-direction follow-on prompt, durable wireframes, current screenshots, and design-system context.
   - If the repo uses Impeccable v3, also gather any project-level `PRODUCT.md` and `DESIGN.md`.
   - Treat the follow-on prompt as startup context, not as a substitute for the actual packet.
2. In brownfield work, decide whether a runtime baseline capture pass is required:
   - read `references/browser-surface-selection.md` before browser interaction
   - if the current screen truth exists only in source code and the running app, capture browser-grounded evidence before inventing any packet artifacts
   - gather desktop and narrow/mobile screenshots for the current screen
   - gather key states for the changed area: loading, empty, validation/error, disabled/permission when relevant
   - capture focused close-ups for high-risk regions and record short notes on hierarchy, spacing, density, and action placement
   - use the running app as the layout truth; use source code as support, not as the only visual source
3. Decide the design-truth source:
   - brownfield default: preserve and extend the current product language
   - redesign: only when explicitly intended
   - degraded mode: when richer design context is unavailable
   - when present, treat `PRODUCT.md` as product/register context and `DESIGN.md` as reusable system documentation, but keep current runtime truth above both in brownfield work
4. Identify the target frontend stack. Use `references/pencil-skill-selection.md` only to choose a downstream Pencil adapter if Pencil remains a possible or selected visual-truth source.
   - If the target is native mobile or mobile-first and the mobile flow is not already settled, use `mobile-product-direction` to define the mobile jobs, screen inventory, primary actions, state matrix, and native-vs-web risks before visual-truth selection.
   - If mobile interaction patterns are material, use `mobile-interaction-and-usability` to record navigation, forms, gestures, permissions, text scaling, tap targets, semantics, and recovery behavior.
   - If mobile visual quality is material, use `mobile-visual-design` to record the product feel, first-screen impression, hierarchy, typography, spacing, color roles, motion, and anti-patterns.
5. In brownfield work, create `brownfield-ui-extraction.md` before asking for visual variants.
   - separate `observed current truth`, `conservative normalization target`, and `optional exploration`
   - for existing-screen work with no prior durable evidence, the first packet job is faithful reproduction, not improvement
6. Build the screen index for the key screens and key states only.
7. If screens, states, images, prompts, or references contain user-visible text, use `writing-ux-copy` before visual-truth selection:
   - carry approved copy from the spec or GSD handoff when present;
   - create or update a copy deck for missing labels, CTAs, helper text, warnings, errors, empty states, confirmations, permission copy, and loading/pending states;
   - record terminology, i18n variables, plural/date/number formatting, translation expansion, and accessibility-name constraints;
   - treat unresolved copy for a `visual-truth` image or board as a packet blocker, not an implementation detail.
8. Decide whether a ChatGPT Images 2 reference phase is needed before the implementation visual-truth decision:
   - run it when the user asks for ChatGPT/Image references, when exact visual direction is still unstable, when baseline screenshots need image-native exploration before durable visual truth, or when generated references are intended to become visual-truth candidates;
   - use `creating-chatgpt-image-upload-packs` to write the upload pack from the spec, frontend-direction draft, screen index, brownfield extraction, and `design/baseline/*`;
   - before the pack is complete, audit all prompt-visible text with `writing-ux-copy` so generated references do not bake in technical or low-quality microcopy;
   - stop after the upload pack and ask the human to generate images externally;
   - do **not** create `pencil-workset.md`, shared Pencil files, feature `.pen` boards, or Pencil screenshots until the human confirms approved generated images exist in the `chatgpt-image-2/` folder using prompt-matching filenames and chooses the Pencil path;
   - keep generated images `reference-only` until the human explicitly approves them and chooses their role.
9. If the ChatGPT Images 2 phase was used, resume only after human confirmation:
   - verify approved image files exist beside the prompt files;
   - record which generated references were approved, rejected, or deferred;
   - ask the human to choose the implementation visual-truth source:
     - `chatgpt-image-2`: approved generated images are visual truth; omit Pencil artifacts and tell GSD implementers to rely on the approved images as the only visual-truth references.
     - `pencil`: approved generated images are reference inputs for durable Pencil boards.
     - `current-ui/degraded`: no generated or Pencil visual truth is approved; use only conservative brownfield guidance and mark degraded mode.
   - update the frontend direction source priority and reference intent ledger before implementation.
10. If the human chooses `chatgpt-image-2` as implementation visual truth:
   - do not create `pencil-workset.md`, shared Pencil files, feature `.pen` boards, or Pencil screenshots for that scope;
   - list every approved generated image file and screen/state it binds;
   - mark those approved images as `visual-truth` in the packet and `screen-index.md`;
   - mark Pencil status as `omitted by human visual-truth decision`;
   - set downstream skills to `gsd-frontend-design` only for visual consumption; do not tell implementers to load `pencil-design-core` or a Pencil stack adapter;
   - require runtime screenshot comparison against the approved ChatGPT Images 2 references during implementation verification.
11. If the human chooses `pencil`, create or refresh the Pencil workset:
   - foundations
   - shell
   - shared patterns
   - feature-specific boards
   - board intent metadata for every board or screenshot that may guide implementation
12. In Pencil, use `pencil-design-core` plus the chosen adapter to:
   - recreate the current structure first
   - keep the workset faithful to the target stack
   - generate or edit only 1–2 bounded variants for the real decision axis
   - classify each board as `visual-truth`, `semantic-guidance`, or `reference-only`
   - ask the human to approve any classification that affects implementation
13. If UI/UX quality work is needed beyond faithful reproduction, run it as a bounded layer on top of the baseline:
   - read `references/impeccable-brownfield-quality-layer.md`
   - if `PRODUCT.md` already exists and is still accurate, do not re-run `/impeccable teach`
   - if `DESIGN.md` is missing or stale, prefer `/impeccable document` to refresh it from the current codebase
   - use `/impeccable extract`, `/impeccable critique`, and `/impeccable audit` after the baseline exists, not before
   - use `/impeccable live` only as a bounded refinement surface on supported stacks; accepted ideas must still converge back into packet prose, screenshots, and the selected visual-truth source, with `.pen` files only when Pencil is selected
   - treat Impeccable findings as refinement input, not as permission to outrank brownfield truth
14. Select the preferred directions and record why they won.
15. Use the HTML visual companion only for temporary comparison artifacts when a choice is materially easier to judge in-browser than in prose.
16. If an HTML companion artifact influenced a choice, translate the chosen concept back into the approved visual-truth source, screenshots, and packet prose before treating it as durable direction.
17. Expand the implementation contract:

   - responsive behavior
   - interaction cues
   - state coverage
   - accessibility constraints
   - must preserve vs may adapt
   - explicit no-gos
   - approved UX copy source, missing copy states, and i18n constraints
   - approved intent for each `.pen` board, ChatGPT Images 2 generated image, screenshot, and retained visual reference
   - downstream skills and adapter to load

18. Review against the checklist until the packet is implementation-usable.
   - For non-trivial mobile packets, use `mobile-design-review` before handoff and carry any blocking or important findings into the packet or open questions.

## Tooling preference

- Prefer a durable, approved visual-truth source. Pencil is the default durable board path; approved ChatGPT Images 2 references are also valid when the human selects the image-only path.
- Prefer repo-local `.pen` files when Pencil is selected.
- For downstream GSD workflows, plan around Pencil CLI interactive mode only when Pencil is selected.
- Do not require or recommend Pencil MCP in GSD-facing packet guidance.
- Treat a Copilot/Codex + Pencil workflow as the default operating model only for Pencil-backed packets.
- If Pencil is unavailable, stay honest about degraded mode and still produce a usable packet from repo context, screenshots, and wireframes.

## Operating rules

- Current product truth outranks unapproved generated imagery in brownfield work; approved ChatGPT Images 2 visual truth binds only the intentional in-scope visual changes.
- Approved spec and GSD handoff define product scope and behavior; this skill defines the UI implementation contract.
- In Impeccable v3 projects, `PRODUCT.md` and `DESIGN.md` are strong context inputs, but they do not outrank current runtime truth, the approved packet, or the selected repo-local visual-truth artifacts.
- When no durable baseline exists, create one from browser-grounded evidence before you explore improvements.
- HTML companion screens are temporary decision artifacts, not durable packet artifacts.
- ChatGPT Images 2 prompt packs are temporary generation inputs until approved images are saved; generated images remain `reference-only` until the human promotes them and chooses their visual-truth role.
- The packet should point to stable repo artifacts first:
  - `brownfield-ui-extraction.md`
  - `screen-index.md`
  - `chatgpt-image-2/` prompt packs and approved generated image references when used
  - `pencil-workset.md` and repo-local `.pen` files only when Pencil is selected
  - screenshots
- Record the exact downstream visual-truth source: `chatgpt-image-2`, `pencil`, or degraded current UI.
- Record the exact Pencil skills downstream agents should load only when Pencil is selected.
- Record the exact mobile design skills downstream agents should load only when mobile product direction, interaction/usability, visual design, or review remains relevant to implementation.
- Record that Pencil CLI interactive mode is the intended downstream transport when Pencil is selected and it matters for reproducibility.
- Treat generated code from design tools as reference evidence, not production-ready output for legacy Angular stacks.
- Do not silently let generated imagery skip the visual-truth decision. If approved ChatGPT Images 2 references are chosen as implementation visual truth, record that Pencil is intentionally omitted.
- Do not leave board or image intent for implementation agents to infer. If a visual reference's intent is unclear, ask for approval or mark the packet incomplete.
- If exact visual direction cannot be stabilized, record the gap explicitly instead of pretending the packet is complete.

## Quality bar

A strong result:

- makes the intended visual direction obvious
- covers the main screens and key states
- for mobile work, records native mobile jobs, primary actions, platform constraints, state coverage, and review gates
- preserves or intentionally updates the current design system
- gives implementation agents enough direction to build without inventing the UI from scratch
- when Pencil is selected, tells downstream agents which `.pen` files, board names, screenshots, and Pencil skills to use
- when ChatGPT Images 2 is selected, tells downstream agents which approved generated image files are the binding visual truth and that Pencil is omitted
- tells downstream agents whether each board, image, or screenshot is `visual-truth`, `semantic-guidance`, or `reference-only`
- stays consistent with the product spec and handoff

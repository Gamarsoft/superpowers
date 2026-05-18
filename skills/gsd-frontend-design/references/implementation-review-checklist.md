# Frontend Implementation Review Checklist

Use this before declaring the UI done.

## 1. Input fidelity

- Did you read the spec, handoff, acceptance criteria, relevant workflow context such as milestone or slice `CONTEXT.md` when present, frontend direction packet, `screen-index.md`, and the packet's declared visual-truth source first?
- If the handoff, `CONTEXT.md`, or equivalent workflow artifact said packet status was `required`, did you stop rather than plan or implement UI from degraded assumptions?
- If ChatGPT Images 2 is selected, did you read the approved generated image files and omit Pencil-specific sources?
- If Pencil is selected, did you read `pencil-workset.md` and the relevant `.pen` files first?
- If brownfield, did you inspect the existing tokens, components, shell patterns, and interaction patterns?
- If retained screenshots or browser captures existed, did you use them for verification?
- If no packet or approved visual-truth source existed, did you state degraded mode honestly?

## 2. Visual fidelity

- Did you read the approved intent for each ChatGPT Images 2 image, Pencil board, or screenshot?
- If reference intent was missing or pending, did you ask for confirmation before making visual changes?
- If confirmation was unavailable, did you avoid treating the image or board as visual truth and record degraded mode or a blocker?
- Does the implemented hierarchy match the approved direction?
- Are typography, spacing rhythm, and color roles consistent with the packet and the existing system?
- Did you preserve the shared shell and baseline product language unless change was explicitly approved?
- Did you avoid drifting into a new aesthetic thesis?
- Did you avoid redesigning a brownfield feature to match an image or board exactly when the reference was only semantic guidance?
- Did you compare the runtime screenshot against each `visual-truth` approved image, board, or retained screenshot?
- Do major surfaces match: page background, pane/card containers, section backgrounds, border/radius, padding, and visual weight?
- Do controls match the approved visual priority: neutral controls remain neutral, primary actions remain singular and obvious, and secondary actions do not inherit primary styling by accident?
- Did you verify that approved visual changes were implemented, not dismissed as brownfield preservation?

## 2a. Reference-Intent Gate

For image-backed or Pencil-backed UI work, completion requires a checklist matching the approved reference intent.

For each `visual-truth` approved image, board, or retained screenshot, record `pass`, `mismatch`, or `waived` for:

- surfaces and containers
- control emphasis and button hierarchy
- typography and numeric emphasis
- spacing rhythm and alignment
- section order and section visual weight
- responsive/mobile flow
- key states named in the packet

For each `semantic-guidance` image or board, record `pass`, `mismatch`, or `waived` for:

- required behavior or workflow
- information hierarchy and content priority
- state coverage
- product-system adaptation
- any explicitly non-binding visual details

Captured screenshots alone are not evidence. The agent must state what was visually inspected and whether it matches.

A waiver is acceptable only when it names the source image or board, approved intent, mismatch, implementation constraint, accepted fallback, and follow-up needed.

## 3. Screen and state coverage

- Are the key screens or components implemented?
- Are loading, empty, error, validation, permission, and destructive states covered where required?
- Do fallback and disabled states feel intentional rather than framework leftovers?
- If live data could not produce required states, were visual fixtures used for deterministic state coverage?
- If fixtures were used, were they contract-shaped API responses rather than UI-only data blobs?
- If an in-browser XHR/fetch monkeypatch was used, was it labeled as an ad-hoc spike and not treated as a reusable fixture harness?

## 4. Responsive fidelity

- Does the UI match the packet’s responsive contract?
- Are mobile and desktop priorities both respected?
- Does the dense-data behavior degrade gracefully without dropping important operator information?

## 5. Interaction and accessibility

- Are focus states visible and consistent?
- Are keyboard and screen-reader paths preserved?
- Do hover, pressed, loading, and disabled states exist where needed?
- Are overlays, dialogs, and forms usable and predictable?
- For native/mobile-first work, did `mobile-interaction-and-usability` shape navigation, forms, gestures, permissions, state behavior, text scaling, tap targets, semantics, and recovery paths?
- Are primary actions visible without relying on hidden gestures?
- Do safe areas, keyboard insets, bottom bars, and compact phone constraints preserve critical controls?

## 6. Copy and content

- If new or changed copy was introduced, did you use `writing-ux-copy` or an approved copy deck before coding?
- Does each changed copy-bearing state have approved visible text?
- Do action labels describe outcomes clearly?
- Do warnings, errors, permission messages, and destructive confirmations explain the user-visible consequence and next action?
- Are errors actionable and specific?
- Are empty states and confirmations aligned with product voice and terminology?
- Are backend service names, internal state names, debug terms, and implementation jargon kept out of user-facing copy unless already product terminology?
- Are i18n keys, semantic variables, plural/date/number/currency formatting, translation expansion, and accessible names covered?
- If ChatGPT Images 2 references were used, did runtime copy match approved visible text rather than rough prompt wording or model-invented text?

## 7. Visual-source discipline

- Did you prefer the selected visual-truth source and retained screenshots over vague packet previews?
- Did you translate the design into the repo’s actual framework primitives instead of copying generated output literally?
- If source metadata or files were missing, did you record the limitation instead of silently guessing?

## 8. HTML companion discipline _(when used upstream)_

- Did you implement from the selected visual-truth source and packet artifacts rather than from raw HTML companion screens?
- If HTML companion artifacts were still consulted, did you use them only to clarify intent rather than as the binding source?
- If HTML companion artifacts still mattered, did you record why the durable artifacts were not enough?

## 9. Deviation discipline

- Did you change anything the packet or workset marked as must-preserve?
- If yes, did you document the deviation and its reason?
- Would the packet or workset need a follow-up update because of what was implemented?

## 10. Verification

- Did you compare the result against the chosen approved images, `.pen` files, or retained references?
- Did runtime evidence support the reference-intent checklist?
- For web targets, did browser evidence include the relevant screenshots, route checks, console/network checks, or traces?
- For native Flutter targets, did evidence include the relevant widget tests, golden tests, simulator/device screenshots, analysis/test commands, accessibility checks, or UI gallery verification?
- If fixture mode was used, did the artifact distinguish live runtime proof from fixture visual-state proof?
- Were fixture claims limited to rendering/state coverage instead of backend integration, authorization, persistence, or service wiring?
- If a temporary monkeypatch proved a useful lane, was the follow-up to convert it into a repeatable network fixture or proxy harness recorded?
- If raw screenshots, traces, console logs, or network dumps were persisted, were they placed under `/tmp`, another temporary directory, an ignored local path, or an external redaction-safe location unless explicitly requested as commit artifacts?
- For non-trivial UI work, did a fresh-context reviewer perform the final visual quality review?
- In GSD-2, was that reviewer a `worker` subagent and was its `VISUAL-REVIEW.md` artifact recorded?
- Did the visual reviewer read the relevant project instructions first, including `AGENTS.md`, `.gsd/**/CONTEXT.md`, `PRODUCT.md`, `DESIGN.md`, the task file, and slice or milestone instructions?
- For web targets, did the visual reviewer use a fresh browser context when supported, and avoid reusing the implementer's browser session, storage, console state, or previously opened page?
- For Flutter targets, did the visual reviewer use fresh simulator/device, widget-test, golden, or UI-gallery evidence when supported instead of relying only on implementer screenshots, assertions, or summaries?
- Did the visual reviewer independently open the target route/screen and recapture the required platform evidence instead of relying only on implementer screenshots, assertions, or summaries?
- If the target route/screen could not be opened due to `ERR_CONNECTION_REFUSED`, connection refused, server unavailable, simulator/device unavailable, test harness failure, or equivalent runtime blockage, did the review avoid approval and use `REQUEST_CHANGES` or `ESCALATE`?
- Did the visual review artifact include `Visual Review Completion Gates` with every missing gate called out?
- Did you run a visual quality review with `$impeccable critique` when available, or record why it was skipped?
- Did you run measurable implementation quality review with `$impeccable audit` when available, or record why it was skipped?
- Were Impeccable findings treated as bounded review findings rather than permission to override the packet or visual-truth source?
- Were blocking and important visual findings fixed, explicitly disproved, waived, or moved into the paired review-and-resolve task?
- If ChatGPT Images 2 was selected, did you compare the result against the approved generated image files and not require Pencil parity?
- Did you verify the required viewports?
- For native Flutter, did you verify the required device families, safe areas, text scaling, tap targets, and semantics expectations named in the packet?
- For non-trivial native/mobile-first work, did `mobile-design-review` run against the packet, reference images/boards, screenshots, or implementation evidence?
- Did you check any acceptance criteria or screenshot checks named in the packet?
- Can another agent recover the same frontend references from your recorded output?
- Did you keep `Frontend References` in the relevant `CONTEXT.md` current when those workflow artifacts are in scope?
- Did you avoid claiming completion from tests, DOM checks, or screenshot capture without reference-intent inspection?

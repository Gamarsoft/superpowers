# Frontend Implementation Review Checklist

Use this before declaring the UI done.

## 1. Input fidelity

- Did you read the spec, frontend direction packet, `pencil-workset.md`, `screen-index.md`, and the relevant `.pen` files first?
- If brownfield, did you inspect the existing tokens, components, shell patterns, and interaction patterns?
- If retained screenshots or browser captures existed, did you use them for verification?
- If no packet or workset existed, did you state degraded mode honestly?

## 2. Visual fidelity

- Did you read the approved intent for each Pencil board or screenshot?
- If board intent was missing or pending, did you ask for confirmation before making visual changes?
- If confirmation was unavailable, did you avoid treating the board as visual truth and record degraded mode or a blocker?
- Does the implemented hierarchy match the approved direction?
- Are typography, spacing rhythm, and color roles consistent with the packet and the existing system?
- Did you preserve the shared shell and baseline product language unless change was explicitly approved?
- Did you avoid drifting into a new aesthetic thesis?
- Did you avoid redesigning a brownfield feature to match a board exactly when the board was only semantic guidance?
- Did you compare the runtime screenshot against each `visual-truth` board or retained screenshot?
- Do major surfaces match: page background, pane/card containers, section backgrounds, border/radius, padding, and visual weight?
- Do controls match the approved visual priority: neutral controls remain neutral, primary actions remain singular and obvious, and secondary actions do not inherit primary styling by accident?
- Did you verify that approved visual changes were implemented, not dismissed as brownfield preservation?

## 2a. Board-Intent Gate

For Pencil-backed UI work, completion requires a checklist matching the approved board intent.

For each `visual-truth` board or retained screenshot, record `pass`, `mismatch`, or `waived` for:

- surfaces and containers
- control emphasis and button hierarchy
- typography and numeric emphasis
- spacing rhythm and alignment
- section order and section visual weight
- responsive/mobile flow
- key states named in the packet

For each `semantic-guidance` board, record `pass`, `mismatch`, or `waived` for:

- required behavior or workflow
- information hierarchy and content priority
- state coverage
- product-system adaptation
- any explicitly non-binding visual details

Captured screenshots alone are not evidence. The agent must state what was visually inspected and whether it matches.

A waiver is acceptable only when it names the source board, approved intent, mismatch, implementation constraint, accepted fallback, and follow-up needed.

## 3. Screen and state coverage

- Are the key screens or components implemented?
- Are loading, empty, error, validation, permission, and destructive states covered where required?
- Do fallback and disabled states feel intentional rather than framework leftovers?

## 4. Responsive fidelity

- Does the UI match the packet’s responsive contract?
- Are mobile and desktop priorities both respected?
- Does the dense-data behavior degrade gracefully without dropping important operator information?

## 5. Interaction and accessibility

- Are focus states visible and consistent?
- Are keyboard and screen-reader paths preserved?
- Do hover, pressed, loading, and disabled states exist where needed?
- Are overlays, dialogs, and forms usable and predictable?

## 6. Copy and content

- Do action labels describe outcomes clearly?
- Are errors actionable and specific?
- Are empty states and confirmations aligned with product voice and terminology?

## 7. Pencil-source discipline

- Did you prefer the approved `.pen` file and retained screenshots over vague packet previews?
- Did you translate the design into the repo’s actual framework primitives instead of copying generated output literally?
- If source metadata or files were missing, did you record the limitation instead of silently guessing?

## 8. HTML companion discipline _(when used upstream)_

- Did you implement from the translated `.pen` and packet artifacts rather than from raw HTML companion screens?
- If HTML companion artifacts were still consulted, did you use them only to clarify intent rather than as the binding source?
- If HTML companion artifacts still mattered, did you record why the durable artifacts were not enough?

## 9. Deviation discipline

- Did you change anything the packet or workset marked as must-preserve?
- If yes, did you document the deviation and its reason?
- Would the packet or workset need a follow-up update because of what was implemented?

## 10. Verification

- Did you compare the result against the chosen `.pen` files or retained references?
- Did you verify the required viewports?
- Did you check any acceptance criteria or screenshot checks named in the packet?
- Can another agent recover the same frontend references from your recorded output?
- Did you avoid claiming completion from tests, DOM checks, or screenshot capture without board-intent inspection?

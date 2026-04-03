# Frontend Implementation Review Checklist

Use this before declaring the UI done.

## 1. Input fidelity
- Did you read the spec, frontend direction packet, screen index, and any selected screenshots first?
- If brownfield, did you inspect the existing tokens, components, and interaction patterns?
- If no packet existed, did you state degraded mode honestly?

## 2. Visual fidelity
- Does the implemented hierarchy match the chosen direction?
- Are typography, spacing rhythm, and color roles consistent with the packet and existing system?
- Did you avoid drifting into a new aesthetic thesis?

## 3. Screen and state coverage
- Are the key screens implemented?
- Are loading, empty, error, validation, permission, and destructive states covered where required?
- Do fallback and disabled states feel intentional rather than default browser leftovers?

## 4. Responsive fidelity
- Does the UI match the packet's responsive contract?
- Are mobile and desktop priorities both respected?
- Does content truncate, wrap, or stack gracefully under stress?

## 5. Interaction and accessibility
- Are focus states visible and consistent?
- Are keyboard and screen-reader paths preserved?
- Do hover, pressed, loading, and disabled states exist where needed?
- Are overlays, dialogs, and forms usable and predictable?

## 6. Copy and content
- Do action labels describe outcomes clearly?
- Are errors actionable and specific?
- Are empty states and confirmations aligned with the product voice?

## 7. Deviation discipline
- Did you change anything the packet marked as must-preserve?
- If yes, did you document the deviation and its reason?
- Would the packet need a follow-up update because of what was implemented?

## 8. Verification
- Did you compare the result against the chosen screenshots or references?
- Did you verify the required viewports?
- Did you check any acceptance criteria or screenshot checks named in the packet?

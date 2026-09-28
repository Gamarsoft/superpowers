# Decision note — ajustement Credipark

## Sources actually read

- `micro-task.md` and `brief.md`, complete.
- `context/AGENTS.md`: Progressive Disclosure, Working approach, Critical Constraints.
- `context/PRODUCT.md`: Users through Accessibility & Inclusion.
- `context/gateway/AGENTS.md`: Project Overview, Relationships, Angular/Nebular constraints, Frontend Context and Design Context.
- `context/gateway/PRODUCT.md`: complete, especially Users, Brand Personality, Product Principles and Accessibility.
- `context/gateway/DESIGN.md`: Overview through Do’s and Don’ts (the documented design-system section beginning at line 110).
- `source/customer-loyalty-adjustment-dialog.component.html`, `.scss`, `.ts`, `.spec.ts`, `copy.json`: complete; `user-baseline.png`: inspected.

No workflow/design skill, external reference, prior result, or repository eval was consulted.

## Proposed refinement

Keep one 48rem light Nebular card, but organize it as a short, ordered review path: **Contexte → Ajustement → Justificatif → Confirmation**. The body scrolls; header and footer remain fixed.

1. **Compress the context into two rows rather than four equal cells.** First row: customer and account; second: parking and available balance, with balance right-aligned and strongest. Remove the asserted “Actif” when account status is unknown. Long values wrap below their labels. Cost: less dashboard-like symmetry, but identity and authoritative money state stay readable at 1280×720.

2. **Make direction and amount one compound decision.** Put the Crédit/Débit selector immediately before a wide amount field; beneath them show one live sentence: “Effet : +2,50 cp” or “Effet : −2,50 cp”. Debit guidance sits here, not in a separate warning panel. Cost: custom responsive grouping and careful accessible labelling; benefit: sign cannot be overlooked or confused with the positive amount entry rule.

3. **Pair required evidence by intent.** Parking and Motif share a row; Note opérateur spans the width below. Keep all six reason meanings. Required errors stay directly under their field and reserve no empty error space. Cost: the note moves lower, but evidence reads in audit order and long parking names have room.

4. **Turn the confirmation into the final review block.** Use the checkbox, “Je confirme cet ajustement audité”, journal help, and—after preview—the server-returned projected balance in the same block. Failures replace that preview feedback without clearing fields. Cost: this block grows on errors; it keeps outcome and acknowledgement adjacent.

5. **Simplify the footer hierarchy.** Left: “Fermer”; right: outlined “Prévisualiser”, primary “Enregistrer l’ajustement”. Show “Recharger le solde” only inside conflict/service feedback. At 390px, stack primary, preview, close; keep 44px targets. Cost: reload is less persistent, but only appears when actionable.

## Contract versus proposed behavior

Unchanged business behavior: positive two-decimal cp input; direction supplies sign; parking, reason, nonblank note, and confirmation required; preview optional for save; server values authoritative; edit invalidates preview; busy/invalid save blocking; stable retry identity; all failure states and entered work preserved; reload closes and requests parent reload.

Proposed behavior change: remove the unproven active-status display and contextually reveal reload. Both require acceptance before implementation; no eligibility rule is added.

## Representative checks

- At 1536×1024 and 1280×720: footer remains visible, body alone scrolls, focus order follows the four sections.
- At 390×844: no horizontal scroll; long customer/parking names, French reasons, support codes, and errors wrap without covering actions.
- Keyboard-only: visible focus, associated labels/errors, predictable checkbox and action order; disabled and loading states remain explicit.
- Exercise valid, invalid, preview-ready, edited-after-preview, busy, conflict, forbidden, and service-failure states; verify no local balance mutation and preserved entries.

# Credipark adjustment — design decision note

## Evidence actually read

- `brief.md`; `source/user-baseline.png`; `copy.json`; component HTML, SCSS, TypeScript, and spec (summary/form/footer markup; responsive rules; form construction, request/state methods; behavioral tests).
- `context/AGENTS.md` (workspace boundaries), `context/PRODUCT.md` (service ownership), Gateway `AGENTS.md` (Angular 7/Nebular constraints), `PRODUCT.md` (dense, dependable, French-first operator UI), and `DESIGN.md` (Overview, Typography, Layout, Inputs/Fields, Buttons, Workflow patterns, Do’s/Don’ts).
- Maintained frontend-direction references: `design-source-priority.md` (brief and verified behavior govern), `brownfield-ui-extraction-template.md` (anchors versus freedoms), `task-to-layout.md` (facts beside decisions/actions), and `design-knowledge-selection.md`. Applied `Refactoring UI`: Visual Hierarchy, Spacing & Sizing, Typography, Layout & Composition; and `Design of Everyday Things`: Two Gulfs, Mappings, Constraints, Feedback, Human Error. No installed Impeccable knowledge was available at the expected local skill path; no command or network fallback was used.

## Proposed refinement

1. **Make the header a compact account context band.** Keep title/subtitle, then show Client + Compte as a wrapping identity block and make **Solde disponible** the single strongest value; omit “Actif” when account state is unknown. Cost: less four-column symmetry, but long identities wrap without squeezing the financial fact.

2. **Couple direction, amount, and effect.** Use one section, “Effet de l’ajustement”: a two-option Crédit/Débit control beside the amount, followed immediately by a persistent sentence, “Mouvement : −12,30 cp”; after preview, add the server result, “Solde après enregistrement : 7,20 cp.” Cost: the first row is denser; at 390px it must stack direction before amount and retain the effect below both.

3. **Group audit evidence separately.** Put Parking, Motif, Note opérateur, then confirmation under “Justification auditée.” Remove the duplicate blue tenant strip; parking remains visible once, as an editable required field. Keep the six reason labels verbatim. Cost: less ambient reassurance, offset by clearer field-to-purpose mapping.

4. **Use contextual feedback instead of permanent competition.** Show debit-limit guidance beneath the effect only for Débit; keep field errors beside their controls. Put conflict/forbidden/service failure above the affected section, preserve inputs, and expose support code plus the supported recovery action. Preview-ready feedback stays adjacent to the effect and disappears on edit. Cost: conditional layout movement; reserve a compact feedback region where practical.

5. **Clarify the footer hierarchy.** Primary filled action: “Enregistrer l’ajustement”; secondary: “Prévisualiser”; tertiary: “Fermer.” Show “Recharger le solde” only with stale/conflict/service recovery feedback. Keep footer visible while the body scrolls; on narrow screens use full-width primary, then two secondary actions. Cost: reload is less discoverable before it is relevant.

## Behavior boundary and checks

Business behavior remains unchanged: positive two-decimal cp input; direction supplies sign; parking, reason, nonblank note, and confirmation required; preview optional; save disabled invalid/busy; server owns preview/save balances; edits invalidate preview; retry identity remains stable for unchanged data; reload closes and requests parent reload; failures preserve work. Conditional reload visibility and debit-only guidance are proposed presentation changes, not eligibility or validation changes.

Prototype checks: 1536×1024, 1280×720, and 390×844; long customer/parking names; keyboard order and visible focus; invalid, preview-ready, busy, conflict, forbidden, and service-failure states; body/footer scrolling; no clipped French copy; signed effect and server balance never confused; unknown account never displayed as active.

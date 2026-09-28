# Credipark adjustment — pre-prototype decision note

## Evidence actually consulted

I read `brief.md`; `source/user-baseline.png`; `copy.json`; the component HTML (summary, failure/preview, form, confirmation, footer), SCSS (dialog sizing, grids, states, footer, 640px reflow), TypeScript (form setup, preview/submit, invalidation, idempotency, reload), and specs (validation, signed minor units, safe failures, preservation, server authority). I also read workspace and Gateway `AGENTS.md`, `PRODUCT.md` (users, purpose, constraints, principles, accessibility), and `DESIGN.md` (Overview, Colors, Typography, Layout, Components, Do/Don’t).

Applied frontend-direction references: `design-source-priority.md` (brief/verified behavior outrank baseline composition), `brownfield-ui-extraction-template.md` (anchors versus freedoms), `task-to-layout.md` (next decision and fact relationships), and `design-knowledge-selection.md`. From bundled knowledge I applied Refactoring UI **Visual Hierarchy, Spacing & Sizing, Typography, Layout & Composition**, and Design of Everyday Things **Two Gulfs, Mappings, Constraints, Feedback, Conceptual Models, Human Error**.

## Practical refinement

The director’s decision is: “For this client and parking, will this signed adjustment create the intended audited balance?” Use one scrollable body and fixed footer, retaining white Nebular surfaces, Open Sans, compact 14px-root rhythm, modest radius, operational blue, and French labels.

1. Replace the four equal summary cells with a compact context band: client/account on the left; current available balance on the right. Omit the asserted “Actif” when account status is unknown. Long identities wrap without shrinking the balance. **Cost:** less tabular symmetry; status is shown only when authoritative.
2. Couple direction and positive amount as one “Effet de l’ajustement” group, with a persistent signed result directly below (`Débit · −12,30 cp`). After a successful optional preview, show current balance → signed change → server-projected balance in one aligned row. **Cost:** the amount block gains prominence and preview occupies extra height when present.
3. Group parking, six-meaning reason selector, note, and audit checkbox under “Justification audit”. Remove duplicated parking text from the blue helper strip; keep the audit explanation once beside confirmation. **Cost:** a section heading adds one line, repaid by removing duplicate guidance.
4. Make `Enregistrer l’ajustement` the sole filled action at the right; keep `Prévisualiser` outlined beside it, `Fermer` quiet, and place `Recharger le solde` inside failure recovery because it closes the dialog. Disabled/busy states retain labels and visible progress. **Cost:** reload is less discoverable before failure, matching its recovery role.

## Behavior boundary

Business behavior remains exactly the brief’s contract, including optional preview, direct valid save, server-returned values, preview invalidation, failure preservation, and unchanged-data retry identity. Proposed changes are presentation and clearer equivalent French copy only. No new eligibility rule, local balance calculation, undo, or implicit reload is proposed.

## Prototype checks

At 1536×1024, 1280×720, and 390×844: verify long client/account/parking strings; body-only scrolling with reachable footer; single-column reflow; logical tab order and visible focus; errors adjacent to fields; signed debit/credit mapping; preview disappears after edits; busy blocks close/save; conflict/forbidden/service failures preserve entries and expose recovery; no-account context never implies active status. This note has no rendered proof or approval.

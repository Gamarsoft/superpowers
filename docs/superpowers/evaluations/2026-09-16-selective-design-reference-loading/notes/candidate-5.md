# Decision note — Ajustement Credipark

## Evidence actually consulted

I read `brief.md`; the screenshot; all of `component.html`, `component.ts`, `component.scss`, `component.spec.ts`, and `copy.json`; root and Gateway `AGENTS.md`; root and Gateway `PRODUCT.md`; and Gateway `DESIGN.md` sections **Overview, Colors, Typography, Layout, Components, Workflow patterns, Do’s and Don’ts**. From the maintained frontend-direction material I read `SKILL.md` sections **Choose the entry and scope, Design loop, Boundaries**; `design-source-priority.md`; `brownfield-ui-extraction-template.md`; `task-to-layout.md` sections **Establish the information model, Choose visual relationships, Connect the choice to evidence**; `design-knowledge-selection.md`; Refactoring UI **Visual Hierarchy, Spacing & Sizing, Typography, Layout & Composition**; and Design of Everyday Things **Two Gulfs, Signifiers, Mappings, Constraints, Feedback, Conceptual Models, Human Error, Seven Stages of Action**.

## Proposed refinement

Use a 48rem white Nebular dialog with fixed header/footer and one scrolling body, retaining Open Sans, operational blue, modest radius and current field styling. Recompose the body into three left-aligned groups: **Compte concerné**, **Ajustement**, then **Justification et confirmation**.

1. Replace the four equal summary cells with a compact two-row context block: customer and account together; current authoritative balance prominent beside them. Do not show “Actif” when account status is unknown. This improves identification and leaves room for long names; the cost is less dashboard-like symmetry.
2. Keep amount and credit/debit adjacent, but add one full-width, live “Effet demandé” line directly beneath: `Débit de 2,50 cp` and, only after a successful preview, `8,20 cp → 5,70 cp (prévisualisation serveur)`. This applies control-to-effect mapping and distinguishes entered intent from server evidence. It costs vertical space and requires clear stale-preview removal after any edit.
3. Put parking and reason side by side on desktop, followed by the full-width note. Move the two debit limits into contextual help shown with debit, while preserving both meanings. This reduces always-visible warning weight; the cost is ensuring the rules remain discoverable and readable without hover.
4. Place confirmation immediately after the effect/evidence block and keep the sticky footer ordered `Fermer`, `Prévisualiser`, blue `Enregistrer l’ajustement`; show `Recharger le solde` inside conflict/service failure feedback. This ties authorization to consequence and recovery to failure. The cost is removing reload as a permanently visible shortcut.
5. At 390px, stack every field and context row, keep the footer two rows with save full width, and allow names/errors to wrap. At 1280×720, the body scrolls while identity and actions remain fixed. Visible focus must survive all layouts.

## Behavior boundary

Business behavior remains: positive two-decimal cp input; direction supplies sign; parking, one of six reasons, nonblank note and confirmation required; preview optional for save but requires complete evidence; server values are authoritative; edits invalidate preview; invalid/busy blocks save; failures preserve work; unchanged retry identity; reload closes and asks the parent to reload. The contextual placement of debit guidance and failure-only reload are proposed interaction changes, not established behavior. No eligibility rule or local balance calculation is introduced.

## Representative prototype checks

Exercise keyboard order/focus, valid/invalid and all busy states; edit after preview; conflict, forbidden and service failure with preserved entries; retry and reload semantics; unknown account/status; long French customer/parking names; wrapped errors; and 1536×1024, 1280×720, 390×844 containment. This note is pre-prototype: it provides no rendered proof or approval.

# Design decision note — Ajustement Credipark

## Material consulted

I read `brief.md` and `micro-task.md`; workspace `context/AGENTS.md` (working approach, constraints) and `context/PRODUCT.md` (users, purpose, principles, accessibility); Gateway `context/gateway/AGENTS.md` (Angular 7/Nebular constraints and frontend routing), `context/gateway/PRODUCT.md` (Users through Accessibility & Inclusion), and `context/gateway/DESIGN.md` (Overview, Colors, Typography, Layout, Shapes, Components, Do’s/Don’ts). I also read `source/copy.json`, the full adjustment HTML, SCSS, TypeScript and spec, and inspected `source/user-baseline.png`. I did not consult external/reference design resources.

## Proposed refinement

Use one scrollable dialog with a fixed, compact header and action footer. Keep the white Nebular card, Open Sans, modest radius and blue primary action. Inside, establish three plainly labelled regions: **Contexte**, **Ajustement**, and **Justification et validation**.

1. **Make context persistent and scannable.** Place client plus account on the left and current server balance plus parking on the right in a two-column summary strip. Allow names to wrap anywhere while keeping labels above values. At 390px, stack four rows. Cost: slightly more vertical space on narrow screens; benefit: the operator can continuously verify the target.

2. **Bind direction, amount and effect.** Put the Crédit/Débit selector before the amount, then show a live signed line directly below: `Effet saisi : −5,00 cp`. After a successful server preview, replace the neutral effect panel with `Solde actuel → ajustement → solde après`. Cost: the effect block changes height; reserve its minimum height to prevent action movement. This is presentation of existing values, not local balance calculation.

3. **Associate evidence fields.** Keep parking and motif on one desktop row, note full-width beneath, then confirmation in the same bordered evidence group. Show each validation message immediately below its control; keep service/conflict errors as a full-width alert above this group and preserve all entries. Cost: confirmation becomes visually prominent, appropriate for an audited write.

4. **Clarify action hierarchy.** Footer order: `Fermer`, `Prévisualiser`, primary `Enregistrer l’ajustement`; move `Recharger le solde` into conflict/service feedback, where its purpose is clear. On 390px, stack save full-width, preview and close beneath; keep the body scrolling and footer visible. Cost: reload is less discoverable before failure, but it is contextual rather than a routine next step.

## Contract and proposed behavior

Business behavior remains unchanged: positive two-decimal cp input; direction signs it; parking, one of six reasons, nonblank note and confirmation are required; preview remains optional; server responses own projected/saved values; edits invalidate preview; invalid/busy blocks save; failures preserve work; unchanged retry retains idempotency; reload closes and requests parent reload.

Proposed behavioral change: none. Copy clarification only: rename the preview line to `Effet saisi` and the accepted result to `Impact calculé par le service`.

## Representative checks

Check keyboard order, visible focus, disabled/busy states and error announcements. At 1536×1024, 1280×720 and 390×844, verify footer access, body scrolling, long customer/parking wrapping, textarea usability, and multi-line errors. Exercise credit/debit, invalid precision/zero, preview invalidation, conflict, forbidden, service failure, retry, reload and successful close without local balance mutation.

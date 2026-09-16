# Decision note — audited Credipark adjustment

## Evidence read

I read `brief.md`; the complete source template, component, styles, tests and `copy.json`; and inspected `source/user-baseline.png`. I also read the complete root `context/AGENTS.md` and `context/PRODUCT.md`, plus Gateway `AGENTS.md` (project overview, Angular/Nebular constraints and frontend-context routing), `PRODUCT.md` (users, operating context, personality, principles and accessibility), and `DESIGN.md` (frontmatter tokens; overview; color, typography, layout, depth, shape, components and do/don’t sections). I did not consult optional context or external references.

## Proposed refinement

Keep a single white, Open Sans dialog, but organize it as a compact review path: **Contexte → Effet → Justificatif → Confirmation**. The body scrolls; the title and footer remain visible. At 1280×720 this keeps the current action available without compressing inputs; at 390×844 every section becomes one column and long values wrap.

1. **Make context concise and trustworthy.** Use a two-column context band: client/account on the left, authoritative “Solde disponible” on the right. Remove the hard-coded “Actif”; an unavailable account must read “Compte indisponible,” without implying status. Keep the selected parking visible beside the evidence fields rather than duplicating it in an info banner. Cost: less at-a-glance metadata, but no unsupported state claim and more room for long names.

2. **Bind direction, amount and consequence.** Place Crédit/Débit as the first control, amount immediately beside it on wide screens, then a full-width effect strip: “Effet de l’écriture : +2,50 cp” and, only after a successful server preview, “Solde après enregistrement : 10,70 cp.” Local effect is clearly labelled as the entered movement, not a new balance. Cost: one additional summary row and careful distinction between derived and server-returned values.

3. **Group audit evidence.** Parking, motif and note sit under “Justificatif de l’ajustement”; retain all six reasons and required markers. Put validation text directly under its control and allow errors to increase section height. Cost: slightly longer body, offset by clearer field/error association.

4. **Clarify the decision edge.** Put the debit limits immediately before the audit checkbox. Footer order: `Fermer`, `Prévisualiser`, primary `Enregistrer l’ajustement`; present `Recharger le solde` as a contextual link near balance/failure, since it closes and asks the parent to reload. On narrow screens, primary is full-width first, then preview and close; reload remains with context. Cost: moving a familiar action, but its consequence becomes legible.

## Contract and proposed behavior

Business behavior remains: positive two-decimal cp input; direction supplies sign; parking, reason, nonblank note and confirmation required; preview optional; server owns preview/saved balances; edits invalidate preview; invalid/busy blocks save; failure preserves entries; unchanged retry keeps identity; reload closes and requests parent refresh.

One proposed behavior change: after an attempted preview/save, focus the first invalid control and move focus to the failure/preview status when a response arrives. This needs explicit implementation approval; it changes focus only, not eligibility or persistence.

## Representative checks

Verify keyboard order and visible focus; required, malformed, zero and over-precision amounts; credit/debit signs; all six reasons; preview invalidation; busy/disabled controls; conflict, forbidden and service failures with preserved entries; sanitized support code; server-returned projected balance; reload/close results; wrapping of long client/parking/error text and contained scrolling at 1536×1024, 1280×720 and 390×844.

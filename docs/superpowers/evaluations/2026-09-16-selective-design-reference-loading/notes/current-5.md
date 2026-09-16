# Credipark adjustment — design decision note

## Evidence actually read

- `brief.md` and `micro-task.md`, complete.
- Frozen `frontend-direction/SKILL.md`: “Choose the entry and scope,” “Design loop,” and “Boundaries and continuation.” Its linked references: `design-source-priority.md` (“Scoped Design Authority”), `brownfield-ui-extraction-template.md` (“Brownfield Inspection Notes”), and `task-to-layout.md` (“Establish the information model,” “Choose visual relationships,” “Connect the choice to evidence”).
- `context/AGENTS.md`: progressive disclosure, service authority, accessibility; `context/PRODUCT.md`: users, operating context, principles, accessibility.
- `context/gateway/AGENTS.md`: Angular 7/Nebular constraints and frontend context; `gateway/PRODUCT.md`: users, brand, anti-references, principles; `gateway/DESIGN.md`: Overview, Colors, Typography, Layout, Shapes, Components.
- Source files: full HTML, SCSS, TypeScript, copy JSON, test cases, and `user-baseline.png`.

## Recommended refinement

Use one compact, scroll-bodied dialog with a fixed footer and three task bands: **Contexte**, **Ajustement**, then **Justification et confirmation**. Retain the white Nebular card, Open Sans, modest radius, restrained dividers, operational blue primary action, and French-first density.

1. Keep a two-row context strip at the top: customer/account together, then current server balance beside parking. Remove the unconditional “Actif” value when the account is unavailable; unknown account data does not establish status. Cost: less symmetry than four equal cells, but long names get useful width and unsupported certainty disappears.
2. Make the effect readable as one relationship: a segmented Crédit/Débit choice beside the positive amount, followed by a persistent line `Effet : +2,50 cp` or `−2,50 cp`. After a successful preview, replace that line with a compact current → projected balance comparison using server values. Cost: the effect block occupies more vertical space; it prevents operators from mentally combining direction and unsigned amount.
3. Group parking, six-value reason, note, warning, and audit checkbox under “Justification et confirmation.” Keep errors directly below their field and reserve wrapping space. Cost: the section looks denser, but evidence is visibly associated with the audited action.
4. Use a stable footer: `Fermer` and quiet `Recharger le solde` on the left; `Prévisualiser` secondary and `Enregistrer l’ajustement` primary on the right. At 390 px, stack primary first, preview second, then close/reload; at 1280×720 keep the body scrolling and footer visible. Cost: reload is less prominent, appropriate because it closes the dialog and asks the parent to reload.

## Behavior boundary and checks

Business behavior remains: positive two-decimal cp input; direction supplies sign; parking, reason, nonblank note, and confirmation required; preview needs complete evidence but remains optional for save; edits invalidate preview; server values remain authoritative; busy/invalid blocks save; failures preserve work; unchanged retry retains idempotency identity; reload closes and delegates refresh.

Proposed behavior change: none. The segmented direction control and reordered actions are presentation/interaction changes only; implementation must verify supported Angular 7/Nebular APIs.

Prototype checks: 1536×1024, 1280×720, and 390×844; keyboard order and visible focus; long customer/parking names; every validation error; valid/invalid/preview-ready/busy/conflict/forbidden/service-failure states; preview invalidation after edit; no local balance mutation; footer and alerts remain reachable without clipping. This is pre-prototype direction, not rendered proof or approval.

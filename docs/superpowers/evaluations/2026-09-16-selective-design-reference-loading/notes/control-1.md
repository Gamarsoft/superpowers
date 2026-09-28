# Decision note — Ajustement Credipark

## Sources actually read

- `brief.md` and `micro-task.md` in full.
- `context/AGENTS.md`: project routing, service authority, accessibility and frontend constraints.
- `context/PRODUCT.md`: users, operating context, product principles and accessibility.
- `context/gateway/AGENTS.md`: Gateway role, Angular 7/Nebular 3.5 constraints and frontend-context routing.
- `context/gateway/PRODUCT.md`: users, brand personality, anti-references, principles and accessibility.
- `context/gateway/DESIGN.md`: overview, typography, layout, colors, inputs, buttons, cards, workflow patterns and do/don’t guidance.
- `source/copy.json`; the component HTML, SCSS, TypeScript and spec; and `source/user-baseline.png`.

## Proposed refinement

Keep one scrollable white dialog with fixed header/footer, but restructure its body into a compact review sequence: **Contexte → Effet → Justification → Confirmation**.

1. Replace the four equal summary cells with a two-row context band. Row one gives the customer and account maximum width; row two pairs authoritative available balance with parking. Remove the unconditional “Actif” display when the account is unavailable. Cost: the summary is slightly taller on desktop, but long names stop competing with four narrow columns and false status confidence disappears.

2. Make amount and direction one “Effet sur le solde” group. Place direction first, amount second, then one prominent computed line: `Effet : +2,50 cp` or `Effet : −2,50 cp`. After a successful server preview, replace that line with `Solde actuel 8,20 cp → solde après 5,70 cp`, while retaining the validated notice. Cost: one extra heading and stronger numerical emphasis; benefit is a single place to verify sign and consequence.

3. Group parking, motif and note under “Justification audit”. Keep parking full width only when its label is long; at 1536×1024 use parking and motif side by side, followed by the note. Cost: responsive CSS needs an intermediate short-desktop rule, but 1280×720 loses less vertical space without reducing type.

4. Put the debit-limit guidance immediately below the effect group and the audit checkbox immediately after the note. Field errors remain adjacent and `role="alert"` failures stay above the edited group. Cost: guidance moves depending on purpose rather than being one stable block; its relation to debit becomes clearer.

5. Footer order becomes `Fermer` / `Prévisualiser` / primary `Enregistrer l’ajustement`; move “Recharger le solde” into failure feedback only. On 390×844, stack the primary action full width above two secondary actions and let the body scroll. Cost: reload is less discoverable before a failure, but it no longer competes with the normal next action.

## Contract and behavior boundary

Positive two-decimal cp input, sign by credit/debit, six reason meanings, required parking/note/confirmation, optional preview, server-owned balances, invalidation on edit, blocking while invalid/busy, failure preservation, idempotent retry, and close-and-parent-reload remain business behavior. Proposed behavior change: do not present “Actif” when account state is unknown; no new eligibility rule is inferred.

## Representative checks

- At 1536×1024, 1280×720 and 390×844: no clipped names, errors, footer actions or hidden confirmation; body alone scrolls.
- Keyboard order follows the visual sequence; focus is visible; labels remain programmatic.
- Credit/debit flips the signed effect; editing clears server preview; preview remains optional for save.
- Invalid, busy, conflict, forbidden and service-failure states preserve entries and expose the correct next action.

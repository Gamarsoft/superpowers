# Credipark adjustment prototype

## Launch

Open `index.html` directly in a browser. The prototype uses only local HTML, CSS, and JavaScript; it performs no network or backend calls.

## State paths

- **État du formulaire:** `Vide`, `Prêt à enregistrer`, `Libellés longs`, and `Sans compte`.
- **Réponse serveur simulée:** `Succès`, `Conflit`, `Accès interdit`, and `Échec du service`.
- `Prêt à enregistrer` is the default: Camille Martin, account CP-8204, available balance 128,50 cp, credit 2,50 cp, Lab Solution Parking.
- Change any field after preview to invalidate the projected balance.
- Preview is optional. Save is available whenever amount, parking, reason, nonblank note, and audit confirmation are valid.
- Close with the close button, `Fermer`, or Escape; `Rouvrir l’ajustement` returns focus to the amount. `Recharger le solde` closes and reports a parent reload request.
- Busy state lasts 650 ms and disables the form and close/reload actions.
- While a request is busy, focus moves to the status message; completion restores focus to the initiating button unless a successful save closes the dialog.
- The collapsible `Requête` panel in the prototype toolbar exposes the synthetic request identity and attempt count without presenting debug data as product UI. Retrying unchanged data increments the count under the same identity; editing business data generates a new identity and resets its visible count.
- Preview stays available while the form is invalid so it can reveal required-field errors and focus the first invalid control. Save remains disabled until every required value is valid. Leaving an invalid amount also reveals its amount-specific error.
- For inspection, `window.adjustmentPrototype.getState()` exposes the synthetic state and `parseCredits(value)` exposes the source-equivalent amount parser.

## Sources read and applied

- Frozen evaluation `brief.md`, `context/AGENTS.md`, `context/PRODUCT.md`, all supplied component HTML/SCSS/TypeScript/spec/copy, and `source/user-baseline.png`.
- DashPark Gateway `AGENTS.md`, `PRODUCT.md`, and `DESIGN.md` from `/Volumes/Workspace/Development/SolutionPark/DashPark/gateway` supplied the retained Angular 7/Nebular feasibility, French-first operational density, Open Sans, light shell, `#3eaafa` action family, modest radius, field/border character, and card shadow.
- The actual Gateway `credipark-formatting.ts`, amount directive, and request builder were read to preserve decimal parsing, positive-only adjustment input, safe-integer limit, blur formatting, sign conversion, and request evidence semantics.
- Maintained frontend-direction references read: scoped design authority; brownfield extraction; task-to-layout; design-knowledge selection; Refactoring UI sections **Visual Hierarchy**, **Spacing & Sizing**, **Typography**, and **Layout & Composition**; Design of Everyday Things sections **Two Gulfs**, **Mappings**, **Constraints**, **Feedback**, and **Human Error**.
- Installed Impeccable 4.3.1 was discovered in the original project and its `SKILL.md`, `reference/operate.md`, and `reference/craft-floor.md` were read as knowledge. No helper command, detector, install, or network action was run.

## Design decisions and costs

- The operator’s decision is organized as context → signed amount/effect → audit evidence → confirmation/action. Customer and authoritative current balance stay together; the server-provided projected balance appears only after preview.
- Amount and direction map directly to a signed value shown immediately. This is the allowed behavioral delta from the baseline. It provides early feedback before the remaining evidence is complete, but it does not enable preview/save or claim a projected balance.
- The audit review is adjacent on desktop and follows the evidence on narrow screens. This costs some horizontal form width, so long labels wrap and short-height desktop scrolls the body while keeping actions visible.
- Errors preserve work. Conflict/forbidden fixtures explicitly reject and can state that no movement was written. A transport/service failure says the outcome may be uncertain and reuses the same idempotency key for an unchanged retry.
- The simulator enforces the established debit limit even when `Succès` is selected: a debit above the known available balance returns the conflict response. This is fixture behavior, not a local authoritative balance decision in production.
- `Sans compte` does not claim an active status or invent an eligibility rule. It shows `Compte indisponible`, `Non vérifié`, and still permits an authorized adjustment when all established evidence is supplied.

## Business and implementation limits

- Synthetic fixture only: no authorization, persistence, ledger, service wiring, actual server calculation, or parent reload is proven.
- The projected balance is displayed only as a labelled simulated server response. The authoritative current balance is never mutated locally.
- The prototype uses an Open Sans-first system stack because no local Open Sans webfont was available for copying. Browser fallback may differ from the production font.
- Vanilla controls approximate feasible Angular 7/Nebular primitives. Production integration would need the verified installed component APIs, translation keys, real focus restoration through `NbDialogRef`, service subscriptions, and Gateway verification gates.

Controller final source check qualified close/Escape copy: closing sends no new request and does not establish the outcome of an earlier attempt.

Final integration review: prototype fixture and response selectors are disabled during simulated requests so response completion cannot consume a different fixture. Optional-source exact identities are preserved in the companion optional-source-identities.json.

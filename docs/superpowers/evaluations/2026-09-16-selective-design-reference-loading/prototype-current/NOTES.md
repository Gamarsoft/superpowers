# Ajustement Credipark, prototype current workflow

## Direction

This is one practical refinement of the existing manual adjustment dialog. It keeps the familiar light DashPark dialog, operational density, compact blue controls and all established business rules. The form is split into two jobs: define the movement, then document the evidence. Customer, account and authoritative current balance stay together above both.

The proposed UX delta is visible and bounded: as soon as amount and direction form a valid positive value, the left panel shows the signed amount that would be sent. This does not compute or mutate the authoritative balance. Only a successful simulated preview displays a projected balance returned by the simulated server.

## Sources read

- `brief.md`
- `context/AGENTS.md` and `context/PRODUCT.md`
- `context/gateway/AGENTS.md`, `PRODUCT.md`, `DESIGN.md`, `DESIGN-EVIDENCE.md`, and `FRONTEND-ANCHORING.md`
- `source/copy.json`
- `source/customer-loyalty-adjustment-dialog.component.html`
- `source/customer-loyalty-adjustment-dialog.component.scss`
- `source/customer-loyalty-adjustment-dialog.component.ts`
- `source/customer-loyalty-adjustment-dialog.component.spec.ts`
- `source/user-baseline.png`
- `/Volumes/Workspace/Development/SolutionPark/DashPark/gateway/src/main/webapp/app/pages/credipark/credipark-formatting.ts`, parser lines 275–345, supplied during correction review
- Frozen `baseline/skills/frontend-direction/SKILL.md`
- Frozen baseline references: `design-source-priority.md`, `brownfield-ui-extraction-template.md`, `task-to-layout.md`, `browser-surface-selection.md`, and `frontend-review-checklist.md`

The screenshot is baseline evidence for visual vocabulary and existing composition. The brief and component behavior govern semantics. The prototype is the proposed scoped direction and has not received human approval.

## Business behavior preserved

- Amount accepts a positive cp value with a comma or dot and no more than two decimals. Credit or debit supplies the sign.
- Amount parsing mirrors the source string path: outer whitespace is trimmed; plain digits or correctly grouped spaces, nonbreaking spaces and narrow nonbreaking spaces are accepted; arbitrary whitespace and malformed grouping are rejected; cents are built as an integer string and compared with `Number.MAX_SAFE_INTEGER` before conversion. Zero, negative and too-large values remain blocked by the component-level positive-amount rule.
- Parking, one of the six supplied reasons, a nonblank operator note and audit confirmation are required for preview and save.
- Preview is optional. Editing any request field clears preview and failure feedback.
- Save stays blocked while invalid or busy. Every control and close/reload action is disabled during the simulated request.
- Success, conflict, forbidden and service-failure responses are visibly labelled as simulated server responses. Failures keep every entered field. The service-failure path reports an uncertain outcome because a transport failure does not prove that no movement was written.
- Retry consumes the same in-memory idempotency identity while request data is unchanged. Editing request data creates a new identity. The simulator counts attempts by identity. The fixture toolbar’s `Identité requête` disclosure shows the actual current synthetic key, operation and attempt number without exposing them in operator copy.
- Even when the response selector says success, a debit above the fixture’s known available balance returns the simulated server conflict. No negative projected balance is formatted as a positive value.
- The displayed current balance never changes locally. A previewed projected balance appears only as a simulated server value.
- Reload closes the modal and reports `reload=true` to the synthetic parent. Submit success closes it and reports `completed=true`.
- The no-account fixture remains actionable and reports the account status as unknown. It does not infer active status or add an eligibility rule.

## Launch and state paths

Open `index.html` directly in a browser. It has no build step and makes no network request.

The visible prototype bar provides four fixtures:

- `Vide`: default customer and account context with empty evidence.
- `Prête`: Camille Martin, account CP-8204, current available balance 128,50 cp, Lab Solution Parking and a default +2,50 cp credit with complete evidence.
- `Libellés longs`: long customer and parking labels with a ready debit.
- `Sans compte`: account unavailable and unknown status, with an authorized empty adjustment form.

The response selector provides success, conflict, forbidden and service failure. Use either Preview or Save to exercise the selection. During a request, focus moves to the focusable simulated status while the initiating action is disabled, then returns to Preview or Save when the response arrives. Close with the header button, footer button or Escape, then use `Rouvrir l’ajustement`; focus returns to the amount input. `Recharger le solde` closes the dialog and shows the parent reload report. Its narrow label is visual only, so the accessible name remains exactly `Recharger le solde`.

## Responsive behavior

- At 1536×1024 the modal uses two compact work panels and a fixed footer.
- At 1280×720 spacing tightens and the body owns scrolling while header and actions remain visible.
- At 390×844 the panels stack, the document scrolls and the action bar stays fixed above the bottom edge.

## Tradeoffs and limits

The two-panel desktop layout makes the signed movement easy to compare with required evidence, but it introduces a layout change from the single vertical source form. On narrow screens it returns to one column in task order.

This is vanilla HTML, CSS and JavaScript with synthetic state. It demonstrates an Angular 7 and Nebular-feasible composition but does not prove exact component APIs, production translations, backend behavior, permissions, server calculations or runtime integration. No browser verification was run here because the controller owns that step. Open Sans is requested in CSS and falls back to Arial because the isolated frozen inputs did not include a local font file and downloads are prohibited.

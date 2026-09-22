<!-- frontend-packet: 1 -->
# Credipark manual adjustment: approved frontend direction

## Brief and scope

Standalone design exploration inside the Superpowers frontend-knowledge evaluation. Parking operators need to credit or debit a customer's Credipark account, identify the attribution parking, supply a reason and note, and understand the result without implementation jargon.

Request scope: design only. Packet status: approved. Revision: `b2-operator-copy-approved-2026-09-22`; descriptor: [packet.json](packet.json). The user approved the simplified B2 with “B2 is great now, lets proceed.” Approval concerns this concrete interface, not production integration or repository merge readiness.

French visible copy in the frozen prototype is authoritative for the redesigned dialog. Preserve Credipark/cp terminology and locale formatting. Synthetic fixture names, notes, balances and checked confirmation are demonstration data, not production defaults.

## Evidence and decisions

See [brownfield inspection](brownfield-ui-extraction.md), [states](screen-index.md), and [history](history/README.md).

Retain the familiar light Gateway interface and blue actions. B2 retains B's input/review split, compacts related fields, shows customer/current balance once, and distinguishes signed adjustment from previewed balance. Parking and reason repeat in the review area to support verification. The review area costs vertical space on narrow screens; the body scrolls while header/footer stay available.

Apply the user's usefulness principle: visible information must help an operator decide, act, understand an outcome, or recover. Remove technical server labels, codes, retry IDs, audit explanations and indicators without actionable purpose. Keep actual constraints and truthful uncertainty. This principle does not remove confirmation, permissions, required evidence or safe retry behavior.

Refactoring UI grouping/hierarchy, DOET mappings/feedback and optional Impeccable operate knowledge informed this iteration. No causal claim is made that fuller references alone improved the design. Human refinement and review were material.

## Exact visual targets

All captures are from the unchanged approved source, recaptured at finalization. Binding scope is the dialog, including its responsive layout and visible copy. The placeholder application shell, fixture toolbar, demonstration notice and simulated parent page are reference-only testing apparatus and must not ship.

| Target | File | State / viewport | Intent |
| --- | --- | --- | --- |
| desktop-ready | references/desktop-ready.png | ready / 1280×720 | visual-truth |
| narrow-ready | references/narrow-ready.png | ready / 390×844 | visual-truth |
| narrow-preview | references/narrow-preview.png | preview / 390×844, body scrolled | visual-truth |

These references and `prototype/` supersede A, original B and earlier B2 copy for this feature. Original artifacts are preserved in history. Prototype behavior binds only within the verified business invariants below; synthetic transport and fixture controls do not.

## Launch and setup

From this packet directory, run:

```sh
python3 -m http.server 8942 --bind 127.0.0.1 --directory prototype
```

Open http://127.0.0.1:8942/. Requires Python3 and a browser, no build or external assets. Toolbar selects empty/ready/long/no-account fixtures and success/conflict/forbidden/interruption responses. Reload restores ready. All actions remain local and synthetic.

## Implementation and verification

Production target: `/Volumes/Workspace/Development/SolutionPark/DashPark/gateway/src/main/webapp/app/pages/customers/customer-loyalty-adjustment-dialog.component.html`, adjacent `.scss` and `.ts`; entry through `/#/pages/customers` under an authorized operator. Keep the existing Angular reactive form, customer service and dialog integration. Use existing Nebular controls or native semantic controls compatible with the installed stack; translate the CSS layout rather than copying the standalone simulation.

| Prototype element | Production responsibility |
| --- | --- |
| Direction radios / amount | Existing direction and amount controls, exact minor-unit parser, locale formatting |
| Parking / reason / note | Existing reactive controls and actual options/permissions; do not invent choices |
| Identity / available balance | Actual selected customer and authoritative account state |
| Review panel | Derived signed input, actual preview response, selected parking/reason |
| Confirmation | Existing required confirmation evidence; unchecked for a new real operation |
| Preview / save | Existing preview/submit handlers, request subscriptions and safe retry identity |
| Close / reload | Existing dialog close contract and parent balance refresh |
| Messages | Existing French i18n catalogue; translate approved operator wording without exposing technical diagnostics |

Preserve positive amount entry with direction, up to two decimals and actual numeric bounds; parking/reason/note/confirmation requirements; preview optionality; clearing preview after edits; disabled controls during requests; input retention on errors; stable retry identity for unchanged requests and regeneration on edited data; authoritative debit rejection and balance refresh. Do not locally apply a balance change or copy the synthetic success/conflict calculations into production.

No-gos: no new workflow prerequisites, wizard, global shell rewrite, new component library, hidden required evidence, diagnostic codes in the operator UI, or claim that an uncertain save failed. Server logs/support tooling may retain diagnostics outside this dialog.

Responsive: two columns above760px; one column at or below760px. On narrow screens the review follows inputs, with full parking name available there. Retain fixed header/footer and scrolling body. Native select truncation is acceptable only with a readable selected value elsewhere. Long content and feedback may scroll.

Keyboard: native radio selection, visible focus, logical form order, first-invalid focus, containment in the dialog, Escape close when idle, busy focus feedback and return, and focus return to the real launcher on close. The synthetic reopen button is not the production launcher. Labels must remain associated; status/error changes announced. Verify production semantics and WCAG AA contrast, zoom, keyboard and reduced motion; standalone evidence does not certify these.

Required acceptance is in screen-index.md. Compare real desktop/narrow rendering against the supplied captures, excluding test apparatus. Verify real authorization, business validation, preview/direct-save, double-submit prevention, retry, unknown account, long content, and parent refresh with the project's testing instructions. Never submit real adjustments solely to demonstrate a visual change without appropriate test authorization.

## Evidence limits and continuation

Current final source was exercised for normal display, preview131.00 from128.50+2.50, pending controls, uncertain-save copy, synthetic success and reopening. Earlier B2 checks covered overdraw, empty errors, mobile long labels, preview invalidation and keyboard close. These are explicitly inherited checks, not fresh final-version claims. No production/backend integration, screen-reader run or complete accessibility certification. Font stack falls back if Open Sans is unavailable. Captures show the actual browser rendering, not generated imagery.

Final approval: user, 2026-09-22, simplified B2 at the displayed local prototype URL. Continuation: preserve this design while completing the Superpowers skill evaluation. Future authorized DashPark implementation should consume this packet with implementing-frontend-design and validate its descriptor identity. No production work begins from this packet finalization alone.

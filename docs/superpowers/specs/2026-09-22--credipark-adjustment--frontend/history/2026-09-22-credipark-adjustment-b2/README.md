# Credipark adjustment B2

Status: design exploration, awaiting user review. This is not an approved implementation packet.

## Brief and authority

Refine the source-assisted B prototype for parking operators after the user's 2026-09-22 instruction to proceed. Preserve its form plus review-area direction while reducing duplication and height. No production integration or skill change is authorized by this prototype iteration.

Starting point: `../2026-09-16-selective-design-reference-loading/prototype-candidate/`. A and original B are unchanged. The user considers A compact and B potentially better for operators; this is not evidence of either source approach's general superiority.

Retained anchors: French Credipark terminology, white/cool-gray surfaces, blue actions, Open-Sans-first font stack, compact controls and authoritative service outcomes. Current DashPark root PRODUCT.md and gateway/PRODUCT.md and gateway/DESIGN.md were consulted. Root DESIGN.md does not exist. The placeholder shell and synthetic state remain isolated from Angular and all services.

## Design changes

- Group direction and amount on one row, parking and reason on another on desktop.
- Keep customer and current balance together once at the top.
- Consolidate the signed amount and server-preview balance in the review area. Retain parking and reason there for checking; remove duplicated customer and third amount rendering.
- Place optional preview beside its result. Save stays in the fixed footer and does not require preview.
- Reduce warning decoration, retain the debit constraint and confirmation.
- Keep mobile body scrolling within a fixed header/footer. Long parking names remain readable in the review area even when a native select truncates its selected label.
- Correct contradictory synthetic credit/debit notes. Distinguish preview-unavailable feedback from an uncertain save outcome.

Knowledge consulted: maintained Refactoring UI Visual Hierarchy and Spacing & Sizing sections, DOET Mappings/Feedback/Constraints and error recovery, and installed Impeccable 4.3.1 operate.md. These support grouping, explicit input-versus-result distinction, and familiar operational density. Impeccable was consulted as knowledge; its launcher, commands and detector were not executed. No quality score or causal design improvement is claimed.

## Proposed copy changes

| Element/state | Proposed French copy | Purpose |
| --- | --- | --- |
| Signed amount | Ajustement saisi | Distinguish entered operation from server result |
| Result | Solde après ajustement | Identify the projected balance |
| Preview helper | Facultatif · Vérifier le solde après ajustement. | Explain optional action at point of use |
| Preview transport failure | Prévisualisation indisponible | Avoid describing a preview as a save |
| Preview failure detail | Le solde après ajustement n’a pas pu être vérifié. Vos données sont conservées. Réessayez la prévisualisation. | State failure, preserved work and recovery |

Remaining production copy is inherited from B. All B2 wording awaits approval with the design; no i18n files changed.

## Run and compare

From the Superpowers repository root:

```sh
python3 -m http.server 8941 --bind 127.0.0.1 --directory docs/superpowers/evaluations
```

- B2: http://127.0.0.1:8941/2026-09-22-credipark-adjustment-b2/
- Original comparison: http://127.0.0.1:8941/2026-09-16-selective-design-reference-loading/

The toolbar switches empty, ready, long-label and no-account fixtures and simulated service responses. All actions are synthetic. Reload restores the initial fixture. Default confirmation is prechecked only in the ready demonstration fixture; it is unchecked in the empty fixture.

## Verification on 2026-09-22

Controller used the Codex in-app browser. Checked normal viewport, 1280x720 and 390x844, including long customer/parking names. At short desktop: toolbar bottom83, dialog top90, footer bottom708. At narrow size: page scroll width390 for viewport390, footer visible. Long forms and feedback still require body scrolling; B2 does not claim every state fits without scrolling.

Observed interactions:

- Credit2.50 preview yields131.00 from128.50; changing amount to5.00 clears preview.
- Synthetic save after that edit succeeds without another preview.
- Debit200 is refused against128.50.
- Long-fixture debit18.75 preview yields109.75; full parking label visible in review.
- Simulated service failure preserves form inputs; retrying preview succeeds.
- Updated preview-failure wording and distinct uncertain-save wording both verified after reload.
- Empty preview exposes amount/reason/note/confirmation errors and focuses amount; save remains disabled.
- Busy operation disables form/actions/fixture controls.
- Escape closes and focuses reopen; reopening works.

`node --check app.js` passes. Original A/B artifact identity checks remain unaffected. Screenshots were inspected inline, not saved as durable captures. No screen-reader run, comprehensive accessibility certification, production/backend verification, or complete repository-suite rerun. The existing skill-branch finishing failure remains unresolved; this design iteration does not reset its correction limit.

Next: user review of B2, then requested refinement or explicit approval and canonical packet finalization. Do not treat this README as final visual truth.

## Operator-copy revision after B2 feedback

The user likes B2 and requests removing technical details and applying YAGNI to UI and copy. This revision supersedes the original copy where changed. Each visible item must help the operator decide, act, understand an outcome, or recover. Remove implementation explanations, redundant reassurance and indicators without an actionable purpose. Preserve consequential uncertainty and required business controls.

Removed audit subtitle/help, diagnostic request disclosure, technical response labels/codes and the note character count, which had no displayed limit. Kept a brief demonstration notice to avoid confusing synthetic actions with real account changes. Required confirmation, preview optionality and validation behavior remain intact. No workflow skill files or production code changed.

| State | Revised copy | Operator need |
| --- | --- | --- |
| Confirmation | Je confirme cet ajustement. | Confirm the intended operation |
| Pending | Prévisualisation en cours / Enregistrement en cours | Know the action is underway |
| Success | Ajustement enregistré. Actualisez le solde pour voir le montant à jour. | Know outcome and next step |
| Debit refused | Le débit dépasse le solde disponible. Réduisez le montant ou rechargez le solde. | Recover from invalid amount |
| Permission | Vous n’avez pas les droits nécessaires. Contactez votre responsable. | Find who can help |
| Uncertain save | L’ajustement a peut-être été enregistré. Réessayez sans modifier les informations. | Avoid changing a possibly completed operation |
| Prototype notice | Démonstration · Aucun compte réel n’est modifié. | Understand this is a demonstration |

French terminology and cp formatting remain unchanged. Required labels stay visible; deleted help references are removed from aria-describedby. Technical request identity is kept internally for retry behavior, not shown to operators. No business rule, permission or required field is removed as a shortcut to simplicity.

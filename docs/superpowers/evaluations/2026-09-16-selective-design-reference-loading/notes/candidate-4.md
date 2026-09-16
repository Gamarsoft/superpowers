# Decision note — Ajustement Credipark

## Evidence actually consulted

I read `brief.md`; `context/AGENTS.md` (Working approach, Critical Constraints); `context/PRODUCT.md` (Users, Product Purpose, Operating Context); Gateway `AGENTS.md` (Frontend, Design Context), `PRODUCT.md` (Users through Accessibility & Inclusion), and `DESIGN.md` (Overview, Typography, Layout, Components, Do’s/Don’ts). I inspected `user-baseline.png`, all of `copy.json`, and the dialog HTML/SCSS/TypeScript plus the component spec’s adjustment tests. From the maintained skill I applied “Choose the entry and scope” and design-loop step 1, plus `design-source-priority` (Scoped Design Authority), `brownfield-ui-extraction-template` (Constraints and anchors/Problems and freedom), `task-to-layout` (information model/visual relationships), and `design-knowledge-selection`. I then read and applied Refactoring UI’s **Visual Hierarchy, Spacing & Sizing, Typography, Layout & Composition**, and Design of Everyday Things’ **Two Gulfs, Signifiers, Mappings, Constraints, Feedback, Conceptual Models, Human Error**.

## Practical refinement

The operator’s decision is: *for this customer and parking, does the signed adjustment and its evidence match my intent, and may I record it?* Use one scrollable, fixed-footer dialog in the existing light Nebular shell.

1. **Compress context into a two-row identity band:** customer + account first, then available balance + parking. Remove the unsupported “Actif” assertion when account state is unknown. Long values wrap. Cost: less at-a-glance symmetry than four equal cells, but the authoritative balance and target remain adjacent to the task.
2. **Make effect the first form group:** a compact Crédit/Débit segmented choice beside positive amount, followed immediately by one strong line, `Effet : +2,50 cp` or `−2,50 cp`; after server preview, extend this same region with current → projected balance and “Prévisualisation validée.” Cost: slightly more vertical space and a custom semantic-radio treatment to verify under Angular 7; it narrows both execution and evaluation gulfs without inventing a balance.
3. **Group evidence beneath effect:** parking and motif share a row on desktop; note spans the width; confirmation sits directly below the note. Keep all six reasons visible and fields labelled. Cost: reason and parking have less width, so 1280px and long-label wrapping need testing.
4. **Use a stable action footer:** left-aligned `Recharger le solde`; right-aligned `Fermer`, outlined `Prévisualiser`, filled `Enregistrer l’ajustement`. On 390px, stack primary first, preview/close second, reload last. Explain disabled save through nearby validation, not color alone. Cost: mobile action order differs visually from desktop, while tab order must remain logical.
5. **Put feedback at the affected layer:** field errors remain inline; conflict/forbidden/service failure appears above the form with support code, “Aucun mouvement n’a été écrit,” and reload where applicable. Preserve inputs. Cost: persistent errors consume short-height space, so body scrolling and footer separation are essential.

## Contract boundary and checks

Business behavior remains unchanged: positive two-decimal cp plus direction determines sign; parking, reason, nonblank note, and confirmation are required; preview requires complete evidence but remains optional for save; edits invalidate preview; server values stay authoritative; unchanged retries retain identity; invalid/busy blocks save; reload closes and asks the parent to reload. The segmented direction control and clearer effect wording are design proposals only; omitting unknown “Actif” corrects an unsupported claim, not eligibility.

Prototype checks: 1536×1024, 1280×720, 390×844; long customer/parking/reason/error text; keyboard order and visible focus; credit/debit sign mapping; invalid, ready, preview-loading, save-loading, conflict, forbidden and service-failure states; edit-after-preview invalidation; preserved evidence after failure; footer/body scroll containment. No rendered proof or approval is claimed.

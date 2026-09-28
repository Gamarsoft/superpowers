# Credipark adjustment — refinement decision note

## Evidence actually read

I read `micro-task.md`, `brief.md`; the complete frozen `frontend-direction/SKILL.md`; `design-source-priority.md` (“Scoped Design Authority”), `brownfield-ui-extraction-template.md` (“Evidence” through “Boundaries”), `task-to-layout.md` (“Establish the information model” through “Connect the choice to evidence”), and `impeccable-brownfield-quality-layer.md` (“Discover and scope”, “Evidence and limits”). I also read the frozen `writing-ux-copy/SKILL.md` (“Source Order”, workflow, pattern and i18n rules); context `AGENTS.md`, `PRODUCT.md`, Gateway `AGENTS.md`, `PRODUCT.md`, `DESIGN.md`, `DESIGN-EVIDENCE.md`, and `FRONTEND-ANCHORING.md`; all supplied component TS/HTML/SCSS/tests and `copy.json`; and inspected `user-baseline.png`. This is source/manual assessment only: no optional command, browser, or rendered prototype was run.

## Direction

Use one scroll-contained, white Nebular dialog with a fixed compact header/footer and a task sequence of **context → adjustment → evidence → confirmation**. Preserve Open Sans, operational blue, modest radius, dense spacing, French labels, and the existing 48rem desktop scale.

1. Replace the four equal summary cells with a two-level context strip: customer/account on the left, current server balance prominent on the right. Remove the hard-coded “Actif”; an unavailable account is not evidence of status. Cost: less symmetry, but long names gain width and the authoritative balance becomes easier to compare with the effect.
2. Make “Crédit / Débit” a compact two-option control immediately before amount, then show a persistent effect row beneath: `Effet : +2,50 cp` and, only after server preview, `Solde après enregistrement : 10,70 cp`. Never calculate or present the projected balance as authoritative locally. Cost: the effect consumes a row; it prevents the current duplicated, weak “Montant envoyé” presentation.
3. Group parking, motif, and note under “Justification de l’ajustement”; keep all visible, with the note full width. On desktop use two columns only for parking/motif; at 390px stack everything. Cost: a slightly taller dialog, offset by clearer evidence association and safer wrapping for long parking names/errors.
4. Keep the audit checkbox adjacent to the final actions. Footer order: `Fermer`, `Prévisualiser`, primary `Enregistrer l’ajustement`; place `Recharger le solde` inside stale/conflict feedback, because it closes and requests parent reload. Cost: reload is less constantly discoverable but no longer looks like a harmless inline refresh.

## Contract boundary

Business behavior remains unchanged: positive two-decimal cp input; direction supplies sign; parking, one of six reasons, nonblank note, and confirmation required; preview optional; edits invalidate preview; server values stay authoritative; save is blocked invalid/busy; failures preserve input; unchanged retries retain idempotency; reload closes; all ready/busy/conflict/forbidden/service states remain. **No behavioral change is proposed.** Copy clarification only: subtitle `Crée une écriture auditée dans le journal Credipark.` and preview action `Vérifier l’effet`.

## Representative checks

At 1536×1024, 1280×720, and 390×844, verify internal scrolling with footer access; long customer/parking names and expanded French errors; keyboard order and visible focus; labels and errors programmatically associated; invalid/ready/loading/conflict/forbidden/service states; preview disappearance after edits; direct valid save without preview; unchanged-data retry identity; and reload/close results without local balance mutation. These remain prototype/runtime checks, not established proof.

# Settings and Forms

## Preferred pattern

For configuration-heavy screens, prefer:

- a clear card shell
- visible section titles and descriptions
- essential settings first
- advanced settings grouped behind accordions or toggles where appropriate
- fixed footer action when the page architecture already uses it

## Angular 7 forms discipline

For dense admin/settings flows, prefer reactive forms by default:

- explicit `FormGroup` / `FormControl` shape in the component class
- `formGroup` and `formControlName` in the template
- validation and disabled state driven from the form model

Template-driven forms are acceptable only for simple, isolated controls when the existing page already uses that pattern.

Do not mix `[(ngModel)]` with `formControlName` on the same control.

## Field guidance

Prefer:

- visible labels on meaningful admin fields
- helpful helper/error text
- consistent control widths
- predictable action placement
- grouped settings by user intent, not raw backend key order
- one chosen forms style per control
- Nebular controls bound through the selected Angular forms style rather than ad-hoc local state

Avoid:

- placeholder-only labeling for dense forms
- raw key-order sprawl
- action buttons that move unpredictably
- heavy controls loaded before needed when lazy load is viable
- mixing reactive and template-driven bindings on the same field

## Nebular control reminders

- `input[nbInput]` and `textarea[nbInput]` work with Angular forms bindings
- `nb-select` supports forms binding and also its own selected API, but the page should still choose one coherent form pattern
- use Nebular `status` styling to reflect semantic state only when that matches the product language already in the repo

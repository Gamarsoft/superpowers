# Angular + Nebular Translation

## Goal

Translate Pencil direction into implementation that feels native to an Angular + Nebular brownfield repo.

For DashPark-style work, assume Angular `7.2.12` and Nebular `3.5.0` unless the target repo proves otherwise.

## Research order

Before translating a Nebular-backed screen:

1. verify Angular guidance through `superpowers:context7-research`
2. read `/Volumes/Workspace/Development/Librairies/nebular/docs/AGENTS.md`
3. read the relevant Nebular article under `docs/articles/` for conceptual/theming questions
4. read the matching component source under `src/framework/theme/components/` for real selectors, inputs, outputs, and module wiring

For Nebular behavior questions, source code outranks generated docs.

## Common mapping patterns

| Pencil pattern | Angular/Nebular translation |
|---|---|
| button | existing button wrapper or `button[nbButton]` pattern |
| card surface | `nb-card` with `nb-card-header`, `nb-card-body`, and `nb-card-footer` where appropriate |
| accordion section | `nb-accordion` / accordion item pattern |
| tabs | `nb-tabset` / `nb-tab`, often with lazy tab content |
| badge / pill / status chip | Nebular badge/status styling or existing shared status component |
| form field | existing field wrapper plus `input[nbInput]`, `textarea[nbInput]`, `nb-select`, checkbox/date/etc. |
| dialog / modal | shared dialog wrapper or `NbDialogService` pattern |
| page shell | existing layout component and page container pattern |
| dense table row | existing table/list row component or current shared row pattern |
| icon action | existing icon-button / utility-action pattern with accessible labeling |

## Template-shape guidance

Prefer:

- the existing layout component
- shared modules
- shared wrappers around Nebular primitives
- semantic classes tied to the theme
- shared SCSS helpers for repeated layout behavior
- Angular bindings and structural directives for view shape
- `ng-container` or `ng-template` instead of meaningless wrapper elements

Avoid:

- deeply nested one-off wrapper div chains
- Tailwind-like utility dumping into templates
- page-local redesign of shared components
- local styles that should belong in a shared shell or primitive
- side-effect-heavy template expressions
- imperative DOM manipulation for what bindings and directives already solve

## Angular module discipline

- `BrowserModule` belongs in the root app module, not feature modules
- feature modules typically import `CommonModule`
- if templates use `ngModel`, the owning module needs `FormsModule`
- if templates use `formGroup` / `formControlName`, the owning module needs `ReactiveFormsModule`
- shared modules may re-export common declarables and modules
- shared modules should not provide app-wide singleton services
- root-versus-lazy scope matters for module APIs such as Nebular dialog `forRoot()` / `forChild()`

## Angular interaction discipline

Default UI translation should use Angular’s normal view contract:

- interpolation for simple text
- `[]` for input/property binding
- `()` for event binding
- `[()]` only when that control actually uses two-way binding in the chosen form style
- `*ngIf` / `*ngFor` for conditional and repeated sections

Keep template expressions simple, fast, and side-effect free.

## Shared vs page-local decision

### Shared
Put behavior or styling in shared code when it is:

- repeated across pages
- part of the shell
- part of a reusable card or action-row pattern
- part of the theme/token system
- part of a reusable status/badge/filter primitive

### Page-local
Keep it local only when it is:

- genuinely specific to one screen
- not part of a broader reusable pattern
- unlikely to be reused or normalized soon

## SCSS discipline

Prefer:

- theme tokens or semantic SCSS variables
- shared wrappers
- layout mixins or shared partials
- minimal page-local overrides
- Nebular theme helpers and component variables when the page participates in the Nebular theme system

Avoid:

- extra hardcoded colors
- repeated card scroll logic per page
- `::ng-deep` unless no cleaner option exists

## Nebular primitive reminders

- `NbButtonModule` powers `nbButton`
- `NbCardModule` powers `nb-card`
- `NbInputModule` powers `nbInput`
- `NbSelectModule` powers `nb-select`
- `NbTabsetModule` powers `nb-tabset`
- `NbDialogModule.forRoot()` belongs at root, `forChild()` in lazy modules

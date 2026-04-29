# Example UI Prompts

Use these examples as the quality bar for generated prompt files. They intentionally mirror the level of detail expected in real upload packs: concrete layout hierarchy, literal UI copy, representative values, table rows, screen-family inheritance, and explicit no-gos.

## Example Parent Screen Prompt

```markdown
# ChatGPT Images Prompt - S1 Credit Park Control Center Active Desktop

Create a high-fidelity desktop admin UI mockup for a native Gateway admin page.

## Reference Handling

If a Gateway screenshot is provided, use it as a style and shell reference only:

- preserve the top header, left sidebar, compact page canvas, density, typography feel, and component styling
- do not copy unrelated page content
- create a new page named "Credit Park"

## Goal

Render the active desktop "Credit Park" control center used by a Gateway program manager to manage rollout, rules, tenants, backfill, supply, and audit from within Gateway.

## Screen Family Reuse Contract

This file is the canonical shared design for all S1 control center states.

Child state map:

- `S1a` = disabled / not-enabled program state
- `S1b` = rollout or backfill running state; split degraded, partial failure, retryable error, or completed reconciliation into separate child prompts when separately indexed
- `S1c` = unauthorized / read-only permission state

For these child states, preserve this exact screen family:

- same Gateway shell and CRM sidebar
- same active `Credit Park` navigation placement
- same status-first page header placement
- same summary strip placement and metric order
- same section order: Program Rules, Tenant Eligibility, Backfill Health, Audit / Reconciliation
- same table column structure
- same card widths, spacing rhythm, typography feel, and copy tone
- same restrained Gateway/Nebular admin style

State prompts may change only status values, messages, enabled/hidden actions, row values, empty-state content, and error/warning emphasis. Do not redesign the page for state variants.

## Output Style

- realistic product UI screenshot
- front-facing flat view
- no perspective distortion
- no device frame
- no browser chrome
- no marketing presentation board
- crisp legible text
- compact enterprise SaaS admin aesthetic

## Screen Structure

1. Gateway shell
   - top header
   - left sidebar
   - compact admin page content area
   - this should feel like settings and operations tooling, not an analytics dashboard

2. Left sidebar
   - include a CRM navigation group
   - CRM group contains "Clients" and "Credit Park"
   - "Credit Park" is the active item

3. Status-first page header
   - title: "Credit Park"
   - compact subtitle: "Manage program rollout, earning rules, tenant eligibility, and operational health."
   - status pill: "Enabled"
   - locked start date: "Start date: 2026-04-01"
   - current ruleset: "Ruleset: v2026.04"
   - one primary action button: "Manage Program" in Operational Blue (#3EAAFA)

4. Summary strip
   - compact stat tiles or inline summary modules
   - Available supply: "24,500"
   - Pending supply: "1,200"
   - Eligible tenants: "86"
   - Backfill: "Running"
   - Audit exceptions: "4"
   - header/status area must feel more important than these metrics

5. Program Rules section
   - compact operational rules card or panel
   - Conversion rate: "1 EUR = 10 credits"
   - Rounding: "Round down"
   - Channels: "Web, Mobile, Partner API"
   - Daily cap: "500 credits"
   - Minimum spend: "5 EUR"
   - Cooldown: "24h"
   - Expiry: "Enabled, 12 months"
   - Effective date: "2026-04-01"
   - include draft/publish affordance, visually guarded and admin-safe

6. Tenant Eligibility section
   - dense readable table
   - columns: "Parking / Tenant", "Eligibility", "Effective window", "Last update", "Action"
   - rows:
     - "Parking Nord" | "Eligible" | "2026-04-01 to Open" | "2026-04-18 09:42" | "Edit"
     - "Aeroport P2" | "Pending" | "2026-04-15 to Open" | "2026-04-18 08:10" | "Review"
     - "Centre Gare" | "Ineligible" | "-" | "2026-04-17 18:27" | "Edit"

7. Backfill Health section
   - compact operational status card
   - Status: "Running"
   - Progress: "12,450 / 18,000"
   - Last processed: "BK-2026-18442"
   - Updated: "2026-04-18 09:51"
   - Last error: "Timeout while reconciling tenant Aeroport P2"
   - use Signal Orange (#f87c09) only sparingly for attention/error state

8. Audit / Reconciliation section
   - dense recent rows table
   - columns: "Audit ID", "Actor", "Timestamp", "Source", "Tenant", "Rule version", "Exception"
   - rows:
     - "AUD-10982" | "system" | "2026-04-18 09:48" | "backfill" | "Parking Nord" | "v2026.04" | "none"
     - "AUD-10981" | "jmartin" | "2026-04-18 09:31" | "admin edit" | "Aeroport P2" | "v2026.04" | "warning"
     - "AUD-10980" | "system" | "2026-04-18 09:12" | "nightly sync" | "Centre Gare" | "v2026.03" | "exception"

## Typography And Spacing

- clean modern sans-serif UI typography matching Gateway/Open Sans
- compact enterprise spacing; use approximately 24px page padding on desktop
- use 16px to 20px card/panel padding, 12px row gap in compact summary areas, and 40px to 44px table row height
- keep button height around 36px to 40px and border radius around 4px to 6px
- consistent padding and alignment
- subtle borders and light surface separation
- minimal shadows
- highly legible labels and tables

## Visual Direction

- make this feel like Gateway settings and operations tooling
- compact cards and dense but readable tables
- header/status area is the primary visual anchor
- primary action blue: #3EAAFA
- Signal Orange (#f87c09) only for warnings, exceptions, or backfill attention
- green only for healthy or published states
- no chart-led dashboard composition

## Avoid

- no marketing-style loyalty visuals
- no consumer reward imagery
- no redemption, checkout, wallet, coupon, or reward-store language
- no page-wide orange theme
- no large hero area
- no illustration-heavy layout
- no nested cards
- no oversized whitespace
- no analytics-heavy chart dashboard

The result should look like a believable production-ready internal admin screen inside the existing Gateway SaaS product.
```

## Example Child State Prompt

```markdown
# ChatGPT Images Prompt - S1a Credit Park Control Center Disabled Desktop

Create a high-fidelity desktop admin UI mockup for the disabled or not-enabled Credit Park control center.

Attach this prompt together with `01-s1-control-center-active.md`. Reuse the S1 active control center design as the shared screen family and apply only the state changes below.

## Reference Handling

If a Gateway screenshot is provided, use it only to match the shell, sidebar, header, spacing density, typography feel, and compact admin component style. Do not copy unrelated content.

## Goal

Render the same S1 Credit Park control center layout in a disabled/not-enabled state. It should feel like a valid operational state, not an application error.

## Output Style

- realistic product UI screenshot
- front-facing flat desktop view
- crisp legible UI text
- compact enterprise admin layout
- no presentation board or annotations

## Inherit From S1 Active

Preserve from `01-s1-control-center-active.md`:

- Gateway shell
- CRM sidebar group with "Clients" and active "Credit Park"
- status-first page header layout
- summary strip location and metric order
- Program Rules section location
- Tenant Eligibility table location and columns
- Backfill Health section location
- Audit / Reconciliation section location
- compact card/table rhythm, spacing, and typography

## State Changes Only

1. Page header
   - keep title: "Credit Park"
   - keep the active baseline subtitle: "Manage program rollout, earning rules, tenant eligibility, and operational health."
   - status pill changes to: "Not enabled"
   - start date value changes to: "Start date: Not set"
   - ruleset value changes to: "Ruleset: No published rules"
   - action slot shows one permitted primary action: "Set up program"

2. Summary strip
   - keep the same five metric positions:
     - Available supply: "0"
     - Pending supply: "0"
     - Eligible tenants: "0"
     - Backfill: "Unavailable"
     - Audit exceptions: "0"
   - use muted neutral styling

3. Program Rules section
   - keep the same rules panel and field labels as S1 active
   - values are muted placeholders:
     - Conversion rate: "Not configured"
     - Rounding: "Not configured"
     - Channels: "Not configured"
     - Daily cap: "Not configured"
     - Minimum spend: "Not configured"
     - Cooldown: "Not configured"
     - Expiry: "Not configured"
     - Effective date: "Not set"
   - no publish action unless permission and setup state allow it

4. Tenant Eligibility section
   - keep the same table columns as S1 active
   - show one muted empty row:
     - "No tenant eligibility configured" spanning the row visually

5. Backfill Health section
   - keep the same card position as S1 active
   - Status: "Unavailable"
   - Progress: "-"
   - Last processed: "-"
   - Updated: "-"
   - no retry or review action

6. Audit / Reconciliation section
   - keep the same table position and columns as S1 active
   - show a muted empty state row: "No audit events yet"

## Visual Direction

- calm and factual
- neutral surfaces
- muted labels
- no danger color unless an actual failure is shown
- the page remains structurally stable instead of blank

## Example Visible Text

- "Credit Park is not enabled for this group."
- "Program setup must be completed before bookings can earn Credit Park."
- "No published rules"
- "No tenant eligibility configured"

## Avoid

- no large illustration
- no marketing empty state
- no error-page treatment
- no publish/backfill/edit tenant actions while the program is not enabled
- no implication that loyalty balances failed to load
- no redemption or wallet language
- no new layout, no alternate section order, no different subtitle style
```

## Example Child State Prompt - Rollout / Backfill

```markdown
# ChatGPT Images Prompt - S1b Credit Park Control Center Rollout Desktop

Create a high-fidelity desktop admin UI mockup for the Credit Park control center during rollout and backfill execution.

Attach this prompt together with `01-s1-control-center-active.md`. Reuse the S1 active control center design as the shared screen family and apply only the rollout/backfill state changes below.

## Reference Handling

Use the same Gateway reference screenshot roles as `01-s1-control-center-active.md`: shell, sidebar, header, spacing density, typography feel, and compact admin component style only. Do not copy unrelated content.

## Goal

Render the same S1 Credit Park control center layout while a program rollout is live and historical booking backfill is still processing. The page must feel like operations tooling inside Gateway, not a separate analytics dashboard or job-monitor product.

## Output Style

- same realistic flat desktop screenshot style as S1 active
- same Gateway shell and density
- same section order and table/card rhythm
- crisp legible operational copy
- no charts except tiny status indicators if already implied by the parent

## Inherit From S1 Active

Preserve from `01-s1-control-center-active.md`:

- Gateway top header and CRM sidebar with active "Credit Park"
- status-first page header placement
- summary strip location and metric order
- Program Rules section location and field labels
- Tenant Eligibility table location, columns, and compact row height
- Backfill Health card location
- Audit / Reconciliation table location and columns
- same typography, restrained borders, button shape, table density, and copy tone

## State Semantics

- This is not a disabled setup state: the program is enabled and rules are published.
- This is not a final completed state: backfill work is still running.
- This is not a total failure state: most work is progressing, with one retryable warning.
- Show partial operational attention using Signal Orange (#f87c09), but keep the page stable and usable.
- Primary management actions remain available, but destructive or duplicate backfill actions should look guarded.

## State Changes Only

1. Page header
   - keep title: "Credit Park"
   - keep subtitle: "Manage program rollout, earning rules, tenant eligibility, and operational health."
   - status pill changes to: "Rollout in progress"
   - start date remains: "Start date: 2026-04-01"
   - ruleset remains: "Ruleset: v2026.04"
   - primary action remains: "Manage Program"
   - add a compact secondary action: "View rollout log"

2. Summary strip
   - keep the same five metric positions:
     - Available supply: "18,250"
     - Pending supply: "7,450"
     - Eligible tenants: "64 / 86"
     - Backfill: "Running"
     - Audit exceptions: "7"
   - use one orange attention marker on "Audit exceptions" or "Backfill", not a page-wide orange theme

3. Program Rules section
   - keep all parent field labels and compact rules layout
   - values remain published and stable:
     - Conversion rate: "1 EUR = 10 credits"
     - Rounding: "Round down"
     - Channels: "Web, Mobile, Partner API"
     - Daily cap: "500 credits"
     - Minimum spend: "5 EUR"
     - Cooldown: "24h"
     - Expiry: "Enabled, 12 months"
     - Effective date: "2026-04-01"
   - show a small note: "Published rules are locked during active backfill."

4. Tenant Eligibility section
   - keep the same table columns as S1 active
   - row examples:
     - "Parking Nord" | "Eligible" | "2026-04-01 to Open" | "2026-04-18 09:42" | "Edit"
     - "Aeroport P2" | "Rolling out" | "2026-04-15 to Open" | "2026-04-18 09:55" | "Review"
     - "Centre Gare" | "Queued" | "2026-04-20 to Open" | "2026-04-18 09:17" | "Review"
   - row actions remain compact and admin-safe

5. Backfill Health section
   - keep the same card position as S1 active
   - Status: "Running with warnings"
   - Progress: "12,450 / 18,000"
   - Last processed: "BK-2026-18442"
   - Updated: "2026-04-18 09:57"
   - Last error: "Timeout while reconciling tenant Aeroport P2"
   - include one guarded action: "Retry failed batch"
   - do not turn this into a large progress dashboard

6. Audit / Reconciliation section
   - keep the same table position and columns as S1 active
   - row examples:
     - "AUD-10992" | "system" | "2026-04-18 09:57" | "backfill" | "Parking Nord" | "v2026.04" | "none"
     - "AUD-10991" | "system" | "2026-04-18 09:56" | "backfill retry" | "Aeroport P2" | "v2026.04" | "warning"
     - "AUD-10990" | "system" | "2026-04-18 09:53" | "rollout sync" | "Centre Gare" | "v2026.04" | "queued"

## Visual Direction

- stable operations surface with one clear warning emphasis
- parent layout remains visually dominant
- orange only for warning chips, backfill attention, or exception count
- green only for healthy/published values
- no new chart-led composition

## Example Visible Text

- "Rollout in progress"
- "Published rules are locked during active backfill."
- "Running with warnings"
- "Retry failed batch"
- "Timeout while reconciling tenant Aeroport P2"

## Avoid

- no analytics dashboard layout
- no separate job-monitor page
- no large progress chart
- no page-wide orange theme
- no disabled/not-enabled copy
- no unauthorized/read-only banner
- no new section order or changed table columns
```

## Example Child State Prompt - Unauthorized / Read-Only

```markdown
# ChatGPT Images Prompt - S1c Credit Park Control Center Unauthorized Desktop

Create a high-fidelity desktop admin UI mockup for the Credit Park control center in an unauthorized/read-only permission state.

Attach this prompt together with `01-s1-control-center-active.md`. Reuse the S1 active control center design as the shared screen family and apply only the permission and affordance changes below.

## Reference Handling

Use the same Gateway reference screenshot roles as `01-s1-control-center-active.md`: shell, sidebar, header, spacing density, typography feel, and compact admin component style only. Do not copy unrelated content.

## Goal

Render the same S1 Credit Park control center layout for an operator who can view operational status but cannot manage program settings, tenant eligibility, rules, or backfill actions.

## Output Style

- same realistic flat desktop screenshot style as S1 active
- same compact enterprise density and readable tables
- same Gateway shell, sidebar, cards, tables, and typography feel
- no full-page error treatment
- no empty application state

## Inherit From S1 Active

Preserve from `01-s1-control-center-active.md`:

- Gateway top header and CRM sidebar with active "Credit Park"
- status-first page header placement
- summary strip location and metric order
- Program Rules section location and field labels
- Tenant Eligibility table location and columns
- Backfill Health card location
- Audit / Reconciliation table location and columns
- all operational data visibility unless the source packet explicitly says to hide data
- same restrained Gateway/Nebular admin style

## State Semantics

- This is a permission state, not a disabled program state.
- The program remains enabled and operational data remains visible.
- The user lacks manage permissions, so edit/publish/backfill controls must disappear or become disabled.
- Use a compact read-only banner or note inside the page; do not replace the page with a 403 screen.

## State Changes Only

1. Page header
   - keep title: "Credit Park"
   - keep subtitle: "Manage program rollout, earning rules, tenant eligibility, and operational health."
   - status pill remains: "Enabled"
   - start date remains: "Start date: 2026-04-01"
   - ruleset remains: "Ruleset: v2026.04"
   - replace primary action "Manage Program" with a disabled or neutral control: "Read-only"
   - add compact permission note: "You can view Credit Park status, but you do not have permission to manage this program."

2. Summary strip
   - keep the same five metric positions and active values:
     - Available supply: "24,500"
     - Pending supply: "1,200"
     - Eligible tenants: "86"
     - Backfill: "Running"
     - Audit exceptions: "4"
   - no muted empty-state styling

3. Program Rules section
   - keep the same values as S1 active
   - remove or disable edit, publish, and draft actions
   - show a small read-only label near the section header: "View only"

4. Tenant Eligibility section
   - keep the same table columns and active rows as S1 active
   - row actions change from "Edit" or "Review" to "View"
   - row examples:
     - "Parking Nord" | "Eligible" | "2026-04-01 to Open" | "2026-04-18 09:42" | "View"
     - "Aeroport P2" | "Pending" | "2026-04-15 to Open" | "2026-04-18 08:10" | "View"
     - "Centre Gare" | "Ineligible" | "-" | "2026-04-17 18:27" | "View"

5. Backfill Health section
   - keep the same card position as S1 active
   - keep Status: "Running"
   - keep Progress: "12,450 / 18,000"
   - keep Last processed: "BK-2026-18442"
   - keep Updated: "2026-04-18 09:51"
   - remove retry, pause, start, or backfill management actions

6. Audit / Reconciliation section
   - keep the same table position, columns, and active-style rows
   - audit rows remain visible for traceability
   - no edit controls inside audit rows

## Permission Affordance Rules

- Visible: status, rules summary, tenant eligibility, backfill health, audit rows.
- Hidden or disabled: Manage Program, edit tenant, publish rules, retry backfill, pause backfill, start backfill.
- Allowed: read-only navigation and row "View" affordances.
- Copy tone: concise and administrative, not alarming.

## Example Visible Text

- "Read-only"
- "You can view Credit Park status, but you do not have permission to manage this program."
- "View only"
- "View"

## Avoid

- no full-page 403 screen
- no blank data state
- no disabled/not-enabled program copy
- no setup CTA
- no rollout/backfill warning drift unless already present in active data
- no red danger theme
- no new layout, no alternate section order, no different component rhythm
```

## Example README And Attachment Map Snippet

```markdown
## Generation Order

Upload shared context and baseline screenshots first, then generate one prompt at a time.

1. Generate `01-s1-control-center-active.md` first. This creates the canonical S1 control center design.
2. Generate each S1 child state with both the parent prompt and the child prompt attached:
   - `02-s1a-control-center-disabled.md` + `01-s1-control-center-active.md`
   - `03-s1b-control-center-rollout.md` + `01-s1-control-center-active.md`
   - `04-s1c-control-center-unauthorized.md` + `01-s1-control-center-active.md`
3. Save approved images beside the prompts with matching stems:
   - `01-s1-control-center-active.png`
   - `02-s1a-control-center-disabled.png`
   - `03-s1b-control-center-rollout.png`
   - `04-s1c-control-center-unauthorized.png`

## Attachment Map

| Prompt | Parent prompt to attach | Required screenshots | Optional screenshots | Purpose |
| --- | --- | --- | --- | --- |
| `01-s1-control-center-active.md` | none | `design/baseline/gateway-crm-profile.png`, `design/baseline/gateway-shell.png` | `gateway/DESIGN.md` | establish Gateway shell, density, typography, and canonical S1 layout |
| `02-s1a-control-center-disabled.md` | `01-s1-control-center-active.md` | same as parent | none | preserve S1 layout and override only disabled/not-enabled values |
| `03-s1b-control-center-rollout.md` | `01-s1-control-center-active.md` | same as parent | `design/baseline/operations-table.png` | preserve S1 layout and override only rollout/backfill statuses and warnings |
| `04-s1c-control-center-unauthorized.md` | `01-s1-control-center-active.md` | same as parent | none | preserve S1 layout and override only permission affordances |
```

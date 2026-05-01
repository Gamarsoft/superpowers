# Visual Fixtures

For visual-state verification, relying only on live runtime data is brittle. Live data proves integration truth, but it is bad at producing every UI state on demand: active, disabled, rollout, backfill failed, unauthorized, missing context, retryable error, degraded data, etc.

A controlled mock-runtime lane would solve that.

I would frame it as **dual runtime data modes**, not “mocking the UI”:

1. **Live mode**
   - Gateway calls real backend services.
   - Proves integration, auth, routing, feature flags, tenant context, and API composition.
   - Used for “does the real system work?” evidence.

2. **Visual fixture mode**
   - Gateway runs normally, but selected API responses come from deterministic fixture data.
   - Proves all visual states, responsive behavior, copy, action hierarchy, and reference-intent parity.
   - Used for “does every designed state render correctly?” evidence.

The key rule: **mock runtime evidence must be labeled as fixture evidence, not live integration evidence.**

## Preferred implementation

Best option: **browser/e2e-level network fixtures**, not production Angular code.

For example:

- Start the real Gateway frontend.
- Use Playwright or a local mock proxy to intercept:
  - `/api/account`
  - `/services/uaa/api/feature-flags`
  - `/services/customer/api/admin/loyalty/programs/{groupId}?tenantId=...`
- Serve committed JSON fixtures for named states:
  - `active.json`
  - `disabled.json`
  - `rollout-backfill.json`
  - `readonly.json`
  - `missing-context-account.json`
  - `transport-error.json`
  - `degraded-data.json`

Then the browser proof can do:

```text
state=disabled → assert disabled page and compare visual checklist
state=active → assert active status/rules/actions
state=rollout-backfill → assert warning/backfill treatment
state=readonly → assert data visible, write actions hidden
state=missing-context → assert page-local missing context state
```

That gives deterministic visual coverage without mutating Customer Service, UAA, feature flags, Keycloak roles, or database rows.

## One-off browser monkeypatches

An in-browser XHR or `fetch` monkeypatch can be useful as a spike to prove that a state can render from a contract-shaped response.

Treat it as temporary proof only:

- acceptable for a quick lane trial
- label it as ad-hoc fixture evidence in UAT
- do not treat it as the reusable fixture harness
- do not use it as the final review lane when a repeatable network fixture or proxy can be added in scope
- convert successful spikes into Playwright/network fixtures or a local mock proxy before relying on them across tasks or slices

## Why I prefer e2e/network fixtures over app-level fixture switches

An app-level switch like `?creditParkFixture=active` inside Angular is convenient, but riskier:

- It adds non-production data-source logic to the app.
- It can accidentally ship.
- It can mask real service wiring problems.
- It becomes another code path to secure and maintain.

If we do add app-level fixture mode, it should be heavily guarded:

- dev/test builds only
- disabled in production environment files
- visible “Fixture data” marker in the UI
- no real write actions
- no secrets/PII
- tests proving it cannot activate in production config

But I’d still start with **test runner or proxy-level interception**.

## What this would change in UAT

The UAT could distinguish evidence types clearly:

```md
## Live Runtime Proof

- Login as real local manager
- `/api/account` real
- UAA feature flags real
- Customer Service call real
- Proved disabled/setup state for tenantGroupId 1

## Fixture Runtime Visual Proof

- `active` fixture rendered in browser
- `disabled` fixture rendered in browser
- `rollout-backfill` fixture rendered in browser
- `readonly` fixture rendered in browser
- `missing-context` fixture rendered in browser
- Mobile fixture lanes rendered in browser

## Claims Boundary

- Live mode proves service composition for the available runtime state.
- Fixture mode proves visual/state rendering against typed Customer Service-shaped DTOs.
```

That would avoid the weak “blocked/waived” section for visual states while still being honest about live integration coverage.

## The main thing to protect

Fixtures must stay **contract-shaped**, not invented UI blobs.

Bad:

```ts
{
  title: 'Active',
  cards: [...]
}
```

Good:

```json
{
  "program": { ...Customer Service DTO shape... },
  "rules": [...],
  "tenantEligibility": [...],
  "backfill": {...},
  "capabilities": {...},
  "nextActions": [...]
}
```

That keeps Gateway honest: it still renders server-authored state and does not grow a parallel UI-only data model.

## Recommended task pattern

Yes, build it.

I’d propose a future task/slice pattern:

1. Add a `credit-park.visual-fixtures/` catalog with typed Customer Service DTO JSON.
2. Add a Playwright or local proxy harness that can serve each fixture state.
3. Add browser/UAT scripts that render each state in desktop and mobile.
4. If an ad-hoc browser monkeypatch was used first, replace it with the harness before making the fixture lane repeatable.
5. Update UAT language to separate:
   - live integration proof
   - fixture visual-state proof
6. Keep screenshots/debug dumps ephemeral unless explicitly requested.

That would make this kind of visual-truth work much more reliable without pretending fixture data proves backend state.

# CRM-RM-037 Tenant Groups + Group Customer Identity (Prerequisite)

**Doc intent:** Planned design (not implemented yet). This is a prerequisite for CRM-RM-009.

**Scope:** Tenant groups in UAA, group-level canonical customer in Customer Service, Keycloak provider changes, auth/WP bridge impacts, Gateway backend, and role-based tenant switching.

**Related docs:**

- Roadmap: [crm-dashpark/00-roadmap.md](../../.github/plan/crm-dashpark/00-roadmap.md)
- Auth flow: [crm-dashpark/01-auth-flow.md](../../.github/plan/crm-dashpark/01-auth-flow.md)
- Customer Service auth: [crm-dashpark/02-customer-service-auth.md](../../.github/plan/crm-dashpark/02-customer-service-auth.md)
- WP bridge: [crm-dashpark/03-wp-bridge-plugin.md](../../.github/plan/crm-dashpark/03-wp-bridge-plugin.md)
- Booking ↔ Customer linking: [crm-dashpark/06-booking-linking.md](../../.github/plan/crm-dashpark/06-booking-linking.md)
- Loyalty design (depends on this): [2026-01-29-crm-rm-009-loyalty-design.md](2026-01-29-crm-rm-009-loyalty-design.md)
- Keycloak UAA provider: [sp-keycloak-uaa-provider/AGENTS.md](../../sp-keycloak-uaa-provider/AGENTS.md)

**Iteration checklist:**

- [ ] `tenant_group` table + `parking.group_id NOT NULL` in UAA.
- [ ] Every parking belongs to exactly one group (mandatory; singleton groups for ungrouped parkings).
- [ ] Keycloak provider emits `parking_id`, `parking_ids`, `tenant_group_id` claims.
- [ ] `ROLE_MANAGER_GROUPE` derived from `group_kind=HOLDING`.
- [ ] Customer Service: `customer.group_id`, `customer_tenant_profile`, `identity_link.group_id`.
- [ ] `ensureLinked` creates tenant profile eagerly.
- [ ] `TenantRegistry` resolves `tenantOrigin → (tenantId, groupId)`.
- [ ] `StatePayload` includes `groupId`; `BoundIdentity` includes `groupCustomerId` + `groupId`.
- [ ] `/auth/exchange/consume` returns `{ firebaseUid, email, returnUrl, groupCustomerId, groupId }`.
- [ ] WP bridge stores `group_customer_id` + `group_id` in user meta.
- [ ] Gateway extracts `parking_ids` + `tenant_group_id` from token (no frontend changes).
- [ ] CS schema uses `group_id` from the start (no data migration — pre-production).
- [ ] All existing CS endpoints updated for group-scoped customer model.
- [ ] `CustomerResource` (JHipster default `/api/customers` CRUD) deprecated and removed.
- [ ] Admin endpoints (`/api/admin/`) accessible to any Keycloak-authenticated user; roles drive business logic, not access.
- [ ] Consent remains tenant-scoped.
- [ ] GDPR erasure is group-wide.

---

## 1) Goals and non-goals

**Goals**

- Single shared customer identity across tenants in the same group (`groupCustomerId`).
- Every parking belongs to exactly one `tenant_group` (mandatory, `parking.group_id NOT NULL`).
- Group-level canonical customer ID used everywhere (clean foundation).
- Tenant-specific preferences/consent isolated per tenant via `customer_tenant_profile`.
- Keycloak claims carry `parking_id` (backward compat), `parking_ids` (role-derived), and `tenant_group_id`.
- Auth flow and WP bridge updated to carry group identity.
- GDPR erasure is group-wide (one person, one identity, one deletion).

**Non-goals**

- Cross-tenant SSO (sessions remain tenant-local).
- Group leave/split handling (follow-up: CRM-RM-041).
- New operator UI surfaces (tenant-switcher in Gateway deferred).
- `group_kind` does not carry business logic — purely informational/filtering.

---

## 2) UAA: tenant groups + group_kind

**Data model**

- New `tenant_group` table: `id` (auto-increment), `name`, `slug`, `group_kind` (enum: `HOLDING`, `CLIENT`), `created_at`, `active`.
- `parking.group_id` FK → `tenant_group.id`, **`NOT NULL`**. Every parking belongs to exactly one group.
- `group_kind` is purely informational — used for filtering/reporting and FF4J gating, not business logic branching.

**Migration**

- `parking_groupe` is deprecated and replaced by `tenant_group.group_kind`.
- Create a tenant group named **"Solution Parking - Groupe"** (`group_kind=HOLDING`).
- Assign all parkings with `parking_groupe=true` to this group.
- For every remaining parking (where `parking_groupe=false` or `NULL`): auto-create a singleton tenant group named "Parking {parking.name}" (`group_kind=CLIENT`). Assign the parking to it.
- After migration, `parking.group_id` is `NOT NULL` — no parking without a group.
- `parking_groupe` column retained temporarily for backward compat but is no longer the source of truth.

**FF4J migration**

- `ParkingGroupeFlippingStrategy` changes from checking `parking.parkingGroupe == true` to checking `parking.group_id → tenant_group.group_kind = 'HOLDING'`.
- No net behavior change — same parkings are gated.

**UAA bulk endpoint**

- New endpoint: returns `tenantOrigin → (tenantId, groupId)` in bulk.
- Consumed by Customer Service `TenantRegistry` (cached, same pattern as existing `BE_MINISITE_API_BASE_URL` resolution).
- UAA remains the sole source of truth for group membership. No `tenant_group` table in Customer Service.

---

## 3) Keycloak provider (sp-keycloak-uaa-provider)

**Parking entity**

- Add `group_id` Long field mapped to `parking.group_id` FK column (read-only, schema owned by UAA Liquibase).
- Add read-only `TenantGroup` entity (`id`, `group_kind`) mapped to `tenant_group` table, for resolving `group_kind` during role assignment.
- Register `TenantGroup` in `persistence.xml`.

**User → Parking relationship fix**

- Change `User.parking` from `@ManyToOne` to `@ManyToMany` (`Set<Parking> parkings`) via `parking_user` join table (matching UAA's actual schema).
- Add a `getPrimaryParking()` convenience method that returns a deterministic "primary" parking (lowest ID). Used for backward-compatible `parkingId` claim.
- All existing code that calls `entity.getParking()` migrates to `entity.getPrimaryParking()`.
- Fetch strategy: `EAGER` (or `LEFT JOIN FETCH` in named queries) to avoid `LazyInitializationException`.

**UserAdapter attribute changes**

- `parkingId` (existing): derived from `getPrimaryParking().getId()` — backward compatible, single value.
- `tenantGroupId` (new): derived from `getPrimaryParking().getGroupId()` — single value.
- `parkingIds` (new): multi-valued attribute. Derivation depends on role scope (see role classification below).
  - **Single-tenant** roles (`ROLE_USER`, `ROLE_MANAGER`, `ROLE_MANAGER_PLUS`, `ROLE_MANAGER_PLUS_E`, `ROLE_VALET`, `ROLE_MARKETING`): `parkingIds = [primaryParking.id]`.
  - **Multi-tenant** roles (`ROLE_DIRECTION`): all parkings in the user's group(s). Resolved by querying parkings with the same `group_id` as the primary parking.
  - **Global** roles (`ROLE_ADMIN`, `ROLE_INTERNAL`): `parkingIds` not emitted — these roles are not tenant-scoped and can access all parkings.
  - **Derived** roles (`ROLE_MANAGER_GROUPE`, `ROLE_PILOTE`): do not affect `parkingIds` derivation — they are additive markers.

**Role classification (reference)**

| Scope         | Roles                                                                                                   | `parkingIds` derivation                              | Notes                                                                                                                                                |
| ------------- | ------------------------------------------------------------------------------------------------------- | ---------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| Global        | `ROLE_ADMIN`, `ROLE_INTERNAL`                                                                           | Not emitted (all-access)                             | Bypass tenant checks entirely                                                                                                                        |
| Single-tenant | `ROLE_USER`, `ROLE_MANAGER`, `ROLE_MANAGER_PLUS`, `ROLE_MANAGER_PLUS_E`, `ROLE_VALET`, `ROLE_MARKETING` | `[primaryParking.id]`                                | Scoped to primary parking only                                                                                                                       |
| Multi-tenant  | `ROLE_DIRECTION`                                                                                        | All parkings sharing `group_id` with primary parking | Must send `X-Parking-Id` on tenant-scoped service requests                                                                                           |
| Derived       | `ROLE_MANAGER_GROUPE`                                                                                   | — (additive marker)                                  | Added when primary parking's `group_kind = HOLDING` (all users have at least `ROLE_USER`, so condition is effectively "any user in a HOLDING group") |
| Derived       | `ROLE_PILOTE`                                                                                           | — (additive marker)                                  | Added dynamically by FF4J at runtime (not by Keycloak provider)                                                                                      |

**ROLE_MANAGER_GROUPE derivation**

- Change from `parking.isParkingGroupe()` to checking `parking.groupId → tenantGroup.groupKind == 'HOLDING'`.
- Condition: user has `ROLE_MANAGER` or `ROLE_USER` AND primary parking belongs to a `HOLDING` group. Since all users have at least `ROLE_USER`, this effectively means any user whose primary parking is in a HOLDING group.
- Refactor: extract shared helper used by both `getRoleMappingsStream()` and `getRoleMappingsInternal()` to eliminate duplication.

**MobileAccessAuthenticator**

- Continues checking `mobileAppActive` on the primary parking. Multi-parking handling deferred (out of scope).

**Protocol mappers (Keycloak admin console)**

- Add "User Attribute" OIDC protocol mapper for `tenantGroupId → tenant_group_id` claim (single-valued).
- Add "User Attribute" OIDC protocol mapper for `parkingIds → parking_ids` claim with `Multivalued = true`.
- Update realm JSON export (`sp-realm.json` in Gateway) for dev environment.

---

## 4) Customer Service data model

**Group-level canonical customer**

- Column is `customer.group_id` (not a rename — schema built from scratch with `group_id`). No local FK constraint — UAA is source of truth for `tenant_group`, CS caches via `TenantRegistry`.
- `customer.id` becomes `groupCustomerId` — used everywhere as the canonical customer identifier.
- Unique constraint: `(group_id, primary_email)`.

**Tenant profile** (`customer_tenant_profile`)

- New table keyed by `(group_customer_id, tenant_id)`.
- Created eagerly at login (`ensureLinked`).
- Columns: `group_customer_id` (FK to customer), `tenant_id` (Long), `newsletter_opt_in`, `custom_attributes` (LOB), `internal_note` (LOB), `created_at`, `updated_at`.

**Field split**

| Field                                 | Stays on `customer` (group-level) | Moves to `customer_tenant_profile` |
| ------------------------------------- | --------------------------------- | ---------------------------------- |
| primary_email, pending_email          | Yes                               |                                    |
| given_name, family_name               | Yes                               |                                    |
| phone_number, alt_phone_number        | Yes                               |                                    |
| birth_date, gender                    | Yes                               |                                    |
| preferred_language, locale, timezone  | Yes                               |                                    |
| preferred_channel, contact_window\*\* | Yes                               |                                    |
| billing*\*, shipping*\*               | Yes                               |                                    |
| newsletter_opt_in                     |                                   | Yes                                |
| custom_attributes                     |                                   | Yes                                |
| internal_note                         |                                   | Yes                                |

**Identity links**

- Column is `identity_link.group_id` (not a rename — schema built from scratch with `group_id`).
- Unique constraint: `(group_id, provider, external_id)`.
- UID-only linking; no email-based auto-merge.

**Consent events**

- `consent_event.parking_id` stays as-is — it's already tenant-scoped (records which tenant the consent action belongs to).
- FK to `customer` (now group-scoped) — links a group customer to a specific tenant consent action.

**Vehicles**

- `customer_vehicle` has no `parking_id` today — implicitly group-scoped via FK to `customer`. No changes needed.

**Booking links**

- `CustomerBookingLink.customerId` naturally becomes a reference to `groupCustomerId`. No schema change.
- `CustomerBookingLink.parkingId` stays — records which tenant (parking) the booking belongs to. Note: `tenantId` and `parkingId` are synonymous — both identify a parking.

**`ensureLinked` changes** (existing method in `CustomerIdentityService`)

Current signature: `ensureLinked(parkingId, provider, externalId, email, given, family, idempotencyKey)`.

New signature: `ensureLinked(groupId, provider, externalId, email, given, family, tenantId, idempotencyKey)`.

- `parkingId` parameter renamed to `groupId` — scopes customer + identity link at the group level.
- `tenantId` parameter added — used to create `customer_tenant_profile` eagerly.
- Customer lookup: `findByGroupIdAndPrimaryEmail(groupId, email)` instead of `findByParkingIdAndPrimaryEmail`.
- IdentityLink: created with `groupId` instead of `parkingId`.
- After link: ensure `customer_tenant_profile(groupCustomerId, tenantId)` exists; create if missing.
- Idempotency key derivation: `deriveLinkIdem(groupId, provider, externalId)` (uses `groupId` instead of `parkingId`).
- Outbox ordering key: `"p:%d:c:%d".formatted(groupId, customerId)` — keyed by group, not tenant.
- `reconcileEmailChange` receives `groupId` context (was `parkingId`).

**Outbox events**

- Existing outbox events (`customer.created.v1`, `identity.linked.v1`) add `groupId` to their payload.
- Keep `parkingId` as `tenantId` in events that have a tenant context (e.g., identity link events).
- No new event version needed — pre-production, consumers are updated in lockstep.

---

## 5) Auth flow + state changes

**StatePayload**

- Add `groupId` (Long) to `StatePayload` record.
- New shape: `record(tenantOrigin, tenantId, groupId, returnUrl, iat, exp, nonce, purpose)`.
- `groupId` resolved from `TenantRegistry` during `/auth/state/init`.
- State HMAC covers `groupId` — tampering is prevented.

**TenantRegistry extension**

- `TenantRegistry` interface adds: returns a `TenantInfo(tenantId, groupId)` record (or equivalent).
- `SimpleTenantRegistry` extends the cached UAA data to include `groupId` per origin.
- `TenantOriginEntry` record: `(normalizedOrigin, parkingId)` → `(normalizedOrigin, parkingId, groupId)`.

**BoundIdentity (Redis code store)**

- Add `groupCustomerId` (Long) and `groupId` (Long).
- New shape: `record(tenantOrigin, returnUrl, uid, email, groupCustomerId, groupId)`.
- `groupCustomerId` resolved during `/auth/exchange/bootstrap` (after `ensureLinked` returns the customer DTO).
- Serialization: JSON in Redis. New fields are additive — old codes drain within 60s TTL before new code is deployed.

**Endpoint changes**

| Endpoint                          | Change                                                                                                                             |
| --------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| `POST /auth/state/init`           | Resolve `groupId` from `tenantOrigin`, include in signed state. No response shape change.                                          |
| `POST /auth/state/describe`       | No change — `groupId` not needed by Auth Portal for display.                                                                       |
| `POST /auth/exchange/bootstrap`   | `ensureLinked` receives `groupId` + `tenantId`. Stores `groupCustomerId` + `groupId` in `BoundIdentity`. No response shape change. |
| `POST /auth/exchange/consume`     | Response adds `groupCustomerId` and `groupId`: `{ firebaseUid, email, returnUrl, groupCustomerId, groupId }`.                      |
| `GET /api/customer/email-status`  | No API change. Internally resolves customer via group-scoped identity link using Firebase UID + `X-Parking-Id` for tenant context. |
| `POST /api/customer/email-change` | No API change. Internally resolves customer via group-scoped identity link.                                                        |

**ConsumeRes**

- New shape: `record(firebaseUid, email, returnUrl, groupCustomerId, groupId)`.

**Auth Portal**

- No code changes — Auth Portal doesn't read consume response (server-to-server from WP to CS).

---

## 6) WP bridge

**Consume response handling**

- WP bridge receives new fields from `/auth/exchange/consume`: `groupCustomerId` and `groupId`.
- Store in WP user meta: `group_customer_id` and `group_id` (alongside existing `firebase_uid`).
- Backward compatible: older plugin versions ignore unknown JSON fields.

**User creation/lookup**

- Unchanged — still uses `firebase_uid` as the primary identity key for WP user lookup.
- `group_customer_id` and `group_id` are metadata, not used for user matching.

**Profile sync**

- `class-profile-sync.php` continues to project shared fields (name, email, billing/shipping) from CS to WP user/Woo customer.
- No tenant-profile-specific sync in Phase 1.

**Plugin settings**

- No changes to plugin settings (`parking_id`, `bridge_secret`, `cs_base_url`, `auth_portal_url`). The plugin's `parking_id` is its own tenant identity — distinct from `group_id`.

**X-Parking-Id header**

- Already sent by `class-auth-client.php` on API calls. No change needed.

---

## 7) Gateway (backend)

**SecurityUtils**

- Currently extracts single `parking_id` from token → `currentAccount.parkingId`.
- Add extraction of `parking_ids` (list of Longs) and `tenant_group_id` (Long) from token claims.
- `currentAccount.parkingId` stays as the primary/active tenant (unchanged behavior).
- `currentAccount.parkingIds` and `currentAccount.tenantGroupId` available but not used in Phase 1.

**X-Parking-Id enforcement**

- For multi-tenant roles (only `ROLE_DIRECTION` for now), backend services enforce `X-Parking-Id` on tenant-scoped requests.
- Gateway does **not** add enforcement in Phase 1 — it always sends `parking_id` from the token (single value, existing behavior).
- Enforcement is on the **service side** (Customer Service, etc.) where multi-tenant roles call tenant-scoped endpoints.

**No frontend changes**

- No tenant-switcher UI (deferred).
- Gateway Angular app continues using `currentAccount.parkingId` for all operations.
- `sp-realm.json` (dev Keycloak config) updated with new protocol mappers for `parking_ids` and `tenant_group_id`.

---

## 8) API scoping

> **Terminology:** `tenantId` and `parkingId` are synonymous throughout the API — both identify a parking. The spec uses `tenantId` in group-aware contexts and `parkingId` in legacy/booking contexts, but the underlying value is always the parking ID.

This section covers **all** existing Customer Service endpoints and how they adapt to the group-scoped model.

### 8a) Auth exchange endpoints (public, rate-limited)

| Endpoint                        | Change                                                                                                                             |
| ------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| `POST /auth/state/init`         | Resolve `groupId` from `tenantOrigin` via `TenantRegistry`. Include in signed state. No response shape change.                     |
| `POST /auth/state/email-link`   | No change.                                                                                                                         |
| `POST /auth/state/describe`     | No change — `groupId` not needed by Auth Portal for display.                                                                       |
| `POST /auth/exchange/bootstrap` | `ensureLinked` receives `groupId` + `tenantId`. Stores `groupCustomerId` + `groupId` in `BoundIdentity`. No response shape change. |
| `POST /auth/exchange/consume`   | Response adds `groupCustomerId` and `groupId`: `{ firebaseUid, email, returnUrl, groupCustomerId, groupId }`.                      |

### 8b) Customer self-service endpoints (Firebase token + `X-Parking-Id`)

| Endpoint                            | Change                                                                                                                                              |
| ----------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| `GET /api/customer/profile`         | Internally resolves customer via group-scoped identity link (Firebase UID + group derived from `X-Parking-Id`). Returns group-level shared profile. |
| `PATCH /api/customer/profile`       | Same resolution. Updates group-level shared fields.                                                                                                 |
| `POST /api/customer/consent`        | Stays tenant-scoped — `X-Parking-Id` determines which tenant the consent event belongs to. FK to group customer.                                    |
| `GET /api/customer/email-status`    | No API change. Internally resolves customer via group-scoped identity link.                                                                         |
| `POST /api/customer/email-change`   | No API change. Internally resolves customer via group-scoped identity link.                                                                         |
| `POST /api/customer/privacy/export` | Group-wide export (one person, one identity).                                                                                                       |
| `POST /api/customer/privacy/delete` | Group-wide erasure (see GDPR below).                                                                                                                |

### 8c) Public bridge endpoints (`X-Bridge-Secret` + `X-Parking-Id`)

| Endpoint                                   | Change                                                                                                |
| ------------------------------------------ | ----------------------------------------------------------------------------------------------------- |
| `POST /api/public/identity/firebase/link`  | Calls `ensureLinked` with `groupId` (resolved from `X-Parking-Id` via `TenantRegistry`) + `tenantId`. |
| `POST /api/public/identity/wordpress/link` | Same — `groupId` + `tenantId`.                                                                        |
| `GET /api/public/identity/lookup`          | Resolves identity link by `groupId` (from `X-Parking-Id`) + provider + externalId.                    |
| `PATCH /api/public/customer/profile`       | Resolves customer via group-scoped identity link. Updates group-level shared fields.                  |
| `POST /api/public/customer/consent`        | Stays tenant-scoped — `X-Parking-Id` determines tenant. FK to group customer.                         |

### 8d) Admin endpoints (any Keycloak-authenticated user)

> **Design rule:** `/api/admin/` is the **exclusive and exhaustive** API surface for parking managers and ops interacting with Customer Service from the Gateway frontend (Keycloak users). All new operator-facing endpoints go here. Roles do not gate access to admin endpoints — any Keycloak-authenticated user can call them. Instead, **roles affect business logic** (e.g., which customers are visible, which operations are allowed, data scoping).

**Customer management:**

| Endpoint                                         | Change                                                                                        |
| ------------------------------------------------ | --------------------------------------------------------------------------------------------- |
| `GET /api/admin/customers?email=X`               | Scoped by caller's group (from token `tenant_group_id`). Returns group customers.             |
| `GET /api/admin/customers/{id}`                  | `{id}` is `groupCustomerId`. Validates caller has access to customer's group.                 |
| `GET /api/admin/customers/{id}/merge-candidates` | Candidates within same group.                                                                 |
| `GET /api/admin/customers/{id}/profile`          | Returns `AdminCustomerProfileDTO` — group-level shared profile + activity metrics.            |
| `PATCH /api/admin/customers/{id}/internal-note`  | Internal note moves to `customer_tenant_profile` — scoped by caller's `parkingId` from token. |

**Customer merge:**

| Endpoint                                       | Change                                                                                             |
| ---------------------------------------------- | -------------------------------------------------------------------------------------------------- |
| `POST /api/admin/customer-merges`              | Both customers must belong to same group. Merge produces/preserves `customer_tenant_profile` rows. |
| `POST /api/admin/customer-merges/{id}/unmerge` | Restores tenant profiles.                                                                          |
| `GET /api/admin/customer-merges/{id}`          | No change (returns merge history).                                                                 |
| `GET /api/admin/customer-merges?customerId=X`  | No change.                                                                                         |

**Booking links & backfill:**

| Endpoint                                                   | Change                                                                                   |
| ---------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| `POST /api/admin/booking-links/force-link`                 | `customerId` in request is `groupCustomerId`. `parkingId` stays (tenant-scoped booking). |
| `POST /api/admin/booking-links/backfill`                   | Stays tenant-scoped (`parkingId`). Matched customers are group-scoped.                   |
| `POST /api/admin/booking-links/backfill/{parkingId}/stop`  | No change.                                                                               |
| `GET /api/admin/booking-links/backfill/{parkingId}/status` | No change.                                                                               |

**Privacy (GDPR):**

| Endpoint                                      | Change                                                 |
| --------------------------------------------- | ------------------------------------------------------ |
| `POST /api/admin/privacy/export?customerId=X` | Group-wide export. `customerId` is `groupCustomerId`.  |
| `POST /api/admin/privacy/delete?customerId=X` | Group-wide erasure. `customerId` is `groupCustomerId`. |

**Tenant branding:**

| Endpoint                                             | Change                     |
| ---------------------------------------------------- | -------------------------- |
| `GET /api/admin/tenant-branding/{tenantId}`          | No change — tenant-scoped. |
| `POST /api/admin/tenant-branding/{tenantId}/publish` | No change.                 |
| `PUT /api/admin/tenant-branding/{tenantId}/version`  | No change.                 |

### 8e) New admin endpoints (group-aware)

All new operator-facing endpoints live under `/api/admin/` (see 8d design rule).

**Shared profile (group-level):**

- `GET /api/admin/customers/{id}/shared-profile` — group-level shared profile fields.
- `PUT /api/admin/customers/{id}/shared-profile` — update shared fields.
- `GET /api/admin/customers/{id}/vehicles` — customer vehicles.
- `GET /api/admin/customers/{id}/identities` — identity links.

**Tenant-specific (subresources):**

- `GET /api/admin/customers/{id}/tenants/{tenantId}/profile` — tenant profile.
- `PUT /api/admin/customers/{id}/tenants/{tenantId}/profile` — update tenant-specific fields.
- `GET /api/admin/customers/{id}/tenants/{tenantId}/consent` — consent events for this tenant.
- `POST /api/admin/customers/{id}/tenants/{tenantId}/consent` — record consent event.
- `GET /api/admin/customers/{id}/tenants` — list all tenant profiles for this customer.

**Booking links:**

- `GET /api/admin/customers/{id}/booking-links` — all linked bookings across tenants (each link carries `tenantId`/`parkingId`).

**GDPR:**

- `DELETE /api/admin/customers/{id}` — group-wide erasure (sets `erased_at`, anonymizes shared fields, cascades to all tenant profiles, identity links, consent events).

### 8f) Deprecated endpoints (to remove)

- **`CustomerResource` (`/api/customers`)** — default JHipster entity controller with generic CRUD (create, update, patch, list, get, delete). This is scaffolded boilerplate, not the real admin API. Deprecate and remove. All operator interactions go through `/api/admin/` endpoints.

### 8g) Authorization rules

- **Admin endpoints:** any Keycloak-authenticated user can call them. Roles do not gate access — they drive business logic (data scoping, allowed operations). Data is scoped by caller's token claims (`parking_id`, `parking_ids`, `tenant_group_id`). Cross-group access denied.
- **Shared profile endpoints (admin):** caller must have access to the customer's group (validated via token `tenant_group_id` or `parking_ids`).
- **Tenant-specific endpoints (admin):** caller must have access to the specific `tenantId` (validated via `parking_ids` claim).
- **Self-service endpoints:** customer identity resolved via Firebase UID + group (from `X-Parking-Id` → `TenantRegistry`). Customer can only access their own data.
- **Bridge endpoints:** `X-Bridge-Secret` authenticates the WP tenant. `X-Parking-Id` provides tenant context. Group resolved via `TenantRegistry`.

---

## 9) Migration rules

**Context**

- **UAA has production data** — parkings exist and need `tenant_group` + `parking.group_id` backfill via Liquibase migration.
- **Customer Service has no production data** — schema is built from scratch with `group_id`. No data migration needed.
- Customer dedup/merge at group boundary is a runtime concern handled by CRM-RM-041 (group membership changes) and the existing merge workflow (CRM-RM-007). Not a migration concern.

**UAA migration (tenant_group + parking.group_id)**

1. Create `tenant_group` table.
2. Insert **"Solution Parking - Groupe"** (`group_kind=HOLDING`, `active=true`).
3. For each parking with `parking_groupe=true`: set `parking.group_id` → the holding group's ID.
4. For each remaining parking: auto-create a singleton tenant group named "Parking {parking.name}" (`group_kind=CLIENT`, `active=true`), set `parking.group_id` → its ID.
5. Add `NOT NULL` constraint on `parking.group_id`.
6. `parking_groupe` column retained but deprecated (no code reads it after migration; removal in follow-up).

**Customer Service schema (no migration — greenfield)**

- CS Liquibase changelogs define `customer.group_id`, `identity_link.group_id`, and `customer_tenant_profile` from the start.
- No column renames, no data backfill, no dedup — there are no existing customers.
- Unique constraints are created directly: `(group_id, primary_email)` on `customer`, `(group_id, provider, external_id)` on `identity_link`.
- Repository methods, mappers, and DTOs use `groupId` from the start (not renamed from `parkingId`).

**Future group membership changes (deferred to CRM-RM-041)**

- Customer dedup at group boundary (when a parking joins a group with existing customers sharing the same email) is handled by CRM-RM-041.
- Merge safeguards (CRM-RM-007) apply at runtime: no merge chains, no erased customers merged, audited moves, UID-only linking.

**Booking backfill**

- `BookingBackfillService.startRun(parkingId)` remains tenant-scoped (backfill is per-parking data). `parkingId` and `tenantId` are synonymous.
- Matched customers are group-scoped — the backfill service resolves `groupId` from `parkingId` via `TenantRegistry` for customer lookup/creation.

---

## 10) Invariants

1. **`groupCustomerId` is canonical** — the single customer identifier across all services and APIs.
2. **Every parking belongs to exactly one `tenant_group`** — `parking.group_id` is `NOT NULL`.
3. **`group_kind` is informational** — no business logic branches on it, only FF4J gating and filtering.
4. **Tenant-specific data remains tenant-scoped** — consent events, newsletter, custom attributes, internal notes are per `(groupCustomerId, tenantId)`.
5. **No email-based auto-merge across tenants** — UID-only linking.
6. **Multi-tenant roles must provide `X-Parking-Id`** on tenant-scoped service requests (enforcement on service side, not Gateway in Phase 1). Currently only `ROLE_DIRECTION` is multi-tenant.
7. **`parking_groupe` is deprecated** — `tenant_group.group_kind` is the source of truth. No new code reads `parking_groupe`.
8. **UAA is sole source of truth for groups** — Customer Service caches `(tenantId, groupId)` but does not store `tenant_group` locally.
9. **GDPR erasure is group-wide** — one person, one identity, one deletion; tenant-scoped opt-out is handled by consent.
10. **Backward-compatible Keycloak claims** — `parking_id` (single, primary) is always emitted alongside new `parking_ids` and `tenant_group_id`.
11. **`ROLE_MANAGER_GROUPE` derived from `group_kind=HOLDING`** — never persisted, dynamically injected by Keycloak provider.
12. **Merge safeguards (CRM-RM-007)** — no merge chains, no erased customers merged, audited moves. Dedup at group boundary deferred to CRM-RM-041.
13. **`tenantId` = `parkingId`** — synonymous throughout the system. Both identify a parking. The spec uses `tenantId` in group-aware contexts.
14. **`/api/admin/` is the exclusive operator surface** — all Gateway-facing (Keycloak user) endpoints live under `/api/admin/`. No role-based access gating on admin endpoints; roles drive business logic (scoping, allowed operations). JHipster default entity controllers (e.g., `CustomerResource`) are removed.
15. **Every user has at least `ROLE_USER`** — this is the baseline role for all Keycloak users.

---

## 11) Decisions log

Decisions made during design brainstorming (2026-02-24):

| #   | Topic                            | Decision                                                                                                                                              |
| --- | -------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| Q1  | Mandatory groups                 | Every parking belongs to a `tenant_group` (`NOT NULL`). Singleton groups for ungrouped parkings.                                                      |
| Q2  | Group data in CS                 | UAA-only source of truth. CS caches `(tenantId, groupId)` via extended `TenantRegistry`.                                                              |
| Q3  | Customer dedup at group boundary | Deferred to CRM-RM-041 (group membership changes). Runtime merge (CRM-RM-007) handles operator-initiated dedup.                                       |
| Q4  | `group_kind` behavior            | Purely informational, no business logic branching.                                                                                                    |
| Q5  | Keycloak claims                  | Hybrid: keep `parking_id`, derive `parking_ids` from role+group, resolve `tenant_group_id` from primary parking.                                      |
| Q6  | `ROLE_MANAGER_GROUPE`            | Keep, derive from `tenant_group.group_kind = 'HOLDING'`.                                                                                              |
| Q7  | `group_kind` values              | `HOLDING` (Solution Parking - Groupe) + `CLIENT` (external SaaS customers).                                                                           |
| Q8  | Tenant profile creation          | Eager at login (`ensureLinked`).                                                                                                                      |
| Q9  | Booking linkage                  | No Booking service changes. `CustomerBookingLink.customerId` naturally becomes `groupCustomerId`.                                                     |
| Q10 | Gateway multi-tenant UX          | Deferred — backend emits claims, Gateway keeps single `parking_id` for now.                                                                           |
| Q11 | GDPR delete                      | Group-wide erasure.                                                                                                                                   |
| Q12 | Consume response                 | Returns `{ firebaseUid, email, returnUrl, groupCustomerId, groupId }`.                                                                                |
| Q13 | Outbox events                    | Add `groupId` to existing payloads, keep `parkingId` as `tenantId`. No new event version.                                                             |
| Q14 | Booking backfill                 | Stays tenant-scoped (`parkingId`); matched customer is group-scoped. `parkingId` = `tenantId`.                                                        |
| Q15 | email-status/email-change        | No API change; internally resolve customer via group-scoped identity link.                                                                            |
| Q16 | CS has no prod data              | Schema built from scratch with `group_id` — no data migration, no column renames.                                                                     |
| Q17 | `tenantId` vs `parkingId`        | Synonymous — both identify a parking. Spec uses `tenantId` in group-aware contexts.                                                                   |
| Q18 | Dedup/merge in migration         | Not needed — no existing customers. Dedup at group boundary is CRM-RM-041. Runtime merge is CRM-RM-007.                                               |
| Q19 | Admin endpoint access            | Any Keycloak-authenticated user can call `/api/admin/` endpoints. Roles affect business logic (data scoping, allowed operations), not access control. |
| Q20 | `CustomerResource` (JHipster)    | Deprecated and removed. `/api/admin/` is the exclusive operator-facing API surface. No new endpoints outside `/api/admin/` for Gateway use.           |
| Q21 | `ROLE_USER` baseline             | All users have at least `ROLE_USER`. `ROLE_MANAGER_GROUPE` derivation condition is effectively "any user in a HOLDING group".                         |

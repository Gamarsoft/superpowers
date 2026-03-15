# CRM-RM-037 Tenant Groups + Group Customer Identity Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build tenant-group source of truth in UAA and propagate a group-scoped canonical customer identity through Keycloak, Customer Service, Gateway, and the WordPress bridge without changing the Auth Portal UX.

**Architecture:** UAA becomes the only source of truth for parking-to-group membership and exposes that mapping to dependent services. Customer Service moves its customer and identity model from tenant-scoped keys to group-scoped keys while preserving tenant-scoped consent and profile subresources. Keycloak emits additive claims (`parking_ids`, `tenant_group_id`) on top of the existing `parking_id`, Gateway consumes them additively, and the WP bridge persists new metadata while keeping Firebase UID as its login key.

**Tech Stack:** Java 21 + Spring Boot 3.4.5 + JHipster + Liquibase (UAA, Customer, Gateway), Keycloak SPI 22.0.0, Java 17 shaded provider module, PHP 8.2 WordPress bridge, Redis-backed auth code store, Angular 7 Gateway, Firebase Web SDK 12.1.0 (no portal code changes in this item).

**Context7 Findings (required if any external libs/APIs are involved):**

- Keycloak 22 user-storage providers surface custom claims through `UserModel` attribute methods; multivalued claims are supported when the provider returns list/stream values and the realm `User Attribute` mapper is configured with `multivalued=true`.
- Keycloak `UserAttributeMapper` is sufficient for `parking_ids` and `tenant_group_id`; this plan does not require a custom protocol mapper implementation.
- Spring Boot 3.4 recommends controller-slice tests with `@WebMvcTest` and repository tests with `@DataJpaTest`; use those patterns where existing repo conventions permit, and keep broader integration coverage in the existing `*IT` suites.
- Java records remain the right contract style for additive REST payload changes in Customer Service (`StatePayload`, `BoundIdentity`, `ConsumeRes`, DTO records for UAA bulk lookup).

---

## Plan Context

**Invariants**

- `groupCustomerId` is the canonical customer identifier across services, APIs, outbox events, and bridge payloads.
- Every parking belongs to exactly one `tenant_group`; `parking.group_id` must end the rollout as `NOT NULL`.
- UAA is the sole source of truth for group membership; Customer Service may cache `(tenantId, groupId)` in `TenantRegistry` but must not introduce a local `tenant_group` table.
- Tenant-specific data stays tenant-scoped: consent events, `newsletterOptIn`, `customAttributes`, and `internalNote` live per `(groupCustomerId, tenantId)`.
- No email-based auto-merge across tenants; linking remains UID/provider based and dedup at group-boundary stays deferred to CRM-RM-041.
- GDPR erasure is group-wide, while tenant-scoped consent remains tenant-scoped.
- `/api/admin/` is the exclusive operator-facing Customer Service surface; `CustomerResource` is removed rather than kept in parallel.

**Non-goals**

- Cross-tenant SSO or tenant-switching UX in Gateway.
- Group leave/split handling or other post-migration group-membership reshaping.
- Auth Portal code changes.
- Booking Service schema or API changes.

**Terminology**

- `tenantId` and `parkingId` are synonymous throughout this plan; both identify a parking. The spec uses `tenantId` for group-aware flows and `parkingId` for legacy or booking-oriented flows.
- `tenant_group` is the UAA-owned grouping construct; `group_kind` values are `HOLDING` and `CLIENT`.
- `groupId` is the application/runtime field name that corresponds to the persisted `group_id` column.
- `tenantGroupId` is the code-level claim/property name that corresponds to the token claim `tenant_group_id`.
- `parkingIds` is the code-level collection name that corresponds to the token claim `parking_ids`.
- `groupCustomerId` is the semantic name for `customer.id` once Customer Service becomes group-scoped.

**Reference data**

- Role classification from the spec:
  - Global roles: `ROLE_ADMIN`, `ROLE_INTERNAL` do not emit `parking_ids`.
  - Single-tenant roles: `ROLE_USER`, `ROLE_MANAGER`, `ROLE_MANAGER_PLUS`, `ROLE_MANAGER_PLUS_E`, `ROLE_VALET`, `ROLE_MARKETING` emit only the primary parking.
  - Multi-tenant role: `ROLE_DIRECTION` emits all parking IDs in the primary parking's group.
  - Derived roles: `ROLE_MANAGER_GROUPE`, `ROLE_PILOTE` are additive and do not change `parking_ids` derivation.
- Field split from the spec:
  - Group-level `customer` fields: identity and shared profile data such as email, names, phone numbers, birth date, locale/preferences, billing, and shipping.
  - Tenant-level `customer_tenant_profile` fields: `newsletterOptIn`, `customAttributes`, `internalNote`.

**Backward compatibility**

- `parking_id` remains emitted and remains the primary/active parking even after `parking_ids` and `tenant_group_id` are added.
- Existing outbox event names and versions stay unchanged; payloads only gain additive `groupId` data and retain tenant context where already present.
- Auth Portal request/response behavior stays unchanged for this item.
- Older WP bridge consumers must continue to tolerate additive fields from `/auth/exchange/consume`.
- `parking_groupe` remains readable during rollout but stops being the source of truth once `tenant_group.group_kind` is available.

## Planned File Structure

- `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/domain/TenantGroup.java` - UAA-owned tenant-group aggregate.
- `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/domain/Parking.java` - add `groupId` ownership on every parking while retaining deprecated `parkingGroupe`.
- `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/repository/TenantGroupRepository.java` - UAA lookup for group migration and registry responses.
- `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/web/rest/TenantRegistryResource.java` - bulk `tenantOrigin -> (tenantId, groupId)` endpoint for Customer Service.
- `uaa/src/main/resources/config/liquibase/changelog/20260312100000_add_tenant_group_schema.xml` - production data migration and `parking.group_id NOT NULL`.
- `sp-keycloak-uaa-provider/src/main/java/fr/gamarsoft/solutionpark/uaa/keycloakuaaprovider/domain/TenantGroup.java` - read-only Keycloak-side mapping to UAA group table.
- `sp-keycloak-uaa-provider/src/main/java/fr/gamarsoft/solutionpark/uaa/keycloakuaaprovider/domain/User.java` - switch parking association to `Set<Parking>` and expose deterministic primary parking.
- `sp-keycloak-uaa-provider/src/main/java/fr/gamarsoft/solutionpark/uaa/keycloakuaaprovider/UserAdapter.java` - emit `parkingId`, `parkingIds`, `tenantGroupId` and derive `ROLE_MANAGER_GROUPE`.
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/domain/CustomerTenantProfile.java` - tenant-scoped profile data keyed by `(groupCustomerId, tenantId)`.
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/domain/Customer.java` and `customer/src/main/java/fr/gamarsoft/solutionpark/customer/domain/IdentityLink.java` - move to `groupId` ownership.
- `customer/src/main/resources/config/liquibase/changelog/20250826152824_added_entity_Customer.xml` - rewrite the historical bootstrap changeset so greenfield replay creates `customer.group_id` from the start.
- `customer/src/main/resources/config/liquibase/changelog/20250826152825_added_entity_IdentityLink.xml` - rewrite the historical bootstrap changeset so greenfield replay creates `identity_link.group_id` from the start.
- `customer/src/main/resources/config/liquibase/changelog/20250827104800_added_constraints.xml` - rewrite historical uniqueness and index definitions for group-scoped root identity.
- `customer/src/main/resources/config/liquibase/changelog/20260312110000_add_customer_tenant_profile.xml` - additive changeset that creates `customer_tenant_profile` for the group-scoped model (no rename/backfill semantics).
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/tenant/TenantRegistry.java` and `customer/src/main/java/fr/gamarsoft/solutionpark/customer/tenant/SimpleTenantRegistry.java` - cache `tenantId + groupId` from UAA.
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/security/StatePayload.java`, `customer/src/main/java/fr/gamarsoft/solutionpark/customer/code/BoundIdentity.java`, `customer/src/main/java/fr/gamarsoft/solutionpark/customer/code/RedisCodeStore.java` - additive auth-flow contracts carrying `groupId` and `groupCustomerId`.
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/CustomerIdentityService.java` and related controllers/services - group-aware identity resolution, eager tenant profile creation, and group-wide GDPR behavior.
- `gateway/src/main/java/fr/gamarsoft/solutionpark/gateway/security/SecurityUtils.java` and `gateway/src/main/java/fr/gamarsoft/solutionpark/gateway/web/rest/AccountResource.java` - additive claim extraction/exposure.
- `gateway/src/main/docker/realm-config/sp-realm.json` - dev realm protocol mapper export for `parking_ids` and `tenant_group_id`.
- `solution-park-firebase-bridge/inc/class-auth-client.php` plus receiver/login classes - persist `group_customer_id` and `group_id` user meta after consume.

## Design Coverage Map

- Spec sections `2`, `9`, and invariants `2`, `3`, `7`, `8` map to Task 1.
- Spec section `3` and invariant `11` map to Task 2.
- Spec section `4` and migration rules for Customer Service in section `9` map to Task 3.
- Spec section `5` (`TenantRegistry` extension + signed state) maps to Task 4.
- Spec section `4` (`ensureLinked`, outbox, tenant profile), section `5` (`BoundIdentity`, bootstrap, consume), section `8a`, section `8b`, and section `8c` map to Task 5.
- Spec section `8b` profile/consent/email flows and section `8c` map to Task 6.
- Spec section `8d`, section `8e` shared/tenant subresources, section `8g`, and invariant `14` map to Task 7.
- Spec section `8b` GDPR routes, section `8d` booking/merge/privacy rules, section `8e` booking-links + delete semantics, section `8f`, and invariants `4`, `6`, `9`, `12`, `13` map to Task 8.
- Spec section `7` and the Gateway runtime part of section `3` map to Task 9.
- Spec section `6` and the bridge-facing consume-response part of section `5` map to Task 10.
- Spec statement "Auth Portal: no code changes" is intentionally satisfied by Tasks 4, 5, and 10 keeping portal-facing/bootstrap behavior additive; there is no portal implementation task in this plan.

## Chunk 1: Cross-Repo Execution Plan

This chunk is the full execution plan for CRM-RM-037; Tasks 1 through 10 are all part of Chunk 1.

### Task 1: UAA tenant-group schema, migration, FF4J source of truth, and bulk registry endpoint

**Files:**

- Create: `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/domain/TenantGroup.java`
- Create: `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/repository/TenantGroupRepository.java`
- Create: `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/service/dto/TenantRegistryEntryDTO.java`
- Create: `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/web/rest/TenantRegistryResource.java`
- Modify: `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/domain/Parking.java`
- Modify: `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/service/dto/ParkingDTO.java`
- Modify: `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/config/ff4j/FF4jFeaturesInitializer.java`
- Modify: `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/web/rest/FeatureFlagsResource.java`
- Modify: `model/src/main/java/fr/gamarsoft/solutionpark/model/ff4j/ParkingGroupeFlippingStrategy.java`
- Modify: `uaa/src/main/resources/config/liquibase/master.xml`
- Create: `uaa/src/main/resources/config/liquibase/changelog/20260312100000_add_tenant_group_schema.xml`
- Test: `uaa/src/test/java/fr/gamarsoft/solutionpark/uaa/web/rest/TenantRegistryResourceIT.java`
- Test: `uaa/src/test/java/fr/gamarsoft/solutionpark/uaa/web/rest/ParkingResourceIT.java`
- Test: `uaa/src/test/java/fr/gamarsoft/solutionpark/uaa/web/rest/FeatureFlagsResourceIT.java`

**Interfaces and contracts:**

- `GET /api/tenant-registry/origins` returns a collection of `TenantRegistryEntryDTO(normalizedOrigin, tenantId, groupId)`.
- New persisted names must match the spec verbatim: `tenant_group`, `group_kind`, and `group_id`; existing Java names remain `TenantGroup`, `groupKind`, and `groupId`.
- `Parking` and `ParkingDTO` expose `groupId` while retaining deprecated `parkingGroupe` for backward-compatible reads during rollout.
- FF4J parking-group gating must resolve `group_kind = HOLDING` from `parking.group_id`, not `parking_groupe`.
- `ParkingGroupeFlippingStrategy` is an explicit implementation anchor for this task: `model/src/main/java/fr/gamarsoft/solutionpark/model/ff4j/ParkingGroupeFlippingStrategy.java` must move from `parkingGroupe` boolean gating to `group_kind = HOLDING` gating semantics.

**Acceptance criteria:**

- Liquibase creates `tenant_group`, backfills every existing parking into exactly one group, and enforces `parking.group_id NOT NULL`.
- The migration creates the holding group with the exact seed name `Solution Parking - Groupe` (`group_kind=HOLDING`) for legacy `parking_groupe=true` parkings.
- The migration creates singleton client groups with the exact seed naming pattern `Parking {parking.name}` (`group_kind=CLIENT`) for all remaining parkings.
- The new bulk registry endpoint returns `tenantOrigin -> (tenantId, groupId)` for Customer Service consumers and rejects unauthenticated access consistently with existing UAA admin APIs.
- FF4J behavior for existing "parking group" features remains unchanged after the source-of-truth swap.
- UAA FF4J execution no longer relies on legacy boolean-only strategy semantics for parking-group decisions; the strategy/file-level change is required, not optional.

**Error handling:**

- Invalid or blank minisite origins must be skipped from the bulk response rather than breaking the whole endpoint.
- Migration must be idempotent within Liquibase execution and fail fast if `group_id` cannot be populated for any parking before the `NOT NULL` constraint.

**Verification:**

- Run: `cd uaa && ./mvnw -q -ntp -Dspotless.apply.skip=true -Djacoco.skip=true -Dspring-boot.build-info.skip=true -Dit.test=TenantRegistryResourceIT,ParkingResourceIT,FeatureFlagsResourceIT verify`
- Expected: targeted UAA API, migration, and FF4J regression coverage passes with tenant groups populated and feature-flag behavior preserved.

**Codebase pointers:**

- `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/domain/Parking.java`
- `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/web/rest/ParkingResource.java`
- `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/web/rest/ParkingSettingsResource.java`
- `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/web/rest/FeatureFlagsResource.java`
- `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/service/dto/ParkingDTO.java`
- `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/config/SecurityConfiguration.java`
- `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/config/ff4j/FF4jFeaturesInitializer.java`
- `model/src/main/java/fr/gamarsoft/solutionpark/model/ff4j/ParkingGroupeFlippingStrategy.java`
- `uaa/src/main/resources/config/liquibase/master.xml`
- `uaa/src/main/resources/config/liquibase/changelog/20211024212700_added_columns_Parking.xml`

- [ ] Step 1: Read codebase pointers and understand existing patterns
- [ ] Step 2: Write failing tests from acceptance criteria
- [ ] Step 3: Run tests to verify they fail
- [ ] Step 4: Write minimal implementation to pass tests
- [ ] Step 5: Run tests, self-review, commit

### Task 2: Keycloak provider group claims, multi-parking support, and `ROLE_MANAGER_GROUPE` derivation

**Files:**

- Create: `sp-keycloak-uaa-provider/src/main/java/fr/gamarsoft/solutionpark/uaa/keycloakuaaprovider/domain/TenantGroup.java`
- Create: `sp-keycloak-uaa-provider/src/test/java/fr/gamarsoft/solutionpark/uaa/keycloakuaaprovider/UserAdapterTest.java`
- Create: `sp-keycloak-uaa-provider/src/test/java/fr/gamarsoft/solutionpark/uaa/keycloakuaaprovider/authenticator/MobileAccessAuthenticatorTest.java`
- Create: `sp-keycloak-uaa-provider/src/test/java/fr/gamarsoft/solutionpark/uaa/keycloakuaaprovider/UaaUserStorageProviderPersistenceIT.java`
- Modify: `sp-keycloak-uaa-provider/src/main/java/fr/gamarsoft/solutionpark/uaa/keycloakuaaprovider/domain/Parking.java`
- Modify: `sp-keycloak-uaa-provider/src/main/java/fr/gamarsoft/solutionpark/uaa/keycloakuaaprovider/domain/User.java`
- Modify: `sp-keycloak-uaa-provider/src/main/java/fr/gamarsoft/solutionpark/uaa/keycloakuaaprovider/UaaUserStorageProvider.java`
- Modify: `sp-keycloak-uaa-provider/src/main/java/fr/gamarsoft/solutionpark/uaa/keycloakuaaprovider/UserAdapter.java`
- Modify: `sp-keycloak-uaa-provider/src/main/java/fr/gamarsoft/solutionpark/uaa/keycloakuaaprovider/authenticator/MobileAccessAuthenticator.java`
- Modify: `sp-keycloak-uaa-provider/src/main/resources/META-INF/persistence.xml`
- Modify: `gateway/src/main/docker/realm-config/sp-realm.json`

**Interfaces and contracts:**

- `User#getPrimaryParking(): Parking` returns the deterministic lowest-ID parking from the `parking_user` join table.
- `UserAdapter` emits code-level attributes `parkingId`, `parkingIds`, and `tenantGroupId`; the realm export must map them to claims `parking_id`, `parking_ids`, and `tenant_group_id`, with `parkingIds` multivalued and role-sensitive.
- Realm export includes `User Attribute` protocol mappers for `tenantGroupId -> tenant_group_id` and `parkingIds -> parking_ids` with multivalued output enabled.

**Acceptance criteria:**

- Keycloak users mapped to multiple parkings resolve a stable primary parking without breaking the legacy `parking_id` claim.
- `ROLE_DIRECTION` users emit all parking IDs in the primary parking's group; global roles omit `parking_ids`; single-tenant roles emit only the primary parking ID.
- `ROLE_MANAGER_GROUPE` is derived from `group_kind=HOLDING`, not `parking_groupe`, and mobile access checks still use only the primary parking's `mobileAppActive`.
- The provider persistence unit loads `TenantGroup` and avoids lazy-loading failures during claim or role derivation.

**Error handling:**

- Missing realm role definitions or incomplete parking/group data must degrade with explicit logs and no duplicate role emission.
- Users with no parking association must yield empty tenant-scoped attributes instead of throwing in token generation.

**Verification:**

- Run: `cd sp-keycloak-uaa-provider && ./mvnw -q -Dtest=UserAdapterTest,MobileAccessAuthenticatorTest test`
- Run: `cd sp-keycloak-uaa-provider && ./mvnw -q -Dit.test=UaaUserStorageProviderPersistenceIT verify`
- Run: `rg -n '"claim.name": "(parking_ids|tenant_group_id)"|"multivalued": "true"' gateway/src/main/docker/realm-config/sp-realm.json`
- Expected: provider tests pass for attribute emission, role derivation, primary-parking mobile gating, and persistence-unit registration/fetch behavior; the realm export contains both mapper claims and a multivalued `parking_ids` mapper.

**Codebase pointers:**

- `sp-keycloak-uaa-provider/src/main/java/fr/gamarsoft/solutionpark/uaa/keycloakuaaprovider/domain/User.java`
- `sp-keycloak-uaa-provider/src/main/java/fr/gamarsoft/solutionpark/uaa/keycloakuaaprovider/domain/Parking.java`
- `sp-keycloak-uaa-provider/src/main/java/fr/gamarsoft/solutionpark/uaa/keycloakuaaprovider/UaaUserStorageProvider.java`
- `sp-keycloak-uaa-provider/src/main/java/fr/gamarsoft/solutionpark/uaa/keycloakuaaprovider/UserAdapter.java`
- `sp-keycloak-uaa-provider/src/main/java/fr/gamarsoft/solutionpark/uaa/keycloakuaaprovider/authenticator/MobileAccessAuthenticator.java`
- `sp-keycloak-uaa-provider/src/main/resources/META-INF/persistence.xml`
- `gateway/src/main/docker/realm-config/sp-realm.json`

- [ ] Step 1: Read codebase pointers and understand existing patterns
- [ ] Step 2: Write failing tests from acceptance criteria
- [ ] Step 3: Run tests to verify they fail
- [ ] Step 4: Write minimal implementation to pass tests
- [ ] Step 5: Run tests, self-review, commit

### Task 3: Customer Service group-scoped schema and repositories

**Files:**

- Create: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/domain/CustomerTenantProfile.java`
- Create: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/repository/CustomerTenantProfileRepository.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/domain/Customer.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/domain/IdentityLink.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/repository/CustomerRepository.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/repository/IdentityLinkRepository.java`
- Modify: `customer/src/main/resources/config/liquibase/changelog/20250826152824_added_entity_Customer.xml`
- Modify: `customer/src/main/resources/config/liquibase/changelog/20250826152825_added_entity_IdentityLink.xml`
- Modify: `customer/src/main/resources/config/liquibase/changelog/20250827104800_added_constraints.xml`
- Create: `customer/src/main/resources/config/liquibase/changelog/20260312110000_add_customer_tenant_profile.xml`
- Modify: `customer/src/main/resources/config/liquibase/changelog/20260119120000_add_customer_email_change.xml`
- Modify: `customer/src/main/resources/config/liquibase/changelog/20260114090000_add_customer_merge_schema.xml`
- Modify: `customer/src/main/resources/config/liquibase/changelog/20260123090000_add_customer_activity_metrics.xml`
- Verify-no-change: `customer/src/main/resources/config/liquibase/changelog/20260113160000_add_consent_privacy.xml`
- Verify-no-change: `customer/src/main/resources/config/liquibase/changelog/20260115143000_add_booking_linking_tables.xml`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/repository/CustomerRepositoryTest.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/repository/IdentityLinkRepositoryTest.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/repository/CustomerTenantProfileRepositoryTest.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/repository/CustomerLiquibaseBootstrapIT.java`

**Interfaces and contracts:**

- `Customer` stores `groupId` as the canonical scope key; `Customer.id` is the `groupCustomerId` used everywhere else.
- New Customer Service schema names must stay verbatim from the spec: `customer.group_id`, `identity_link.group_id`, and `customer_tenant_profile`; existing code-level field names remain `groupId` and `groupCustomerId`.
- Historical bootstrap changesets must define group-scoped root identity directly; do not introduce a late `20260312110000_group_customer_schema.xml` rename/backfill sequence for `customer` or `identity_link`.
- `customer_tenant_profile` must be created by a dedicated additive changeset (`20260312110000_add_customer_tenant_profile.xml`); this changeset is allowed to be late in history because it introduces a new table rather than converting root identity.
- Later historical changelog policy for greenfield replay:
  - Rewrite to group scope: `20260119120000_add_customer_email_change.xml`, `20260114090000_add_customer_merge_schema.xml`, and `20260123090000_add_customer_activity_metrics.xml` where parking-scoped root identity assumptions exist.
  - Keep intentionally tenant-scoped: `20260113160000_add_consent_privacy.xml` and `20260115143000_add_booking_linking_tables.xml` keep `parking_id` as tenant context while `customer_id` points to canonical `groupCustomerId`.
- `IdentityLink` stores `groupId`, `provider`, `externalId`, and references the canonical `Customer`.
- `CustomerTenantProfile` is keyed by `(groupCustomerId, tenantId)` and owns `newsletterOptIn`, `customAttributes`, and `internalNote`.

**Acceptance criteria:**

- `master.xml` replay on an empty Customer Service database creates `customer.group_id`, `identity_link.group_id`, and `customer_tenant_profile` directly, without first creating parking-scoped root identity and then converting it.
- Historical bootstrap changesets `20250826152824_added_entity_Customer.xml`, `20250826152825_added_entity_IdentityLink.xml`, and `20250827104800_added_constraints.xml` define the greenfield-correct group-scoped root identity model from the start.
- Later historical changelogs are explicitly handled per policy:
  - rewritten: `20260119120000_add_customer_email_change.xml`, `20260114090000_add_customer_merge_schema.xml`, `20260123090000_add_customer_activity_metrics.xml`
  - intentionally tenant-scoped and unchanged: `20260113160000_add_consent_privacy.xml`, `20260115143000_add_booking_linking_tables.xml`
- Unique constraints are `(group_id, primary_email)` on `customer` and `(group_id, provider, external_id)` on `identity_link`.
- Tenant-scoped fields are removed from `customer` and persisted through `customer_tenant_profile` without introducing a local `tenant_group` table.
- Later Liquibase changelogs that add columns or foreign-keyed tables on top of `customer` continue to replay cleanly after the historical bootstrap rewrite.
- Operating rule for already-initialized non-production databases: do not use `validCheckSum` bypasses for the rewritten historical changesets; reset the local schema (or local database) before validation so Liquibase replays the new history cleanly.
- Repository methods support `findByGroupId...` lookups required by the service-layer tasks.

**Error handling:**

- Repository and schema constraints must reject duplicate email or identity links within the same group while permitting the same values in different groups.
- Any checksum or replay failure introduced by rewriting the historical bootstrap changelogs must fail fast in tests rather than being masked by a follow-up rename/backfill migration.
- For local developer environments that already executed old checksums, validation must fail closed unless the schema is reset and replayed; this task does not permit checksum suppression (`validCheckSum`) as a migration shortcut.
- N/A — this task is persistence-focused and the only fallible behavior is database constraint enforcement covered by tests.

**Verification:**

- Run: `cd customer && ./mvnw -q -ntp -Dspotless.apply.skip=true -Djacoco.skip=true -Dspring-boot.build-info.skip=true -Dtest=CustomerRepositoryTest,IdentityLinkRepositoryTest,CustomerTenantProfileRepositoryTest test`
- Run: `cd customer && ./mvnw -q -ntp -Dspotless.apply.skip=true -Djacoco.skip=true -Dspring-boot.build-info.skip=true -Dit.test=CustomerLiquibaseBootstrapIT verify`
- Expected: repository tests pass with group-scoped uniqueness and tenant-profile persistence, and a fresh Liquibase replay proves the rewritten historical bootstrap creates the correct group-scoped root schema without a late conversion step.

**Codebase pointers:**

- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/domain/Customer.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/domain/IdentityLink.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/repository/CustomerRepository.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/repository/IdentityLinkRepository.java`
- `customer/src/main/resources/config/liquibase/changelog/20250826152824_added_entity_Customer.xml`
- `customer/src/main/resources/config/liquibase/changelog/20250826152825_added_entity_IdentityLink.xml`
- `customer/src/main/resources/config/liquibase/changelog/20250827104800_added_constraints.xml`
- `customer/src/main/resources/config/liquibase/changelog/20260119120000_add_customer_email_change.xml`
- `customer/src/main/resources/config/liquibase/changelog/20260114090000_add_customer_merge_schema.xml`
- `customer/src/main/resources/config/liquibase/changelog/20260123090000_add_customer_activity_metrics.xml`
- `customer/src/main/resources/config/liquibase/changelog/20260113160000_add_consent_privacy.xml`
- `customer/src/main/resources/config/liquibase/changelog/20260115143000_add_booking_linking_tables.xml`
- `customer/src/test/java/fr/gamarsoft/solutionpark/customer/IntegrationTest.java`
- `customer/src/test/java/fr/gamarsoft/solutionpark/customer/service/CustomerMergeRepositoryIT.java`

- [ ] Step 1: Read codebase pointers and understand existing patterns
- [ ] Step 2: Write failing tests from acceptance criteria
- [ ] Step 3: Run tests to verify they fail
- [ ] Step 4: Write minimal implementation to pass tests
- [ ] Step 5: Run tests, self-review, commit

### Task 4: Customer tenant registry and signed state

**Files:**

- Create: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/client/uaa/dto/TenantRegistryEntryDTO.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/client/uaa/UaaProxy.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/tenant/TenantRegistry.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/tenant/SimpleTenantRegistry.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/security/StatePayload.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/StateController.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/tenant/SimpleTenantRegistryTest.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/StateControllerIT.java`

**Interfaces and contracts:**

- `TenantRegistry` resolves `TenantInfo(tenantId, groupId)` from `tenantOrigin`.
- `TenantOriginEntry` remains an explicit record anchor in this task and becomes `(normalizedOrigin, parkingId, groupId)` for the cached UAA origin registry representation.
- `StatePayload` becomes `(tenantOrigin, tenantId, groupId, returnUrl, iat, exp, nonce, purpose)`.
- `/auth/state/*` response shapes stay unchanged; `groupId` is additive inside the signed payload rather than a new outward-facing Auth Portal contract.

**Acceptance criteria:**

- `/auth/state/init` signs and verifies `groupId` as part of the HMAC payload without changing its response shape.
- `SimpleTenantRegistry` caches the UAA bulk lookup and still rejects unknown or ambiguous tenant origins.
- `StateController` keeps the existing return-url and origin-validation behavior while adding `groupId` to the signed state consumed by later auth-exchange work.

**Error handling:**

- Invalid or expired state and missing `groupId` must continue returning the existing unauthorized semantics.
- Ambiguous or unknown tenant origins must still fail closed before any signed state is minted.

**Verification:**

- Run: `cd customer && ./mvnw -q -ntp -Dspotless.apply.skip=true -Djacoco.skip=true -Dspring-boot.build-info.skip=true -Dtest=SimpleTenantRegistryTest test`
- Run: `cd customer && ./mvnw -q -ntp -Dspotless.apply.skip=true -Djacoco.skip=true -Dspring-boot.build-info.skip=true -Dit.test=StateControllerIT verify`
- Expected: tenant lookup and signed-state tests pass with both tenant and group identifiers present in the registry and HMAC payload.

**Codebase pointers:**

- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/client/uaa/UaaProxy.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/tenant/TenantRegistry.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/tenant/SimpleTenantRegistry.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/security/StatePayload.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/StateController.java`

- [ ] Step 1: Read codebase pointers and understand existing patterns
- [ ] Step 2: Write failing tests from acceptance criteria
- [ ] Step 3: Run tests to verify they fail
- [ ] Step 4: Write minimal implementation to pass tests
- [ ] Step 5: Run tests, self-review, commit

### Task 5: Customer core identity, outbox, and auth-exchange contracts

**Files:**

- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/CustomerIdentityService.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/CustomerEmailChangeService.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/OutboxEventService.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/dto/CustomerDTO.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/dto/IdentityLinkDTO.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/code/BoundIdentity.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/code/RedisCodeStore.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AuthExchangeController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/dto/ConsumeRes.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/service/CustomerIdentityServiceTest.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/AuthExchangeControllerIT.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/code/RedisCodeStoreConcurrencyIT.java`

**Interfaces and contracts:**

- `CustomerIdentityService.ensureLinked(groupId, provider, externalId, email, given, family, tenantId, idempotencyKey)` returns the canonical group customer and eagerly ensures a tenant profile row.
- `OutboxEventService` keeps existing event names and versions but makes their payloads explicit and additive:
  - `customer.created.v1` retains the current payload fields and adds `groupId`; any existing `parkingId` or tenant field keeps its current meaning as the triggering tenant context.
  - `identity.linked.v1` retains the current payload fields, keeps `customerId` as the canonical `groupCustomerId`, and adds `groupId`; any existing `parkingId` or tenant field keeps representing the triggering tenant context.
  - Outbox ordering switches to the group-scoped key from the spec, `"p:%d:c:%d".formatted(groupId, customerId)`, so retries remain stable across tenants in the same group.
- `BoundIdentity` becomes `(tenantOrigin, returnUrl, uid, email, groupCustomerId, groupId)` and `ConsumeRes` becomes `(firebaseUid, email, returnUrl, groupCustomerId, groupId)`.
- Preserve the spec-approved outward names exactly for new auth-exchange fields: JSON keys remain `groupCustomerId` and `groupId`, while Redis/Java records may use the matching camelCase field names.

**Acceptance criteria:**

- `ensureLinked` reuses or creates customers by `(groupId, primaryEmail)`, creates `identity_link.group_id`, and creates the `(groupCustomerId, tenantId)` tenant profile if missing.
- Outbox ordering and idempotency keys become group-aware and remain stable across retries.
- `/auth/exchange/bootstrap` writes `groupCustomerId` and `groupId` into the minted code after `ensureLinked` returns the canonical customer, and `/auth/exchange/consume` returns those additive fields unchanged.

**Error handling:**

- Missing tenant/group context or missing identity links must keep current bad-request/not-found semantics.
- Concurrent link creation must remain safe under unique constraints and idempotency keys.
- Redis payload upgrades for auth exchange must tolerate short-lived mixed deployments by using additive fields and explicit parsing failures rather than silent truncation.

**Verification:**

- Run: `cd customer && ./mvnw -q -ntp -Dspotless.apply.skip=true -Djacoco.skip=true -Dspring-boot.build-info.skip=true -Dtest=CustomerIdentityServiceTest test`
- Run: `cd customer && ./mvnw -q -ntp -Dspotless.apply.skip=true -Djacoco.skip=true -Dspring-boot.build-info.skip=true -Dit.test=AuthExchangeControllerIT,RedisCodeStoreConcurrencyIT verify`
- Expected: canonical group identity, outbox behavior, and auth-exchange payload tests pass with `groupCustomerId` and `groupId`.

**Codebase pointers:**

- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/CustomerIdentityService.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/CustomerEmailChangeService.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/OutboxEventService.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/code/BoundIdentity.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/code/RedisCodeStore.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/dto/ConsumeRes.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AuthExchangeController.java`

- [ ] Step 1: Read codebase pointers and understand existing patterns
- [ ] Step 2: Write failing tests from acceptance criteria
- [ ] Step 3: Run tests to verify they fail
- [ ] Step 4: Write minimal implementation to pass tests
- [ ] Step 5: Run tests, self-review, commit

### Task 6: Customer public and self-service group-aware adoption

**Files:**

- Create: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/PublicCustomerProfileService.java`
- Create: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/SelfServiceCustomerProfileService.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/IdentityLinkService.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/ConsentService.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/CustomerEmailChangeService.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/PublicIdentityController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/PublicCustomerProfileController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/PublicCustomerConsentController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/CustomerProfileController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/CustomerConsentController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/EmailStatusController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/EmailChangeController.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/PublicIdentityControllerIT.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/PublicCustomerProfileControllerIT.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/PublicCustomerConsentControllerIT.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/CustomerProfileControllerIT.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/CustomerConsentControllerIT.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/EmailStatusControllerTest.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/EmailChangeControllerTest.java`

**Interfaces and contracts:**

- Public and self-service shared-profile reads/writes move into dedicated services (`PublicCustomerProfileService`, `SelfServiceCustomerProfileService`) instead of expanding `CustomerProfileService`.
- Public and self-service controllers resolve Firebase or WordPress identity by `groupId + provider + externalId`, with tenant context still sourced from `X-Parking-Id`.
- Consent remains tenant-scoped even when the underlying customer is group-scoped.
- Email-status and email-change APIs keep their current HTTP contract while switching to group-scoped identity lookup internally.

**Acceptance criteria:**

- Public identity, self-service profile, consent, email-status, and email-change flows all resolve the same canonical customer across tenants in the same group.
- `POST /api/public/customer/consent` and `POST /api/customer/consent` remain tenant-scoped and keep recording the tenant parking ID.
- No controller introduces email-based cross-group auto-merge behavior.

**Error handling:**

- Missing `X-Parking-Id`, unresolved tenant/group context, or missing identity links must keep current bad-request/not-found semantics.
- Email-status and email-change endpoints must continue to fail safely when the Firebase identity does not map to a group-scoped customer.

**Verification:**

- Run: `cd customer && ./mvnw -q -ntp -Dspotless.apply.skip=true -Djacoco.skip=true -Dspring-boot.build-info.skip=true -Dtest=EmailStatusControllerTest,EmailChangeControllerTest test`
- Run: `cd customer && ./mvnw -q -ntp -Dspotless.apply.skip=true -Djacoco.skip=true -Dspring-boot.build-info.skip=true -Dit.test=PublicIdentityControllerIT,PublicCustomerProfileControllerIT,PublicCustomerConsentControllerIT,CustomerProfileControllerIT,CustomerConsentControllerIT verify`
- Expected: public and self-service regression suites pass with group-aware lookup and unchanged tenant-scoped consent behavior.

**Codebase pointers:**

- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/IdentityLinkService.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/ConsentService.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/CustomerEmailChangeService.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/PublicIdentityController.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/PublicCustomerProfileController.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/PublicCustomerConsentController.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/CustomerProfileController.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/CustomerConsentController.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/EmailStatusController.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/EmailChangeController.java`

- [ ] Step 1: Read codebase pointers and understand existing patterns
- [ ] Step 2: Write failing tests from acceptance criteria
- [ ] Step 3: Run tests to verify they fail
- [ ] Step 4: Write minimal implementation to pass tests
- [ ] Step 5: Run tests, self-review, commit

### Task 7: Customer admin shared and tenant subresource endpoints

**Files:**

- Create: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/dto/AdminCustomerSharedProfileDTO.java`
- Create: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/dto/AdminCustomerTenantProfileDTO.java`
- Create: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/dto/AdminCustomerTenantSummaryDTO.java`
- Create: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/dto/AdminCustomerTenantConsentDTO.java`
- Create: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/AdminCustomerSharedProfileService.java`
- Create: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/AdminCustomerTenantProfileService.java`
- Create: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminCustomerIdentityController.java`
- Create: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminCustomerVehicleController.java`
- Create: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminCustomerTenantConsentController.java`
- Create: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminCustomerTenantProfileController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/config/SecurityConfiguration.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/security/SecurityUtils.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/CustomerMergeCandidateService.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/CustomerInternalNoteService.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/dto/AdminCustomerProfileDTO.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminCustomerController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminCustomerProfileController.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/security/SecurityUtilsUnitTest.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminCustomerControllerIT.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminCustomerIdentityControllerIT.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminCustomerVehicleControllerIT.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminCustomerProfileControllerIT.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminCustomerTenantConsentControllerIT.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminCustomerTenantProfileControllerIT.java`

**Interfaces and contracts:**

- Admin endpoints use token claims (`parking_id`, `parking_ids`, `tenant_group_id`) for business scoping rather than role-gated endpoint access.
- Shared-profile and tenant-subresource orchestration lives in dedicated admin services (`AdminCustomerSharedProfileService`, `AdminCustomerTenantProfileService`) rather than expanding the already-large `CustomerProfileService`.
- `GET /api/admin/customers?email=...` returns only group customers visible to the caller's `tenant_group_id`.
- `GET /api/admin/customers/{id}` and `GET /api/admin/customers/{id}/profile` use `groupCustomerId` path IDs and reject cross-group access.
- `GET /api/admin/customers/{id}/merge-candidates` returns only same-group candidates and never crosses the caller's group boundary.
- `PATCH /api/admin/customers/{id}/internal-note` writes the tenant-scoped note for the caller's active tenant, not a group-level field.
- `GET|PUT /api/admin/customers/{id}/shared-profile` uses `AdminCustomerSharedProfileDTO { groupCustomerId, primaryEmail, givenName, familyName, phoneNumber, altPhoneNumber, birthDate, gender, preferredLanguage, locale, timezone, preferredChannel, contactWindowStart, contactWindowEnd, billing, shipping }`.
- `GET /api/admin/customers/{id}/identities` returns `List<IdentityLinkDTO>` and `GET /api/admin/customers/{id}/vehicles` returns `List<CustomerVehicleDTO>`.
- `GET /api/admin/customers/{id}/tenants` returns `List<AdminCustomerTenantSummaryDTO { tenantId, newsletterOptIn, hasInternalNote, consentSummary }>`.
- `GET|PUT /api/admin/customers/{id}/tenants/{tenantId}/profile` uses `AdminCustomerTenantProfileDTO { tenantId, newsletterOptIn, customAttributes, internalNote }`.
- `GET|POST /api/admin/customers/{id}/tenants/{tenantId}/consent` uses `AdminCustomerTenantConsentDTO { tenantId, marketingSummary, events }`.

**Acceptance criteria:**

- Any authenticated Keycloak user can reach `/api/admin/*`, but cross-group access is denied by business logic rather than `@PreAuthorize` role checks.
- Admin search, fetch, merge-candidates, shared-profile, identities, vehicles, tenant list, tenant profile read/write, and tenant consent read/write all operate on the canonical group customer while enforcing tenant access for tenant-specific subresources.
- Internal-note writes are tenant-scoped and persist through `customer_tenant_profile`, not the group-level `customer` row.

**Error handling:**

- Missing `tenant_group_id` or malformed `parking_ids` claims must fail closed for group/tenant-scoped admin operations.
- Requests for customers outside the caller's group or tenant IDs outside the caller's accessible set must return forbidden/not-found semantics consistently.

**Verification:**

- Run: `cd customer && ./mvnw -q -ntp -Dspotless.apply.skip=true -Djacoco.skip=true -Dspring-boot.build-info.skip=true -Dtest=SecurityUtilsUnitTest test`
- Run: `cd customer && ./mvnw -q -ntp -Dspotless.apply.skip=true -Djacoco.skip=true -Dspring-boot.build-info.skip=true -Dit.test=AdminCustomerControllerIT,AdminCustomerIdentityControllerIT,AdminCustomerVehicleControllerIT,AdminCustomerProfileControllerIT,AdminCustomerTenantConsentControllerIT,AdminCustomerTenantProfileControllerIT verify`
- Expected: admin shared/tenant subresource suites pass for in-group callers and fail for cross-group or cross-tenant access.

**Codebase pointers:**

- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/security/SecurityUtils.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/config/SecurityConfiguration.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/CustomerMergeCandidateService.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/CustomerInternalNoteService.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminCustomerController.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminCustomerProfileController.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminCustomerIdentityController.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminCustomerVehicleController.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminCustomerTenantConsentController.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminCustomerTenantProfileController.java`

- [ ] Step 1: Read codebase pointers and understand existing patterns
- [ ] Step 2: Write failing tests from acceptance criteria
- [ ] Step 3: Run tests to verify they fail
- [ ] Step 4: Write minimal implementation to pass tests
- [ ] Step 5: Run tests, self-review, commit

### Task 8: Customer booking, merge, privacy, and deprecated endpoint cleanup

**Files:**

- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/BookingLinkService.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/BookingBackfillService.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/CustomerMergeService.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/PrivacyWorkflowService.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/CustomerInternalNoteService.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminCustomerController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminBookingLinkController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminBookingBackfillController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminCustomerMergeController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminPrivacyController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/CustomerPrivacyController.java`
- Delete: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/CustomerResource.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminBookingLinkControllerIT.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminBookingBackfillControllerIT.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminCustomerMergeControllerIT.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminPrivacyControllerIT.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/CustomerPrivacyControllerIT.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/CustomerResourceIT.java`

**Interfaces and contracts:**

- `customerId` in admin booking-link, merge, booking-links list, and privacy APIs is the canonical `groupCustomerId`.
- Tenant-specific admin behavior uses explicit tenant context (`parkingId`/`tenantId`) alongside the caller's accessible tenant set.
- `GET /api/admin/customers/{id}/booking-links` is served from `AdminBookingLinkController` and returns all linked bookings for the group customer, each carrying its tenant/parking ID.
- `POST /api/admin/privacy/export?customerId=...` and `POST /api/admin/privacy/delete?customerId=...` stay supported and operate on `groupCustomerId`; `DELETE /api/admin/customers/{id}` is the equivalent group-wide delete route on the consolidated admin surface.
- `POST /api/customer/privacy/export` and `POST /api/customer/privacy/delete` remain self-service routes but execute group-wide export/erasure after resolving the caller via Firebase UID plus `X-Parking-Id -> groupId`.
- `/api/customers/**` is removed and must resolve as absent.

**Acceptance criteria:**

- Booking-link list, force-link, and backfill remain tenant-scoped by parking but always read/write group customers.
- Merge/unmerge logic forbids cross-group merges and preserves/restores tenant profiles correctly.
- `POST /api/admin/privacy/export?customerId=...` returns the whole group customer's shared data plus all tenant-scoped consent/profile data.
- `POST /api/admin/privacy/delete?customerId=...` and `DELETE /api/admin/customers/{id}` both perform group-wide erasure, mark the customer erased, anonymize shared PII fields, clear tenant-profile mutable fields, and prevent future identity resolution by erased links.
- Requests to `/api/customers/**` return `404` after `CustomerResource` removal.

**Error handling:**

- Group-wide delete/export must reject callers without both group access and tenant context where tenant-specific side effects still exist.
- Backfill and merge endpoints must fail closed on cross-group IDs or tenant IDs outside `parking_ids`.

**Verification:**

- Run: `cd customer && ./mvnw -q -ntp -Dspotless.apply.skip=true -Djacoco.skip=true -Dspring-boot.build-info.skip=true -Dit.test=AdminBookingLinkControllerIT,AdminBookingBackfillControllerIT,AdminCustomerMergeControllerIT,AdminPrivacyControllerIT,CustomerPrivacyControllerIT,CustomerResourceIT verify`
- Expected: booking, merge, privacy, and deprecated-endpoint coverage passes with group-scoped IDs, tenant-aware enforcement, and `404` on `/api/customers/**`.

**Codebase pointers:**

- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/BookingLinkService.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/BookingBackfillService.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/CustomerMergeService.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/PrivacyWorkflowService.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/CustomerInternalNoteService.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminCustomerController.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminBookingLinkController.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminBookingBackfillController.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminCustomerMergeController.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminPrivacyController.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/CustomerPrivacyController.java`
- `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/CustomerResource.java`

- [ ] Step 1: Read codebase pointers and understand existing patterns
- [ ] Step 2: Write failing tests from acceptance criteria
- [ ] Step 3: Run tests to verify they fail
- [ ] Step 4: Write minimal implementation to pass tests
- [ ] Step 5: Run tests, self-review, commit

### Task 9: Gateway claim extraction and account exposure

**Files:**

- Modify: `gateway/src/main/java/fr/gamarsoft/solutionpark/gateway/security/SecurityUtils.java`
- Modify: `gateway/src/main/java/fr/gamarsoft/solutionpark/gateway/web/rest/AccountResource.java`
- Test: `gateway/src/test/java/fr/gamarsoft/solutionpark/gateway/security/SecurityUtilsUnitTest.java`
- Test: `gateway/src/test/java/fr/gamarsoft/solutionpark/gateway/web/rest/AccountResourceIT.java`

**Interfaces and contracts:**

- `SecurityUtils.extractDetailsFromTokenAttributes(...)` exposes `parkingId`, `parkingIds`, and `tenantGroupId` in the account details map.
- `AccountResource /api/account` keeps `parkingId` as the active tenant while exposing additive multi-tenant/group fields for future UI use.
- Token claim names stay `parking_id`, `parking_ids`, and `tenant_group_id`; Gateway runtime fields stay `parkingId`, `parkingIds`, and `tenantGroupId`.
- No Gateway frontend routing or request-generation behavior changes in this item.

**Acceptance criteria:**

- Gateway token parsing accepts `parking_ids` arrays and `tenant_group_id` longs without breaking existing `parking_id` consumers.
- `/api/account` returns the new fields when present and omits them safely when absent.
- Existing `/api/account` consumers continue receiving `parkingId`, and tokens that also carry `parking_ids` / `tenant_group_id` surface those fields additively without changing `login` or `authorities`.

**Error handling:**

- Non-numeric or malformed `parking_ids`/`tenant_group_id` values must not crash account resolution; the parser should fail safely and preserve existing fields.
- N/A — Gateway changes are additive claim parsing with no new external I/O beyond existing token handling.

**Verification:**

- Run: `cd gateway && ./mvnw -q -ntp -Dspotless.apply.skip=true -Djacoco.skip=true -Dspring-boot.build-info.skip=true -Dtest=SecurityUtilsUnitTest test`
- Run: `cd gateway && ./mvnw -q -ntp -Dspotless.apply.skip=true -Djacoco.skip=true -Dspring-boot.build-info.skip=true -Dit.test=AccountResourceIT verify`
- Expected: Gateway tests pass with additive claim parsing and unchanged `parkingId` behavior.

**Codebase pointers:**

- `gateway/src/main/java/fr/gamarsoft/solutionpark/gateway/security/SecurityUtils.java`
- `gateway/src/main/java/fr/gamarsoft/solutionpark/gateway/web/rest/AccountResource.java`
- `gateway/src/test/java/fr/gamarsoft/solutionpark/gateway/security/SecurityUtilsUnitTest.java`

- [ ] Step 1: Read codebase pointers and understand existing patterns
- [ ] Step 2: Write failing tests from acceptance criteria
- [ ] Step 3: Run tests to verify they fail
- [ ] Step 4: Write minimal implementation to pass tests
- [ ] Step 5: Run tests, self-review, commit

### Task 10: WordPress bridge consume metadata persistence and regression coverage

**Files:**

- Modify: `solution-park-firebase-bridge/inc/class-auth-client.php`
- Modify: `solution-park-firebase-bridge/inc/class-receiver-route.php`
- Modify: `solution-park-firebase-bridge/inc/class-bridge-login.php`
- Modify: `solution-park-firebase-bridge/inc/class-profile-sync.php`
- Test: `solution-park-firebase-bridge/tests/bridge-login-email-update.php`
- Test: `solution-park-firebase-bridge/tests/bridge-login-group-meta.php`

**Interfaces and contracts:**

- `exchange_consume()` accepts additive `groupCustomerId` and `groupId` fields while keeping Firebase UID as the primary identity key.
- Successful bridge login persists `group_customer_id` and `group_id` user meta alongside existing Firebase/WP metadata.
- Preserve the naming split exactly: consume-response JSON uses `groupCustomerId` / `groupId`, while persisted WordPress meta keys use `group_customer_id` / `group_id`.
- Bridge settings and outbound headers remain tenant-scoped (`parking_id`, `X-Parking-Id`, `X-Bridge-Secret`).

**Acceptance criteria:**

- Older consume responses without group fields remain accepted, and newer responses persist both new meta values when present.
- Login/profile sync continues to locate users by Firebase UID, not by group metadata.
- No plugin settings, redirect rules, or tenant header behavior change in this item.

**Error handling:**

- Missing additive fields from Customer Service must not block login for older servers.
- Invalid consume responses must continue returning `WP_Error` with existing failure semantics.

**Verification:**

- Run: `cd solution-park-firebase-bridge && docker run --rm -v "$PWD":/app -w /app php:8.2-cli php tests/bridge-login-email-update.php && docker run --rm -v "$PWD":/app -w /app php:8.2-cli php tests/bridge-login-group-meta.php`
- Expected: existing bridge regression still passes and the new test confirms `group_customer_id` and `group_id` persistence.

**Codebase pointers:**

- `solution-park-firebase-bridge/inc/class-auth-client.php`
- `solution-park-firebase-bridge/inc/class-receiver-route.php`
- `solution-park-firebase-bridge/inc/class-bridge-login.php`
- `solution-park-firebase-bridge/inc/class-profile-sync.php`

- [ ] Step 1: Read codebase pointers and understand existing patterns
- [ ] Step 2: Write failing tests from acceptance criteria
- [ ] Step 3: Run tests to verify they fail
- [ ] Step 4: Write minimal implementation to pass tests
- [ ] Step 5: Run tests, self-review, commit

## Saved Context

- Spec document: `docs/superpowers/specs/2026-01-29-crm-rm-037-tenant-groups-design.md`
- Roadmap anchor: `.github/plan/crm-dashpark/00-roadmap.md` (`CRM-RM-037`)
- Cross-repo constraints captured in this plan:
  - UAA is the sole source of truth for tenant groups; Customer Service caches `(tenantId, groupId)` only.
  - `tenantId` and `parkingId` remain synonymous throughout execution.
  - Auth Portal intentionally has no code changes for this item; additive backend and bridge contract changes must preserve that invariant.
  - `/api/admin/` remains the exclusive operator-facing Customer Service surface after `CustomerResource` removal.
  - Customer Service must achieve greenfield group-scoped root identity by rewriting the historical `customer` / `identity_link` bootstrap changelogs; do not rely on a late rename/backfill Liquibase sequence for empty-database correctness.

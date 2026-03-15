# CRM-RM-037 Tenant Groups + Group Customer Identity Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Ship tenant groups as the UAA source of truth and convert CRM identity from parking-scoped customers to group-scoped customers, while keeping tenant-scoped preferences/consent and preserving backward-compatible operator login claims.

**Architecture:** This rollout is intentionally cross-repo and coupled. UAA owns tenant groups and exposes a bulk tenant registry contract; the Keycloak provider derives new claims from that source; Customer Service switches its canonical identity model to `groupCustomerId` plus tenant profiles; Gateway and the WordPress bridge consume the new claims/payloads without introducing Phase 1 UI changes.

**Tech Stack:** Java 17, Spring Boot/JHipster, Liquibase, shared `model` module DTO contracts, Keycloak 22 SPI, Redis code store, Angular 7 Gateway backend, PHP 8.2 WordPress bridge.

**Context7 Findings (required if any external libs/APIs are involved):**

- Libraries + installed versions
  - Keycloak (`22.0.0` in [sp-keycloak-uaa-provider/pom.xml](/Volumes/Workspace/Development/SolutionPark/DashPark/sp-keycloak-uaa-provider/pom.xml)) is the only version-sensitive surface that materially affects this plan.
- Doc-backed API/config decisions
  - Use `AbstractUserAdapterFederatedStorage`/`UserModel` overrides to expose custom attributes from the provider; keep single-valued claims on `getFirstAttribute(...)` and expose list claims through `getAttributeStream(...)`.
  - For OIDC "User Attribute" protocol mappers, keep `user.attribute`, `claim.name`, `jsonType.label`, and token inclusion flags aligned with the existing `parking_id` mapper in [sp-realm.json](/Volumes/Workspace/Development/SolutionPark/DashPark/gateway/src/main/docker/realm-config/sp-realm.json); add `multivalued = true` for `parking_ids`.
  - Role mapping remains provider-owned; the adapter can continue deriving transient roles in `getRoleMappingsStream()` / `getRoleMappingsInternal()`.
- Caveats/migrations
  - Keycloak 22 user-storage code is sensitive to lazy JPA access inside adapters/authenticators; fetch parking/group relationships eagerly or via fetch joins.
  - Realm export changes are configuration, not code generation; keep claim names stable: `parking_id`, `parking_ids`, `tenant_group_id`.

---

This plan stays as one document instead of splitting by subsystem because CRM-RM-037 only produces a coherent, testable behavior when all participating repos are upgraded together. The implementation order below minimizes broken intermediate states while still allowing frequent commits inside each repo.

## File Structure

### Shared Contract (`model`)

- Create: `model/src/main/java/fr/gamarsoft/solutionpark/model/uaa/TenantOriginGroupDTO.java`
  - Shared DTO for `tenantOrigin -> (tenantId, groupId)` bulk registry entries returned by UAA and consumed by Customer Service.
- Create: `model/src/test/java/fr/gamarsoft/solutionpark/model/uaa/TenantOriginGroupDTOTest.java`
  - Minimal serialization/equality coverage for the shared contract.

### UAA (`uaa`)

- Create: `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/domain/TenantGroup.java`
  - New aggregate for group membership source of truth.
- Create: `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/domain/enumeration/TenantGroupKind.java`
  - Enum for `HOLDING` / `CLIENT`.
- Create: `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/repository/TenantGroupRepository.java`
  - Group lookups needed by migration/service assembly.
- Create: `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/web/rest/TenantRegistryResource.java`
  - Bulk endpoint for Customer Service registry refresh.
- Modify: `uaa/src/main/resources/config/liquibase/master.xml`
  - Register the new tenant-group migration changelog.
- Create: `uaa/src/main/resources/config/liquibase/changelog/20260311100000_add_tenant_groups.xml`
  - New schema/data migration for `tenant_group`, singleton groups, and `parking.group_id NOT NULL`.
- Modify: `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/domain/Parking.java`
  - Add `groupId` FK field while retaining deprecated `parkingGroupe`.
- Modify: `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/service/dto/ParkingDTO.java`
  - Surface `groupId` for admin APIs; keep `parkingGroupe` temporarily.
- Modify: `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/service/mapper/ParkingMapper.java`
  - Map `groupId` cleanly.
- Modify: `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/repository/ParkingRepository.java`
  - Add helper queries for group-backed lookups if service assembly needs them.
- Modify: `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/service/ParkingService.java`
  - Preserve group fields through save/load flows.
- Modify: `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/web/rest/ParkingResource.java`
  - Expose new field in existing parking admin endpoints.
- Modify: `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/web/rest/FeatureFlagsResource.java`
  - Replace `parkingGroupe` gating input with `groupKind == HOLDING`.
- Modify: `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/service/ParkingSettingsService.java`
  - Assemble bulk registry rows from minisite settings plus `groupId`.
- Modify: `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/web/rest/ParkingSettingsResource.java`
  - Keep existing bulk-by-key endpoint intact if reused internally; do not overload it with group payloads.
- Test: `uaa/src/test/java/fr/gamarsoft/solutionpark/uaa/web/rest/ParkingResourceIT.java`
- Test: `uaa/src/test/java/fr/gamarsoft/solutionpark/uaa/web/rest/ParkingSettingsResourceIT.java`
- Create: `uaa/src/test/java/fr/gamarsoft/solutionpark/uaa/web/rest/TenantRegistryResourceIT.java`

### Keycloak Provider (`sp-keycloak-uaa-provider`)

- Create: `sp-keycloak-uaa-provider/src/main/java/fr/gamarsoft/solutionpark/uaa/keycloakuaaprovider/domain/TenantGroup.java`
  - Read-only Keycloak-side mapping for `tenant_group`.
- Create: `sp-keycloak-uaa-provider/src/main/java/fr/gamarsoft/solutionpark/uaa/keycloakuaaprovider/domain/enumeration/TenantGroupKind.java`
  - Local enum for provider-side `group_kind`.
- Modify: `sp-keycloak-uaa-provider/src/main/resources/META-INF/persistence.xml`
  - Register the new entity.
- Modify: `sp-keycloak-uaa-provider/src/main/java/fr/gamarsoft/solutionpark/uaa/keycloakuaaprovider/domain/Parking.java`
  - Replace `parkingGroupe`-only view with `groupId` and parking metadata needed by claims.
- Modify: `sp-keycloak-uaa-provider/src/main/java/fr/gamarsoft/solutionpark/uaa/keycloakuaaprovider/domain/User.java`
  - Correct `parking_user` mapping to `@ManyToMany`, add primary-parking helper, update named queries for eager fetches.
- Modify: `sp-keycloak-uaa-provider/src/main/java/fr/gamarsoft/solutionpark/uaa/keycloakuaaprovider/UserAdapter.java`
  - Emit `parkingId`, `parkingIds`, `tenantGroupId`; refactor `ROLE_MANAGER_GROUPE`.
- Modify: `sp-keycloak-uaa-provider/src/main/java/fr/gamarsoft/solutionpark/uaa/keycloakuaaprovider/authenticator/MobileAccessAuthenticator.java`
  - Continue using primary parking only.
- Create: `sp-keycloak-uaa-provider/src/test/java/fr/gamarsoft/solutionpark/uaa/keycloakuaaprovider/UserAdapterTest.java`
- Create: `sp-keycloak-uaa-provider/src/test/java/fr/gamarsoft/solutionpark/uaa/keycloakuaaprovider/authenticator/MobileAccessAuthenticatorTest.java`

### Customer Service (`customer`)

- Create: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/domain/CustomerTenantProfile.java`
  - Tenant-scoped fields split from `Customer`.
- Create: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/repository/CustomerTenantProfileRepository.java`
  - Persistence for eager tenant-profile creation and admin tenant subresources.
- Modify: `customer/src/main/resources/config/liquibase/changelog/20250826152824_added_entity_Customer.xml`
  - Rewrite the greenfield bootstrap so `customer` is created with `group_id`, not `parking_id`.
- Modify: `customer/src/main/resources/config/liquibase/changelog/20250826152825_added_entity_IdentityLink.xml`
  - Rewrite the greenfield bootstrap so `identity_link` is created with `group_id`, not `parking_id`.
- Modify: `customer/src/main/resources/config/liquibase/changelog/20250827104800_added_constraints.xml`
  - Replace parking-scoped unique constraints and indexes with group-scoped ones for root identity tables.
- Modify: `customer/src/main/resources/config/liquibase/changelog/20260113090000_add_customer_profile_fields.xml`
  - Keep only shared profile columns on `customer`; stop adding tenant-only fields to the root row in greenfield history.
- Modify: `customer/src/main/resources/config/liquibase/changelog/20260114090000_add_customer_merge_schema.xml`
  - Make merge history group-scoped where the record represents canonical customer identity operations.
- Modify: `customer/src/main/resources/config/liquibase/changelog/20260119120000_add_customer_email_change.xml`
  - Make email-history schema group-scoped for greenfield databases.
- Modify: `customer/src/main/resources/config/liquibase/changelog/20260123090000_add_customer_activity_metrics.xml`
  - Stop adding `internal_note` to `customer`; keep tenant metrics tables tenant-scoped where the spec still requires tenant context.
- Create: `customer/src/main/resources/config/liquibase/changelog/20260311120000_add_group_customer_model.xml`
  - Add only new CRM-RM-037 structures with no historical equivalent, chiefly `customer_tenant_profile` and related constraints.
- Modify: `customer/src/main/resources/config/liquibase/master.xml`
  - Register new changelog.
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/domain/Customer.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/domain/IdentityLink.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/domain/ConsentEvent.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/domain/CustomerBookingLink.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/domain/PrivacyRequest.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/repository/CustomerRepository.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/repository/IdentityLinkRepository.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/mapper/CustomerMapper.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/dto/CustomerDTO.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/CustomerIdentityService.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/CustomerProfileService.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/ConsentService.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/PrivacyWorkflowService.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/CustomerMergeService.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/BookingBackfillService.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/CustomerEmailChangeService.java`
- Create: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/CustomerTenantProfileService.java`
- Create: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/dto/AdminCustomerSharedProfileDTO.java`
- Create: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/dto/AdminCustomerTenantProfileDTO.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/client/uaa/UaaProxy.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/tenant/TenantRegistry.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/tenant/SimpleTenantRegistry.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/security/StatePayload.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/code/BoundIdentity.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/code/RedisCodeStore.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/dto/ConsumeRes.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/StateController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AuthExchangeController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/PublicIdentityController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/PublicCustomerProfileController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/CustomerProfileController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/CustomerConsentController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/CustomerPrivacyController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/EmailStatusController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/EmailChangeController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminCustomerController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminCustomerProfileController.java`
- Create: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminCustomerTenantController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminCustomerMergeController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminBookingLinkController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminBookingBackfillController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminPrivacyController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/config/SecurityConfiguration.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/security/SecurityUtils.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/interceptor/ParkingInterceptor.java`
- Delete: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/CustomerResource.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/service/CustomerIdentityServiceTest.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/tenant/SimpleTenantRegistryTest.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/repository/CustomerRepositoryTest.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/repository/IdentityLinkRepositoryTest.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/StateControllerIT.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/AuthExchangeControllerIT.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/PublicIdentityControllerIT.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminCustomerControllerIT.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminCustomerProfileControllerIT.java`
- Create: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminCustomerTenantControllerIT.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/CustomerPrivacyControllerIT.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/security/SecurityUtilsUnitTest.java`

### Gateway (`gateway`)

- Modify: `gateway/src/main/java/fr/gamarsoft/solutionpark/gateway/security/SecurityUtils.java`
  - Extract `parking_ids` and `tenant_group_id` into `/api/account` details.
- Modify: `gateway/src/main/java/fr/gamarsoft/solutionpark/gateway/web/rest/AccountResource.java`
  - No behavior change beyond surfacing extra details.
- Modify: `gateway/src/main/docker/realm-config/sp-realm.json`
  - Add new protocol mappers for the dev realm export.
- Test: `gateway/src/test/java/fr/gamarsoft/solutionpark/gateway/security/SecurityUtilsUnitTest.java`
- Test: `gateway/src/test/java/fr/gamarsoft/solutionpark/gateway/web/rest/AccountResourceIT.java`

### WordPress Bridge (`solution-park-firebase-bridge`)

- Modify: `solution-park-firebase-bridge/inc/class-auth-client.php`
  - Accept additive consume fields.
- Modify: `solution-park-firebase-bridge/inc/class-receiver-route.php`
  - Pass group metadata through login flow.
- Modify: `solution-park-firebase-bridge/inc/class-bridge-login.php`
  - Persist `group_customer_id` and `group_id` user meta.
- Modify: `solution-park-firebase-bridge/inc/class-profile-sync.php`
  - No semantic change, but keep regression coverage around profile sync after new meta writes.
- Modify: `solution-park-firebase-bridge/tests/bridge-login-email-update.php`
  - Extend or duplicate test coverage for new meta persistence.
- Create: `solution-park-firebase-bridge/tests/bridge-login-group-meta.php`
  - Focused regression for additive consume payload handling.

## Chunk 1: Shared Contract, UAA Source Of Truth, Keycloak Claims

### Task 1: Add Shared Tenant Registry Contract In `model`

**Files:**

- Create: `model/src/main/java/fr/gamarsoft/solutionpark/model/uaa/TenantOriginGroupDTO.java`
- Test: `model/src/test/java/fr/gamarsoft/solutionpark/model/uaa/TenantOriginGroupDTOTest.java`

**Error handling:**

- N/A — DTO-only contract task. Validation belongs in UAA/Customer Service callers.

**Edge cases:**

- Ensure the DTO stays additive and serialization-stable so downstream repos can consume mixed-version payloads during local development.

**Verification criteria:**

- `model` builds and installs locally.
- Downstream code can import the DTO without introducing circular dependencies.

- [ ] **Step 1: Write the failing test**

```java
package fr.gamarsoft.solutionpark.model.uaa;

import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.Test;

class TenantOriginGroupDTOTest {
    @Test
    void roundTripsConstructorValues() {
        TenantOriginGroupDTO dto = new TenantOriginGroupDTO("https://tenant.example", 42L, 7L);
        assertThat(dto.tenantOrigin()).isEqualTo("https://tenant.example");
        assertThat(dto.tenantId()).isEqualTo(42L);
        assertThat(dto.groupId()).isEqualTo(7L);
    }
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `cd model && ./mvnw -q -ntp -Dspotless.apply.skip=true -Djacoco.skip=true -Dspring-boot.build-info.skip=true -Dtest=TenantOriginGroupDTOTest test`
Expected: FAIL because `TenantOriginGroupDTO` does not exist.

- [ ] **Step 3: Write minimal implementation**

```java
package fr.gamarsoft.solutionpark.model.uaa;

import java.io.Serializable;

public record TenantOriginGroupDTO(String tenantOrigin, Long tenantId, Long groupId) implements Serializable {}
```

- [ ] **Step 4: Run test to verify it passes**

Run: `cd model && ./mvnw -q -ntp -Dspotless.apply.skip=true -Djacoco.skip=true -Dspring-boot.build-info.skip=true test`
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git -C model add src/main/java/fr/gamarsoft/solutionpark/model/uaa/TenantOriginGroupDTO.java src/test/java/fr/gamarsoft/solutionpark/model/uaa/TenantOriginGroupDTOTest.java
git -C model commit -m "feat(model): add tenant origin group contract"
```

- [ ] **Step 6: Install the shared artifact for downstream repos**

Run: `cd model && ./mvnw -q -ntp -Dspotless.apply.skip=true -Djacoco.skip=true -Dspring-boot.build-info.skip=true install`
Expected: PASS and local Maven repo updated.

### Task 2: Add UAA Tenant Group Schema, Migration, And Bulk Registry Endpoint

**Files:**

- Create: `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/domain/TenantGroup.java`
- Create: `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/domain/enumeration/TenantGroupKind.java`
- Create: `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/repository/TenantGroupRepository.java`
- Create: `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/web/rest/TenantRegistryResource.java`
- Create: `uaa/src/main/resources/config/liquibase/changelog/20260311100000_add_tenant_groups.xml`
- Modify: `uaa/src/main/resources/config/liquibase/master.xml`
- Modify: `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/domain/Parking.java`
- Modify: `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/service/dto/ParkingDTO.java`
- Modify: `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/service/mapper/ParkingMapper.java`
- Modify: `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/repository/ParkingRepository.java`
- Modify: `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/service/ParkingService.java`
- Modify: `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/service/ParkingSettingsService.java`
- Modify: `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/web/rest/ParkingResource.java`
- Modify: `uaa/src/main/java/fr/gamarsoft/solutionpark/uaa/web/rest/FeatureFlagsResource.java`
- Test: `uaa/src/test/java/fr/gamarsoft/solutionpark/uaa/web/rest/ParkingResourceIT.java`
- Test: `uaa/src/test/java/fr/gamarsoft/solutionpark/uaa/web/rest/ParkingSettingsResourceIT.java`
- Create: `uaa/src/test/java/fr/gamarsoft/solutionpark/uaa/web/rest/TenantRegistryResourceIT.java`

**Error handling:**

- Liquibase migration must be idempotent for fresh dev databases and deterministic for populated UAA databases.
- Registry endpoint should skip invalid minisite URLs the same way `SimpleTenantRegistry` already does, not fail the full response.
- UAA admin APIs must continue working while `parking_groupe` remains temporarily present.

**Edge cases:**

- Existing `parking_groupe=true` parkings all collapse into the single HOLDING group.
- Parkings with `parking_groupe=false` or `NULL` each get a singleton CLIENT group.
- Parkings missing minisite URLs are excluded from the bulk registry payload but still receive a `group_id`.
- `FeatureFlagsResource` must not NPE if a parking/group row is partially configured in lower environments.

**Verification criteria:**

- Fresh schema boot creates `tenant_group`, `parking.group_id`, and `NOT NULL` constraint.
- Existing UAA parking CRUD still round-trips.
- Registry endpoint returns normalized origins plus `tenantId` and `groupId`.
- FF4J output for former groupe parkings stays unchanged after the migration.

- [ ] **Step 1: Write the failing tests**

```java
@Test
@WithMockUser(authorities = "ROLE_ADMIN")
void getTenantRegistryReturnsGroupAwareEntries() throws Exception {
    Parking parking = parkingRepository.saveAndFlush(ParkingResourceIT.createEntity(em).name("Registry Parking"));
    ParkingSettings minisite = ParkingSettingsResourceIT.createEntity(em)
        .parking(parking)
        .settingKey(ParkingSettingKey.BE_MINISITE_API_BASE_URL.name())
        .settingValue("https://registry.example")
        .frontend(Boolean.TRUE);
    parkingSettingsRepository.saveAndFlush(minisite);

    mockMvc
        .perform(get("/api/tenant-registry/origins"))
        .andExpect(status().isOk())
        .andExpect(jsonPath("$.[0].tenantId").isNumber())
        .andExpect(jsonPath("$.[0].tenantOrigin").value("https://registry.example"))
        .andExpect(jsonPath("$.[0].groupId").isNumber());
}

@Test
@WithMockUser(authorities = "ROLE_ADMIN")
void getParkingFromAdminIncludesGroupId() throws Exception {
    Parking parking = parkingRepository.saveAndFlush(ParkingResourceIT.createEntity(em));

    mockMvc
        .perform(get("/api/parkings-from-admin/{id}", parking.getId()))
        .andExpect(status().isOk())
        .andExpect(jsonPath("$.id").value(parking.getId().intValue()))
        .andExpect(jsonPath("$.groupId").isNumber());
}

@Test
@WithMockUser(authorities = "ROLE_ADMIN")
void getTenantRegistrySkipsInvalidMinisiteUrls() throws Exception {
    Parking parking = parkingRepository.saveAndFlush(ParkingResourceIT.createEntity(em).name("Broken Registry Parking"));
    ParkingSettings invalid = ParkingSettingsResourceIT.createEntity(em)
        .parking(parking)
        .settingKey(ParkingSettingKey.BE_MINISITE_API_BASE_URL.name())
        .settingValue("not a url")
        .frontend(Boolean.TRUE);
    parkingSettingsRepository.saveAndFlush(invalid);

    mockMvc.perform(get("/api/tenant-registry/origins")).andExpect(status().isOk()).andExpect(content().json("[]"));
}
```

- [ ] **Step 2: Run tests to verify they fail**

Run: `cd uaa && ./mvnw -q -ntp -Dspotless.apply.skip=true -Djacoco.skip=true -Dspring-boot.build-info.skip=true -Dtest=TenantRegistryResourceIT,ParkingResourceIT test`
Expected: FAIL because the endpoint, entity, and `groupId` field do not exist.

- [ ] **Step 3: Implement the schema and endpoint**

```java
@RestController
@RequestMapping("/api/tenant-registry")
class TenantRegistryResource {

    private static final Logger LOG = LoggerFactory.getLogger(TenantRegistryResource.class);

    private final ParkingSettingsService parkingSettingsService;
    private final ParkingRepository parkingRepository;

    TenantRegistryResource(ParkingSettingsService parkingSettingsService, ParkingRepository parkingRepository) {
        this.parkingSettingsService = parkingSettingsService;
        this.parkingRepository = parkingRepository;
    }

    @GetMapping("/origins")
    List<TenantOriginGroupDTO> getTenantOrigins() {
        Map<Long, Parking> parkingById = parkingRepository.findAll().stream().collect(Collectors.toMap(Parking::getId, Function.identity()));
        return parkingSettingsService.findAllBySettingKey(ParkingSettingKey.BE_MINISITE_API_BASE_URL, false)
            .stream()
            .map(dto -> toRegistryEntry(dto, parkingById.get(dto.getParkingId())))
            .flatMap(Optional::stream)
            .toList();
    }

    private Optional<TenantOriginGroupDTO> toRegistryEntry(ParkingSettingsDTO dto, Parking parking) {
        if (dto.getParkingId() == null || dto.getSettingValue() == null || dto.getSettingValue().isBlank() || parking == null) {
            return Optional.empty();
        }
        try {
            String normalizedOrigin = normalizeOrigin(dto.getSettingValue());
            return Optional.of(new TenantOriginGroupDTO(normalizedOrigin, parking.getId(), parking.getGroupId()));
        } catch (IllegalArgumentException ex) {
            LOG.warn("Ignoring invalid minisite base URL for parking {}", dto.getParkingId(), ex);
            return Optional.empty();
        }
    }

    private String normalizeOrigin(String rawValue) {
        String candidate = rawValue.contains("://") ? rawValue : "https://" + rawValue;
        URI uri = URI.create(candidate);
        if (uri.getHost() == null || uri.getHost().isBlank()) {
            throw new IllegalArgumentException("Missing host");
        }
        return uri.getScheme().toLowerCase() + "://" + uri.getHost().toLowerCase();
    }
}
```

- [ ] **Step 4: Run focused UAA tests**

Run: `cd uaa && ./mvnw -q -ntp -Dspotless.apply.skip=true -Djacoco.skip=true -Dspring-boot.build-info.skip=true -Dtest=TenantRegistryResourceIT,ParkingResourceIT,ParkingSettingsResourceIT test`
Expected: PASS, including a clean bootstrap of the rewritten Liquibase history in the empty integration-test schema.

- [ ] **Step 5: Commit**

```bash
git -C uaa add src/main/java src/main/resources/config/liquibase src/test/java
git -C uaa commit -m "feat(uaa): add tenant groups and registry endpoint"
```

### Task 3: Update Keycloak Provider For Group-Aware Claims And Role Derivation

**Files:**

- Create: `sp-keycloak-uaa-provider/src/main/java/fr/gamarsoft/solutionpark/uaa/keycloakuaaprovider/domain/TenantGroup.java`
- Create: `sp-keycloak-uaa-provider/src/main/java/fr/gamarsoft/solutionpark/uaa/keycloakuaaprovider/domain/enumeration/TenantGroupKind.java`
- Modify: `sp-keycloak-uaa-provider/src/main/resources/META-INF/persistence.xml`
- Modify: `sp-keycloak-uaa-provider/src/main/java/fr/gamarsoft/solutionpark/uaa/keycloakuaaprovider/domain/Parking.java`
- Modify: `sp-keycloak-uaa-provider/src/main/java/fr/gamarsoft/solutionpark/uaa/keycloakuaaprovider/domain/User.java`
- Modify: `sp-keycloak-uaa-provider/src/main/java/fr/gamarsoft/solutionpark/uaa/keycloakuaaprovider/UserAdapter.java`
- Modify: `sp-keycloak-uaa-provider/src/main/java/fr/gamarsoft/solutionpark/uaa/keycloakuaaprovider/authenticator/MobileAccessAuthenticator.java`
- Create: `sp-keycloak-uaa-provider/src/test/java/fr/gamarsoft/solutionpark/uaa/keycloakuaaprovider/UserAdapterTest.java`
- Create: `sp-keycloak-uaa-provider/src/test/java/fr/gamarsoft/solutionpark/uaa/keycloakuaaprovider/authenticator/MobileAccessAuthenticatorTest.java`

**Error handling:**

- Default to empty `parkingIds` for unsupported/global scopes rather than emitting malformed values.
- Preserve backward-compatible `parkingId` behavior even when multiple parkings exist.
- Avoid lazy-loading failures inside `UserAdapter` and `MobileAccessAuthenticator`.

**Edge cases:**

- Users with multiple parkings need a deterministic primary parking for `parkingId` and `tenantGroupId`.
- Global roles (`ROLE_ADMIN`, `ROLE_INTERNAL`) should not emit tenant-scoped `parking_ids`.
- `ROLE_MANAGER_GROUPE` must still be derived when the primary parking belongs to a HOLDING group.

**Verification criteria:**

- `parking_id` remains present for existing consumers.
- `parking_ids` contains one value for single-tenant users and the full group set for `ROLE_DIRECTION`.
- `tenant_group_id` is emitted for tenant-scoped users.
- Mobile app access still keys off the primary parking only.

- [ ] **Step 1: Write the failing tests**

```java
@Test
void getPrimaryParkingReturnsLowestParkingId() {
    User user = new User();
    Parking parking102 = new Parking();
    parking102.setId(102L);
    parking102.setGroupId(7L);
    Parking parking101 = new Parking();
    parking101.setId(101L);
    parking101.setGroupId(7L);
    user.setParkings(new HashSet<>(List.of(parking102, parking101)));

    assertThat(user.getPrimaryParking().getId()).isEqualTo(101L);
}

@Test
void userAdapterExposesParkingIdsAndTenantGroupId() {
    User user = new User();
    KeycloakSession session = mock(KeycloakSession.class);
    RealmModel realm = mock(RealmModel.class);
    ComponentModel componentModel = new ComponentModel();
    Parking parking102 = new Parking();
    parking102.setId(102L);
    parking102.setGroupId(7L);
    Parking parking101 = new Parking();
    parking101.setId(101L);
    parking101.setGroupId(7L);
    user.setParkings(new HashSet<>(List.of(parking102, parking101)));
    UserAdapter adapter = new UserAdapter(session, realm, componentModel, user);

    assertThat(adapter.getFirstAttribute("parkingId")).isEqualTo("101");
    assertThat(adapter.getFirstAttribute("tenantGroupId")).isEqualTo("7");
    assertThat(adapter.getAttributeStream("parkingIds")).containsExactly("101", "102");
}
```

- [ ] **Step 2: Run tests to verify they fail**

Run: `cd sp-keycloak-uaa-provider && ./mvnw -q -ntp -Dtest=UserAdapterTest,MobileAccessAuthenticatorTest test`
Expected: FAIL because test classes and new claim behavior do not exist.

- [ ] **Step 3: Implement provider changes**

```java
private static final String ATTR_PARKING_ID = "parkingId";
private static final String ATTR_PARKING_IDS = "parkingIds";
private static final String ATTR_TENANT_GROUP_ID = "tenantGroupId";

public Parking getPrimaryParking() {
    return parkings.stream().filter(parking -> parking.getId() != null).min(Comparator.comparing(Parking::getId)).orElse(null);
}

public List<Parking> getAccessibleParkings() {
    return parkings.stream()
        .filter(parking -> parking.getId() != null)
        .sorted(Comparator.comparing(Parking::getId))
        .toList();
}

@Override
public String getFirstAttribute(String name) {
    return switch (name) {
        case ATTR_PARKING_ID -> Optional.ofNullable(entity.getPrimaryParking()).map(Parking::getId).map(String::valueOf).orElse(null);
        case ATTR_TENANT_GROUP_ID -> Optional.ofNullable(entity.getPrimaryParking()).map(Parking::getGroupId).map(String::valueOf).orElse(null);
        default -> super.getFirstAttribute(name);
    };
}

@Override
public Stream<String> getAttributeStream(String name) {
    return switch (name) {
        case ATTR_PARKING_IDS -> entity.getAccessibleParkings().stream().map(parking -> parking.getId().toString());
        case ATTR_TENANT_GROUP_ID -> Optional.ofNullable(getFirstAttribute(ATTR_TENANT_GROUP_ID)).stream();
        default -> super.getAttributeStream(name);
    };
}
```

- [ ] **Step 4: Run provider tests**

Run: `cd sp-keycloak-uaa-provider && ./mvnw -q -ntp -Dtest=UserAdapterTest,MobileAccessAuthenticatorTest test`
Expected: PASS and both single-valued (`getFirstAttribute`) and multivalued (`getAttributeStream`) claim assertions stay green.

- [ ] **Step 5: Commit**

```bash
git -C sp-keycloak-uaa-provider add src/main/java src/main/resources/META-INF src/test/java
git -C sp-keycloak-uaa-provider commit -m "feat(keycloak): emit tenant group claims"
```

## Chunk 2: Customer Service Group Identity Core

### Task 4: Convert Customer Service Persistence To Group-Scoped Identity Plus Tenant Profiles

**Files:**

- Create: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/domain/CustomerTenantProfile.java`
- Create: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/repository/CustomerTenantProfileRepository.java`
- Modify: `customer/src/main/resources/config/liquibase/changelog/20250826152824_added_entity_Customer.xml`
- Modify: `customer/src/main/resources/config/liquibase/changelog/20250826152825_added_entity_IdentityLink.xml`
- Modify: `customer/src/main/resources/config/liquibase/changelog/20250827104800_added_constraints.xml`
- Modify: `customer/src/main/resources/config/liquibase/changelog/20260113090000_add_customer_profile_fields.xml`
- Modify: `customer/src/main/resources/config/liquibase/changelog/20260114090000_add_customer_merge_schema.xml`
- Modify: `customer/src/main/resources/config/liquibase/changelog/20260119120000_add_customer_email_change.xml`
- Modify: `customer/src/main/resources/config/liquibase/changelog/20260123090000_add_customer_activity_metrics.xml`
- Create: `customer/src/main/resources/config/liquibase/changelog/20260311120000_add_group_customer_model.xml`
- Modify: `customer/src/main/resources/config/liquibase/master.xml`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/domain/Customer.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/domain/IdentityLink.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/domain/ConsentEvent.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/domain/CustomerBookingLink.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/domain/PrivacyRequest.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/repository/CustomerRepository.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/repository/IdentityLinkRepository.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/mapper/CustomerMapper.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/dto/CustomerDTO.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/repository/CustomerRepositoryTest.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/repository/IdentityLinkRepositoryTest.java`

**Error handling:**

- Liquibase `master.xml` already replays the full history on empty databases, so rewrite the historical `customer` / `identity_link` bootstrap changelogs that currently create parking-scoped root identity. Do not rely on a late `20260311120000_add_group_customer_model.xml` rename/backfill sequence for greenfield correctness.
- If a local dev database already ran the old Liquibase history, reset that schema and rerun from empty rather than introducing compatibility rename/backfill changeSets just to preserve old checksums.
- Repository lookups must remain deterministic after uniqueness moves from parking scope to group scope.

**Edge cases:**

- Same email can exist in different groups; uniqueness must only hold inside one group.
- Same provider/external ID can exist in different groups; uniqueness must only hold inside one group.
- Tenant-profile rows must allow sparse data for first-login creation.
- Historical add-column changelogs currently place `newsletter_opt_in`, `custom_attributes`, and `internal_note` on `customer`; rewrite that history so fresh databases never put tenant-only fields on the root row.
- Historical tables such as `customer_email_history` and `customer_merge` currently carry `parking_id`; switch them to `group_id` only where the business record is now group-scoped, while leaving tenant-context tables like `consent_event`, `privacy_request`, `customer_booking_link`, and booking metrics tenant-scoped.

**Verification criteria:**

- `customer` uniqueness is `(group_id, primary_email)`.
- `identity_link` uniqueness is `(group_id, provider, external_id)`.
- Tenant-specific fields no longer live on the root `customer` row.
- A fresh empty database built from the full Liquibase history creates `customer.group_id` and `identity_link.group_id` directly; the historical bootstrap no longer creates parking-scoped root columns first.

- [ ] **Step 1: Write the failing repository/schema tests**

```java
@Test
void allowsSameEmailAcrossDifferentGroups() {
    customerRepository.saveAndFlush(new Customer().groupId(9L).primaryEmail("alice@example.com"));
    customerRepository.saveAndFlush(new Customer().groupId(10L).primaryEmail("alice@example.com"));

    assertThat(customerRepository.findAll()).hasSize(2);
}

@Test
void rejectsDuplicateIdentityInSameGroup() {
    Customer customer = customerRepository.saveAndFlush(new Customer().groupId(9L).primaryEmail("alice@example.com"));
    identityLinkRepository.saveAndFlush(
        new IdentityLink().groupId(9L).customer(customer).provider(IdentityProvider.FIREBASE).externalId("UID-1").email("alice@example.com")
    );

    assertThatThrownBy(() ->
        identityLinkRepository.saveAndFlush(
            new IdentityLink().groupId(9L).customer(customer).provider(IdentityProvider.FIREBASE).externalId("UID-1").email("alice@example.com")
        )
    ).isInstanceOf(DataIntegrityViolationException.class);
}

@Test
void freshLiquibaseBootstrapCreatesGroupColumnsAndNoTenantOnlyRootFields() {
    List<String> customerColumns = jdbcTemplate.queryForList(
        "select column_name from information_schema.columns where table_name = 'customer'",
        String.class
    );
    List<String> identityLinkColumns = jdbcTemplate.queryForList(
        "select column_name from information_schema.columns where table_name = 'identity_link'",
        String.class
    );

    assertThat(customerColumns).contains("group_id").doesNotContain("parking_id", "newsletter_opt_in", "custom_attributes", "internal_note");
    assertThat(identityLinkColumns).contains("group_id").doesNotContain("parking_id");
}
```

- [ ] **Step 2: Run tests to verify they fail**

Run: `cd customer && ./mvnw -q -ntp -Dspotless.apply.skip=true -Djacoco.skip=true -Dspring-boot.build-info.skip=true -Dtest=CustomerRepositoryTest,IdentityLinkRepositoryTest test`
Expected: FAIL because repositories, historical Liquibase bootstrap files, and uniqueness constraints are still parking-scoped.

- [ ] **Step 3: Implement the schema/model split and rewrite the historical Liquibase bootstrap**

```xml
<createTable tableName="customer">
    <column name="id" type="bigint" autoIncrement="true" startWith="1500">
        <constraints primaryKey="true" nullable="false"/>
    </column>
    <column name="group_id" type="bigint">
        <constraints nullable="false"/>
    </column>
    <column name="primary_email" type="varchar(255)">
        <constraints nullable="false"/>
    </column>
</createTable>

<createTable tableName="identity_link">
    <column name="id" type="bigint" autoIncrement="true" startWith="1500">
        <constraints primaryKey="true" nullable="false"/>
    </column>
    <column name="group_id" type="bigint">
        <constraints nullable="false"/>
    </column>
    <column name="provider" type="varchar(255)">
        <constraints nullable="false"/>
    </column>
    <column name="external_id" type="varchar(255)">
        <constraints nullable="false"/>
    </column>
</createTable>

<addUniqueConstraint tableName="customer"
    columnNames="group_id, primary_email"
    constraintName="uk_customer_group_email"/>

<addUniqueConstraint tableName="identity_link"
    columnNames="group_id, provider, external_id"
    constraintName="uk_identity_group_provider_ext"/>
```

Apply the same greenfield rewrite pattern to the later historical changelogs that currently make root identity parking-scoped:

- In `20260113090000_add_customer_profile_fields.xml`, stop adding `newsletter_opt_in`, `custom_attributes`, and similar tenant-only fields to `customer`; create or extend `customer_tenant_profile` instead.
- In `20260114090000_add_customer_merge_schema.xml`, switch canonical merge-history columns and indexes from `parking_id` to `group_id` so `customer_merge` records group-scoped identity operations from the start.
- In `20260119120000_add_customer_email_change.xml`, create `customer_email_history` with `group_id` for greenfield databases because email identity is group-scoped.
- In `20260123090000_add_customer_activity_metrics.xml`, leave metrics and contribution tables tenant-scoped, but stop reintroducing tenant-only columns on `customer`.

```java
@Column(name = "group_id", nullable = false)
private Long groupId;

@Entity
@Table(
    name = "customer_tenant_profile",
    uniqueConstraints = @UniqueConstraint(name = "uk_customer_tenant_profile_customer_tenant", columnNames = { "customer_id", "tenant_id" })
)
public class CustomerTenantProfile {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(optional = false)
    @JoinColumn(name = "customer_id", nullable = false)
    private Customer customer;

    @Column(name = "tenant_id", nullable = false)
    private Long tenantId;
}
```

- [ ] **Step 4: Run focused persistence tests**

Run: `cd customer && ./mvnw -q -ntp -Dspotless.apply.skip=true -Djacoco.skip=true -Dspring-boot.build-info.skip=true -Dtest=CustomerRepositoryTest,IdentityLinkRepositoryTest test`
Expected: PASS and the empty test schema is created from the rewritten Liquibase history with group-scoped root identity tables.

- [ ] **Step 5: Commit**

```bash
git -C customer add src/main/java/fr/gamarsoft/solutionpark/customer/domain src/main/java/fr/gamarsoft/solutionpark/customer/repository src/main/java/fr/gamarsoft/solutionpark/customer/service/mapper src/main/java/fr/gamarsoft/solutionpark/customer/service/dto src/main/resources/config/liquibase src/test/java/fr/gamarsoft/solutionpark/customer/repository
git -C customer commit -m "feat(customer): add group-scoped customer schema"
```

### Task 5: Extend Tenant Registry, Signed State, And Code Store For `groupId`

**Files:**

- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/client/uaa/UaaProxy.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/tenant/TenantRegistry.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/tenant/SimpleTenantRegistry.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/security/StatePayload.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/code/BoundIdentity.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/code/RedisCodeStore.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/StateController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AuthExchangeController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/dto/ConsumeRes.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/code/RedisCodeStoreConcurrencyIT.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/tenant/SimpleTenantRegistryTest.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/StateControllerIT.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/AuthExchangeControllerIT.java`

**Error handling:**

- Treat ambiguous origin mappings as security failures, same as today.
- Keep additive code-store serialization so already-minted codes expire naturally during rollout.
- Reject state/consume flows when `groupId` cannot be resolved.

**Edge cases:**

- Dev `http://localhost` and `.ddev.site` normalization rules must remain intact.
- Mixed deployment window: old codes without `groupId` may still exist for up to TTL; rollout order should deploy Customer Service atomically enough to avoid cross-version code use.
- `tenantId` mismatch remains enforced after adding `groupId`.

**Verification criteria:**

- `/auth/state/init` signs a payload containing `groupId`.
- `/auth/exchange/bootstrap` stores `groupCustomerId` and `groupId` in Redis.
- `/auth/exchange/consume` returns `{ firebaseUid, email, returnUrl, groupCustomerId, groupId }`.

- [ ] **Step 1: Write the failing tests**

```java
@Test
void resolveGroupId_shouldReturnMatchingGroupId() {
    when(uaaProxy.getTenantOrigins()).thenReturn(List.of(new TenantOriginGroupDTO("https://tenant.example", 101L, 7L)));

    assertThat(tenantRegistry.resolveGroupId("https://tenant.example")).isEqualTo(7L);
}

@Test
void initStateIncludesResolvedGroupId() throws Exception {
    when(uaaProxy.getTenantOrigins()).thenReturn(List.of(new TenantOriginGroupDTO("https://tenant.example", 101L, 7L)));

    String response = mockMvc
        .perform(post("/auth/state/init").contentType(MediaType.APPLICATION_JSON).content("""
            {"tenantOrigin":"https://tenant.example","tenantId":101,"returnUrl":"/mon-compte"}
            """))
        .andExpect(status().isOk())
        .andReturn()
        .getResponse()
        .getContentAsString();

    String state = objectMapper.readTree(response).get("state").asText();
    assertThat(hmacStateService.verify(state).groupId()).isEqualTo(7L);
}

@Test
void consumeReturnsGroupCustomerIdAndGroupId() throws Exception {
    when(codeStore.consume("code-123")).thenReturn(
        new BoundIdentity("https://tenant.example", "/mon-compte", "UID-1", "alice@example.com", 1500L, 7L)
    );

    mockMvc
        .perform(post("/auth/exchange/consume").contentType(MediaType.APPLICATION_JSON).content("""
            {"code":"code-123"}
            """))
        .andExpect(status().isOk())
        .andExpect(jsonPath("$.groupCustomerId").value(1500))
        .andExpect(jsonPath("$.groupId").value(7));
}

@Test
void bootstrapMintsCodeWithGroupAwareIdentity() throws Exception {
    String state = buildStateToken("/my-account");
    when(codeStore.mint(any(BoundIdentity.class))).thenReturn("code-123");
    when(firebaseTokenVerifier.verify("id.token.value")).thenReturn(new Decoded("uid-123", "user@example.com", true));
    when(customerIdentityService.ensureLinked(any(), any(), any(), any(), any(), any(), any())).thenReturn(sampleCustomer());

    mockMvc
        .perform(post("/auth/exchange/bootstrap").contentType(MediaType.APPLICATION_JSON).content("""
            {"idToken":"id.token.value","state":"%s"}
            """.formatted(state)))
        .andExpect(status().isOk());

    ArgumentCaptor<BoundIdentity> identityCaptor = ArgumentCaptor.forClass(BoundIdentity.class);
    verify(codeStore).mint(identityCaptor.capture());
    BoundIdentity bound = identityCaptor.getValue();
    assertThat(bound.groupCustomerId()).isEqualTo(1500L);
    assertThat(bound.groupId()).isEqualTo(7L);
}

@Test
void redisCodeStoreRoundTripsGroupAwareIdentityAdditively() {
    String code = redisCodeStore.mint(new BoundIdentity("https://tenant.example", "/mon-compte", "UID-1", "alice@example.com", 1500L, 7L));

    BoundIdentity bound = redisCodeStore.consume(code);

    assertThat(bound.groupCustomerId()).isEqualTo(1500L);
    assertThat(bound.groupId()).isEqualTo(7L);
}
```

- [ ] **Step 2: Run tests to verify they fail**

Run: `cd customer && ./mvnw -q -ntp -Dspotless.apply.skip=true -Djacoco.skip=true -Dspring-boot.build-info.skip=true -Dtest=RedisCodeStoreConcurrencyIT,SimpleTenantRegistryTest,StateControllerIT,AuthExchangeControllerIT test`
Expected: FAIL because `groupId` is not part of the contract yet.

- [ ] **Step 3: Implement the registry/state/code changes**

```java
@RequestMapping(method = RequestMethod.GET, value = "/api/tenant-registry/origins")
@ResponseBody
List<TenantOriginGroupDTO> getTenantOrigins();

public record StatePayload(
    String tenantOrigin,
    Long tenantId,
    Long groupId,
    String returnUrl,
    long iat,
    long exp,
    String nonce,
    StatePurpose purpose
) {}

public interface TenantRegistry {
    void validateOrigin(String tenantOrigin);
    String normalizeOrigin(String tenantOrigin);
    Long resolveTenantId(String tenantOrigin);
    Long resolveGroupId(String tenantOrigin);
}

public record BoundIdentity(String tenantOrigin, String returnUrl, String uid, String email, Long groupCustomerId, Long groupId) {}
```

- [ ] **Step 4: Run focused tests**

Run: `cd customer && ./mvnw -q -ntp -Dspotless.apply.skip=true -Djacoco.skip=true -Dspring-boot.build-info.skip=true -Dtest=RedisCodeStoreConcurrencyIT,SimpleTenantRegistryTest,StateControllerIT,AuthExchangeControllerIT test`
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git -C customer add src/main/java/fr/gamarsoft/solutionpark/customer/client/uaa src/main/java/fr/gamarsoft/solutionpark/customer/tenant src/main/java/fr/gamarsoft/solutionpark/customer/security src/main/java/fr/gamarsoft/solutionpark/customer/code src/main/java/fr/gamarsoft/solutionpark/customer/web src/test/java/fr/gamarsoft/solutionpark/customer/tenant src/test/java/fr/gamarsoft/solutionpark/customer/web/rest
git -C customer commit -m "feat(customer): add group-aware auth registry state"
```

### Task 6: Rewrite Identity Linking, Outbox, Merge, Privacy, And Backfill Around `groupCustomerId`

**Files:**

- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/CustomerIdentityService.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/CustomerEmailChangeService.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/PrivacyWorkflowService.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/CustomerMergeService.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/BookingBackfillService.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/BookingLinkService.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/OutboxEventService.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/OutboxRelay.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/OutboxRealtimeRelay.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/service/CustomerIdentityServiceTest.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/service/BookingBackfillServiceIT.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/service/CustomerMergeServiceIT.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/CustomerPrivacyControllerIT.java`

**Error handling:**

- Continue handling unique-constraint races in `ensureLinked`.
- Keep email-change reconciliation FIREBASE-only.
- Privacy delete/export must fail closed on cross-group access.

**Edge cases:**

- First login creates both the group customer and the tenant profile.
- Existing group customer logs into a new tenant in the same group and gets only a new tenant profile row.
- Booking backfill remains tenant-scoped but resolves/creates customers by `groupId`.
- GDPR delete is group-wide even when consent data remains tenant-scoped.

**Verification criteria:**

- `ensureLinked(groupId, provider, externalId, email, given, family, tenantId, idempotencyKey)` is idempotent.
- Outbox payloads contain `groupId` and keep tenant context where needed.
- Merge/unmerge preserve tenant profiles.
- Privacy export/delete work across all tenants in the group.

- [ ] **Step 1: Write the failing service tests**

```java
@Test
void ensureLinkedCreatesTenantProfileForNewTenant() {
    when(identityLinkRepository.findByGroupIdAndProviderAndExternalId(7L, IdentityProvider.FIREBASE, "UID-1")).thenReturn(Optional.empty());
    when(customerRepository.findByGroupIdAndPrimaryEmail(7L, "alice@example.com")).thenReturn(Optional.of(new Customer().id(1500L).groupId(7L)));

    customerIdentityService.ensureLinked(7L, IdentityProvider.FIREBASE, "UID-1", "alice@example.com", "Alice", "Doe", 101L, null);

    verify(customerTenantProfileRepository).save(any(CustomerTenantProfile.class));
}

@Test
void ensureLinkedWritesGroupAwareOutboxPayload() {
    when(identityLinkRepository.findByGroupIdAndProviderAndExternalId(7L, IdentityProvider.FIREBASE, "UID-1")).thenReturn(Optional.empty());
    when(customerRepository.findByGroupIdAndPrimaryEmail(7L, "alice@example.com")).thenReturn(Optional.empty());
    when(customerRepository.saveAndFlush(any(Customer.class))).thenAnswer(invocation -> {
        Customer customer = invocation.getArgument(0);
        customer.setId(1500L);
        return customer;
    });

    customerIdentityService.ensureLinked(7L, IdentityProvider.FIREBASE, "UID-1", "alice@example.com", "Alice", "Doe", 101L, "idem-1");

    verify(outboxEventService).write(
        eq(101L),
        eq("customer"),
        eq("1500"),
        eq("identity.linked.v1"),
        argThat(payload -> payload.contains("\"groupId\":7") && payload.contains("\"tenantId\":101")),
        eq("g:7:c:1500:t:101"),
        eq("idem-1")
    );
}

@Test
void mergeAndUnmergePreserveTenantProfiles() {
    Customer primary = customerRepository.saveAndFlush(new Customer().groupId(7L).primaryEmail("primary@example.com"));
    Customer secondary = customerRepository.saveAndFlush(new Customer().groupId(7L).primaryEmail("secondary@example.com"));
    customerTenantProfileRepository.saveAndFlush(new CustomerTenantProfile().customer(secondary).tenantId(101L));
    customerTenantProfileRepository.saveAndFlush(new CustomerTenantProfile().customer(secondary).tenantId(102L));

    CustomerMergeRes merge = customerMergeService.merge(7L, primary.getId(), secondary.getId(), CustomerMergeReasonCode.EMAIL_REUSE, "support", "admin");
    customerMergeService.unmerge(7L, merge.mergeId(), "admin");

    assertThat(customerTenantProfileRepository.findAllByCustomerId(secondary.getId())).extracting(CustomerTenantProfile::getTenantId)
        .containsExactlyInAnyOrder(101L, 102L);
}

@Test
void bookingBackfillStillWritesTenantScopedLinksForGroupScopedCustomers() {
    bookingBackfillService.startRun(101L);

    when(bookingSnapshotsClient.getBookingSnapshots(101L, 0L, 2)).thenReturn(List.of(
        new BookingCustomerSnapshotDTO(
            101L,
            55L,
            ZonedDateTime.parse("2026-03-11T10:00:00Z"),
            ZonedDateTime.parse("2026-03-11T10:00:00Z"),
            ZonedDateTime.parse("2026-03-12T10:00:00Z"),
            false,
            new BigDecimal("100.00"),
            new BigDecimal("100.00"),
            Instant.parse("2026-03-11T10:05:00Z"),
            "alice@example.com",
            null,
            "Alice",
            "Doe",
            null
        )
    ));

    bookingBackfillService.processNextPage(101L);

    verify(bookingLinkService).link(argThat(snapshot -> snapshot.parkingId().equals(101L) && snapshot.email().equals("alice@example.com")), eq(BookingLinkSource.BACKFILL));
}

@Test
void privacyDeleteErasesEntireGroupIdentity() throws Exception {
    mockMvc.perform(post("/api/customer/privacy/delete").header("X-Parking-Id", "101")).andExpect(status().isNoContent());
    assertThat(customerRepository.findById(1500L)).get().extracting(Customer::getErasedAt).isNotNull();
}
```

- [ ] **Step 2: Run tests to verify they fail**

Run: `cd customer && ./mvnw -q -ntp -Dspotless.apply.skip=true -Djacoco.skip=true -Dspring-boot.build-info.skip=true -Dtest=CustomerIdentityServiceTest,BookingBackfillServiceIT,CustomerMergeServiceIT,CustomerPrivacyControllerIT test`
Expected: FAIL because the service layer still assumes parking-scoped customers.

- [ ] **Step 3: Implement the service rewrite**

```java
public CustomerDTO ensureLinked(
    Long groupId,
    IdentityProvider provider,
    String externalId,
    String email,
    @Nullable String given,
    @Nullable String family,
    Long tenantId,
    @Nullable String idempotencyKey
) {
    String linkIdem = deriveLinkIdem(groupId, provider, externalId);
    String effectiveIdem = (idempotencyKey != null && !idempotencyKey.isBlank())
        ? idempotencyKey
        : "g:%d:%s".formatted(groupId, linkIdem);

    Customer customer = identityLinkRepository.findByGroupIdAndProviderAndExternalId(groupId, provider, externalId)
        .map(IdentityLink::getCustomer)
        .orElseGet(() -> findOrCreateGroupCustomer(groupId, email, given, family));

    try {
        identityLinkRepository.saveAndFlush(
            new IdentityLink().groupId(groupId).customer(customer).provider(provider).externalId(externalId).email(email).linkedAt(Instant.now())
        );
    } catch (DataIntegrityViolationException ignored) {
        customer = identityLinkRepository.findByGroupIdAndProviderAndExternalId(groupId, provider, externalId)
            .map(IdentityLink::getCustomer)
            .orElse(customer);
    }

    customerTenantProfileRepository.findByCustomerIdAndTenantId(customer.getId(), tenantId).orElseGet(() ->
        customerTenantProfileRepository.save(new CustomerTenantProfile().customer(customer).tenantId(tenantId))
    );

    if (provider == IdentityProvider.FIREBASE) {
        customerEmailChangeService.applyEmailChange(groupId, externalId, email, null, Instant.now());
    }

    writeOutbox(
        tenantId,
        customer.getId(),
        "identity.linked.v1",
        Map.of("groupId", groupId, "tenantId", tenantId, "groupCustomerId", customer.getId(), "provider", provider.name(), "externalId", externalId),
        effectiveIdem
    );

    return customerMapper.toDto(customer);
}
```

Also update the adjacent workflow services in the same step:

- `CustomerMergeService` must move and restore `CustomerTenantProfile` rows alongside identity links and vehicles so merge/unmerge keeps tenant membership intact.
- `BookingLinkService` and `BookingBackfillService` must continue writing tenant-scoped booking links and metrics, but resolve/create the underlying customer through `groupId` first.
- `PrivacyWorkflowService` must export and erase the shared customer plus all tenant profiles in the caller's group, while rejecting cross-group access.

- [ ] **Step 4: Run focused service tests**

Run: `cd customer && ./mvnw -q -ntp -Dspotless.apply.skip=true -Djacoco.skip=true -Dspring-boot.build-info.skip=true -Dtest=CustomerIdentityServiceTest,BookingBackfillServiceIT,CustomerMergeServiceIT,CustomerPrivacyControllerIT test`
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git -C customer add src/main/java/fr/gamarsoft/solutionpark/customer/service src/test/java/fr/gamarsoft/solutionpark/customer/service src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/CustomerPrivacyControllerIT.java
git -C customer commit -m "feat(customer): switch identity workflows to group scope"
```

## Chunk 3: Customer API Surface, Gateway, And WordPress Bridge

### Task 7: Update Public, Self-Service, And Admin Customer APIs For Group Scoping

**Files:**

- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/config/SecurityConfiguration.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/security/SecurityUtils.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/interceptor/ParkingInterceptor.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/PublicIdentityController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/PublicCustomerProfileController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/CustomerProfileController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/CustomerConsentController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/EmailStatusController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/EmailChangeController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminCustomerController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminCustomerProfileController.java`
- Create: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminCustomerTenantController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminCustomerMergeController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminBookingLinkController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminBookingBackfillController.java`
- Modify: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminPrivacyController.java`
- Create: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/CustomerTenantProfileService.java`
- Create: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/dto/AdminCustomerSharedProfileDTO.java`
- Create: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/service/dto/AdminCustomerTenantProfileDTO.java`
- Delete: `customer/src/main/java/fr/gamarsoft/solutionpark/customer/web/rest/CustomerResource.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/PublicIdentityControllerIT.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/PublicIdentityControllerParkingIsolationIT.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/PublicCustomerProfileControllerIT.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminCustomerControllerIT.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminCustomerProfileControllerIT.java`
- Create: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminCustomerTenantControllerIT.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/CustomerProfileControllerIT.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/CustomerConsentControllerIT.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/EmailStatusControllerTest.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/EmailChangeControllerTest.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminBookingLinkControllerIT.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminBookingBackfillControllerIT.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/CustomerPrivacyControllerIT.java`
- Create: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/AdminPrivacyControllerIT.java`
- Test: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/security/SecurityUtilsUnitTest.java`
- Delete: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/CustomerResourceIT.java`
- Modify: `customer/src/test/java/fr/gamarsoft/solutionpark/customer/web/rest/IdentityLinkResourceIT.java`

**Error handling:**

- Admin endpoints must allow any authenticated Keycloak user through the security filter, then reject only on business-scoping checks.
- Tenant-specific admin calls must reject missing or unauthorized `X-Parking-Id`.
- Removing `CustomerResource` must not orphan any frontend usage; verify no callers remain before deletion.

**Edge cases:**

- `ROLE_DIRECTION` may carry multiple `parking_ids`; tenant-specific admin actions must enforce the requested tenant against that list.
- `ROLE_ADMIN` / `ROLE_INTERNAL` bypass tenant restrictions but still need group validation where applicable.
- Self-service flows still resolve tenant context from `X-Parking-Id`, not from the token.

**Verification criteria:**

- `/api/admin/**` is the only operator surface for Customer Service.
- Generic JHipster `/api/customers` CRUD is gone.
- Customer search/profile/admin operations are group-scoped, while tenant notes/consent stay tenant-scoped.
- New admin subresources exist for shared profile, tenant profiles, tenant consent, tenant listing, cross-tenant booking links, and `DELETE /api/admin/customers/{id}`.

- [ ] **Step 1: Write the failing controller/security tests**

```java
@Test
void adminSearchScopesByTenantGroupIdNotControllerRoleCheck() throws Exception {
    mockMvc
        .perform(
            get("/api/admin/customers")
                .param("email", "alice@example.com")
                .header("X-Parking-Id", "101")
                .with(jwt().jwt(jwt -> jwt.claim("parking_id", 101L).claim("tenant_group_id", 7L).claim("groups", List.of("ROLE_DIRECTION"))))
        )
        .andExpect(status().isOk())
        .andExpect(jsonPath("$.[0].groupId").value(7));
}

@Test
void extractParkingIdsFromClaimsReturnsAllowedTenantIds() {
    Jwt jwt = Jwt.withTokenValue("token")
        .header("alg", "none")
        .claim("parking_id", 101L)
        .claim("parking_ids", List.of(101L, 102L))
        .claim("tenant_group_id", 7L)
        .claim("groups", List.of("ROLE_DIRECTION"))
        .build();

    assertThat(SecurityUtils.extractParkingIdsFromClaims(jwt.getClaims())).containsExactly(101L, 102L);
}

@Test
void customerProfileUsesRequestedTenantButReturnsGroupScopedIdentity() throws Exception {
    mockMvc
        .perform(get("/api/customer/profile").header("X-Parking-Id", "101").with(jwt().jwt(jwt -> jwt.claim("tenant_group_id", 7L))))
        .andExpect(status().isOk())
        .andExpect(jsonPath("$.groupId").value(7));
}

@Test
void adminDeleteRejectsCrossGroupAccess() throws Exception {
    mockMvc
        .perform(
            delete("/api/admin/customers/{id}", 1500L)
                .header("X-Parking-Id", "101")
                .with(jwt().jwt(jwt -> jwt.claim("parking_ids", List.of(101L)).claim("tenant_group_id", 7L).claim("groups", List.of("ROLE_DIRECTION"))))
        )
        .andExpect(status().isForbidden());
}
```

- [ ] **Step 2: Run tests to verify they fail**

Run: `cd customer && ./mvnw -q -ntp -Dspotless.apply.skip=true -Djacoco.skip=true -Dspring-boot.build-info.skip=true -Dtest=PublicIdentityControllerIT,PublicIdentityControllerParkingIsolationIT,PublicCustomerProfileControllerIT,CustomerProfileControllerIT,CustomerConsentControllerIT,EmailStatusControllerTest,EmailChangeControllerTest,AdminCustomerControllerIT,AdminCustomerProfileControllerIT,AdminCustomerTenantControllerIT,AdminBookingLinkControllerIT,AdminBookingBackfillControllerIT,CustomerPrivacyControllerIT,AdminPrivacyControllerIT,SecurityUtilsUnitTest test`
Expected: FAIL because controllers and security still assume parking-scoped records and role-gated admin access.

- [ ] **Step 3: Implement the API and authorization changes**

```java
.requestMatchers(mvc.pattern("/api/admin/**")).authenticated()

Long requestedTenantId = SecurityUtils.resolveRequestedTenantId(request);
Long callerGroupId = SecurityUtils.getCurrentUserTenantGroupId()
    .orElseThrow(() -> new ResponseStatusException(HttpStatus.FORBIDDEN, "missing tenant_group_id"));
Set<Long> allowedTenantIds = SecurityUtils.extractParkingIdsFromClaims(jwt.getClaims());
Customer customer = customerRepository.findById(id).orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND));
if (!Objects.equals(customer.getGroupId(), callerGroupId)) {
    throw new ResponseStatusException(HttpStatus.FORBIDDEN, "cross-group access denied");
}
if (!SecurityUtils.canAccessTenant(requestedTenantId, allowedTenantIds)) {
    throw new ResponseStatusException(HttpStatus.FORBIDDEN, "tenant not allowed");
}

// Delete CustomerResource and CustomerResourceIT in the same commit.
// Update IdentityLinkResourceIT to stop depending on CustomerResourceIT factory helpers before removing them.
```

- [ ] **Step 4: Run focused API tests**

Run: `cd customer && ./mvnw -q -ntp -Dspotless.apply.skip=true -Djacoco.skip=true -Dtest=PublicIdentityControllerIT,PublicIdentityControllerParkingIsolationIT,PublicCustomerProfileControllerIT,CustomerProfileControllerIT,CustomerConsentControllerIT,EmailStatusControllerTest,EmailChangeControllerTest,AdminCustomerControllerIT,AdminCustomerProfileControllerIT,AdminCustomerTenantControllerIT,AdminBookingLinkControllerIT,AdminBookingBackfillControllerIT,CustomerPrivacyControllerIT,AdminPrivacyControllerIT,SecurityUtilsUnitTest test`
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git -C customer add src/main/java/fr/gamarsoft/solutionpark/customer/config src/main/java/fr/gamarsoft/solutionpark/customer/security src/main/java/fr/gamarsoft/solutionpark/customer/web src/test/java/fr/gamarsoft/solutionpark/customer/web/rest src/test/java/fr/gamarsoft/solutionpark/customer/security
git -C customer commit -m "feat(customer): expose group-aware customer api surface"
```

### Task 8: Surface New Claims In Gateway And Update Dev Realm Export

**Files:**

- Modify: `gateway/src/main/java/fr/gamarsoft/solutionpark/gateway/security/SecurityUtils.java`
- Modify: `gateway/src/main/java/fr/gamarsoft/solutionpark/gateway/web/rest/AccountResource.java`
- Modify: `gateway/src/main/docker/realm-config/sp-realm.json`
- Test: `gateway/src/test/java/fr/gamarsoft/solutionpark/gateway/security/SecurityUtilsUnitTest.java`
- Test: `gateway/src/test/java/fr/gamarsoft/solutionpark/gateway/web/rest/AccountResourceIT.java`

**Error handling:**

- Missing new claims must degrade gracefully so older tokens do not break `/api/account`.
- Keep `parkingId` as the active tenant detail until UI switching work exists.

**Edge cases:**

- `parking_ids` may be absent for global roles.
- `tenant_group_id` may be absent on old dev tokens until the realm export is re-imported.
- `/api/account` must remain backward-compatible for consumers that only read `parkingId`; `parkingIds` and `tenantGroupId` are additive fields.

**Verification criteria:**

- `/api/account` includes `parkingId`, `parkingIds`, and `tenantGroupId` when present.
- No Angular changes are required for Phase 1.
- Dev realm export contains mappers for `parking_ids` and `tenant_group_id`.

- [ ] **Step 1: Write the failing tests**

```java
@Test
void extractDetailsIncludesParkingIdsAndTenantGroupId() {
    Map<String, Object> details = SecurityUtils.extractDetailsFromTokenAttributes(
        Map.of("parking_id", 101L, "parking_ids", List.of(101L, 102L), "tenant_group_id", 7L, "groups", List.of("ROLE_DIRECTION"), "sub", "jane")
    );

    assertThat(details.get("parkingId")).isEqualTo(101L);
    assertThat(details.get("parkingIds")).isEqualTo(List.of(101L, 102L));
    assertThat(details.get("tenantGroupId")).isEqualTo(7L);
}

@Test
void accountEndpointReturnsTenantGroupClaims() {
    claims.put("parking_id", 101L);
    claims.put("parking_ids", List.of(101L, 102L));
    claims.put("tenant_group_id", 7L);

    webTestClient
        .mutateWith(mockAuthentication(registerAuthenticationToken(authorizedClientService, clientRegistration, authenticationToken(claims))))
        .mutateWith(csrf())
        .get()
        .uri("/api/account")
        .exchange()
        .expectStatus()
        .isOk()
        .expectBody()
        .jsonPath("$.parkingId").isEqualTo(101)
        .jsonPath("$.parkingIds[0]").isEqualTo(101)
        .jsonPath("$.tenantGroupId").isEqualTo(7);
}
```

- [ ] **Step 2: Run tests to verify they fail**

Run: `cd gateway && ./mvnw -q -ntp -Dspotless.apply.skip=true -Djacoco.skip=true -Dspring-boot.build-info.skip=true -Dtest=SecurityUtilsUnitTest,AccountResourceIT test`
Expected: FAIL because only `parking_id` is extracted today.

- [ ] **Step 3: Implement the claim extraction and realm JSON changes**

```java
Object parkingIds = attributes.get("parking_ids");
details.put("parkingIds", parkingIds instanceof Collection<?> ? parkingIds : List.of());
details.put("tenantGroupId", attributes.get("tenant_group_id"));
```

```json
{
  "name": "Parking Ids",
  "protocol": "openid-connect",
  "protocolMapper": "oidc-usermodel-attribute-mapper",
  "config": {
    "user.attribute": "parkingIds",
    "claim.name": "parking_ids",
    "jsonType.label": "String",
    "multivalued": "true",
    "userinfo.token.claim": "true",
    "id.token.claim": "true",
    "access.token.claim": "true"
  }
}
```

```json
{
  "name": "Tenant Group Id",
  "protocol": "openid-connect",
  "protocolMapper": "oidc-usermodel-attribute-mapper",
  "config": {
    "user.attribute": "tenantGroupId",
    "claim.name": "tenant_group_id",
    "jsonType.label": "long",
    "userinfo.token.claim": "true",
    "id.token.claim": "true",
    "access.token.claim": "true"
  }
}
```

- [ ] **Step 4: Run focused gateway tests**

Run: `cd gateway && ./mvnw -q -ntp -Dspotless.apply.skip=true -Djacoco.skip=true -Dspring-boot.build-info.skip=true -Dtest=SecurityUtilsUnitTest,AccountResourceIT test`
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git -C gateway add src/main/java/fr/gamarsoft/solutionpark/gateway/security/SecurityUtils.java src/main/java/fr/gamarsoft/solutionpark/gateway/web/rest/AccountResource.java src/main/docker/realm-config/sp-realm.json src/test/java/fr/gamarsoft/solutionpark/gateway/security/SecurityUtilsUnitTest.java src/test/java/fr/gamarsoft/solutionpark/gateway/web/rest/AccountResourceIT.java
git -C gateway commit -m "feat(gateway): expose tenant group token claims"
```

### Task 9: Persist Group Metadata In The WordPress Bridge Without Changing Login Matching

**Files:**

- Modify: `solution-park-firebase-bridge/inc/class-auth-client.php`
- Modify: `solution-park-firebase-bridge/inc/class-receiver-route.php`
- Modify: `solution-park-firebase-bridge/inc/class-bridge-login.php`
- Modify: `solution-park-firebase-bridge/tests/bridge-login-email-update.php`
- Create: `solution-park-firebase-bridge/tests/bridge-login-group-meta.php`

**Error handling:**

- Older consume responses without `groupCustomerId` / `groupId` must still log users in.
- Invalid additive fields should be ignored rather than breaking the auth flow.

**Edge cases:**

- Existing users linked by `firebase_uid` should get fresh group meta on next login.
- Email fallback matching logic must stay unchanged; group metadata is not a lookup key.

**Verification criteria:**

- Bridge still logs in the user using `firebase_uid`.
- `group_customer_id` and `group_id` are written to user meta when present.
- Profile sync continues to use shared customer fields only.

- [ ] **Step 1: Write the failing PHP test**

```php
$consume = [
  'email' => 'new@example.com',
  'firebaseUid' => 'uid-123',
  'returnUrl' => '/mon-compte',
  'groupCustomerId' => 1500,
  'groupId' => 7,
];

$opts = SP_FB_Receiver_Route::build_login_options( $consume, SP_FB_Settings::get() );
$result = SP_FB_Bridge_Login::login( 'new@example.com', 'uid-123', $opts );

assert_true( $result === true, 'login should succeed' );
assert_true( $opts['group_customer_id'] === '1500', 'expected receiver helper to forward group_customer_id' );
assert_true( $opts['group_id'] === '7', 'expected receiver helper to forward group_id' );
assert_true( get_user_meta( 123, 'group_customer_id', true ) === '1500', 'expected group_customer_id meta' );
assert_true( get_user_meta( 123, 'group_id', true ) === '7', 'expected group_id meta' );
```

- [ ] **Step 2: Run test to verify it fails**

Run: `cd solution-park-firebase-bridge && docker run --rm -v "$PWD":/app -w /app php:8.2-cli php tests/bridge-login-group-meta.php`
Expected: FAIL because group metadata is not persisted.

- [ ] **Step 3: Implement additive consume handling**

```php
$opts = self::build_login_options( $res, $opts );
$ok = SP_FB_Bridge_Login::login( $email, $uid, $opts );
```

```php
public static function build_login_options( array $consume, array $opts ): array {
  $opts['group_customer_id'] = isset( $consume['groupCustomerId'] ) ? (string) $consume['groupCustomerId'] : '';
  $opts['group_id'] = isset( $consume['groupId'] ) ? (string) $consume['groupId'] : '';
  return $opts;
}

$group_customer_id = isset( $opts['group_customer_id'] ) ? (string) $opts['group_customer_id'] : '';
$group_id = isset( $opts['group_id'] ) ? (string) $opts['group_id'] : '';

if ( $group_customer_id !== '' ) {
  update_user_meta( $user->ID, 'group_customer_id', $group_customer_id );
}
if ( $group_id !== '' ) {
  update_user_meta( $user->ID, 'group_id', $group_id );
}
```

- [ ] **Step 4: Run focused bridge tests**

Run: `cd solution-park-firebase-bridge && docker run --rm -v "$PWD":/app -w /app php:8.2-cli php tests/bridge-login-email-update.php && docker run --rm -v "$PWD":/app -w /app php:8.2-cli php tests/bridge-login-group-meta.php`
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git -C solution-park-firebase-bridge add inc/class-auth-client.php inc/class-receiver-route.php inc/class-bridge-login.php tests/bridge-login-email-update.php tests/bridge-login-group-meta.php
git -C solution-park-firebase-bridge commit -m "feat(wp-bridge): persist group customer metadata"
```

## Chunk 4: Full Verification And Handoff

### Task 10: Run Cross-Repo Verification In Rollout Order

**Files:**

- Verify only; no new files required.
- Inspect: `.github/plan/crm-dashpark/00-roadmap.md`
- Inspect: `.github/plan/crm-dashpark/99-shipped.md`

**Error handling:**

- If any downstream repo fails after the model/UAA contract change, stop in that repo, fix the contract mismatch, and rerun the exact failing verification command before proceeding further.
- Treat failing integration tests as real regressions; do not paper over them by narrowing scope until behavior is explicitly understood.
- If the contract-smoke checks fail, fix the controller or bridge contract first, then rerun the exact Step 3 command before trusting the broader Step 2 suite.

**Edge cases:**

- Local Maven cache may still hold an old `model` artifact if Task 1 install was skipped.
- Existing Redis codes minted before the Customer Service rollout can expire naturally; do not attempt destructive cache cleanup.
- The roadmap check in this task validates the docs state created by this planning work: CRM-RM-037 stays in `00-roadmap.md` with design and implementation-plan links, and must not appear in `99-shipped.md` yet.

**Verification criteria:**

- All touched repos have their focused automated tests passing.
- Contract-smoke checks confirm the new auth payloads and WP metadata:
  - `AuthExchangeControllerIT` asserts `groupCustomerId` and `groupId` in `/auth/exchange/consume`.
  - `bridge-login-group-meta.php` asserts `group_customer_id` and `group_id` writes.
- Roadmap verification shows CRM-RM-037 in `.github/plan/crm-dashpark/00-roadmap.md` with its design and implementation-plan links while rollout is still in progress.

- [ ] **Step 1: Reinstall the shared model contract**

Run: `cd model && ./mvnw -q -ntp -Dspotless.apply.skip=true -Djacoco.skip=true -Dspring-boot.build-info.skip=true install`
Expected: PASS

- [ ] **Step 2: Run repo-focused automated tests**

Run: `cd uaa && ./mvnw -q -ntp -Dspotless.apply.skip=true -Djacoco.skip=true -Dspring-boot.build-info.skip=true -Dtest=ParkingResourceIT,TenantRegistryResourceIT,ParkingSettingsResourceIT test`
Expected: PASS

Run: `cd sp-keycloak-uaa-provider && ./mvnw -q -ntp -Dtest=UserAdapterTest,MobileAccessAuthenticatorTest test`
Expected: PASS

Run: `cd customer && ./mvnw -q -ntp -Dspotless.apply.skip=true -Djacoco.skip=true -Dspring-boot.build-info.skip=true -Dtest=CustomerRepositoryTest,IdentityLinkRepositoryTest,SimpleTenantRegistryTest,CustomerIdentityServiceTest,StateControllerIT,AuthExchangeControllerIT,PublicIdentityControllerIT,AdminCustomerControllerIT,AdminCustomerProfileControllerIT,AdminCustomerTenantControllerIT,CustomerPrivacyControllerIT,BookingBackfillServiceIT,CustomerMergeServiceIT,SecurityUtilsUnitTest test`
Expected: PASS

Run: `cd gateway && ./mvnw -q -ntp -Dspotless.apply.skip=true -Djacoco.skip=true -Dspring-boot.build-info.skip=true -Dtest=SecurityUtilsUnitTest,AccountResourceIT test`
Expected: PASS

Run: `cd solution-park-firebase-bridge && docker run --rm -v "$PWD":/app -w /app php:8.2-cli php tests/bridge-login-email-update.php && docker run --rm -v "$PWD":/app -w /app php:8.2-cli php tests/bridge-login-group-meta.php`
Expected: PASS

- [ ] **Step 3: Run contract-smoke checks for the new payload fields**

Run: `cd customer && ./mvnw -q -ntp -Dspotless.apply.skip=true -Djacoco.skip=true -Dspring-boot.build-info.skip=true -Dtest=StateControllerIT#initStateIncludesResolvedGroupId,AuthExchangeControllerIT#consumeReturnsGroupCustomerIdAndGroupId test`
Expected: PASS and the controller assertions prove `state` carries `groupId` and `/auth/exchange/consume` returns JSON fields `groupCustomerId` and `groupId`.

Run: `cd solution-park-firebase-bridge && docker run --rm -v "$PWD":/app -w /app php:8.2-cli php tests/bridge-login-group-meta.php`
Expected: PASS and the script proves `group_customer_id` and `group_id` are written to WordPress user meta.

- [ ] **Step 4: Confirm no verification artifacts were introduced by the checks**

Run: `if git -C uaa status --ignored --short | rg -q '(^.. |^!! )(target/|.*surefire-reports/|.*failsafe-reports/|.*\\.log$|.*\\.tmp$)'; then echo unexpected-artifacts; exit 1; else echo ok; fi`
Expected: `ok`

Run: `if git -C sp-keycloak-uaa-provider status --ignored --short | rg -q '(^.. |^!! )(target/|.*surefire-reports/|.*failsafe-reports/|.*\\.log$|.*\\.tmp$)'; then echo unexpected-artifacts; exit 1; else echo ok; fi`
Expected: `ok`

Run: `if git -C customer status --ignored --short | rg -q '(^.. |^!! )(target/|.*surefire-reports/|.*failsafe-reports/|coverage/|build/|dist/|.*\\.log$|.*\\.tmp$)'; then echo unexpected-artifacts; exit 1; else echo ok; fi`
Expected: `ok`

Run: `if git -C gateway status --ignored --short | rg -q '(^.. |^!! )(target/|.*surefire-reports/|.*failsafe-reports/|coverage/|build/|dist/|.*\\.log$|.*\\.tmp$)'; then echo unexpected-artifacts; exit 1; else echo ok; fi`
Expected: `ok`

Run: `if git -C solution-park-firebase-bridge status --ignored --short | rg -q '(^.. |^!! )(vendor/|build/|dist/|playwright-report/|.*\\.log$|.*\\.tmp$)'; then echo unexpected-artifacts; exit 1; else echo ok; fi`
Expected: `ok`

- [ ] **Step 5: Confirm roadmap status is still correct for the rollout stage**

Run: `heading_count=$(rg -n "^### CRM-RM-037" .github/plan/crm-dashpark/00-roadmap.md | wc -l | tr -d ' '); design_link_count=$(rg -n "crm-rm-037-tenant-groups-design.md" .github/plan/crm-dashpark/00-roadmap.md | wc -l | tr -d ' '); plan_link_count=$(rg -n "crm-rm-037-tenant-groups-implementation-plan.md" .github/plan/crm-dashpark/00-roadmap.md | wc -l | tr -d ' '); if [ "$heading_count" = "1" ] && [ "$design_link_count" = "1" ] && [ "$plan_link_count" = "1" ]; then echo ok; else echo roadmap-mismatch; exit 1; fi`
Expected: `ok`

Run: `if rg -q "^### CRM-RM-037" .github/plan/crm-dashpark/99-shipped.md; then echo already-shipped; exit 1; else echo rollout-only; fi`
Expected: `rollout-only`

## Implementation Notes For The Executor

- Prefer repo-by-repo commits exactly as laid out above; this feature spans submodules and should not be staged from the workspace root.
- Do not remove `parking_groupe` from UAA or the Keycloak/UAA provider in this feature. It becomes deprecated here; physical removal is follow-up work.
- Keep Customer Service event versions unchanged. The spec explicitly allows payload updates in pre-production lockstep.
- Keep Gateway UI behavior unchanged in Phase 1. Only backend claim extraction and dev realm config are in scope.
- Remove `customer`'s JHipster `CustomerResource` only after verifying no remaining callers via `rg "/api/customers" gateway customer`.
- When adding the new UAA endpoint, prefer returning normalized origins from the server side so Customer Service can keep its current ambiguity/error behavior without duplicating more normalization logic.
- `.github/plan/crm-dashpark/00-roadmap.md` already links this plan; move CRM-RM-037 to `.github/plan/crm-dashpark/99-shipped.md` only in the final rollout-complete docs commit.

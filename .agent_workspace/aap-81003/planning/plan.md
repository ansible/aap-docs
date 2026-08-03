# Documentation Plan

**Project**: Update custom TLS certificate guidance to reflect mesh-CA.crt behavior change in containerized installer
**Date**: 2026-06-30
**Ticket**: [AAP-81003](https://redhat.atlassian.net/browse/AAP-81003)

## What is the support status of the feature(s) being used to complete the user's JTBD (Job To Be Done)?

General Availability. The behavior change was merged to stable-2.6 (as an async update) and stable-2.7 branches. The containerized installer is GA in both AAP 2.6 and 2.7.

## Why is this content important?

The containerized installer changed how it populates the receptor mesh trust bundle (mesh-CA.crt). Customers using custom CA certificates will experience different behavior after upgrading: `custom_ca_cert` is no longer unconditionally bundled into mesh-CA.crt. Without updated documentation, customers cannot determine which certificate configuration approach applies to their deployment, cannot diagnose new preflight validation errors, and may misconfigure their receptor mesh trust chain. This behavior change resolves a production-impacting bug (CRYPTO_BUFFER_EXCEEDED) that broke receptor connectivity for customers with large enterprise CA chains, but introduces a new prerequisite (receptor_tls_cert requires custom_ca_cert) that must be documented to prevent upgrade failures.

## Who is the target persona(s)?

* SysAdmin: Primary user who configures TLS certificates, manages the AAP containerized deployment inventory, and troubleshoots receptor mesh connectivity issues.
* IT Operations Leader: Responsible for TLS/PKI policy decisions, including whether to use an enterprise CA vs. installer-generated certificates for the AAP deployment.

## What is the main JTBD? What user goal is being accomplished? What pain point is being avoided?

**Job 1 (SysAdmin — Configure):**
When I am deploying or upgrading a containerized AAP installation that uses custom TLS certificates, I want to configure the correct inventory variables so that my receptor mesh trust chain is established correctly and all nodes can communicate, while avoiding CRYPTO_BUFFER_EXCEEDED errors that break receptor connectivity or preflight validation failures that halt the installer.

**Job 2 (SysAdmin — Troubleshoot):**
When my receptor mesh connectivity fails after an upgrade or configuration change, I want to identify the root cause and correct my certificate configuration so that I can restore receptor communication across all nodes, while avoiding trial-and-error debugging of certificate bundle issues.

## How does the JTBD(s) relate to the overall real-world workflow for the user?

These jobs fit into the AAP containerized installation and upgrade lifecycle:

1. **Plan** — The IT Operations Leader or SysAdmin decides on a TLS strategy: use installer-generated self-signed certificates, provide an enterprise CA for the installer to use, or supply pre-signed receptor certificates.
2. **Configure** — The SysAdmin sets inventory variables (`custom_ca_cert`, `ca_tls_cert`, `ca_tls_key`, `receptor_tls_cert`) based on the chosen strategy. **This is where Job 1 sits.** The decision table in the new concept module helps the SysAdmin select the right variable combination.
3. **Deploy/Upgrade** — The SysAdmin runs the containerized installer. If the configuration is incorrect, the new preflight validation catches the error before deployment proceeds.
4. **Operate** — The deployment runs in production. If receptor connectivity fails, the SysAdmin needs to troubleshoot. **This is where Job 2 sits.** The updated troubleshooting module provides the root cause (QUIC buffer limit) and links back to the configuration guidance.
5. **Maintain** — After upgrading from a previous version where `custom_ca_cert` was always bundled into mesh-CA.crt, the SysAdmin must understand the behavior change and adjust configuration if needed.

## What high-level steps does the user need to take to accomplish the goal?

**For Job 1 (Configure custom TLS certificates for receptor mesh):**

1. **Prerequisites**: Access to the AAP containerized installer inventory file; TLS certificates and CA certificates available on the installer host or remote nodes.
2. **Determine which scenario applies**: Consult the mesh-CA.crt scenarios decision table to identify whether you are using Scenario 1 (default), Scenario 2 (enterprise CA), or Scenario 3 (pre-signed receptor certs).
3. **Set the appropriate inventory variables**: Configure `ca_tls_cert`+`ca_tls_key` for Scenario 2 (recommended) or `receptor_tls_cert`+`custom_ca_cert` for Scenario 3 (advanced).
4. **Run the installer**: The preflight validation will check for correct variable combinations before proceeding.
5. **Verify**: Confirm receptor connectivity across mesh nodes.

**For Job 2 (Troubleshoot receptor mesh connectivity):**

1. **Identify symptoms**: CRYPTO_BUFFER_EXCEEDED errors in receptor logs, or receptor nodes unable to establish mesh connections.
2. **Check mesh-CA.crt size**: Inspect the mesh-CA.crt file for excessive certificates (>10) or total size exceeding ~16 KB.
3. **Determine root cause**: The QUIC crypto buffer has a ~16 KB limit; large CA bundles in mesh-CA.crt exceed this limit.
4. **Apply fix**: Re-run the installer with corrected inventory variables (move to Scenario 2 if possible), or manually trim the mesh-CA.crt bundle.

## Is there a demo available or can one be created?

No

## Are there special considerations for disconnected environments?

No. The certificate configuration behavior is identical in connected and disconnected (bundled) installations. The mesh-CA.crt population logic is determined solely by inventory variables, not network connectivity.

## Who can provide information and answer questions?

* **PM / Reporter**: See AAP-81003 assignee and reporter fields
* **Technical SME**: The author of MR !1088 (containerized installer changes to mesh-CA.crt.j2 and preflight/tasks/nodes.yml)
* **Related engineering**: AAP-70677 assignee (receptor CA bundle size fix), AAP-51480 epic owner (Receptor CA Bundle Optimizations)

## Release Note needed?

Yes

Draft release note: The containerized installer no longer unconditionally bundles the `custom_ca_cert` certificate into the receptor mesh trust bundle (`mesh-CA.crt`). This change resolves CRYPTO_BUFFER_EXCEEDED errors that could break receptor connectivity when large enterprise CA chains were provided via `custom_ca_cert`. After this update, `custom_ca_cert` is only added to `mesh-CA.crt` when `receptor_tls_cert` is also configured. If you provide `receptor_tls_cert` without `ca_tls_cert`, you must also set `custom_ca_cert` to the CA certificate that signed the receptor certificates. For the recommended approach to custom receptor mesh certificates, use `ca_tls_cert` and `ca_tls_key` to provide an AAP-specific CA that the installer uses to sign receptor node certificates.

## Links to existing content

* [AAP 2.6 Containerized Installation Guide — Custom TLS Certificates](https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.6/html-single/containerized_installation/index#using-custom-tls-certificates)
* [AAP 2.6 Custom TLS Certificates section](https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.6/install-con_using_custom_tls_certificates#installer-generated-certificates)
* [AAP 2.6 Automation Mesh Setup](https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.6/html/automation_mesh_for_vm_environments/setting-up)
* [Upstream Receptor TLS documentation](https://docs.ansible.com/projects/receptor/en/latest/user_guide/tls.html#above-the-mesh-tls)
* [KCS 7129200 — CRYPTO_BUFFER_EXCEEDED error with receptor](https://access.redhat.com/solutions/7129200)
* [KCS 7091588 — Custom CA certs with containerized AAP 2.5](https://access.redhat.com/solutions/7091588)
* [KCS 7098311 — Receptor fails to start with custom SSL certificates](https://access.redhat.com/solutions/7098311)
* `downstream/assemblies/platform/assembly-using-custom-tls-certificates.adoc`
* `downstream/assemblies/platform/assembly-advanced-configuration-containerized.adoc`

---

## Doc impact assessment

| Requirement | Grade | Rationale |
|-------------|-------|-----------|
| REQ-001: Three mesh-CA.crt scenarios | **High** | New concept documenting a behavior change that affects production deployments. Creates a new module and updates 7 existing files. |
| REQ-002: Clarify custom_ca_cert vs ca_tls_cert | **High** | Addresses a fundamental documentation gap — the existing docs do not distinguish the two certificate paths, leading to misconfiguration. |
| REQ-003: Behavior change — custom_ca_cert no longer in mesh-CA.crt | **High** | Breaking behavior change affecting upgrading customers. Must be clearly documented to prevent upgrade failures. |
| REQ-004: Preflight validation for receptor_tls_cert | **High** | New installer behavior that produces an error message not in current docs. Users will encounter this error and need documentation. |
| REQ-005: Recommended guidance for custom receptor certs | **High** | Without clear recommended vs. advanced guidance, customers may choose the harder and riskier Scenario 3 when Scenario 2 would suffice. |
| REQ-006: Large CA bundle warning | **Medium** | Important safety information. Scenarios 1 and 2 are now protected by the code change, but Scenario 3 users still face this risk. |

All requirements have High or Medium impact. No items are filtered out.

## Relationship analysis

| Pair | Relationship | Notes |
|------|-------------|-------|
| REQ-001 ↔ REQ-002 | Overlapping | Both require documenting the three scenarios and updating the same files (proc-provide-custom-ca-cert, proc-use-custom-ca-certs, ref-general-inventory-variables, con-receptor-cert-considerations). Must be consolidated to avoid duplication. |
| REQ-001 ↔ REQ-003 | Overlapping | REQ-003 is a subset of REQ-001 — the behavior change is Scenario context within the three-scenario model. Consolidate into the same module updates. |
| REQ-002 ↔ REQ-004 | Complementary | REQ-002 explains what the variables do; REQ-004 documents what happens when you set them incorrectly. Different aspects of the same feature. |
| REQ-004 ↔ REQ-005 | Sequential | Users must understand the preflight validation (REQ-004) before choosing between recommended and advanced approaches (REQ-005). |
| REQ-005 ↔ REQ-006 | Complementary | REQ-005 guides users to the safer Scenario 2; REQ-006 warns about the risk of Scenario 3. Together they form a complete decision framework. |
| REQ-003 ↔ REQ-006 | Complementary | REQ-003 documents the fix (custom_ca_cert no longer in mesh-CA.crt by default); REQ-006 warns that the risk persists for Scenario 3. |

**Overlap risk**: High. All six requirements converge on the same set of ~10 files. Without consolidation, writers will make conflicting edits. The theme clustering below consolidates them into a single coordinated documentation effort.

## Theme clustering

### Theme 1: mesh-CA.crt scenarios and certificate variable clarification
- **Summary**: Document the three mesh-CA.crt population scenarios, clarify the distinction between `custom_ca_cert` and `ca_tls_cert`+`ca_tls_key`, and add the recommended vs. advanced guidance.
- **Issues included**: REQ-001, REQ-002, REQ-003, REQ-005
- **Overlap risk**: High — all four requirements touch the same core concept and the same files
- **Recommended ownership**: The new `con-mesh-ca-crt-scenarios.adoc` concept module is the single source of truth for scenarios. Updates to procedure and reference modules cross-reference it rather than duplicating scenario details.

### Theme 2: Preflight validation and error handling
- **Summary**: Document the new preflight check for `receptor_tls_cert` without `ca_tls_cert`/`custom_ca_cert`, including the exact error message and resolution.
- **Issues included**: REQ-004
- **Overlap risk**: Low — distinct content (error message, resolution steps), though it references the same variables
- **Recommended ownership**: Updates to `con-receptor-cert-considerations.adoc` and reference variable modules.

### Theme 3: Large CA bundle warning and troubleshooting
- **Summary**: Add warnings about the QUIC crypto buffer ~16 KB limit and update troubleshooting guidance with root cause.
- **Issues included**: REQ-006, plus troubleshooting updates from REQ-001 and REQ-003
- **Overlap risk**: Medium — the warning appears in both the concept module and the troubleshooting procedure
- **Recommended ownership**: Warning admonition in `con-receptor-cert-considerations.adoc`; root cause details in `proc-troubleshoot-multiple-cas.adoc`.

---

## JTBD hierarchy

### Category: Configure

**Main Job: Secure the receptor mesh with custom TLS certificates**

Parent Topic: The existing assembly `assembly-using-custom-tls-certificates.adoc` ("Configuring custom TLS certificates") already serves as the parent topic for this main job. No new parent topic is needed. The assembly will be updated to include the new concept module.

User Stories:
1. As a SysAdmin, I want to understand how mesh-CA.crt is populated so that I can choose the right certificate configuration for my deployment.
2. As a SysAdmin, I want to configure an enterprise CA for the installer to use so that my receptor mesh certificates are signed by my organization's CA.
3. As a SysAdmin, I want to provide pre-signed receptor certificates so that I can use certificates generated outside the installer.
4. As a SysAdmin, I want to understand the new preflight validation so that I can resolve installer errors related to receptor certificate configuration.
5. As a SysAdmin, I want to provide a custom CA certificate for system trust so that AAP services can validate certificates signed by my organization's CA.

### Category: Troubleshoot

**Main Job: Resolve receptor mesh connectivity failures**

Parent Topic: The existing troubleshooting content (proc-troubleshoot-multiple-cas.adoc) serves this job. No new parent topic is needed.

User Stories:
1. As a SysAdmin, I want to understand why receptor mesh connectivity fails with CRYPTO_BUFFER_EXCEEDED errors so that I can fix the root cause rather than just the symptom.
2. As a SysAdmin, I want to correct an oversized mesh-CA.crt bundle so that receptor nodes can re-establish mesh connectivity.

---

## Gap analysis

| Category | Gap identified | Severity | Current state | Required state |
|----------|---------------|----------|---------------|----------------|
| **Coverage** | No documentation exists for the three mesh-CA.crt population scenarios | Critical | Undocumented — users have no way to understand how mesh-CA.crt is populated | New concept module with decision table mapping variable combinations to mesh-CA.crt contents |
| **Coverage** | No documentation of the behavior change (custom_ca_cert no longer in mesh-CA.crt by default) | Critical | Docs describe old behavior where custom_ca_cert is always bundled | Docs must describe the new conditional behavior and its implications for upgrading |
| **Coverage** | No documentation of the preflight validation error message | High | Users encountering the error have no docs to reference | Error message, cause, and resolution documented in concept module and cross-referenced from variable references |
| **Coverage** | No recommended vs. advanced approach guidance | High | All custom certificate approaches presented without preference | Clear recommendation for Scenario 2 (enterprise CA) with Scenario 3 (pre-signed certs) labeled as advanced |
| **Coverage** | No warning about large CA bundles in mesh-CA.crt | High | Risk exists for Scenario 3 users but is not documented | WARNING admonition about ~16 KB QUIC crypto buffer limit |
| **Currency** | `custom_ca_cert` variable description is outdated | High | Description implies custom_ca_cert is always added to mesh trust | Description must reflect conditional behavior (only added to mesh-CA.crt when receptor_tls_cert is also set) |
| **Currency** | `receptor_tls_cert` variable description is incomplete | High | No mention of custom_ca_cert dependency or preflight requirement | Description must note the custom_ca_cert dependency and link to preflight requirement |
| **Completeness** | Troubleshooting module lacks root cause explanation | Medium | Describes symptom (>10 certs) and manual fix but not why it happens | Add QUIC crypto buffer limit as root cause, cross-reference to scenarios documentation |
| **Completeness** | `con-receptor-cert-considerations.adoc` covers only OID and wildcard restrictions | Medium | 3-line module with minimal content | Expand to cover all three scenarios, recommended vs. advanced approach, preflight validation, and large CA bundle warning |
| **Completeness** | `con-installer-generated-certs.adoc` does not mention mesh-CA.crt | Low | Describes self-signed CA generation but not what goes into mesh-CA.crt | Add note that the self-signed CA populates mesh-CA.crt (Scenario 1) |
| **Structure** | New concept module not yet included in assemblies | High | Assemblies do not reference mesh-CA.crt scenarios | Both assembly-using-custom-tls-certificates.adoc and assembly-advanced-configuration-containerized.adoc must include the new module |

### Content journey phase distribution

| Phase | Modules | Assessment |
|-------|---------|------------|
| **Expand** | None planned | Not applicable — this is an update to existing GA content, not a new product |
| **Discover** | con-mesh-ca-crt-scenarios.adoc (new) | Adequate — the decision table helps users evaluate which scenario applies |
| **Learn** | con-receptor-cert-considerations.adoc (updated) | Adequate — expanded concept provides the learning context |
| **Evaluate** | proc-use-custom-ca-certs.adoc, proc-provide-custom-ca-cert.adoc, proc-provide-custom-tls-certs-per-service.adoc (updated) | Adequate — procedures guide production configuration |
| **Adopt** | proc-troubleshoot-multiple-cas.adoc (updated), ref-general-inventory-variables.adoc, ref-receptor-inventory-variables.adoc (updated) | Adequate — troubleshooting and reference support day-to-day operations |

No phase gaps identified. The content covers Discover through Adopt appropriately for an update to existing GA documentation.

---

## Module specifications

### NEW MODULE

#### 1. con-mesh-ca-crt-scenarios.adoc (CONCEPT)

- **Title**: How the receptor mesh CA bundle is populated
- **Content journey phase**: Discover
- **Audience**: SysAdmin
- **Source traceability**: REQ-001, REQ-002, REQ-003
- **Priority**: Critical
- **Prerequisites**: Basic understanding of TLS certificates and the AAP containerized installer inventory file
- **Dependencies**: None (this is the foundational concept that other modules reference)
- **Content points**:
  1. Brief introduction explaining that mesh-CA.crt is the trust bundle used by receptor nodes to authenticate each other
  2. Decision table with three columns: Scenario name, Inventory variables set, What goes into mesh-CA.crt
     - Scenario 1 (Default): No custom cert variables → installer-generated self-signed CA
     - Scenario 2 (Enterprise CA — Recommended): `ca_tls_cert` + `ca_tls_key` → the enterprise CA certificate
     - Scenario 3 (Pre-signed receptor certs — Advanced): `receptor_tls_cert` + `custom_ca_cert` → the custom CA certificate
  3. Explanation that `custom_ca_cert` alone (without `receptor_tls_cert`) is used only for system-level trust via update-ca-trust, NOT added to mesh-CA.crt
  4. Note about the behavior change: previously, `custom_ca_cert` was always appended to mesh-CA.crt regardless of other variables
  5. Cross-reference to `proc-use-custom-ca-certs.adoc` for Scenario 2 procedure
  6. Cross-reference to `proc-provide-custom-ca-cert.adoc` for Scenario 3 procedure
  7. Note that mixed mesh nodes (some signed with internal CA, others with custom certs) are not supported
- **Placement in assemblies**:
  - `assembly-using-custom-tls-certificates.adoc` — include after `con-receptor-cert-considerations.adoc` at `leveloffset=+2` (under "Receptor certificate considerations")
  - `assembly-advanced-configuration-containerized.adoc` — include after `con-receptor-cert-considerations.adoc` at `leveloffset=+3`

### UPDATED MODULES

#### 2. con-receptor-cert-considerations.adoc (CONCEPT) — Major expansion

- **Content journey phase**: Learn
- **Source traceability**: REQ-001, REQ-002, REQ-003, REQ-004, REQ-005, REQ-006
- **Priority**: Critical
- **Content updates**:
  1. Retain existing content about `otherName` OID requirement and wildcard restriction
  2. Add section on recommended vs. advanced approach:
     - Recommended (Scenario 2): Create an AAP-specific child/intermediate CA and provide via `ca_tls_cert` + `ca_tls_key`. The installer generates properly formatted receptor node certs with the required OID.
     - Advanced (Scenario 3): Provide pre-signed receptor certificates via `receptor_tls_cert` + `custom_ca_cert`. Requires manually including the custom OID in each certificate.
  3. Add preflight validation section: when `receptor_tls_cert` is provided without `ca_tls_cert`, the installer requires `custom_ca_cert`. Include exact error message: "When receptor_tls_cert is provided without ca_tls_cert, custom_ca_cert must also be set to the CA certificate that signed the receptor certificates."
  4. Add WARNING admonition about the QUIC crypto buffer ~16 KB limit: large CA bundles in mesh-CA.crt can cause CRYPTO_BUFFER_EXCEEDED errors. Recommend keeping custom_ca_cert to a single CA certificate or a minimal chain for Scenario 3 users.
  5. Cross-reference to `con-mesh-ca-crt-scenarios.adoc` for the full scenarios decision table
  6. Cross-reference to `proc-troubleshoot-multiple-cas.adoc` for troubleshooting CRYPTO_BUFFER_EXCEEDED

#### 3. proc-provide-custom-ca-cert.adoc (PROCEDURE) — Major rewrite

- **Content journey phase**: Evaluate
- **Source traceability**: REQ-001, REQ-002, REQ-003, REQ-004, REQ-005, REQ-006
- **Priority**: Critical
- **Content updates**:
  1. Rewrite abstract to clarify that `custom_ca_cert` serves two purposes: (a) system-level trust via update-ca-trust for all AAP services, and (b) mesh trust bundle inclusion only when `receptor_tls_cert` is also configured
  2. Add note that this procedure describes the advanced approach (Scenario 3) for receptor mesh certificates; for the recommended approach, cross-reference `proc-use-custom-ca-certs.adoc`
  3. Add note about the preflight requirement: when `receptor_tls_cert` is set without `ca_tls_cert`, `custom_ca_cert` is required
  4. Add WARNING about large CA bundles: if `custom_ca_cert` contains a large bundle and is used with `receptor_tls_cert`, the entire bundle goes into mesh-CA.crt and can cause CRYPTO_BUFFER_EXCEEDED errors
  5. Cross-reference to `con-mesh-ca-crt-scenarios.adoc` for the full scenarios decision table

#### 4. proc-use-custom-ca-certs.adoc (PROCEDURE) — Moderate update

- **Content journey phase**: Evaluate
- **Source traceability**: REQ-001, REQ-002, REQ-004, REQ-005
- **Priority**: High
- **Content updates**:
  1. Add note that this is the recommended approach for customers who want their own CA for receptor mesh certificates (Scenario 2)
  2. Add explanation that when `ca_tls_cert` + `ca_tls_key` are provided, the enterprise CA becomes the mesh CA in mesh-CA.crt, and `custom_ca_cert` is NOT added to mesh-CA.crt
  3. Cross-reference to `con-mesh-ca-crt-scenarios.adoc` for the full scenarios decision table

#### 5. ref-general-inventory-variables.adoc (REFERENCE) — Targeted update

- **Content journey phase**: Adopt
- **Source traceability**: REQ-001, REQ-002, REQ-003, REQ-004
- **Priority**: High
- **Content updates**:
  1. Update `custom_ca_cert` description to clarify dual role: (a) system-level trust for AAP service certificates, and (b) mesh-CA.crt inclusion only when `receptor_tls_cert` is also configured
  2. Update `ca_tls_cert` and `ca_tls_key` descriptions to note that when set, the CA also becomes the mesh CA in mesh-CA.crt
  3. Cross-reference to `con-mesh-ca-crt-scenarios.adoc` from the containerized install conditional block

#### 6. ref-receptor-inventory-variables.adoc (REFERENCE) — Targeted update

- **Content journey phase**: Adopt
- **Source traceability**: REQ-002, REQ-003, REQ-004
- **Priority**: High
- **Content updates**:
  1. Update `receptor_tls_cert` description to note: when set without `ca_tls_cert`, `custom_ca_cert` must also be provided (preflight requirement)
  2. Add cross-reference to `con-receptor-cert-considerations.adoc` for full receptor certificate guidance
  3. Add cross-reference to `con-mesh-ca-crt-scenarios.adoc` for mesh-CA.crt population rules

#### 7. proc-troubleshoot-multiple-cas.adoc (PROCEDURE) — Moderate update

- **Content journey phase**: Adopt
- **Source traceability**: REQ-001, REQ-003, REQ-006
- **Priority**: Medium
- **Content updates**:
  1. Add root cause explanation: the QUIC protocol used by receptor has a crypto buffer limit of approximately 16 KB (16,384 bytes). When mesh-CA.crt exceeds this size, receptor fails with CRYPTO_BUFFER_EXCEEDED
  2. Add context about the behavior change: in AAP 2.6+ (async update) and 2.7+, the installer no longer unconditionally appends `custom_ca_cert` to mesh-CA.crt, which prevents this issue in Scenarios 1 and 2
  3. Note that Scenario 3 users (receptor_tls_cert + custom_ca_cert) can still encounter this issue if custom_ca_cert contains a large bundle
  4. Cross-reference to `con-mesh-ca-crt-scenarios.adoc` for understanding which scenario applies
  5. Cross-reference to KCS 7129200 for additional troubleshooting context

#### 8. con-installer-generated-certs.adoc (CONCEPT) — Minor update

- **Content journey phase**: Discover
- **Source traceability**: REQ-002
- **Priority**: Low
- **Content updates**:
  1. Add sentence noting that the self-signed CA also populates the receptor mesh trust bundle (`mesh-CA.crt`), which receptor nodes use to authenticate each other (Scenario 1)

#### 9. proc-provide-custom-tls-certs-per-service.adoc (PROCEDURE) — Minor update

- **Content journey phase**: Evaluate
- **Source traceability**: REQ-004
- **Priority**: Medium
- **Content updates**:
  1. Under the Receptor section of the per-service certificate variables, add a note that when providing `receptor_tls_cert` without `ca_tls_cert`, you must also set `custom_ca_cert` to the CA certificate that signed the receptor certificates
  2. Cross-reference to `con-receptor-cert-considerations.adoc` for receptor-specific OID requirements and preflight validation

#### 10. assembly-using-custom-tls-certificates.adoc (ASSEMBLY) — Include update

- **Content journey phase**: N/A (structural)
- **Source traceability**: REQ-001
- **Priority**: Critical
- **Content updates**:
  1. Add include directive for `con-mesh-ca-crt-scenarios.adoc` after the `con-receptor-cert-considerations.adoc` include, at `leveloffset=+2`

#### 11. assembly-advanced-configuration-containerized.adoc (ASSEMBLY) — Include update

- **Content journey phase**: N/A (structural)
- **Source traceability**: REQ-001
- **Priority**: Critical
- **Content updates**:
  1. Add include directive for `con-mesh-ca-crt-scenarios.adoc` after the `con-receptor-cert-considerations.adoc` include, at `leveloffset=+3`

---

## Implementation order

The modules must be written and reviewed in the following order based on dependencies:

| Order | Module | Type | Rationale |
|-------|--------|------|-----------|
| 1 | `con-mesh-ca-crt-scenarios.adoc` | NEW CONCEPT | Foundational module — all other updates cross-reference this module. Must be written first. |
| 2 | `con-receptor-cert-considerations.adoc` | UPDATE CONCEPT | Major expansion depends on scenario definitions from module 1. Other procedure updates reference content added here. |
| 3 | `proc-provide-custom-ca-cert.adoc` | UPDATE PROCEDURE | Major rewrite references scenarios from module 1 and considerations from module 2. |
| 4 | `proc-use-custom-ca-certs.adoc` | UPDATE PROCEDURE | References scenarios from module 1. |
| 5 | `ref-general-inventory-variables.adoc` | UPDATE REFERENCE | Variable descriptions reference scenarios from module 1. |
| 6 | `ref-receptor-inventory-variables.adoc` | UPDATE REFERENCE | Variable descriptions reference preflight validation from module 2. |
| 7 | `proc-provide-custom-tls-certs-per-service.adoc` | UPDATE PROCEDURE | Note references preflight validation from module 2. |
| 8 | `proc-troubleshoot-multiple-cas.adoc` | UPDATE PROCEDURE | Root cause and cross-references depend on modules 1 and 2. |
| 9 | `con-installer-generated-certs.adoc` | UPDATE CONCEPT | Minor addition, no dependencies on other updates. |
| 10 | `assembly-using-custom-tls-certificates.adoc` | UPDATE ASSEMBLY | Include directive for module 1. Must be done after module 1 exists. |
| 11 | `assembly-advanced-configuration-containerized.adoc` | UPDATE ASSEMBLY | Include directive for module 1. Must be done after module 1 exists. |

**Parallel execution opportunities**: Modules 5-9 can be written in parallel after modules 1-4 are complete. Assembly updates (10-11) can be done in parallel after module 1 exists.

---

## Assembly structure

### Assembly 1: assembly-using-custom-tls-certificates.adoc

Updated reading order (showing include structure with new module integrated):

```
= Configuring custom TLS certificates
  ├── con-installer-generated-certs.adoc          [leveloffset=+1] (updated: Scenario 1 note)
  ├── con-user-provided-certificates.adoc          [leveloffset=+1] (unchanged)
  │   ├── proc-use-custom-ca-certs.adoc            [leveloffset=+2] (updated: recommended label, mesh-CA.crt note)
  │   ├── proc-provide-custom-tls-certs-per-service.adoc [leveloffset=+2] (updated: receptor note)
  │   ├── con-certs-per-service-considerations.adoc [leveloffset=+2] (unchanged)
  │   └── proc-provide-custom-ca-cert.adoc         [leveloffset=+2] (updated: major rewrite)
  ├── con-receptor-cert-considerations.adoc        [leveloffset=+1] (updated: major expansion)
  │   └── con-mesh-ca-crt-scenarios.adoc           [leveloffset=+2] (NEW: scenarios decision table)
  └── con-redis-cert-considerations.adoc           [leveloffset=+1] (unchanged)
```

### Assembly 2: assembly-advanced-configuration-containerized.adoc

Updated reading order (showing only the custom TLS certificates section):

```
= Advanced containerized deployment
  ├── ... (other sections unchanged)
  ├── con-using-custom-tls-certificates.adoc       [leveloffset=+1] (unchanged)
  │   ├── con-installer-generated-certs.adoc       [leveloffset=+2] (updated: Scenario 1 note)
  │   ├── con-user-provided-certificates.adoc      [leveloffset=+2] (unchanged)
  │   │   ├── proc-use-custom-ca-certs.adoc        [leveloffset=+3] (updated)
  │   │   ├── proc-provide-custom-tls-certs-per-service.adoc [leveloffset=+3] (updated)
  │   │   ├── con-certs-per-service-considerations.adoc [leveloffset=+3] (unchanged)
  │   │   └── proc-provide-custom-ca-cert.adoc     [leveloffset=+3] (updated)
  │   ├── con-receptor-cert-considerations.adoc    [leveloffset=+2] (updated)
  │   │   └── con-mesh-ca-crt-scenarios.adoc       [leveloffset=+3] (NEW)
  │   └── con-redis-cert-considerations.adoc       [leveloffset=+2] (unchanged)
  │   └── ref-using-custom-receptor-signing-keys.adoc [leveloffset=+2] (unchanged)
  └── ... (other sections unchanged)
```

### Shared prerequisites

The following prerequisites apply across multiple modules in these assemblies:

1. Access to the AAP containerized installer inventory file
2. Understanding of TLS certificate concepts (CA, certificate chain, signing)
3. Familiarity with AAP containerized deployment architecture (controller nodes, execution nodes, receptor mesh)

---

## Content sources from JIRA and PR/MR analysis

### JIRA tickets

| Ticket | Type | Relevance | Key content to extract |
|--------|------|-----------|----------------------|
| [AAP-81003](https://redhat.atlassian.net/browse/AAP-81003) | Story | Primary docs ticket | Five documentation update areas, acceptance criteria, mesh-CA.crt scenario descriptions |
| [AAP-70677](https://redhat.atlassian.net/browse/AAP-70677) | Bug | Parent bug | Root cause description: custom CA bundled into mesh CA hits receptor QUIC crypto buffer limit |
| [AAP-51480](https://redhat.atlassian.net/browse/AAP-51480) | Epic | Context | Receptor CA Bundle Optimizations — strategic context for the change |
| [AAP-47511](https://redhat.atlassian.net/browse/AAP-47511) | Bug | Customer case | Original customer-reported failure — containerized installation failed to load custom CA cert |

### Merge requests

| MR | Repository | Key changes | Documentation impact |
|----|-----------|-------------|---------------------|
| [MR !1088](https://gitlab.cee.redhat.com/ansible/aap-containerized-installer/-/merge_requests/1088) | aap-containerized-installer | 2 files: `roles/receptor/templates/mesh-CA.crt.j2` (conditional inclusion logic), `roles/preflight/tasks/nodes.yml` (new validation task) | Provides exact preflight error message text, Jinja2 template logic for scenario documentation, and test scenarios for validation |

### KCS articles

| Article | Relevance |
|---------|-----------|
| [KCS 7129200](https://access.redhat.com/solutions/7129200) | CRYPTO_BUFFER_EXCEEDED error documentation — cross-reference from troubleshooting module |
| [KCS 7091588](https://access.redhat.com/solutions/7091588) | Custom CA certs with containerized AAP 2.5 — historical context |
| [KCS 7098311](https://access.redhat.com/solutions/7098311) | Receptor fails to start with custom SSL certificates — related symptom |

---

## Prioritization summary

| Priority | Modules | Rationale |
|----------|---------|-----------|
| **Critical** | con-mesh-ca-crt-scenarios.adoc (NEW), con-receptor-cert-considerations.adoc, proc-provide-custom-ca-cert.adoc, assembly includes (2) | Core behavior change documentation. Blocks users from correctly configuring custom TLS certificates after upgrading. |
| **High** | proc-use-custom-ca-certs.adoc, ref-general-inventory-variables.adoc, ref-receptor-inventory-variables.adoc | Important for complete coverage of variable behavior changes. Users consulting reference docs will find outdated information without these updates. |
| **Medium** | proc-troubleshoot-multiple-cas.adoc, proc-provide-custom-tls-certs-per-service.adoc | Improves troubleshooting quality and per-service procedure completeness. Not blocking but significantly improves user experience. |
| **Low** | con-installer-generated-certs.adoc | Minor contextual addition. Users can function without this update. |

## New Docs

* How the receptor mesh CA bundle is populated (Concept)
    - New concept module (`con-mesh-ca-crt-scenarios.adoc`) explaining the three mesh-CA.crt population scenarios:
      - Scenario 1 (Default): No custom cert variables set — installer-generated self-signed CA populates mesh-CA.crt
      - Scenario 2 (Enterprise CA — Recommended): `ca_tls_cert` + `ca_tls_key` — enterprise CA becomes mesh CA in mesh-CA.crt
      - Scenario 3 (Pre-signed receptor certs — Advanced): `receptor_tls_cert` + `custom_ca_cert` — custom CA certificate added to mesh-CA.crt
    - Decision table mapping inventory variable combinations to mesh-CA.crt contents
    - Note that `custom_ca_cert` alone is for system-level trust only, NOT added to mesh-CA.crt
    - Behavior change note: previously `custom_ca_cert` was always appended to mesh-CA.crt
    - Cross-references to the recommended (Scenario 2) and advanced (Scenario 3) procedures
    - Note that mixed mesh nodes are not supported

## Updated Docs

* `con-receptor-cert-considerations.adoc`
    - Major expansion: add recommended vs. advanced approach guidance, preflight validation section with exact error message, WARNING about QUIC crypto buffer ~16 KB limit, and cross-references to scenarios concept module and troubleshooting procedure

* `proc-provide-custom-ca-cert.adoc`
    - Major rewrite: clarify `custom_ca_cert` dual role (system trust vs. mesh trust), add note that this is the advanced approach (Scenario 3), add preflight requirement note, add WARNING about large CA bundles with receptor_tls_cert, add cross-reference to scenarios module

* `proc-use-custom-ca-certs.adoc`
    - Moderate update: add recommended approach label (Scenario 2), explain that enterprise CA becomes mesh CA in mesh-CA.crt, note that `custom_ca_cert` is NOT added to mesh-CA.crt in this scenario, add cross-reference to scenarios module

* `ref-general-inventory-variables.adoc`
    - Targeted update: update `custom_ca_cert` description to clarify dual role and conditional mesh-CA.crt inclusion, update `ca_tls_cert`/`ca_tls_key` descriptions to note mesh CA role, add cross-reference to scenarios module

* `ref-receptor-inventory-variables.adoc`
    - Targeted update: update `receptor_tls_cert` description to note `custom_ca_cert` dependency when `ca_tls_cert` is not set, add cross-references to receptor cert considerations and scenarios modules

* `proc-troubleshoot-multiple-cas.adoc`
    - Moderate update: add QUIC crypto buffer root cause explanation (~16 KB limit), add behavior change context (fix prevents issue in Scenarios 1 and 2), note Scenario 3 risk, add cross-references to scenarios module and KCS 7129200

* `con-installer-generated-certs.adoc`
    - Minor update: add note that the self-signed CA also populates mesh-CA.crt for receptor mesh trust (Scenario 1)

* `proc-provide-custom-tls-certs-per-service.adoc`
    - Minor update: add note under Receptor section that `receptor_tls_cert` without `ca_tls_cert` requires `custom_ca_cert`, add cross-reference to receptor cert considerations

* `assembly-using-custom-tls-certificates.adoc`
    - Include update: add `include::platform/con-mesh-ca-crt-scenarios.adoc[leveloffset=+2]` after the `con-receptor-cert-considerations.adoc` include

* `assembly-advanced-configuration-containerized.adoc`
    - Include update: add `include::platform/con-mesh-ca-crt-scenarios.adoc[leveloffset=+3]` after the `con-receptor-cert-considerations.adoc` include

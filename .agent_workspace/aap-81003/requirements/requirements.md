# Documentation Requirements

**Source**: Update custom TLS certificate guidance to reflect mesh-CA.crt behavior change in containerized installer
**Date**: 2026-06-30
**Release/Sprint**: 2.6, 2.7

## Summary

- Total requirements analyzed: 6
- New modules needed: 1
- Existing modules to update: 10
- Breaking changes requiring docs: 1

## Requirements by priority

### Critical

#### REQ-001: Document three mesh-CA.crt population scenarios
- **Source**: [AAP-81003](https://redhat.atlassian.net/browse/AAP-81003) | [AAP-70677](https://redhat.atlassian.net/browse/AAP-70677) | [MR !1088](https://gitlab.cee.redhat.com/ansible/aap-containerized-installer/-/merge_requests/1088)
- **Summary**: The containerized installer behavior for mesh-CA.crt was changed so that custom_ca_cert is no longer unconditionally bundled into the receptor mesh trust bundle. After MR 1088 (merged to stable-2.6 and stable-2.7), mesh-CA.crt is now populated based on three distinct scenarios depending on which inventory variables are set: (1) default installer-generated CA, (2) enterprise CA via ca_tls_cert+ca_tls_key, or (3) pre-signed receptor certs via receptor_tls_cert+custom_ca_cert.
- **User impact**: Customers using custom CA certificates with containerized AAP will experience changed mesh-CA.crt behavior after upgrading. Those who previously relied on custom_ca_cert being included in the mesh trust bundle must now also set receptor_tls_cert explicitly. Customers who only used custom_ca_cert for system trust benefit from the fix as their receptor mesh will no longer risk CRYPTO_BUFFER_EXCEEDED failures.
- **Documentation action**:
  - [ ] Create `downstream/modules/platform/con-mesh-ca-crt-scenarios.adoc` (CONCEPT) — New concept module explaining the three mesh-CA.crt population scenarios with a summary table mapping inventory variable combinations to mesh-CA.crt contents.
  - [ ] Update `downstream/modules/platform/proc-provide-custom-ca-cert.adoc` (PROCEDURE) — Clarify that custom_ca_cert is primarily for system-level trust and is only added to mesh-CA.crt when receptor_tls_cert is also provided.
  - [ ] Update `downstream/modules/platform/proc-use-custom-ca-certs.adoc` (PROCEDURE) — Add context that when ca_tls_cert+ca_tls_key are provided, the enterprise CA becomes the mesh CA in mesh-CA.crt, and custom_ca_cert is NOT added to mesh-CA.crt.
  - [ ] Update `downstream/modules/platform/con-receptor-cert-considerations.adoc` (CONCEPT) — Expand to explain the new preflight validation, the advanced approach for Scenario 3, and cross-reference to the mesh-CA.crt scenarios concept module.
  - [ ] Update `downstream/modules/platform/ref-general-inventory-variables.adoc` (REFERENCE) — Update custom_ca_cert description to clarify its dual role.
  - [ ] Update `downstream/assemblies/platform/assembly-using-custom-tls-certificates.adoc` (ASSEMBLY) — Add include for the new con-mesh-ca-crt-scenarios.adoc module.
  - [ ] Update `downstream/assemblies/platform/assembly-advanced-configuration-containerized.adoc` (ASSEMBLY) — Add include for the new con-mesh-ca-crt-scenarios.adoc module.
  - [ ] Update `downstream/modules/platform/proc-troubleshoot-multiple-cas.adoc` (PROCEDURE) — Update to reference the behavior change and explain the fix prevents custom_ca_cert from bloating mesh-CA.crt.
- **Acceptance criteria**:
  - [ ] Users can identify which mesh-CA.crt scenario applies to their deployment by consulting a clearly documented decision table
  - [ ] Users can distinguish between custom_ca_cert (system trust) and ca_tls_cert (mesh CA signing)
  - [ ] Users can configure Scenario 2 (enterprise CA) by following documented recommended path
  - [ ] Users can configure Scenario 3 (pre-signed receptor certs) by following documented advanced guidance
  - [ ] Users can understand the new preflight validation error message
  - [ ] Users can find a documented warning about the practical size limit on mesh-CA.crt
  - [ ] The three scenarios are documented consistently across both the containerized installation guide and the custom TLS certificates guide
- **References**:
  - [AAP-81003](https://redhat.atlassian.net/browse/AAP-81003): Complete documentation requirements with five update areas
  - [AAP-70677](https://redhat.atlassian.net/browse/AAP-70677): Parent bug describing the problem
  - [MR !1088](https://gitlab.cee.redhat.com/ansible/aap-containerized-installer/-/merge_requests/1088): Code changes (merged to stable-2.6 and stable-2.7)
  - [AAP-51480](https://redhat.atlassian.net/browse/AAP-51480): Receptor CA Bundle Optimizations epic
  - [AAP-47511](https://redhat.atlassian.net/browse/AAP-47511): Original customer case
  - [KCS 7129200](https://access.redhat.com/solutions/7129200): CRYPTO_BUFFER_EXCEEDED error documentation

#### REQ-002: Clarify distinction between custom_ca_cert and ca_tls_cert variables
- **Source**: [AAP-81003](https://redhat.atlassian.net/browse/AAP-81003) | [MR !1088](https://gitlab.cee.redhat.com/ansible/aap-containerized-installer/-/merge_requests/1088)
- **Summary**: The docs must clearly distinguish custom_ca_cert (system-level trust via update-ca-trust, only goes into mesh-CA.crt when receptor_tls_cert is also provided) from ca_tls_cert+ca_tls_key (used by installer to sign receptor node certificates and becomes mesh CA in mesh-CA.crt).
- **User impact**: Users who set custom_ca_cert for system-level trust will no longer experience receptor mesh failures from oversized mesh-CA.crt bundles. Users providing receptor_tls_cert without custom_ca_cert will now see a preflight error. The existing documentation does not clearly distinguish these two certificate paths.
- **Documentation action**:
  - [ ] Update `downstream/modules/platform/proc-provide-custom-ca-cert.adoc` (PROCEDURE) — Major rewrite: clarify custom_ca_cert is primarily for system-level trust and is NOT added to mesh-CA.crt unless receptor_tls_cert is also set.
  - [ ] Update `downstream/modules/platform/proc-use-custom-ca-certs.adoc` (PROCEDURE) — Clarify that ca_tls_cert+ca_tls_key causes the installer to use this CA to sign receptor certs AND it becomes the mesh CA.
  - [ ] Update `downstream/modules/platform/ref-general-inventory-variables.adoc` (REFERENCE) — Update custom_ca_cert and ca_tls_cert descriptions to reflect mesh-CA.crt behavior.
  - [ ] Update `downstream/modules/platform/ref-receptor-inventory-variables.adoc` (REFERENCE) — Update receptor_tls_cert description to note the new preflight requirement.
  - [ ] Update `downstream/modules/platform/con-receptor-cert-considerations.adoc` (CONCEPT) — Expand to cover recommended vs advanced approach and large CA bundle warning.
  - [ ] Update `downstream/modules/platform/con-installer-generated-certs.adoc` (CONCEPT) — Minor update: note the self-signed CA populates mesh-CA.crt for Scenario 1.
- **Acceptance criteria**:
  - [ ] Users can determine from the docs whether to use custom_ca_cert or ca_tls_cert+ca_tls_key for their use case
  - [ ] The docs clearly state that custom_ca_cert is for system-level trust and is NOT placed in mesh-CA.crt unless receptor_tls_cert is also configured
  - [ ] The docs clearly state that ca_tls_cert+ca_tls_key provides the CA the installer uses to sign receptor node certificates
  - [ ] All three mesh-CA.crt population scenarios are documented with a summary table
  - [ ] The new preflight validation error is documented with exact error message
- **References**:
  - [AAP-81003](https://redhat.atlassian.net/browse/AAP-81003): Complete specification of documentation changes
  - [MR !1088](https://gitlab.cee.redhat.com/ansible/aap-containerized-installer/-/merge_requests/1088): Implementation details and test scenarios
  - [AAP-70677](https://redhat.atlassian.net/browse/AAP-70677): Parent bug describing the problem

#### REQ-003: Document behavior change — custom_ca_cert no longer added to mesh-CA.crt by default
- **Source**: [AAP-81003](https://redhat.atlassian.net/browse/AAP-81003) | [AAP-70677](https://redhat.atlassian.net/browse/AAP-70677) | [MR !1088](https://gitlab.cee.redhat.com/ansible/aap-containerized-installer/-/merge_requests/1088)
- **Summary**: The containerized AAP installer previously always appended custom_ca_cert to mesh-CA.crt. This caused the bundle to exceed receptor's 16 KB QUIC crypto buffer limit when customers provided large CA chains. After MR 1088, custom_ca_cert is only placed in mesh-CA.crt when receptor_tls_cert is also configured. A new preflight check warns when receptor_tls_cert is set without custom_ca_cert.
- **User impact**: Users who set custom_ca_cert without receptor_tls_cert will see their custom CA no longer in mesh-CA.crt (resolves CRYPTO_BUFFER_EXCEEDED errors). Users providing receptor_tls_cert must also provide custom_ca_cert or the installer will produce a preflight warning.
- **Documentation action**:
  - [ ] Update `downstream/modules/platform/proc-provide-custom-ca-cert.adoc` (PROCEDURE) — Add explanation that custom_ca_cert is only added to mesh-CA.crt when receptor_tls_cert is also configured.
  - [ ] Update `downstream/modules/platform/con-receptor-cert-considerations.adoc` (CONCEPT) — Add consideration that receptor_tls_cert requires custom_ca_cert for mesh trust.
  - [ ] Update `downstream/modules/platform/ref-general-inventory-variables.adoc` (REFERENCE) — Update custom_ca_cert description.
  - [ ] Update `downstream/modules/platform/ref-receptor-inventory-variables.adoc` (REFERENCE) — Update receptor_tls_cert description with custom_ca_cert dependency.
  - [ ] Update `downstream/modules/platform/proc-troubleshoot-multiple-cas.adoc` (PROCEDURE) — Note the fix prevents certificate accumulation in most scenarios.
- **Acceptance criteria**:
  - [ ] Users can determine from proc-provide-custom-ca-cert.adoc when custom_ca_cert is included in mesh-CA.crt
  - [ ] Users can find the five certificate scenarios documented or referenced
  - [ ] Users upgrading can identify the behavior change from the documentation
- **References**:
  - [AAP-81003](https://redhat.atlassian.net/browse/AAP-81003): Documentation requirements
  - [AAP-70677](https://redhat.atlassian.net/browse/AAP-70677): Root cause — crypto buffer exceeded
  - [MR !1088](https://gitlab.cee.redhat.com/ansible/aap-containerized-installer/-/merge_requests/1088): Implementation — mesh-CA.crt.j2 and preflight/tasks/nodes.yml
  - [KCS 7129200](https://access.redhat.com/solutions/7129200): CRYPTO_BUFFER_EXCEEDED error with receptor

### High

#### REQ-004: Document new preflight validation for receptor_tls_cert without ca_tls_cert
- **Source**: [AAP-81003](https://redhat.atlassian.net/browse/AAP-81003) | [MR !1088](https://gitlab.cee.redhat.com/ansible/aap-containerized-installer/-/merge_requests/1088)
- **Summary**: The containerized AAP installer now includes a preflight check: when receptor_tls_cert is provided without ca_tls_cert, the installer requires custom_ca_cert to also be set. The error message is: "When receptor_tls_cert is provided without ca_tls_cert, custom_ca_cert must also be set to the CA certificate that signed the receptor certificates."
- **User impact**: Users providing custom receptor TLS certificates without also providing custom_ca_cert will now see a preflight validation error. The existing documentation does not mention this requirement.
- **Documentation action**:
  - [ ] Update `downstream/modules/platform/con-receptor-cert-considerations.adoc` (CONCEPT) — Document the three mesh-CA.crt scenarios, the new preflight validation error message, and the large CA bundle warning.
  - [ ] Update `downstream/modules/platform/proc-provide-custom-ca-cert.adoc` (PROCEDURE) — Add note about the new preflight requirement.
  - [ ] Update `downstream/modules/platform/proc-use-custom-ca-certs.adoc` (PROCEDURE) — Clarify that this is the recommended approach for custom receptor mesh certificates.
  - [ ] Update `downstream/modules/platform/ref-general-inventory-variables.adoc` (REFERENCE) — Update custom_ca_cert description with dual role.
  - [ ] Update `downstream/modules/platform/ref-receptor-inventory-variables.adoc` (REFERENCE) — Update receptor_tls_cert description with preflight requirement.
  - [ ] Update `downstream/modules/platform/proc-provide-custom-tls-certs-per-service.adoc` (PROCEDURE) — Add note under Receptor section about the custom_ca_cert requirement.
- **Acceptance criteria**:
  - [ ] Users can identify which mesh-CA.crt scenario applies to their deployment
  - [ ] Users can determine when custom_ca_cert is required vs optional
  - [ ] Users can find the exact preflight error message in the documentation
  - [ ] The distinction between custom_ca_cert and ca_tls_cert is clearly explained
  - [ ] The receptor_tls_cert variable reference includes a cross-reference to the preflight requirement

#### REQ-005: Add recommended guidance for custom receptor certificate approaches
- **Source**: [AAP-81003](https://redhat.atlassian.net/browse/AAP-81003)
- **Summary**: Add guidance recommending customers create an AAP-specific child/intermediate CA (Scenario 2: ca_tls_cert + ca_tls_key) as the preferred approach, with pre-signed receptor certs (Scenario 3: receptor_tls_cert + custom_ca_cert) as the advanced alternative. The recommended approach lets the installer generate properly-formatted receptor node certs with the required custom OID while keeping the mesh CA small and purpose-built.
- **User impact**: Customers who want to use their own CA for receptor mesh certificates need clear guidance on the recommended path vs the advanced path. Without this, they may choose the harder and riskier Scenario 3 when Scenario 2 would be simpler and more reliable.
- **Documentation action**:
  - [ ] Update `downstream/modules/platform/con-receptor-cert-considerations.adoc` (CONCEPT) — Add recommended vs advanced approach guidance with clear criteria for when to use each.
  - [ ] Update `downstream/modules/platform/proc-use-custom-ca-certs.adoc` (PROCEDURE) — Add note that this is the recommended approach for customers wanting their own CA for receptor mesh certificates.
  - [ ] Update `downstream/modules/platform/proc-provide-custom-ca-cert.adoc` (PROCEDURE) — Note that using custom_ca_cert with receptor_tls_cert is the advanced approach.
- **Acceptance criteria**:
  - [ ] Users can follow the recommended approach (Scenario 2) with clear step-by-step guidance
  - [ ] Users can follow the advanced approach (Scenario 3) with clear prerequisites
  - [ ] The recommended approach is clearly labeled as such
  - [ ] The advanced approach includes a note about the receptor OID requirement

#### REQ-006: Add warning about large CA bundles in mesh-CA.crt
- **Source**: [AAP-81003](https://redhat.atlassian.net/browse/AAP-81003) | [AAP-51480](https://redhat.atlassian.net/browse/AAP-51480) | [AAP-70677](https://redhat.atlassian.net/browse/AAP-70677)
- **Summary**: The receptor mesh has a practical size limit on the CA bundle in mesh-CA.crt (QUIC crypto buffer limit of ~16 KB). Large enterprise CA bundles can cause CRYPTO_BUFFER_EXCEEDED errors breaking receptor connectivity. While the behavior change prevents this in Scenarios 1 and 2, Scenario 3 users (receptor_tls_cert + custom_ca_cert) still risk this if custom_ca_cert contains a large bundle.
- **User impact**: Users with large enterprise CA chains who use Scenario 3 (receptor_tls_cert + custom_ca_cert) will have that large bundle placed in mesh-CA.crt, potentially causing CRYPTO_BUFFER_EXCEEDED errors. A clear warning helps them avoid this.
- **Documentation action**:
  - [ ] Update `downstream/modules/platform/con-receptor-cert-considerations.adoc` (CONCEPT) — Add WARNING admonition about the QUIC crypto buffer ~16 KB limit and CRYPTO_BUFFER_EXCEEDED errors.
  - [ ] Update `downstream/modules/platform/proc-provide-custom-ca-cert.adoc` (PROCEDURE) — Add warning that if custom_ca_cert contains a large bundle and is used with receptor_tls_cert, it will go into mesh-CA.crt and can break receptor.
  - [ ] Update `downstream/modules/platform/proc-troubleshoot-multiple-cas.adoc` (PROCEDURE) — Add root cause explanation (QUIC crypto buffer limit) and cross-reference to the scenarios documentation.
- **Acceptance criteria**:
  - [ ] Users see a warning that large CA bundles in mesh-CA.crt can cause CRYPTO_BUFFER_EXCEEDED errors
  - [ ] Users can find troubleshooting guidance for CRYPTO_BUFFER_EXCEEDED errors with root cause and resolution
  - [ ] The warning is present in the receptor certificate considerations section

## Documentation scope

### New documentation needed

| Requirement | Scope | References |
|-------------|-------|------------|
| REQ-001 | Create `con-mesh-ca-crt-scenarios.adoc` — new concept module documenting three mesh-CA.crt population scenarios with a variable-to-content mapping table | AAP-81003, AAP-70677, MR !1088 |

### Existing documentation to update

| Requirement | What changed | References |
|-------------|-------------|------------|
| REQ-001, REQ-002, REQ-003, REQ-004, REQ-005, REQ-006 | `proc-provide-custom-ca-cert.adoc` — Clarify custom_ca_cert role: system trust only unless receptor_tls_cert is set | AAP-81003, MR !1088 |
| REQ-001, REQ-002, REQ-004, REQ-005 | `proc-use-custom-ca-certs.adoc` — Clarify ca_tls_cert role as mesh CA; add recommended approach guidance | AAP-81003 |
| REQ-001, REQ-002, REQ-003, REQ-004, REQ-005, REQ-006 | `con-receptor-cert-considerations.adoc` — Expand with three scenarios, preflight validation, recommended guidance, and large CA bundle warning | AAP-81003, AAP-70677 |
| REQ-001, REQ-002, REQ-003, REQ-004 | `ref-general-inventory-variables.adoc` — Update custom_ca_cert and ca_tls_cert descriptions | AAP-81003 |
| REQ-002, REQ-003, REQ-004 | `ref-receptor-inventory-variables.adoc` — Update receptor_tls_cert description with custom_ca_cert dependency | AAP-81003, MR !1088 |
| REQ-001, REQ-003, REQ-006 | `proc-troubleshoot-multiple-cas.adoc` — Update with root cause and behavior change context | AAP-51480, AAP-70677 |
| REQ-001 | `assembly-using-custom-tls-certificates.adoc` — Include new con-mesh-ca-crt-scenarios.adoc | AAP-81003 |
| REQ-001 | `assembly-advanced-configuration-containerized.adoc` — Include new con-mesh-ca-crt-scenarios.adoc | AAP-81003 |
| REQ-002 | `con-installer-generated-certs.adoc` — Add mesh-CA.crt Scenario 1 context | AAP-81003 |
| REQ-004 | `proc-provide-custom-tls-certs-per-service.adoc` — Add note about receptor_tls_cert requiring custom_ca_cert | AAP-81003 |

## Breaking changes

| Change | Migration steps needed | Deprecation notice | References |
|--------|------------------------|-------------------|------------|
| custom_ca_cert is no longer added to mesh-CA.crt by default | Users relying on custom_ca_cert being in mesh trust must now use ca_tls_cert+ca_tls_key (Scenario 2) or receptor_tls_cert+custom_ca_cert (Scenario 3) | None — behavior change, not deprecation | AAP-70677, MR !1088 |

## Notes

- This is a behavior change in the containerized installer only (RPM installer is not affected by this MR).
- The change applies to AAP 2.6 (as an async update) and AAP 2.7.
- The MR modifies two files: `roles/receptor/templates/mesh-CA.crt.j2` (Jinja2 template now conditionally includes custom_ca_cert) and `roles/preflight/tasks/nodes.yml` (new validation task).
- The MR description lists five test scenarios that consolidate into three primary scenarios in the documentation.
- Mixed mesh nodes (some signed with internal CA, others with custom receptor certs) are explicitly not supported.
- The QUIC crypto buffer limit is approximately 16 KB (16,384 bytes); the precise breaking point is between 16,745-17,035 bytes for CA bundles.
- The existing `proc-troubleshoot-multiple-cas.adoc` addresses the symptom (>10 certs) but lacks the root cause explanation (QUIC crypto buffer limit).
- Documentation files are identical across main, 2.5, and 2.6 branches (except a minor URL change in con-receptor-cert-considerations.adoc between 2.6 and main).

## Related tickets

- [AAP-70677](https://redhat.atlassian.net/browse/AAP-70677) — Parent bug: custom CA bundled into mesh CA hits receptor size limits
- [AAP-51480](https://redhat.atlassian.net/browse/AAP-51480) — Epic: Receptor CA Bundle Optimizations
- [AAP-47511](https://redhat.atlassian.net/browse/AAP-47511) — Original customer case: containerized installation failed to load custom CA cert to receptor container

## Sources consulted

### JIRA tickets
- [AAP-81003](https://redhat.atlassian.net/browse/AAP-81003) — Docs story: Update custom TLS certificate guidance
- [AAP-70677](https://redhat.atlassian.net/browse/AAP-70677) — Bug: custom CA bundled into mesh CA hits receptor size limits
- [AAP-51480](https://redhat.atlassian.net/browse/AAP-51480) — Epic: Receptor CA Bundle Optimizations
- [AAP-47511](https://redhat.atlassian.net/browse/AAP-47511) — Original customer case

### Pull requests / Merge requests
- [MR !1088](https://gitlab.cee.redhat.com/ansible/aap-containerized-installer/-/merge_requests/1088) — Update mesh-CA.crt bundle logic (2 files changed: mesh-CA.crt.j2 and preflight/tasks/nodes.yml)

### Existing documentation
- `downstream/modules/platform/con-using-custom-tls-certificates.adoc`
- `downstream/modules/platform/proc-use-custom-ca-certs.adoc`
- `downstream/modules/platform/proc-provide-custom-ca-cert.adoc`
- `downstream/modules/platform/con-receptor-cert-considerations.adoc`
- `downstream/modules/platform/ref-general-inventory-variables.adoc`
- `downstream/modules/platform/ref-receptor-inventory-variables.adoc`
- `downstream/modules/platform/proc-troubleshoot-multiple-cas.adoc`
- `downstream/modules/platform/con-installer-generated-certs.adoc`
- `downstream/modules/platform/proc-provide-custom-tls-certs-per-service.adoc`
- `downstream/modules/platform/con-certs-per-service-considerations.adoc`
- `downstream/assemblies/platform/assembly-using-custom-tls-certificates.adoc`
- `downstream/assemblies/platform/assembly-advanced-configuration-containerized.adoc`

### External references
- [Receptor TLS documentation](https://docs.ansible.com/projects/receptor/en/latest/user_guide/tls.html#above-the-mesh-tls) — upstream receptor TLS and OID requirements

### Web search findings
- [AAP 2.6 Containerized Installation Guide](https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.6/html-single/containerized_installation/index) — Published documentation that needs updating
- [AAP 2.6 Custom TLS Certificates section](https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.6/install-con_using_custom_tls_certificates#installer-generated-certificates) — Published page referenced in JIRA
- [AAP 2.6 Automation Mesh Setup](https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.6/html/automation_mesh_for_vm_environments/setting-up) — Mesh CA configuration
- [KCS 7129200](https://access.redhat.com/solutions/7129200) — CRYPTO_BUFFER_EXCEEDED error documentation
- [KCS 7091588](https://access.redhat.com/solutions/7091588) — Custom CA certs with containerized AAP 2.5
- [KCS 7098311](https://access.redhat.com/solutions/7098311) — Receptor fails to start with custom SSL certificates
- [APNIC Blog: TLS certificates and QUIC performance](https://blog.apnic.net/2023/01/16/on-the-interplay-between-tls-certificates-and-quic-performance/) — Technical background on QUIC crypto buffer limits

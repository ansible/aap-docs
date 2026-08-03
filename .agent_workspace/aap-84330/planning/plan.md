# Documentation Plan

**Project**: Update AAP on Azure docs with new VM series
**Date**: 2026-07-28
**Ticket**: [AAP-84330](https://redhat.atlassian.net/browse/AAP-84330)

## What is the support status of the feature(s) being used to complete the user's JTBD (Job To Be Done)?

General Availability

## Why is this content important?

The Azure Database for PostgreSQL VM SKU references in the infrastructure usage documentation are outdated. The deployed infrastructure now uses the Dds_v5 series VMs, but the documentation still references the older Ds_v3 series. Customers who consult this page to understand their Azure resource consumption, estimate costs, or plan capacity will see VM SKU values that do not match what is actually deployed in their subscription. Correcting these references ensures customers can accurately cross-reference their Azure portal resources against the documentation and produce reliable cost estimates using the Azure Pricing Calculator.

## Who is the target persona(s)?

* SysAdmin: Manages and monitors the Azure infrastructure underlying the AAP deployment; references the infrastructure usage page to understand resource shapes and verify deployed resources.
* IT Operations Leader: Responsible for capacity planning and cost forecasting for Azure subscriptions hosting AAP; uses the documented VM SKUs to estimate infrastructure costs.

## What is the main JTBD? What user goal is being accomplished? What pain point is being avoided?

When I am reviewing or planning the Azure infrastructure costs for my Ansible Automation Platform deployment, I want to see the correct VM SKU series for each plan size in the documentation, so that I can produce accurate cost estimates and verify that my deployed resources match the documented configuration while avoiding confusion caused by outdated SKU references that do not correspond to what Azure actually provisions.

## How does the JTBD(s) relate to the overall real-world workflow for the user?

This JTBD sits within the broader workflow of evaluating, deploying, and operating AAP on Azure. Before purchasing or after deploying, administrators consult the infrastructure usage documentation to understand what Azure resources are provisioned at each plan tier. They use this information to:

1. Estimate ongoing Azure infrastructure costs with the Azure Pricing Calculator.
2. Verify that the resources visible in the Azure portal match expected configurations.
3. Plan capacity by understanding how database resources scale across plan sizes (50 through 10,000 nodes).
4. Communicate infrastructure requirements to procurement or finance teams.

If the documented VM SKUs are outdated, every downstream step in this workflow produces incorrect results — cost estimates are wrong, resource verification fails, and capacity planning is based on stale data.

## What high-level steps does the user need to take to accomplish the goal?

No user action is required beyond reading the updated documentation. This is a content correction, not a procedural change.

The documentation writer needs to:

1. Open `aap-clouds/topics/con-azure-infrastructure-usage.adoc`.
2. Locate the "Azure Database for PostgreSQL" table (lines 39-48).
3. Replace `Standard_D2s_v3` with `Standard_D2ds_v5` in the plan size 50 row.
4. Replace `Standard_D4s_v3` with `Standard_D4ds_v5` in all remaining rows (plan sizes 400, 1000, 2500, 5000, 10000).
5. Verify no other content in the file is modified.

## Is there a demo available or can one be created?

No

## Are there special considerations for disconnected environments?

No. This change updates reference data only and has no impact on disconnected or air-gapped deployment scenarios.

## Who can provide information and answer questions?

* PM / Reporter: See AAP-84330 assignee and reporter fields
* Technical SME: Engineering team responsible for AAP on Azure infrastructure (parent epic AAP-79958: 2026 Q3 Management and Infrastructure improvements for Cloud)

## Release Note needed?

No

Draft release note: N/A. This is a documentation-only correction to align published VM SKU references with current deployed infrastructure. No user-facing product behavior has changed.

## Links to existing content

* [AAP on Azure infrastructure usage (published)](https://docs.redhat.com/en/documentation/ansible_on_clouds/2.x/html-single/red_hat_ansible_automation_platform_on_microsoft_azure_guide/index#con-azure-infrastructure-usage_azure-intro)
* [AAP-84330 — Update AAP on Azure docs with new VM series](https://redhat.atlassian.net/browse/AAP-84330)
* [AAP-79958 — 2026 Q3 Management and Infrastructure improvements for Cloud (parent epic)](https://redhat.atlassian.net/browse/AAP-79958)
* Source file: `aap-clouds/topics/con-azure-infrastructure-usage.adoc`
* Parent assembly: `aap-clouds/stories/assembly-azure-intro.adoc` (Introduction to AAP on Azure)

## New Docs

No new modules are required. This change is entirely scoped to updating existing reference data within an existing concept module.

## Updated Docs

* `aap-clouds/topics/con-azure-infrastructure-usage.adoc`
    Update the Azure Database for PostgreSQL "Database shape configuration" table to replace all VM SKU references from the Ds_v3 series to the Dds_v5 series. Specific changes:
    - Plan size 50 row: `Standard_D2s_v3` changes to `Standard_D2ds_v5`
    - Plan size 400 row: `Standard_D4s_v3` changes to `Standard_D4ds_v5`
    - Plan size 1000 row: `Standard_D4s_v3` changes to `Standard_D4ds_v5`
    - Plan size 2500 row: `Standard_D4s_v3` changes to `Standard_D4ds_v5`
    - Plan size 5000 row: `Standard_D4s_v3` changes to `Standard_D4ds_v5`
    - Plan size 10000 row: `Standard_D4s_v3` changes to `Standard_D4ds_v5`
    No other content, structure, or formatting in the file should be modified.

---

## Doc impact assessment

| Requirement | Grade | Rationale |
|-------------|-------|-----------|
| REQ-001: Update Azure Database for PostgreSQL VM SKUs from v3 to v5 series | Medium | Enhancement to existing reference data — changed default VM SKU values in a published table. No new features, no breaking changes, but documented values will not match deployed infrastructure without the update. |

## Gap analysis

| Category | Finding |
|----------|---------|
| Coverage | The infrastructure usage page already covers the correct scope (all plan sizes, database shape, storage, IOPS). No coverage gaps. |
| Currency | The VM SKU values are outdated (Ds_v3 series) and must be updated to Dds_v5 series. This is the sole currency gap. |
| Completeness | The table structure is complete — all six plan sizes are documented with shape, storage, and IOPS columns. No missing rows or columns. |
| Structure | The module is correctly typed as CONCEPT with proper anchor ID, abstract role, and assembly inclusion. No structural issues. |
| User stories | The user journey for understanding Azure infrastructure costs is complete (concept overview, pricing calculator links, scaling guidance). No journey gaps. |

## JTBD hierarchy mapping

| Level | Value |
|-------|-------|
| Category (job_map_stage) | Plan |
| Main Job | Understand Azure infrastructure resource usage and costs |
| User Story | Verify the database VM SKU configuration for my AAP plan size |

## Content journey phase

| Module | Phase | Rationale |
|--------|-------|-----------|
| con-azure-infrastructure-usage.adoc | Evaluate | Users consult this page when evaluating infrastructure costs and planning capacity before committing to or scaling a deployment. |

## Assembly structure

No changes to assembly structure. The file `con-azure-infrastructure-usage.adoc` remains included at `leveloffset=+1` in `assembly-azure-intro.adoc` (line 27). The parent assembly "Introduction to AAP on Azure" is unchanged.

## Implementation order

1. Update `con-azure-infrastructure-usage.adoc` — replace the six VM SKU values in the database table.

This is a single-file change with no dependencies on other modules or assemblies.

## Module specification

### Updated module: con-azure-infrastructure-usage.adoc

| Attribute | Value |
|-----------|-------|
| Type | CONCEPT (existing, no change) |
| Title | {AAPonAzureNameShort} infrastructure usage (existing, no change) |
| Audience | SysAdmin, IT Operations Leader |
| Content journey phase | Evaluate |
| JTBD category | Plan |
| Main job | Understand Azure infrastructure resource usage and costs |
| Prerequisites | None |
| Dependencies | None — self-contained table data update |
| Assembly | assembly-azure-intro.adoc |
| Cross-references from | con-azure-disaster-recovery.adoc, ref-azure-resource-quotas.adoc |

**Content points to update:**
1. Database shape configuration table, plan size 50 row: change `Standard_D2s_v3` to `Standard_D2ds_v5`
2. Database shape configuration table, plan sizes 400/1000/2500/5000/10000 rows: change `Standard_D4s_v3` to `Standard_D4ds_v5`
3. No other edits to prose, structure, links, or formatting

## Content sources

| Source | Type | Key information |
|--------|------|-----------------|
| [AAP-84330](https://redhat.atlassian.net/browse/AAP-84330) | JIRA ticket | Specifies the exact VM SKU changes: D2s_v3 to D2ds_v5, D4s_v3 to D4ds_v5 |
| [AAP-79958](https://redhat.atlassian.net/browse/AAP-79958) | Parent epic | 2026 Q3 Management and Infrastructure improvements for Cloud — provides broader context |
| [Published docs page](https://docs.redhat.com/en/documentation/ansible_on_clouds/2.x/html-single/red_hat_ansible_automation_platform_on_microsoft_azure_guide/index#con-azure-infrastructure-usage_azure-intro) | Existing documentation | Current published state showing outdated v3 SKUs |

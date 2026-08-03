# Documentation Review Report

**Source**: Ticket: AAP-84330
**Date**: 2026-07-28

## Summary

| Metric | Count |
|--------|-------|
| Files reviewed | 1 |
| Fixes applied in place | 7 |
| Errors (must fix) | 0 |
| Warnings (should fix) | 4 |
| Suggestions (optional) | 5 |

## Fixes Applied

The following issues were identified and fixed in place:

1. **con-azure-infrastructure-usage.adoc:16,22,31** -- "Service Shape" changed to "Service shape" (sentence case per RH SSG formatting guidelines).
2. **con-azure-infrastructure-usage.adoc:24** -- "Azure Kubernetes service (AKS)" changed to "Azure Kubernetes Service (AKS)" (product name uses official capitalization per IBM Style Guide references).
3. **con-azure-infrastructure-usage.adoc:28** -- "will move" changed to "move" (present tense per RH SSG grammar guidelines). Trailing whitespace also removed.
4. **con-azure-infrastructure-usage.adoc:31** -- Hard-coded "Ansible Automation Platform" replaced with `{PlatformNameShort}` attribute (per RH SSG formatting: product names must use attributes, not hard-coded names).
5. **con-azure-infrastructure-usage.adoc:41** -- Hard-coded "Ansible Automation Platform" in table header replaced with `{PlatformNameShort}` attribute.
6. **con-azure-infrastructure-usage.adoc:46-47** -- IOPS value "5000" changed to "5,000" for consistency with other IOPS values in the same column that already use commas (per IBM Style Guide numbers: commas in numbers with four or more digits).
7. **con-azure-infrastructure-usage.adoc:56** -- "will work" changed to "work" (present tense per RH SSG grammar guidelines).

## Files Reviewed

### 1. aap-clouds/topics/con-azure-infrastructure-usage.adoc

**Type**: CONCEPT

#### Vale Linting

| Line | Severity | Rule | Message |
|------|----------|------|---------|
| 41 | warning | AsciiDocDITA.ConceptLink | Move all links and cross references to Additional resources. |
| 52 | warning | AsciiDocDITA.ConceptLink | Move all links and cross references to Additional resources. |
| 53 | warning | AsciiDocDITA.ConceptLink | Move all links and cross references to Additional resources. |

#### Structure Review

| Line | Severity | Issue |
|------|----------|-------|
| 8 | warning | Short description is only one sentence. RH SSG requires 2-3 sentences covering *what* and *why*. The current sentence serves as a lead-in to the definition list but does not explain why this information matters to the reader. |
| 39-48 | suggestion | Table lacks a title or caption. Adding a `.Title` line above the table improves accessibility and findability. |

#### Language Review

| Line | Severity | Issue |
|------|----------|-------|
| 14 | suggestion | Passive voice: "The {Azure} service is used for file and block storage." Consider active voice: "Provides file and block storage such as local storage for projects and containers." |
| 20 | suggestion | Passive voice: "The {Azure} service is used to manage all internal networking." Consider active voice: "Manages all internal networking and dependent services such as the Azure Application Gateway." |
| 50 | suggestion | Sentence is 37 words. Consider splitting for readability. For example: "Exact infrastructure usage depends on the length of time that the managed application is deployed in your tenant. Automation requirements can cause the Kubernetes cluster to autoscale to meet the demands of your workload." |
| 53 | suggestion | Sentence is 40+ words. Consider splitting for readability. |

#### Elements Review

| Line | Severity | Issue |
|------|----------|-------|
| 44-45 | suggestion | Plan size values "1000" and "2500" lack commas. If these are numeric node counts (as the column header implies), consider "1,000" and "2,500" for consistency with IOPS values in the same table that already use commas. Skip this if these are product-specific tier label names used as-is in the Azure Marketplace. |

---

## Required Changes

1. **con-azure-infrastructure-usage.adoc:8** -- Short description must be expanded to 2-3 sentences per RH SSG structure guidelines. Add a sentence explaining why understanding infrastructure usage matters to the user.

   Suggested fix:
   > When you install {AAPonAzureNameShort}, you deploy the following infrastructure into your {Azure} subscription. Understanding these components helps you plan for resource allocation and cost management.

   Note: If the original colon-terminated sentence is kept as a lead-in, add a separate abstract paragraph above it.

## Suggestions

1. **con-azure-infrastructure-usage.adoc:14,20** -- Consider replacing passive voice ("is used for", "is used to manage") with active constructions for consistency with other definition list entries that use active voice (e.g., line 13: "Manages local DNS requests").
2. **con-azure-infrastructure-usage.adoc:39** -- Consider adding a table title (e.g., `.Database configuration tiers`) for accessibility and to help screen readers identify the table purpose.
3. **con-azure-infrastructure-usage.adoc:44-45** -- Consider adding commas to plan size values 1000 and 2500 if these are numeric quantities, not product tier names.
4. **con-azure-infrastructure-usage.adoc:50,53** -- Consider splitting long sentences (37 and 40+ words) for improved readability and scannability.
5. **con-azure-infrastructure-usage.adoc:41,52,53** -- Vale flags three external links in the concept module body (AsciiDocDITA.ConceptLink). For DITA conversion readiness, consider moving these to an Additional resources section. This is a DITA-specific guideline and does not affect the current AsciiDoc rendering.

---

*Generated with [Claude Code](https://claude.com/claude-code)*

## Technical Review -- con-azure-infrastructure-usage.adoc

**Doc type detected:** Concept
**Reviewer lens applied:** Architect
**Overall technical confidence:** MEDIUM -- IOPS values and VM specs are verified accurate against Azure documentation, but a broken external link, an inaccurate storage description, and confusing structural grouping reduce implementer usability.

**Note:** JIRA access for ticket AAP-84330 failed (`JIRA_API_TOKEN not set`). This review is based solely on the source file content and cross-referencing with sibling modules and Azure upstream documentation.

---

### Critical issues (must fix before publication)

**C1. Broken external link to Azure PostgreSQL IOPS documentation**

- **Location:** Line 41 -- `link:https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-compute-storage#storage[IOPS]`
- **Issue:** Microsoft has restructured their Azure Database for PostgreSQL documentation. The URL path `/azure/postgresql/flexible-server/concepts-compute-storage` now redirects to the compute-only page at `/azure/postgresql/compute-storage/concepts-compute`. The `#storage` anchor no longer resolves. The storage IOPS information is now at a separate page: `https://learn.microsoft.com/en-us/azure/postgresql/compute-storage/concepts-storage`.
- **Impact:** Readers clicking the IOPS link land on the compute options page, which does not contain the IOPS-by-storage-size table that the link text promises. They cannot verify the IOPS values claimed in the table.
- **Suggestion:** Update the link to `https://learn.microsoft.com/en-us/azure/postgresql/compute-storage/concepts-storage`. Verify the anchor target if a specific section is desired.

---

### Significant issues (should fix)

**S1. Storage account description inaccurately claims "block storage"**

- **Location:** Line 14 -- `Storage account:: The {Azure} service is used for file and block storage such as local storage of projects and containers.`
- **Issue:** Azure Storage Accounts provide blob, file, queue, and table storage -- not block storage. Block storage in Azure is provided by Azure Managed Disks. The term "block storage" has a specific meaning in cloud infrastructure and is technically incorrect here.
- **Impact:** An architect or Azure administrator reading this would find the description inaccurate, which undermines confidence in the rest of the infrastructure details. They may also misunderstand the storage type being provisioned.
- **Suggestion:** Replace "file and block storage" with "blob and file storage" or simply "storage." Also clarify what "containers" means in context (container images? storage containers/blobs?), since the term is ambiguous when discussing a Kubernetes-based deployment.

**S2. Application Gateway service shape is misleadingly nested under Virtual network**

- **Location:** Lines 20-22 -- the Virtual network definition list entry includes "Service Shape: Application Gateway: WAF_v2"
- **Issue:** Azure Application Gateway is a separate Azure service from Azure Virtual Network. While an Application Gateway is deployed into a VNet subnet, it is not a component or feature of VNet. The current structure implies the Application Gateway is the "service shape" of the Virtual network, which is architecturally misleading. VNet itself does not have a "service shape" in the same way that compute or database resources do.
- **Impact:** A reader planning Azure resource quotas or cost estimates may not realize that Application Gateway (WAF_v2 tier) is a separate billed resource requiring its own quota allocation. An architect reviewing infrastructure could misunderstand the component boundaries.
- **Suggestion:** Either break Application Gateway out as its own definition list entry (similar to how AKS and PostgreSQL are separate entries), or clarify the nesting with text like "The virtual network includes an Azure Application Gateway deployed in WAF_v2 tier to manage ingress traffic."

**S3. Table column header "plan size (minimum node count)" is ambiguous**

- **Location:** Line 41 -- `Ansible Automation Platform plan size (minimum node count)`
- **Issue:** The parenthetical "(minimum node count)" is ambiguous. The values in this column (50, 400, 1000, 2500, 5000, 10000) appear to represent the number of managed nodes (hosts to automate) in each subscription tier, not the minimum number of infrastructure nodes. The column header could be read as "minimum number of nodes in the AKS cluster" or "minimum number of managed automation targets." These are very different things.
- **Impact:** Readers may confuse plan tier sizes with infrastructure sizing. The AKS section above states minimum 3 compute nodes, so seeing "50" as a "minimum node count" in a different context creates cognitive dissonance.
- **Suggestion:** Clarify the header to something like "Plan size (managed nodes)" or "Subscription plan tier" with an explanatory note. If "minimum node count" refers to the minimum managed nodes for each plan, state that explicitly.

**S4. Missing cross-reference for disaster recovery storage impact**

- **Location:** Lines 18-19 -- Storage account section mentions "If disaster recovery is not enabled" / "If disaster recovery is enabled"
- **Issue:** The disaster recovery concept is introduced here without context or a cross-reference to the dedicated disaster recovery module (`con-azure-disaster-recovery.adoc`), which is included in the same assembly. The disaster recovery module itself cross-references back to this infrastructure usage module for storage shape details, but the reverse link is missing.
- **Impact:** A reader encountering the disaster recovery condition for the first time in this section has no way to learn what disaster recovery means, how to enable it, or what its implications are, without scrolling through the parent assembly.
- **Suggestion:** Add a cross-reference such as: "For more information about disaster recovery, see xref:con-azure-disaster-recovery_{context}[Disaster recovery]."

**S5. Duplicated AKS tier change information without full context**

- **Location:** Lines 27-29 -- IMPORTANT admonition about AKS Free to Standard tier migration
- **Issue:** This IMPORTANT admonition duplicates content from `con-azure-pricing.adoc` (which states the same Free-to-Standard tier change). The pricing module provides additional context about why the change is happening and its cost implications. This module's version of the same information lacks that context. Having the same statement in two modules creates a maintenance burden and risks the two versions drifting apart.
- **Impact:** Readers may encounter the statement in both places and wonder if they refer to the same change. If one is updated and the other is not, conflicting information results.
- **Suggestion:** Either remove the IMPORTANT admonition from this module and cross-reference `con-azure-pricing.adoc`, or add a cross-reference here that directs readers to the pricing module for full details. Alternatively, use a shared snippet.

---

### Minor issues (consider fixing)

**M1. Managed identity description oversimplifies the service**

- **Location:** Line 10 -- "A {Azure} service that enables {PlatformNameShort} components to communicate with other {Azure} services"
- **Issue:** Azure Managed Identity provides an identity for Azure resources to authenticate with other Azure services without managing credentials. It enables authentication, not communication. The current description could be read as saying Managed Identity handles networking or service communication, which is the role of VNet, DNS, and service endpoints.
- **Suggestion:** Consider: "A {Azure} service that provides identity-based authentication so that {PlatformNameShort} components can securely access other {Azure} services without managing credentials."

**M2. Shareable Azure pricing estimate link may become stale**

- **Location:** Line 53 -- `link:https://azure.com/e/d12a08795a4942c1801c610810791764[Red Hat Ansible Automation Platform on Azure Infrastructure Estimate]`
- **Issue:** Azure pricing calculator shared estimate links (`azure.com/e/...`) can expire, be updated, or become unavailable. There is no indication of when this estimate was created, what assumptions it makes, or what plan size it represents.
- **Impact:** If the link expires, readers get no cost estimation guidance. Even if the link works, readers cannot assess whether the estimate matches their planned deployment.
- **Suggestion:** Add context about what the estimate covers (e.g., which plan size, which region), and note the date the estimate was last verified. Consider adding a note that readers should verify the estimate against their actual deployment parameters.

**M3. No cross-reference to the scaling module despite overlapping content**

- **Location:** Lines 33-35 (autoscaling settings) vs. `con-azure-scaling.adoc`
- **Issue:** This module states "Autoscaling minimum nodes: 3 / Autoscaling maximum nodes: 20." The scaling module (`con-azure-scaling.adoc`) states the same values. There is no cross-reference between them. These are the same values, but the two modules present them in different contexts without linking to each other.
- **Suggestion:** Add a cross-reference to the scaling module, or note that autoscaling behavior is covered in more detail in the scaling section.

**M4. Upgrade process description lacks operational detail**

- **Location:** Lines 55-57 -- "Red Hat site reliability engineers will work with you to upgrade the infrastructure tier"
- **Issue:** The description of the tier upgrade process lacks operational details: how the customer is notified, what the expected timeline is, whether the upgrade involves downtime, and whether the customer can decline.
- **Suggestion:** Add a brief note about the notification process and link to the support or lifecycle documentation for more details.

**M5. Inconsistent article usage in definition list descriptions**

- **Location:** Lines 10-14
- **Issue:** Some definition list descriptions start with "A {Azure} service" (lines 10, 13) while others start with "The {Azure} service" (line 14) or use different phrasing (line 12: "A {Azure} service that enables..."). This is a minor consistency issue.
- **Suggestion:** Standardize the article usage across all definition list entries.

---

### SME verification needed

**SME1. Identical database configuration across plans 400, 1000, and 2500**

- **Location:** Lines 43-45 -- Database table rows for plans 400, 1000, and 2500
- **Issue:** Plans 400, 1000, and 2500 all show identical database configuration: Standard_D4ds_v5, 512 GB, Provisioned 2,300 IOPS. It seems unexpected that a plan designed for 2,500 managed nodes would have the same database resources as one designed for 400 managed nodes. Either this is correct (database workload does not scale linearly with managed nodes in this range) or the table is incomplete.
- **Verification needed:** Confirm with the SRE team or product management that plans 400, 1000, and 2500 genuinely share the same database shape and storage.

**SME2. Whether the IOPS column reflects Premium SSD or Premium SSD v2**

- **Location:** Lines 42-47 -- IOPS column in the database table
- **Issue:** The IOPS values (Provisioned 2,300; up to 3,500 for 512 GB; 5,000 for 1 TB) match the Azure Premium SSD (v1) storage tier exactly. However, Azure also offers Premium SSD v2 with significantly higher IOPS (12,000 baseline free for 512 GB+). If the deployment uses Premium SSD v2, the IOPS values in the table would be wrong. If it uses Premium SSD v1, the values are correct.
- **Verification needed:** Confirm which PostgreSQL storage tier (Premium SSD v1 or v2) the managed application uses, and verify the IOPS values match.

**SME3. Missing infrastructure components**

- **Location:** Entire module -- infrastructure list
- **Issue:** For a Kubernetes-based managed application deployment, several common Azure infrastructure components are not listed: container registry (ACR), network security groups (NSGs), public IP addresses, load balancers (separate from Application Gateway), and Azure Monitor (beyond Log Analytics Workspace). These may be managed transparently, grouped under other listed services, or genuinely not used.
- **Verification needed:** Confirm whether the listed infrastructure is exhaustive or whether additional resources are deployed that the customer should be aware of for cost estimation and quota planning purposes.

**SME4. Verify that {PlatformVers} resolves correctly in the AKS tier IMPORTANT admonition**

- **Location:** Line 28 -- `{PlatformNameShort} {PlatformVers}`
- **Issue:** The attribute `{PlatformVers}` resolves to "2.5" per the attributes file. The IMPORTANT admonition therefore reads "when upgrading to Ansible Automation Platform 2.5." If AAP on Azure has moved beyond 2.5, or if this change applies to a specific minor release, the version reference may be stale or too broad.
- **Verification needed:** Confirm that "2.5" is the correct version for the AKS tier change. If the change has already occurred for all deployments, consider rephrasing to past tense or removing the version reference.

---

### Strengths

- **IOPS values are accurate.** Cross-referencing with the current Azure PostgreSQL Flexible Server storage documentation confirms that the Premium SSD IOPS values (2,300 provisioned / up to 3,500 for 512 GB; 5,000 for 1 TB) are correct.
- **VM specs are accurate.** The Standard_D4ds_v5 spec (4 vCPUs x 16 GiB) matches the official Azure Ddsv5-series documentation.
- **Storage redundancy correctly tied to disaster recovery.** The LRS vs. GRS distinction based on disaster recovery enablement is architecturally sound and correctly described.
- **Clear tier differentiation in the database table.** The table provides a useful at-a-glance view of how database resources scale with plan size.
- **Includes external estimation tools.** Pointing readers to the Azure Pricing Calculator and providing a pre-configured estimate link demonstrates good customer empathy.
- **The module is well-placed in the assembly.** It follows the disaster recovery and architecture modules in `assembly-azure-intro.adoc`, giving readers the right context before encountering infrastructure details.

Severity counts: critical=1 significant=5 minor=5 sme=4

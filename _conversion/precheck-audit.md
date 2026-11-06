# AAP on Microsoft Azure pre-check audit

**Run:** 2026-11-05, `conversion-aap-azure` at source `d7307c91c2` (evidence snapshot `19664cba03`); versionless; CSV-generated `aap-on-azure` navigation map.

**Readiness:** Not ready for conversion. The writer must complete the source fixes and content decisions below. The conversion engineer must then incorporate the updated source, rerun the pre-check, and verify the agreed map scope and cleaned output before full conversion. The 2026-11-06 isolated probe verifies the map-nesting fix with `-A`; five assembly-only dependencies still require scope decisions, and full readiness remains unverified.

## Asciidoctor

### The Access assembly retains three missing peering includes

The generated Access map selects `aap-clouds/stories/assembly-azure-access.adoc`. In that source assembly, lines 15, 17, and 19 still include the nonexistent files `assembly-azure-network-peering.adoc`, `assembly-azure-hub-spoke-peering.adoc`, and `assembly-azure-vwan-peering.adoc`. Asciidoctor reports `include file not found` ([log](logs/asciidoctor.log#L6)); conversion also cannot load them ([log](logs/conversion.log#L2)). These are stale references inside a selected assembly, rather than missing CSV-selected source files. The current peering concepts and procedures exist under `aap-clouds/topics/` and are included by `assembly-azure-post-deployment-requirements.adoc:15-42`.

**Decision and fix:** Should peering instructions appear only under post-deployment requirements, or also within the Access job?

- If they belong only under post-deployment, remove the three stale include directives at lines 15, 17, and 19, and the `assembly-azure-direct-peering.adoc` include at line 21 from `assembly-azure-access.adoc`. Direct peering remains included by the post-deployment assembly at line 42. This was the previous audit's proposed disposition; writer confirmation is required because CSV membership alone does not decide assembly dependencies.
- If Access also needs peering instructions, replace the three stale assembly references with the intended current topic/assembly includes and their required procedure dependencies. Confirm the resulting Access hierarchy with the content architect and update the JTBD scope if it changes. Do not create empty assemblies merely to satisfy the filenames.

Asciidoctor also reports `section title out of sequence: expected level 5, got level 6` for the direct-peering include ([log](logs/asciidoctor.log#L9)). If retained under `== Post-deployment prerequisites`, change its `leveloffset=+3` to `+2` so it starts immediately below that section; verify the hierarchy on rerun. If removed from Access, verify that the warning disappears while post-deployment still contains direct peering.

**Owner:** Writer (content placement and source edits); content architect if approved scope/hierarchy changes · **Timing:** Before conversion — record the placement decision and apply the corresponding include edits.

### The Access assembly uses different filenames for the SSO and license topics

The saved CSV input and project notes select `aap-clouds/topics/ref-azure-license-association.adoc` and `aap-clouds/topics/con-azure-configure-ad-sso.adoc`, and both files exist. However, lines 33 and 35 of `aap-clouds/stories/assembly-azure-access.adoc` use the different names `proc-azure-license-association.adoc` and `proc-azure-configure-ad-sso.adoc`. Those names do not match the mapped files, so Asciidoctor cannot find them ([log](logs/asciidoctor.log#L12)). Update line 33 to include `topics/ref-azure-license-association.adoc` and line 35 to include `topics/con-azure-configure-ad-sso.adoc`. The source include paths are stale; the selected topic files exist and retain their confirmed REFERENCE and CONCEPT types.

**Owner:** Writer · **Timing:** Before conversion — correct both include paths; the conversion engineer verifies them on rerun.

## Vale and DITA cleanup

### The access procedure needs its own section level

Vale flags `assembly-azure-access.adoc:31` (`MapLevel`: invalid `leveloffset`) ([log](logs/vale.log#L1)). The assembly starts its included topics at `+2`, then uses `+1` for `proc-azure-accessing-aap.adoc`. The `// Accessing AAP` line is a comment, so it creates no section to separate access instructions from “Post-deployment prerequisites.” Replace the comment with the second-level heading `== Accessing AAP` and change the procedure include to `leveloffset=+2`; this keeps the procedure under its own section and satisfies the map-level rule.

**Owner:** Writer · **Timing:** Before conversion — correct the section structure; the conversion engineer verifies it on rerun.

### Restructure the Support assembly

Vale reports `Content other than additional resources cannot follow include directives` at `aap-clouds/stories/assembly-azure-support.adoc:18` ([log](logs/vale.log#L3)). The source includes `ref-azure-responsibilities.adoc` at line 16 and then defines four inline sections. Those sections contain substantive guidance, so deleting them would lose content. The first three have existing, scoped concept destinations, but those topics currently contain only short introductions and KB links.

**Fix:** In `aap-clouds/stories/assembly-azure-support.adoc`, extract the following sections into their existing files under `aap-clouds/topics/`, merging repeated introductory text and retaining all additional guidance. Replace each extracted section with an include of its destination topic at the agreed section level:

- Lines 18-25 → `con-azure-virtual-appliance-routing.adoc`: preserve the peering, outbound routing, and allowlist guidance.
- Lines 27-53 → `con-azure-private-dns.adoc`: preserve zone-conflict guidance, the AKS zone restriction, customer record responsibilities, backup exclusions, and connectivity warnings.
- Lines 55-62 → `con-azure-policy.adoc`: preserve the policy-enforcement impact and exclusion guidance.

Apply the concept-link placement fix below while moving the material. These destination topics also appear in other Azure jobs, so confirm that the merged guidance reads correctly in those uses. The conversion engineer must verify that all newly included topics are explicitly represented in the agreed CSV/map scope; assembly-internal includes alone do not make them reachable under the verified `-A` approach below.

**Timeline destination decision:**

The fourth inline section, `aap-clouds/stories/assembly-azure-support.adoc:64-70`, records weekly notices, an unsupported-state transition after two weeks, and possible infrastructure scale-down after 90 days. This timeline is absent from the other source modules inspected; `ref-azure-limited-support-status.adoc` covers related support conditions but lacks these timings. It must be preserved when the assembly prose is extracted.

**Decision and fix:** Does this timeline belong in the existing `aap-clouds/topics/ref-azure-limited-support-status.adoc`, or in a separate topic? If it belongs in the existing reference, move the section there and remove it from the assembly. If it needs a new topic, create that module, replace the inline section with its include, and coordinate its addition to the JTBD scope with the content architect. If removing the inline heading changes the nesting of the limited-support include at line 72 (`leveloffset=+2`), adjust that include to match the intended hierarchy. Preserve the subsequent maintenance-window include.

**Owner:** Writer (content moves, timeline destination, and source edits) · **Timing:** Before conversion — move all four inline sections into topic modules, preserve their guidance, and update the assembly includes and JTBD scope where needed.

### Links in concept topics

Vale and `dita-cleanup.log` identify links in concept-topic bodies ([Vale findings](logs/vale.log#L2), [cleanup findings](logs/dita-cleanup.log#L1)). The affected topic modules declare concept content (the SSO concept mapping is confirmed in the project notes); their URLs are in body text or in unrecognized resources blocks. For direct body links, keep the explanatory text and move each URL into a bulleted `Additional resources` block marked with `[role="_additional-resources"]` followed by `.Additional resources`. `con-azure-about.adoc:13-15` and `con-azure-architecture.adoc:42-44` already have `_additional-resources` role markers, but no section title; add `.Additional resources` immediately after each role marker so the converter recognizes the block, and make the link in `con-azure-about.adoc` a list item (`* link:...`). Preserve the existing bullets in `con-azure-architecture.adoc`. Affected source locations:

- `aap-clouds/topics/con-aap-notification-feed.adoc:10`; `aap-clouds/topics/con-azure-configure-ad-sso.adoc:10`.
- `aap-clouds/topics/con-azure-infrastructure-usage.adoc:46,57`; `aap-clouds/topics/con-azure-maintenance-upgrade.adoc:53`; `aap-clouds/topics/con-azure-network-peering.adoc:31,38,41`.
- `aap-clouds/topics/con-azure-policy.adoc:12`; `aap-clouds/topics/con-azure-private-dns.adoc:13`; `aap-clouds/topics/con-azure-scaling.adoc:8`; `aap-clouds/topics/con-azure-user-defined-routing-tables.adoc:13`; `aap-clouds/topics/con-azure-virtual-appliance-routing.adoc:14`; `aap-clouds/topics/con-azure-vnet-cidr.adoc:38`.
- `aap-clouds/stories/assembly-azure-install-prerequisites.adoc:21`.
- `aap-clouds/stories/assembly-azure-support.adoc:25,44,53,62`. Apply these placements after restructuring the support assembly above; cleanup confirms these links land in concept topics.

For `con-azure-scaling.adoc:8`, keep the abstract text but remove its inline link and add that URL under Additional resources. In `con-azure-infrastructure-usage.adoc`, keep the `IOPS` table text and place its linked source in Additional resources; move the line 57 URL there as well. `con-aap-notification-feed.adoc` is shared with the SaaS AWS assembly, so coordinate that shared-source fix with the AWS workstream. For the support assembly, complete link placement after moving its content into topic modules.

In `assembly-azure-install-prerequisites.adoc:21`, keep the account requirement bullet and move its URL to an Additional resources block for the `Platform requirements` concept chunk.

**Owner:** Writer · **Timing:** Before conversion — fix the link placement and coordinate the shared notification-feed edit with the AWS writer; the conversion engineer verifies the result on rerun.

### Short descriptions exceed the limit

Cleanup reports converted short descriptions of 314, 312, and 352 characters; the converted short-description limit is 300 characters ([first finding](logs/dita-cleanup.log#L8), [second](logs/dita-cleanup.log#L9), [third](logs/dita-cleanup.log#L17)). Shorten the `[role="_abstract"]` paragraph in `aap-clouds/topics/con-azure-lifecycle.adoc`, `aap-clouds/topics/ref-azure-nw-private-deploy-az-hosted-vm.adoc`, and `aap-clouds/topics/ref-azure-limited-support-status.adoc` so each converted short description is 300 characters or fewer after attributes expand. Keep only the summary in the abstract and move supporting detail into the topic body.

**Owner:** Writer · **Timing:** Before conversion — shorten the three abstracts; the conversion engineer checks the expanded lengths on rerun.

## Conditionals

### Remove avoidable context conditionals and correct Support context handling

The Azure scan covers 79 included files and records 15 `ifdef` directives across eight assemblies ([scan summary](logs/azure-conditionals.log#L4), [directive locations](logs/azure-conditionals.log#L7)). These guards save or restore `context`, which contributes to IDs such as `azure-limited-support-status_{context}`; the scan found no `ifeval` or content-selection branches. The conversion preference is to avoid conditionals unless necessary, including context-management guards. Their purpose alone does not establish that they must be retained.

**Fix:** For the following files under `aap-clouds/stories/`, inspect their callers and nested includes to establish which incoming context values must be preserved:

- `assembly-azure-access.adoc`
- `assembly-azure-connecting-to-aap.adoc`
- `assembly-azure-deploy.adoc`
- `assembly-azure-direct-peering.adoc`
- `assembly-azure-install-prerequisites.adoc`
- `assembly-azure-intro.adoc`
- `assembly-azure-post-deployment-requirements.adoc`
- `assembly-azure-support.adoc`

Where a fixed invocation context permits it, replace the conditional save/restore logic with explicit context assignments or resets appropriate to that invocation. Preserve the context values required by included topics and cross-references; do not simply delete the guards. Where shared or nested use genuinely requires caller-dependent behavior, record why the conditional is necessary and agree its conversion handling with the conversion engineer. A single unconditional replacement has not been verified for all uses.

The Support assembly also has an incomplete save/restore sequence: it saves the incoming context at line 3, sets `context` to `azure-support` at line 8, and never restores or clears it at the end. Correct this as part of the conditional removal. If its guards prove necessary and are retained, complete the sequence with `ifdef::parent-context[:context: {parent-context}]` and `ifndef::parent-context[:!context:]`; adding those guards is the fallback, rather than the preferred fix.

The duplicate-ID warning for `azure-limited-support-status_azure-support` also involves the topic appearing inside the assembly and as a direct map entry ([log](logs/asciidoctor.log#L21)); assess repeated content separately under [generated map validation](#correct-the-converter-invocation-and-confirm-assembly-only-scope).

**Owner:** Writer (remove avoidable guards, correct context handling, and explain necessary exceptions); conversion engineer (agree exception handling and verify IDs and references) · **Timing:** Before conversion — simplify the source and record any necessary retained conditionals; the conversion engineer verifies context-dependent IDs and references on rerun.

The Azure-specific scan covers the included `aap-clouds/` files; its findings require the assessment above.

## Conversion log

### Correct the converter invocation and confirm assembly-only scope

The original `conversion.log` reports `invalid mapref child element` across all seven generated job maps ([log](logs/conversion.log#L95)). The maps encode an assembly followed by child topic entries, but `convert -rC` turns that assembly into a `<mapref>` with invalid nested topic references. The source sheet's hierarchy does not need changing to fix this defect.

**Verified fix:** In an isolated 2026-11-06 comparison using unchanged Azure source and a refreshed CSV that generates identical AsciiDoc maps, adding `-A` (`convert -ArC`) reduced invalid-mapref warnings from 61 to zero. Whole-navigation DITA-OT validation found seven map content-model errors in the baseline and none with `-A`. All seven job maps have resolving topic/map targets, retained introductory titles and short descriptions, and no repeated topic href within a job. Direct `csv2map --ditamap` generation also avoids invalid nesting, but is not required for this fix and still requires its additional map-root chunking to be assessed. The results are recorded in the [verification summary](logs/audit-verification.log).

**Conversion action:** Use `-A` for this CSV/assembly-based conversion so assemblies become topic references that can contain the sheet-listed child topics. Ensure that the verification pre-check's conversion dry run uses the same option; the current generic pre-check and conversion wrappers use `-rC`. Do not change topic types or flatten the sheet hierarchy to work around the converter setting. The corrected probe builds still report link/chunk and image issues, so this verifies the map-nesting fix rather than full conversion readiness.

**Writer scope decision:** With either corrected map approach, five converted files are no longer reachable through assembly-internal map references, because they have no explicit CSV entries. Being converted is not sufficient for inclusion in the published navigation. Confirm whether to retain or intentionally exclude:

- Direct peering: `aap-clouds/stories/assembly-azure-direct-peering.adoc` and its child `aap-clouds/topics/proc-azure-nw-direct-peering.adoc`. These are reached through `assembly-azure-post-deployment-requirements.adoc:42` and the stale Access structure; align their placement with the earlier Access peering decision.
- Prerequisites: `aap-clouds/topics/proc-monitor-deployment-driver.adoc`, `aap-clouds/topics/proc-deploy-subscription-support-offering.adoc`, and `aap-clouds/topics/proc-manual-entitlement-process.adoc`, currently included by `assembly-azure-install-prerequisites.adoc:40,42,44`.

If retained, add explicit entries at the confirmed locations in the authoritative JTBD sheet and the derived Azure export, including the nested direct-peering procedure. If excluded, record the intentional exclusion and align the source includes. The conversion engineer must regenerate maps and verify every agreed topic is reachable. Apply the same check to new includes introduced by the Support restructuring.

The original duplicate-ID warnings arise where the assembly-expanding path includes topics both through source assemblies and direct CSV entries ([log](logs/asciidoctor.log#L1)); do not rename source IDs solely to silence those duplicate inclusions. Reassess IDs and references using the agreed scope and corrected conversion approach.

**Owner:** Conversion engineer (converter option, map generation, and verification); Writer (include/exclude decisions and sheet/source updates) · **Timing:** Before conversion — confirm the five dependency dispositions and align the sheet; use the verified converter option for the rerun and validate the agreed scope after conversion cleanup.

### Use a stable lifecycle topic ID and update its cross-reference

The source link in `aap-clouds/topics/ref-azure-responsibilities.adoc:98` hard-codes `con-azure-lifecycle_azure-intro`, but standalone conversion produces the title-context ID `con-azure-lifecycle_azure`. The topic exists; the mismatched IDs break the link, and standard cleanup alone does not repair it ([original warning](logs/conversion.log#L85), [cleanup test summary](logs/audit-verification.log)).

**Verified source fix:**

- In `aap-clouds/topics/con-azure-lifecycle.adoc:3`, replace `[id="con-azure-lifecycle_{context}"]` with `[id="con-azure-lifecycle"]`.
- In `aap-clouds/topics/ref-azure-responsibilities.adoc:98`, replace `xref:con-azure-lifecycle_azure-intro[` with `xref:con-azure-lifecycle[`, preserving the link text.

The [source-fix test](logs/audit-verification.log) verified the link in both the current AsciiDoc book and converted HTML after normal cleanup, without a manual DITA rewrite. Repository search found no other authored lifecycle xrefs to update. This changes the topic anchor; if preserving the existing source ID is required, use the previously verified generated-DITA repair instead. Source edits have only been tested on temporary copies.

**Owner:** Writer (topic ID and source cross-reference); conversion engineer (final link verification) · **Timing:** Before conversion — apply the source fix; during conversion — verify the rendered destination after organization and cleanup.

## Scope note

All sheet-selected source files were found in the original generated map ([scope audit](logs/azure-scope-audit.log#L5)). The five assembly-only dependencies requiring writer decisions are listed in the conversion finding above.

**Retained input:** [Azure JTBD CSV](azure-jtbd-scope.csv), refreshed 2026-11-06 and confirmed to generate the same AsciiDoc maps as the original run.

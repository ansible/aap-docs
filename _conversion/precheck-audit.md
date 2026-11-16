# AAP Service on AWS pre-check audit

**Run:** 2026-11-16 · `conversion-aap-service-aws` at `514bf4be53` (source branch base `56a211d342`, including `upstream/aap-clouds-latest` at `241fc058fd`) · versionless product · CSV map mode, prefix `aap-service-aws`.

**Readiness:** Not ready for conversion. The writer must move the remaining link out of its concept abstract and rerun the pre-check. The separate conversion-engineer work below concerns generated maps and final DITA output.

## Writer source fix

### Move the access-management link to Additional resources

[`dita-cleanup.log`](logs/dita-cleanup.log), line 1, flags the link in the abstract of `aap-clouds/topics/con-saas-identity-and-access-management.adoc`. Move the existing link, preserving its destination and link text, into a link-only `[role="_additional-resources"]` / `.Additional resources` block. Keep the explanation in the abstract and rerun the pre-check.

**Owner:** Writer · **Timing:** Before conversion — source fix

## Conversion-engineer work

### Keep the verified converter mode

The pre-check used `-ArC` (`conversion.log`, line 1), which the focused comparison in [`audit-verification.log`](logs/audit-verification.log) verified for this map structure. The AWS conversion runbook now passes `--assembly-topics`; confirm the conversion log also reports `-ArC`.

**Owner:** Conversion engineer · **Timing:** During conversion — confirm the logged mode

### Remove redundant chunking from generated category maps

The map generator adds chunking to category-level includes when a job has child H2 topics. The job map already chunks its assembly, so the generated category map repeats the chunk boundary. The earlier focused correction removed the category-level attribute from ten includes and cleared the DITA-OT chunk diagnostics while preserving the approved hierarchy and job chunking. A refreshed map preview shows one additional include in the new “What’s new” category; that include still needs a DITA-OT build check.

After generating maps from the refreshed CSV, remove `chunk="to-content"` from these category-map includes only:

- `aap-service-aws-plan.adoc`: `control-plane.adoc`, `execution-plane.adoc`, and `red-hat-ansible-automation-platform-service-on-aws-pull-and-push-models.adoc`.
- `aap-service-aws-get-started.adoc`: `set-up-red-hat-ansible-automation-platform-service-on-aws.adoc`.
- `aap-service-aws-administer.adoc`: `account-management.adoc`, `support.adoc`, `red-hat-ansible-automation-platform-service-on-aws-subscription-lifecycle.adoc`, and `red-hat-ansible-automation-platform-best-practices.adoc`.
- `aap-service-aws-configure.adoc`: `red-hat-ansible-automation-platform-service-on-aws-private-link-connectivity.adoc`.
- `aap-service-aws-optimize.adoc`: `multiregion-activepassive-infrastructure.adoc`.
- `aap-service-aws-whats-new.adoc`: `ansible-automation-platform-service-on-aws-release-notes.adoc`.

Keep chunking on the job maps and their assembly includes. Run DITA-OT on the corrected refreshed maps and confirm the chunk errors are gone and job content remains reachable.

**Owner:** Conversion engineer · **Timing:** Before conversion — adjust generated maps; during conversion — verify the build

### Verify the three cross-references after cleanup

The source xrefs already name their target files and IDs, and the focused test in [`audit-verification.log`](logs/audit-verification.log) confirmed them before organization. The current [`missing-refs.log`](logs/missing-refs.log) still marks them `VERIFY`, so check the final hrefs and anchors after organization and cleanup:

- `proc-saas-standard-ingress-configuration.adoc` → `ref-saas-network-dns-routing#ref-saas-network-dns-routing`
- `ref-saas-exe-plane-strategy.adoc` → `ref-saas-infrastructure-metering#ref-saas-infrastructure-metering`
- `ref-saas-network-dns-routing.adoc` → `proc-saas-standard-ingress-configuration#proc-saas-standard-ingress-configuration`

If a final target file or ID is missing, send that specific link to the writer for correction.

**Owner:** Conversion engineer · **Timing:** During conversion — verify final links

### Package the six images

The prior isolated DITA-OT build reported six missing images ([`audit-verification.log`](logs/audit-verification.log), lines 221–226). Image cleanup normalizes hrefs but does not copy assets. Copy these files from `aap-clouds/images/` into `_conversion/dita/images/`, then rerun image cleanup until it reports no missing files: `AWS_tenant_isolation.png`, `automation_mesh.png`, `one-zone-subnet.png`, `many-zone-subnet.png`, `mesh_egress.png`, and `mesh_ingress.png`.

**Owner:** Conversion engineer · **Timing:** During conversion — copy assets and verify image links

### Normalize the output filename

[`vale.log`](logs/vale.log), lines 1–2, flags the uppercase `CIDR` in the included source filename. Use the standard rename step after organization to lowercase `con-saas-networking-with-overlapping-CIDR-blocks.dita` and update DITA references. Keep the source filename unchanged; the prior rename test is recorded in [`audit-verification.log`](logs/audit-verification.log).

**Owner:** Conversion engineer · **Timing:** During conversion — rename output and verify references

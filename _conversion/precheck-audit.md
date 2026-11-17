# AAP Service on AWS pre-check audit

**Run:** 2026-11-17 · `conversion-aap-service-aws` source tree at `ce69c84521` (writer commits `a4f16efeea` and `bd8100b193`) · versionless · CSV map mode with `--assembly-topics` (`-ArC`), prefix `aap-service-aws`.

**Readiness:** Not ready for conversion. Fix the source link issue below and complete the map-chunk, duplicate-ID, cross-reference, and image checks before conversion.

## Source and JTBD follow-up

### Correct the source link in the AWS update

In `aap-clouds/topics/ref-saas-disconnect-aws-privatelink.adoc`, line 20, the PULL/PUSH link contains `.../documentation//ansible_on_clouds...` with a doubled slash. Correct the URL to a single slash and confirm its destination.

**Owner:** Writer · **Timing:** Before conversion — source fixes

## Conversion-engineer follow-up

### Keep the verified converter mode

The current [`conversion.log`](logs/conversion.log), line 1, confirms the pre-check used `-ArC`; the runbook passes `--assembly-topics`. Use the same option for the production conversion and confirm that its log reports `-ArC`. The prior focused comparison remains historical evidence.

**Owner:** Conversion engineer · **Timing:** During conversion — confirm the logged mode

### Resolve duplicate-ID warnings from assembly and topic inputs

The current [`asciidoctor.log`](logs/asciidoctor.log) contains 84 warnings of the form `id assigned to section already in use`. Source inspection shows the warned topic files are included by their selected parent assemblies and also appear as H2 entries in the CSV map (for example, the renamed PrivateLink procedure is included by `assembly-saas-control-plane.adoc`). The run completed map generation and navigation checks, but the shared guidance does not define whether these duplicate-ID warnings are expected for `-ArC` output. Verify in the DITA-OT build whether the assembly and standalone topic outputs retain duplicate IDs or break links; do not change stable source IDs solely to silence the AsciiDoc warning.

**Owner:** Conversion engineer · **Timing:** During conversion — verify the generated DITA and record the warning disposition

### Remove redundant chunking from generated category maps

The map generator adds chunking to category-level includes when a job has child H2 topics. The job map already chunks its assembly, so the generated category map repeats the chunk boundary. The earlier focused correction removed the category-level attribute from ten includes and cleared the DITA-OT chunk diagnostics while preserving the approved hierarchy and job chunking. The Nov 17 pre-check regenerated maps from the corrected temporary CSV but did not run DITA-OT, so the current category maps still need a build check. Compare the regenerated map against the historical include list below before applying those adjustments.

After generating maps from the refreshed CSV, remove `chunk="to-content"` from these category-map includes only:

- `aap-service-aws-plan.adoc`: `control-plane.adoc`, `execution-plane.adoc`, and `red-hat-ansible-automation-platform-service-on-aws-pull-and-push-models.adoc`.
- `aap-service-aws-get-started.adoc`: `set-up-red-hat-ansible-automation-platform-service-on-aws.adoc`.
- `aap-service-aws-administer.adoc`: `account-management.adoc`, `support.adoc`, `red-hat-ansible-automation-platform-service-on-aws-subscription-lifecycle.adoc`, and `red-hat-ansible-automation-platform-best-practices.adoc`.
- `aap-service-aws-configure.adoc`: `red-hat-ansible-automation-platform-service-on-aws-private-link-connectivity.adoc`.
- `aap-service-aws-optimize.adoc`: `multiregion-activepassive-infrastructure.adoc`.
- `aap-service-aws-whats-new.adoc`: `ansible-automation-platform-service-on-aws-release-notes.adoc`.

Keep chunking on the job maps and their assembly includes. Run DITA-OT on the regenerated maps and confirm the chunk errors are gone and job content remains reachable. The include list above describes the earlier generated maps; recheck it against the current live-sheet export after the JTBD row is updated.

**Owner:** Conversion engineer · **Timing:** Before conversion — adjust generated maps; during conversion — verify the build

### Verify the three cross-references after cleanup

These three source xrefs remain in the current tree. The current [`missing-refs.log`](logs/missing-refs.log) marks each `VERIFY`: its target source is selected, but the cleaned destination file and anchor are not checked by this pre-check. Verify the final hrefs and anchors after organization and cleanup; the earlier focused test in [`audit-verification.log`](logs/audit-verification.log) is historical:

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

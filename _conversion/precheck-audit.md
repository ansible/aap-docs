# AAP Service on AWS pre-check audit

**Run:** 2026-11-17 · `conversion-aap-service-aws` source tree at `367cd2c8e2` (includes writer fix `45a2f7af6d`) · versionless · CSV map mode, 11 jobs and 87 H2 topics · `--assembly-topics` (`-ArC`) · prefix `aap-service-aws`.

**Readiness:** Not ready for conversion. Regenerate the maps from the live export and remove the redundant category-level chunk attributes listed below. Then verify the generated output during conversion.

## Generated map chunking

The job map chunks its assembly, and the generated category map repeats that chunk boundary. The current live export produces 11 affected category-level includes. In the generated maps, remove `chunk="to-content"` from:

- `aap-service-aws-plan.adoc`: `control-plane.adoc`, `execution-plane.adoc`, and `red-hat-ansible-automation-platform-service-on-aws-pull-and-push-models.adoc`.
- `aap-service-aws-get-started.adoc`: `set-up-red-hat-ansible-automation-platform-service-on-aws.adoc`.
- `aap-service-aws-administer.adoc`: `account-management.adoc`, `support.adoc`, `red-hat-ansible-automation-platform-service-on-aws-subscription-lifecycle.adoc`, and `red-hat-ansible-automation-platform-best-practices.adoc`.
- `aap-service-aws-configure.adoc`: `red-hat-ansible-automation-platform-service-on-aws-private-link-connectivity.adoc`.
- `aap-service-aws-optimize.adoc`: `multiregion-activepassive-infrastructure.adoc`.
- `aap-service-aws-whats-new.adoc`: `ansible-automation-platform-service-on-aws-release-notes.adoc`.

Keep chunking on job maps and their assembly includes. A focused correction to the earlier map removed these redundant category boundaries and cleared its DITA-OT chunk diagnostics; recheck the current map after applying the change.

**Owner:** Conversion engineer · **Timing:** Before conversion — correct generated maps; during conversion — confirm there are no chunk errors and job content remains reachable

## Duplicate IDs

The current [`asciidoctor.log`](logs/asciidoctor.log) has 84 warnings of the form `id assigned to section already in use`. The warned topic files are included by selected parent assemblies and also appear as direct H2 entries in the CSV map; for example, `aap-clouds/topics/ref-saas-disconnect-aws-privatelink.adoc` is both a topic-map entry and included by `assembly-saas-private-link.adoc`. The pre-check did not establish whether the build retains duplicate IDs or breaks links.

Verify duplicate IDs in the generated DITA and build; do not change stable source IDs solely to silence these AsciiDoc warnings.

**Owner:** Conversion engineer · **Timing:** During conversion — verify generated IDs and record the warning disposition

## Cross-references

The current [`missing-refs.log`](logs/missing-refs.log) marks three IDs `VERIFY`: their target source files are selected, but the cleaned destination file and anchor are not checked. Verify the final hrefs and anchors after organization and cleanup:

- `proc-saas-standard-ingress-configuration.adoc` → `ref-saas-network-dns-routing#ref-saas-network-dns-routing`
- `ref-saas-exe-plane-strategy.adoc` → `ref-saas-infrastructure-metering#ref-saas-infrastructure-metering`
- `ref-saas-network-dns-routing.adoc` → `proc-saas-standard-ingress-configuration#proc-saas-standard-ingress-configuration`

If a final target file or ID is missing, send that specific link to the writer for correction.

**Owner:** Conversion engineer · **Timing:** During conversion — verify final links

## Images

The prior isolated DITA-OT check reported six missing images; image cleanup normalizes hrefs but does not copy assets. Copy the following files from `aap-clouds/images/` to `_conversion/dita/images/`, then verify image links:

`AWS_tenant_isolation.png`, `automation_mesh.png`, `one-zone-subnet.png`, `many-zone-subnet.png`, `mesh_egress.png`, and `mesh_ingress.png`.

**Owner:** Conversion engineer · **Timing:** During conversion — copy assets and verify image links

## Output filename

The current [`vale.log`](logs/vale.log) flags uppercase `CIDR` in `con-saas-networking-with-overlapping-CIDR-blocks.adoc`. The converted filename inherits that casing. Run the standard rename step after organization; it changes the DITA filename to `con-saas-networking-with-overlapping-cidr-blocks.dita` and updates its map reference. Keep the source filename unchanged.

**Owner:** Conversion engineer · **Timing:** During conversion — normalize the DITA filename and verify references

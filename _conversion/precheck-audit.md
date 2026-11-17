# AAP on Microsoft Azure pre-check audit

**Run:** 2026-11-17 · `conversion-aap-azure` source tree at `88785f8e6e` (includes shared source commit `45a2f7af6d`) · versionless · CSV map mode, 7 jobs and 63 H2 topics · `--assembly-topics` (`-ArC`) · prefix `aap-on-azure`.

**Readiness:** Ready for conversion. All selected source paths exist and the current [`navigation-scope.log`](logs/navigation-scope.log) reports no navigation discrepancies. Complete the conversion-stage checks below before AEM handoff.

## Duplicate IDs

The current [`asciidoctor.log`](logs/asciidoctor.log) contains 13 warnings of the form `id assigned to section already in use`. Each warned topic is included by a selected assembly and also appears as a direct H2 row in the CSV input; for example, `ref-major-upgrade-considerations.adoc` is included by `assembly-azure-deploy.adoc`. Verify in the DITA-OT build whether the assembly and standalone topic outputs retain duplicate IDs or break links. Do not change stable source IDs solely to silence the AsciiDoc warnings.

**Owner:** Conversion engineer · **Timing:** During conversion — verify generated IDs and record the warning disposition

## Assembly context

The current [`conditionals.log`](logs/conditionals.log) lists guards in these seven selected assemblies:

- `assembly-azure-connecting-to-aap.adoc`
- `assembly-azure-deploy.adoc`
- `assembly-azure-install-prerequisites.adoc`
- `assembly-azure-intro.adoc`
- `assembly-azure-post-deployment-requirements.adoc`
- `assembly-azure-release-notes.adoc`
- `assembly-azure-support.adoc`

The release-notes assembly also sets `:context: azure-release-notes`. Verify generated IDs and cross-references for these assemblies in the converted output.

**Owner:** Conversion engineer · **Timing:** During conversion — verify generated IDs and links

## Lifecycle link

The current [`conversion.log`](logs/conversion.log#L70) warns twice about `#con-azure-lifecycle`. [`missing-refs.log`](logs/missing-refs.log#L5) marks it `VERIFY`: `aap-clouds/topics/con-azure-lifecycle.adoc` is selected, but the cleaned destination and anchor have not been checked. The source fix is present: `con-azure-lifecycle.adoc` declares `con-azure-lifecycle`, and `ref-azure-responsibilities.adoc` links to it.

After cleanup, verify that `con-azure-lifecycle.dita` contains the ID and that the rendered link resolves to the intended destination and anchor.

**Owner:** Conversion engineer · **Timing:** During conversion — verify the cleaned target and rendered link

# AAP on Microsoft Azure pre-check audit

**Run:** 2026-11-17 · `conversion-aap-azure` source tree at `4aaef1adac` (writer commits `a4f16efeea` and `bd8100b193`) · versionless · `aap-on-azure-navigation` generated with `--assembly-topics` (`-ArC`). The derived CSV input was rebuilt locally from the freshly exported JTBD source tab: 7 jobs and 63 H2 topics. The Azure csv2map export tab has since been refreshed to match.

**Readiness:** Ready for conversion handoff. All selected source paths exist and navigation has no discrepancies. The conversion engineer should complete the conversion-stage ID, context, and lifecycle-link checks.

## Duplicate IDs from assembly and topic inputs

The current [`asciidoctor.log`](logs/asciidoctor.log) has 13 warnings of the form `id assigned to section already in use`. Each warned topic is included by a selected assembly and also appears as a direct H2 row in the csv2map input (for example, `ref-major-upgrade-considerations.adoc` is included by `assembly-azure-deploy.adoc`). The shared guidance does not define a disposition for this pattern.

**Action:** Verify in the DITA-OT build whether the assembly and standalone topic outputs retain duplicate IDs or break links. Do not change stable source IDs solely to silence the AsciiDoc warnings.

**Owner:** Conversion engineer · **Timing:** During conversion — verify the generated DITA and record the warning disposition

## Context conditionals

The current [`conditionals.log`](logs/conditionals.log) lists guards in seven selected assemblies: `assembly-azure-connecting-to-aap.adoc`, `assembly-azure-deploy.adoc`, `assembly-azure-install-prerequisites.adoc`, `assembly-azure-intro.adoc`, `assembly-azure-post-deployment-requirements.adoc`, `assembly-azure-release-notes.adoc`, and `assembly-azure-support.adoc`. The release-notes assembly also sets `:context: azure-release-notes`. During conversion, verify that generated IDs and cross-references remain valid for the included content in these assemblies.

**Owner:** Conversion engineer · **Timing:** During conversion — verify generated IDs and links

## Cross-reference verification

The stable-ID source fix remains in the current tree: `aap-clouds/topics/con-azure-lifecycle.adoc` declares `con-azure-lifecycle`, and `aap-clouds/topics/ref-azure-responsibilities.adoc` links to that ID. The current conversion log warns twice about `#con-azure-lifecycle`; `missing-refs.log` marks it `VERIFY` because the source is selected but the cleaned destination and anchor are not verified ([conversion warning](logs/conversion.log#L70), [verification status](logs/missing-refs.log#L5)). Source membership does not establish that the cleaned output link works.

**Action:** After conversion cleanup, verify that the generated `con-azure-lifecycle.dita` contains `con-azure-lifecycle` and that the rendered link resolves to the intended destination and anchor.

**Owner:** Conversion engineer · **Timing:** During conversion — verify the cleaned DITA target and rendered link.

## Evidence note

The retained `azure-scope-audit.log` and `azure-conditionals.log` are dated 2026-11-05, and `audit-verification.log` is dated 2026-11-06. They are historical; this audit uses the fresh 2026-11-17 `navigation-scope.log` and `conditionals.log`. The lifecycle link remains a separate conversion-stage verification item.

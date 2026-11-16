# AAP on Microsoft Azure pre-check audit

**Run:** 2026-11-16, `conversion-aap-azure` at `a58c625c80` (source `241fc058fd`); versionless, `aap-on-azure-navigation` map generated from the JTBD sheet with `--assembly-topics` (`convert -ArC`).

**Readiness:** Not ready for conversion. The writing team must confirm the repeated JTBD placements and disposition the remaining context guards. During conversion, the conversion engineer must verify the cleaned lifecycle link target and anchor. Rerun the pre-check if the source or JTBD scope changes.

## JTBD scope and duplicate IDs

The Azure section of the [AAP Clouds JTBD sheet](https://docs.google.com/spreadsheets/d/1SR47crWz12bbDGRmShnnxvUkkiQxeT66KJoG80toc9Q/edit?gid=1423880652#gid=1423880652) repeats six topic files across job groups: `aap-clouds/topics/con-azure-user-defined-routing-tables.adoc`, `aap-clouds/topics/con-azure-virtual-appliance-routing.adoc`, and `aap-clouds/topics/con-azure-private-dns.adoc` appear under Access and post-deployment requirements; `aap-clouds/topics/proc-azure-accessing-aap.adoc`, `aap-clouds/topics/ref-azure-license-association.adoc`, and `aap-clouds/topics/con-azure-configure-ad-sso.adoc` appear under Access and Connect. Cross-job reuse was already noted in the previous audit; this run reports duplicate section IDs for reused topics ([examples](logs/asciidoctor.log#L1), [routing topics](logs/asciidoctor.log#L11)). The current conversion log creates one DITA output per source file, and `navigation-scope.log` reports 88 of 88 outputs reachable with no scope discrepancies ([scope](logs/navigation-scope.log#L1)). This confirms current output coverage, but does not establish whether every repeated placement is intended.

**Decision:** Should all six topics remain in both job groups shown in the JTBD sheet? If so, confirm that intent. If not, update the affected topic placements in the Azure section of the sheet. The conversion engineer should export the updated sheet, regenerate the maps, and rerun the pre-check. Do not rename source IDs solely to silence duplicate-ID warnings.

**Owner:** Writing team (placement decision and sheet edits); conversion engineer (export, map regeneration, and rerun if scope changes) · **Timing:** Before conversion.

## Context conditionals

The current `conditionals.log` lists context save/restore guards in eight selected assemblies under `aap-clouds/stories/`: `aap-clouds/stories/assembly-azure-access.adoc` (lines 3, 28–29), `aap-clouds/stories/assembly-azure-connecting-to-aap.adoc` (3, 39–40), `aap-clouds/stories/assembly-azure-deploy.adoc` (3, 29–30), `aap-clouds/stories/assembly-azure-install-prerequisites.adoc` (3, 50–51), `aap-clouds/stories/assembly-azure-intro.adoc` (3, 37–38), `aap-clouds/stories/assembly-azure-post-deployment-requirements.adoc` (3, 53–54), `aap-clouds/stories/assembly-azure-release-notes.adoc` (3, 14–15), and `aap-clouds/stories/assembly-azure-support.adoc` (3, 30–31) ([locations](logs/conditionals.log#L8)). These guards preserve caller context, but their purpose alone does not show that each is necessary. The Support assembly now restores or clears context at lines 30–31; the earlier missing-restore issue is resolved.

**Decision and fix:** For each assembly, confirm whether nested or shared use requires the incoming context. Where the invocation context is fixed, replace the guards with explicit context assignments or resets that preserve the IDs used by included topics and cross-references. For any retained guards, record why caller-dependent context is needed. Do not remove the guards without checking included-topic IDs and other callers.

**Owner:** Writing team (source disposition); conversion engineer (verify retained context-dependent IDs) · **Timing:** Before conversion — resolve avoidable guards and record necessary exceptions; rerun the pre-check if source changes.

## Cross-reference verification

The earlier stable-ID source fix is now present: `aap-clouds/topics/con-azure-lifecycle.adoc` declares `con-azure-lifecycle`, and `aap-clouds/topics/ref-azure-responsibilities.adoc` links to that ID. The current conversion log still warns twice about `#con-azure-lifecycle`; `missing-refs.log` classifies the target as `VERIFY` because its source is selected but the cleaned destination and anchor are not verified ([conversion warning](logs/conversion.log#L73), [verification status](logs/missing-refs.log#L5)). Source membership and the earlier temporary-copy test do not establish that the current cleaned output link works.

**Action:** After conversion cleanup, verify that the generated `con-azure-lifecycle.dita` contains `con-azure-lifecycle` and that the rendered link resolves to the intended destination and anchor.

**Owner:** Conversion engineer · **Timing:** During conversion — verify the cleaned DITA target and rendered link.

## Evidence note

The retained `azure-scope-audit.log` and `azure-conditionals.log` are dated 2026-11-05, and `audit-verification.log` is dated 2026-11-06. They are historical; this audit uses the current `navigation-scope.log` and `conditionals.log` from 2026-11-16.

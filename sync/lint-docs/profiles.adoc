////
-
Do not manually edit, generated from generate_docs.py
////
= Profiles

Ansible-lint profiles gradually increase the strictness of rules as your Ansible content lifecycle.

[,{note}]
----
Rules with `*` in the suffix are not yet implemented but are documented with linked GitHub issues.
----

== min

The `min` profile ensures that Ansible can load content. Rules in this profile are mandatory because they prevent fatal errors. You can add files to the exclude list or provide dependencies to load the correct files.

* link:rules/internal-error/[internal-error]
* link:rules/load-failure/[load-failure]
* link:rules/parser-error/[parser-error]
* link:rules/syntax-check/[syntax-check]

== basic

The `basic` profile prevents common coding issues and enforces standard styles and formatting.
 It extends <<min,min>> profile.

* link:rules/command-instead-of-module/[command-instead-of-module]
* link:rules/command-instead-of-shell/[command-instead-of-shell]
* link:rules/deprecated-bare-vars/[deprecated-bare-vars]
* link:rules/deprecated-command-syntax/[deprecated-command-syntax]
* link:rules/deprecated-local-action/[deprecated-local-action]
* link:rules/deprecated-module/[deprecated-module]
* link:rules/inline-env-var/[inline-env-var]
* link:rules/key-order/[key-order]
* link:rules/literal-compare/[literal-compare]
* link:rules/jinja/[jinja]
* link:rules/no-jinja-when/[no-jinja-when]
* link:rules/no-tabs/[no-tabs]
* link:rules/partial-become/[partial-become]
* link:rules/playbook-extension/[playbook-extension]
* link:rules/role-name/[role-name]
* link:rules/schema/[schema]
* link:rules/name/[name]
* link:rules/var-naming/[var-naming]
* link:rules/yaml/[yaml]

== moderate

The `moderate` profile ensures that content adheres to best practices for making content easier to read and maintain.
 It extends <<basic,basic>> profile.

* link:rules/name/[name[template\]]
* https://github.com/ansible/ansible-lint/issues/2170[name[imperative\]]
* link:rules/name/[name[casing\]]
* https://github.com/ansible/ansible-lint/issues/2117[no-free-form]
* https://github.com/ansible/ansible-lint/issues/2168[spell-var-name]

== safety

The `safety` profile avoids module calls that can have non-determinant outcomes or security concerns.
 It extends <<moderate,moderate>> profile.

* link:rules/avoid-implicit/[avoid-implicit]
* link:rules/latest/[latest]
* link:rules/package-latest/[package-latest]
* link:rules/risky-file-permissions/[risky-file-permissions]
* link:rules/risky-octal/[risky-octal]
* link:rules/risky-shell-pipe/[risky-shell-pipe]

== shared

The `shared` profile ensures that content follows best practices for packaging and publishing. This profile is intended for content creators who want to make Ansible playbooks, roles, or collections available from https://galaxy.ansible.com[galaxy.ansible.com], https://console.redhat.com/ansible/automation-hub[automation-hub], or a private instance.
 It extends <<safety,safety>> profile.

* link:rules/galaxy/[galaxy]
* link:rules/ignore-errors/[ignore-errors]
* https://github.com/ansible/ansible-lint/issues/1900[layout]
* link:rules/meta-incorrect/[meta-incorrect]
* link:rules/meta-no-info/[meta-no-info]
* link:rules/meta-no-tags/[meta-no-tags]
* link:rules/meta-video-links/[meta-video-links]
* https://github.com/ansible/ansible-lint/issues/2103[meta-version]
* https://github.com/ansible/ansible-lint/issues/2102[meta-unsupported-ansible]
* link:rules/no-changed-when/[no-changed-when]
* https://github.com/ansible/ansible-lint/issues/2101[no-changelog]
* link:rules/no-handler/[no-handler]
* link:rules/no-relative-paths/[no-relative-paths]
* https://github.com/ansible/ansible-lint/issues/2173[max-block-depth]
* https://github.com/ansible/ansible-lint/issues/2172[max-tasks]
* https://github.com/ansible/ansible-lint/issues/2038[unsafe-loop]

== production

The `production` profile ensures that content meets requirements for inclusion in https://www.redhat.com/en/technologies/management/ansible[Ansible Automation Platform (AAP)] as validated or certified content.
 It extends <<shared,shared>> profile.

* https://github.com/ansible/ansible-lint/issues/2174[avoid-dot-notation]
* https://github.com/ansible/ansible-lint/issues/2121[disallowed-ignore]
* link:rules/fqcn/[fqcn]
* https://github.com/ansible/ansible-lint/issues/2219[import-task-no-when]
* https://github.com/ansible/ansible-lint/issues/2159[meta-no-dependencies]
* https://github.com/ansible/ansible-lint/issues/2242[single-entry-point]
* https://github.com/ansible/ansible-lint/issues/2204[use-loop]

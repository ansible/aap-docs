= schema

The `schema` rule validates Ansible metadata files against JSON schemas.
These schemas ensure the compatibility of Ansible syntax content across versions.

This `schema` rule is *mandatory*.
You cannot use inline `noqa` comments to ignore it.

Ansible-lint validates the `schema` rule before processing other rules.
This prevents unexpected syntax from triggering multiple rule violations.

== Validated schema

Ansible-lint currently validates several schemas that are maintained in
separate projects and updated independently to ansible-lint.

____
Report bugs related to schema in their respective repository and not in the ansible-lint project.
____

Maintained in the https://github.com/ansible/ansible-lint[ansible-lint] project:

* `schema[ansible-lint-config]` validates https://github.com/ansible/ansible-lint/blob/main/src/ansiblelint/schemas/ansible-lint-config.json[ansible-lint configuration]

Maintained in the https://github.com/ansible/ansible-navigator[ansible-navigator] project:

* `schema[ansible-navigator]` validates https://github.com/ansible/ansible-navigator/blob/main/src/ansible_navigator/data/ansible-navigator.json[ansible-navigator configuration]
* `schema[arg_specs]` validates https://docs.ansible.com/ansible/latest/dev_guide/developing_program_flow_modules.html#argument-spec[module argument specs]
* `schema[execution-environment]` validates https://docs.ansible.com/automation-controller/latest/html/userguide/execution_environments.html[execution environments]
* `schema[galaxy]` validates https://docs.ansible.com/ansible/latest/dev_guide/collections_galaxy_meta.html[collection metadata].
* `schema[inventory]` validates https://docs.ansible.com/ansible/latest/inventory_guide/intro_inventory.html[inventory files] that match `inventory/*.yml`.
* `schema[meta-runtime]` validates https://docs.ansible.com/ansible/devel/dev_guide/developing_collections_structure.html#meta-directory-and-runtime-yml[runtime information] that matches `meta/runtime.yml`
* `schema[meta]` validates metadata for roles that match `meta/main.yml`. See https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_reuse_roles.html#role-dependencies[role-dependencies] or https://github.com/ansible/ansible/blob/devel/lib/ansible/playbook/role/metadata.py#L79[role/metadata.py]) for details.
* `schema[playbook]` validates Ansible playbooks.
* `schema[requirements]` validates Ansible https://docs.ansible.com/ansible/latest/galaxy/user_guide.html#install-multiple-collections-with-a-requirements-file[requirements] files that match `requirements.yml`.
* `schema[tasks]` validates Ansible task files that match `+tasks/**/*.yml+`.
* `schema[vars]` validates Ansible https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_variables.html[variables] that match `+vars/*.yml+` and `defaults/*.yml`.

== schema[meta]

For `meta/main.yml` files, Ansible-lint requires a `galaxy_info.standalone`
property that clarifies if a role is an old standalone one or a new one,
collection based:

[,yaml]
----
galaxy_info:
  standalone: true # <-- this is a standalone role (not part of a collection)
----

Ansible-lint requires the `standalone` key to avoid confusion and provide more
specific error messages. For example, the `meta` schema will require some
properties only for standalone roles or prevent the use of some properties that
are not supported by collections.

You cannot use an empty `meta/main.yml` file or use only comments in the `meta/main.yml` file.

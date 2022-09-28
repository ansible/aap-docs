== Execution Environment Setup Reference

This section contains reference information associated with setting up
and building execution environments.

[[ref_ee_definition]]
Execution environment definition ~~~~~~~~~~~~~~~~~

A definition file is a `.yml` file that is required to build an image
for an execution environment. An example of an execution environment
definition schema is as follows:

:

....
---
version: 1

build_arg_defaults:
  EE_BASE_IMAGE: 'quay.io/ansible/ansible-runner:stable-2.10-devel'

ansible_config: 'ansible.cfg'

dependencies:
  galaxy: requirements.yml
  python: requirements.txt
  system: bindep.txt

additional_build_steps:
  prepend: |
    RUN whoami
    RUN cat /etc/os-release
  append:
    - RUN echo This is a post-install command!
    - RUN ls -la /etc
....

=== Build arguments and base image

Default values for build arguments can be specified in the definition
file in the `default_build_args` section as a dictionary. This is an
alternative to using the `--build-arg` CLI flag.

Build arguments used by `ansible-builder` are the following:

* `ANSIBLE_GALAXY_CLI_COLLECTION_OPTS` allows the user to pass the
`–pre` flag to enable the installation of pre-releases collections.
* `EE_BASE_IMAGE` specifies the parent image for the execution
environment.
* `EE_BUILDER_IMAGE` specifies the image used for compiling type tasks.

Values given inside of `default_build_args` will be hard-coded into the
Containerfile, so they will persist if `podman build` is called
manually.

If the same variable is specified in the CLI `--build-arg` flag, the CLI
value will take higher precedence.

=== Ansible config file path

When using an `ansible.cfg` file to pass a token and other settings for
a private account to an Automation Hub server, listing the config file
path here (as a string) will enable it to be included as a build
argument in the initial phase of the build.

=== Ansible Galaxy dependencies

The `galaxy` entry points to a valid requirements file for the
`ansible-galaxy collection install -r ...` command.

The entry `requirements.yml` may be a relative path from the directory
of the execution environment definition’s folder, or an absolute path.

=== Python dependencies

The python entry points to a valid requirements file for the
`pip install -r ...` command.

The entry `requirements.txt` may be a relative path from the directory
of the execution environment definition’s folder, or an absolute path.

=== System-level dependencies

The `system` entry points to a `bindep` requirements file. This will be
processed by `bindep` and then passed to `dnf`, other platforms are not
yet supported. For more information about bindep, refer to the
https://docs.opendev.org/opendev/bindep/latest/readme.html[OpenDev
documentation].

=== Additional custom build steps

Additional commands may be specified in the `additional_build_steps`
section, either for before the main build steps (`prepend`) or after
(`append`). The syntax needs to be one of the following:

* a multi-line string (example shown in the `prepend` section above)
* a dictionary (as shown via `append`)

==== ansible-builder build options

The following options can be used with the `ansible-builder build`
command:

[width="100%",cols="10%,60%,30%",]
|=======================================================================
|*Flag* |*Description* |*Syntax*

|`--tag` |To customize the tagged name applied to the built image
|`$ ansible-builder build --tag=my-custom-ee`

|`--file` |To use a definition file named something other than
`execution-environment.yml` |`$ ansible-builder build --file=my-ee.yml`

|`--context` |To specify a location other than the default directory
named `context` created in the current working directory
|`$ ansible-builder build --context=/path/to/dir`

a|
`--build-arg`

__
* 
__

a|
__________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________
To use Podman or Docker’s build-time variables, specify them the same
way you would with `podman build` or `docker build`. By default, the
Containerfile / Dockerfile outputted by ansible-builder contains a build
argument `EE_BASE_IMAGE,` which can be useful for rebuilding execution
environments wi
__________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+::
  To use a custom base image (replaces previously discontinued
  `--base-image` option)

a|
_____________________________________________
`$ ansible-builder build --build-arg FOO=bar`
_____________________________________________

thout modifying any files. |
---------------------------------------------------------------------------------------+
`$ ansible-builder build --build-arg EE_BASE_IMAGE=registry.example.com/another-ee`

|`--container-runtime` |To use Docker to build images instead of the
Podman default |`$ ansible-builder build --container-runtime=docker`

|`--verbosity` |To customize the level of verbosity
|`$ ansible-builder build --verbosity 2`
|=======================================================================

=== Examples

The example in `test/data/pytz` requires the `awx.awx` collection in the
execution environment definition. The lookup plugin
`awx.awx.tower_schedule_rrule` requires the PyPI `pytz` and another
library to work. If `test/data/pytz/execution-environment.yml` file is
provided to the `ansible-builder build` command, then it will install
the collection inside the image, read the `requirements.txt` file inside
of the collection, and then install `pytz` into the image.

The image produced can be used inside of an `ansible-runner` project by
placing these variables inside the `env/settings` file, inside of the
private data directory.

....
---
container_image: image-name
process_isolation_executable: podman # or docker
process_isolation: true
....

The `awx.awx` collection is a subset of content included in the default
AWX execution environment. More details can be found in the
https://github.com/ansible/awx-ee[awx-ee repository].

[[ref_collections_metadata]]
==== Collection-level metadata¶

Collections inside of the `galaxy` entry of an execution environment
will contribute their Python and system requirements to the image.

Requirements from a collection can be recognized in these ways:

* A file `meta/execution-environment.yml` references the Python and/or
bindep requirements files
* A file named `requirements.txt` is in the root level of the collection
* A file named `bindep.txt` is in the root level of the collection

If any of these files are in the `build_ignore` of the collection, it
will not work correctly.

Collection maintainers can verify that ansible-builder recognizes the
requirements they expect by using the `introspect` command, for example:

....
ansible-builder introspect --sanitize ~/.ansible/collections/
....

=== Python Dependencies

Python requirements files are combined into a single file using the
`requirements-parser` library in order to support complex syntax like
references to other files.

Entries from separate collections that give the same package name will
be combined into the same entry, with the constraints combined.

There are several package names which are specifically _ignored_ by
ansible-builder, meaning that if a collection lists these, they will not
be included in the combined file. These include test packages and
packages that provide Ansible itself. The full list can be found in
`EXCLUDE_REQUIREMENTS` in the `ansible_builder.requirements` module.

=== System-level Dependencies

The `bindep` format provides a way of specifying cross-platform
requirements. A minimum expectation is that collections specify
necessary requirements for `[platform:rpm]`.

Entries from multiple collections will be combined into a single file.
Only requirements with no profiles (runtime requirements) will be
installed to the image. Entries from multiple collections which are
outright duplicates of each other may be consolidated in the combined
file.

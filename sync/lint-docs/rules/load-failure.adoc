= load-failure

Linter failed to process a YAML file, probably because it is either:

* contains unsupported encoding (only UTF-8 is supported)
* not an Ansible file
* it contains some unsupported custom YAML objects (`!!` prefix)
* it was not able to decrypt an inline `!vault` block.

This violation *is not* skippable, so it cannot be added to the `warn_list`
or the `skip_list`. If a vault decryption issue cannot be avoided, the
offending file can be added to `exclude_paths` configuration.

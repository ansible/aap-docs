#!/bin/bash

######
# This script creates an assembly that contains Ansible-lint rule documentation.
######

for f in $(find ../sync/lint-docs/rules -name '*.adoc')
do
  echo "$f"
done > ../sync/lint-docs/assembly_lint_rules.adoc
sed -i -e 's|../sync/lint-docs/rules|include::rules|g' \
-e 's|.adoc|.adoc\[leveloffset=+1\]|g' ../sync/lint-docs/assembly_lint_rules.adoc
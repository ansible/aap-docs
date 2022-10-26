#!/bin/bash

######
# This script creates an assembly that contains Ansible-lint rule documentation.
# Resulting assembly requires manual intervention to put adoc files in alphabetical order.
######

# Create an assembly with all the adoc rules.
for f in $(find ../sync/lint-docs/rules -name '*.adoc')
do
  echo "$f"
done > ../titles/ansible-lint/assembly_lint_rules.adoc

# Replace the path with an include directive and add a leveloffset.
sed -i -e 's|../sync/|include::|g' \
 -e 's|.adoc|.adoc\[leveloffset=+1\]|g' ../titles/ansible-lint/assembly_lint_rules.adoc
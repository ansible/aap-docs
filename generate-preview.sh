#!/bin/bash

######
# This script creates an index.asciidoc file to generate preview builds.
######

assemblies=$(find downstream/assemblies/** -name '*.adoc')

for f in $assemblies
do
  echo "include::$f"
done > index.asciidoc

sed -i -e 's|.adoc|.adoc\[leveloffset=+1\]|g' index.asciidoc

sed -i '1iinclude::downstream/attributes/attributes.adoc\[\]' index.asciidoc
sed -i '2i\\' index.asciidoc
sed -i '3i= Content preview' index.asciidoc
sed -i '4iIMPORTANT: This is a preview site of content that is in development and not supported. Visit link:https://www.redhat.com/en/technologies/management/ansible\[Red Hat Ansible Automation Platform\] for more information.' index.asciidoc
sed -i '5i\\' index.asciidoc

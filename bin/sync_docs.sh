#!/bin/bash

######
# This script synchronizes content to the downstream repository.
# There is a Jenkins job that configures the source and target repositories and runs this script directly.
# If you commit changes to this script you should verify the Jenkins job runs successfully.
######

# Set the path to the source and target directories.
# The source directory contains the content that you want to synchronize.
source=source
# The target directory is the location where you want to synchronize content.
target=target

# Clean the existing downstream content.
rm -rf $target/controller/topics

# Copy converted asciidoc content downstream.
cp -r $source/sync/controller-docs $target/controller/topics

# Set up the aap-common content.
# Add a symlink to aap-common in each titles directory.
find $target/controller/titles/ -mindepth 1 -maxdepth 2 -type d -exec ln -sr $target/aap-common {} \;
# Include aap-common content in each master assembly.
find $target/controller/titles/ -name master.adoc -exec sed -i -e 's|//include::aap-common|include::aap-common|g' {} \;

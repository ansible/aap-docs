#!/bin/bash

######
# This script synchronizes cloud content to the AAP docs clouds/ repository in Gitlab.
# A Jenkins job configures the source and target repositories and runs this script directly.
# If you commit changes to this script, verify the Jenkins job runs successfully.
######

# Set the path to the source and target directories.
# The source directory contains the content that you want to synchronize.
source=source
# The target directory is the location where you want to synchronize content.
target=target

# Clean the existing downstream and release-note folders.
rm -rf $target/aap-clouds

# Copy the content of the downstream and release-note folders.
cp -r $source/aap-clouds $target/aap-clouds

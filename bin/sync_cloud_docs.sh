#!/bin/bash

######
# This script synchronizes cloud content to the AAP docs downstream repository in Gitlab.
# A Jenkins job configures the source and target repositories and runs this script directly.
# If you commit changes to this script, verify the Jenkins job runs successfully.
######

# Set the path to the source and target directories.
# The source directory contains the content that you want to synchronize.
source=source
# The target directory is the location where you want to synchronize content.
target=target

# Clean the target directories.
# rm -rf $target/titles/aap-on-aws
rm -rf $target/aap-common
rm -rf $target/attributes
rm -rf $target/images
rm -rf $target/stories
rm -rf $target/aap-on-azure/stories.adoc

# Copy aap-common to the target directories.
cp -r $source/aap-common/ $target/

# Copy attributes to the target directories.
cp -r $source/attributes/ $target/

# Copy images to the target directories.
cp -r $source/images/ $target/

# Copy user stories to the target directories.
cp -r $source/stories/ $target/
cp -r $source/titles/aap-on-azure/stories.adoc $target/titles/aap-on-azure/

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
rm -rf $target/aap-on-azure/aap-common
rm -rf $target/aap-on-azure/attributes
rm -rf $target/aap-on-azure/images
rm -rf $target/aap-on-azure/stories
rm -rf $target/aap-on-azure/stories.adoc

rm -rf $target/aap-on-aws/aap-common
rm -rf $target/aap-on-aws/attributes
rm -rf $target/aap-on-aws/images
rm -rf $target/aap-on-aws/stories
rm -rf $target/aap-on-aws/stories.adoc

rm -rf $target/aap-on-gcp/aap-common
rm -rf $target/aap-on-gcp/attributes
rm -rf $target/aap-on-gcp/images
rm -rf $target/aap-on-gcp/stories
rm -rf $target/aap-on-gcp/stories.adoc

rm -rf $target/release-notes-gcp/aap-common
rm -rf $target/release-notes-gcp/attributes
rm -rf $target/release-notes-gcp/images
rm -rf $target/release-notes-gcp/stories
rm -rf $target/release-notes-gcp/stories.adoc

# Copy aap-common to the target directories.
cp -r $source/aap-common/ $target/aap-on-azure/
cp -r $source/aap-common/ $target/aap-on-aws/
cp -r $source/aap-common/ $target/aap-on-gcp/
cp -r $source/aap-common/ $target/release-notes-gcp/

# Copy attributes to the target directories.
cp -r $source/attributes/ $target/aap-on-azure/
cp -r $source/attributes/ $target/aap-on-aws/
cp -r $source/attributes/ $target/aap-on-gcp/
cp -r $source/attributes/ $target/release-notes-gcp/

# Copy images to the target directories.
cp -r $source/images/ $target/aap-on-azure/
cp -r $source/images/ $target/aap-on-aws/
cp -r $source/images/ $target/aap-on-gcp/
cp -r $source/images/ $target/release-notes-gcp/

# Copy user stories to the target directories.
cp -r $source/stories/ $target/aap-on-azure/
cp -r $source/titles/aap-on-azure/stories.adoc $target/aap-on-azure/
cp -r $source/stories/ $target/aap-on-aws/
cp -r $source/titles/aap-on-aws/stories.adoc $target/aap-on-aws/
cp -r $source/stories/ $target/aap-on-gcp/
cp -r $source/titles/aap-on-gcp/stories.adoc $target/aap-on-gcp/
cp -r $source/stories/ $target/release-notes-gcp/
cp -r $source/titles/release-notes-gcp/stories.adoc $target/release-notes-gcp/

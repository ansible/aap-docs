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

#####
# Controller documentation
#####

###
# Administration guide
###

# Clean existing downstream content.
rm -rf $target/controller/titles/administration/administration
rm -f $target/controller/titles/administration/stories.adoc
mkdir -p $target/controller/titles/administration/administration

# Copy converted asciidoc content downstream.
cp -r $source/sync/controller-docs/administration/source/* $target/controller/titles/administration/administration

# Copy the table of contents.
cp -r $source/titles/controller/administration/stories.adoc $target/controller/titles/administration/stories.adoc

# Copy the images.
cp -r $source/sync/controller-docs/common/source/images/ $target/controller/titles/administration/

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

################
# Administration
################

# Clean existing downstream content.
rm -rf $target/controller/administration/administration
rm -f $target/controller/administration/stories.adoc
rm -f $target/controller/administration/controller-xrefs.adoc
mkdir -p $target/controller/administration/administration

# Copy converted asciidoc content downstream.
cp -r $source/sync/controller-docs/administration/source/* $target/controller/administration/administration

# Copy the table of contents.
cp -r $source/titles/controller/administration/stories.adoc $target/controller/administration/stories.adoc

# Copy the images.
cp -r $source/sync/controller-docs/common/source/images/ $target/controller/administration/

# Copy the cross-references.
cp -r $source/titles/controller/xrefs/controller-xrefs.adoc $target/controller/administration/controller-xrefs.adoc

################
# Controller API
################

# Clean existing downstream content.
rm -rf $target/controller/controllerapi/controllerapi
rm -f $target/controller/controllerapi/stories.adoc
rm -f $target/controller/controllerapi/controller-xrefs.adoc
mkdir -p $target/controller/controllerapi/controllerapi

# Copy converted asciidoc content downstream.
cp -r $source/sync/controller-docs/controllerapi/source/* $target/controller/controllerapi/controllerapi

# Copy the table of contents.
cp -r $source/titles/controller/controllerapi/stories.adoc $target/controller/controllerapi/stories.adoc

# Copy the images.
cp -r $source/sync/controller-docs/common/source/images/ $target/controller/controllerapi/

# Copy the cross-references.
cp -r $source/titles/controller/xrefs/controller-xrefs.adoc $target/controller/controllerapi/controller-xrefs.adoc

############
# Quickstart
############

# Clean existing downstream content.
rm -rf $target/controller/quickstart/quickstart
rm -f $target/controller/quickstart/stories.adoc
rm -f $target/controller/quickstart/controller-xrefs.adoc
mkdir -p $target/controller/quickstart/quickstart

# Copy converted asciidoc content downstream.
cp -r $source/sync/controller-docs/quickstart/source/* $target/controller/quickstart/quickstart

# Copy the table of contents.
cp -r $source/titles/controller/quickstart/stories.adoc $target/controller/quickstart/stories.adoc

# Copy the images.
cp -r $source/sync/controller-docs/common/source/images/ $target/controller/quickstart/

# Copy the cross-references.
cp -r $source/titles/controller/xrefs/controller-xrefs.adoc $target/controller/quickstart/controller-xrefs.adoc

###############
# Release notes
###############

# Clean existing downstream content.
rm -rf $target/controller/release-notes/release-notes
rm -f $target/controller/release-notes/stories.adoc
rm -f $target/controller/release-notes/controller-xrefs.adoc
mkdir -p $target/controller/release-notes/release-notes

# Copy converted asciidoc content downstream.
cp -r $source/sync/controller-docs/release-notes/source* $target/controller/release-notes/release-notes

# Copy the table of contents.
cp -r $source/titles/controller/release-notes/stories.adoc $target/controller/release-notes/stories.adoc

# Copy the images.
cp -r $source/sync/controller-docs/common/source/images/ $target/controller/release-notes/

# Copy the cross-references.
cp -r $source/titles/controller/xrefs/controller-xrefs.adoc $target/controller/release-notes/controller-xrefs.adoc

#######################
# Upgrade and migration
#######################

# Clean existing downstream content.
rm -rf $target/controller/upgrade-migration-guide/upgrade-migration-guide
rm -f $target/controller/upgrade-migration-guide/stories.adoc
rm -f $target/controller/upgrade-migration-guide/controller-xrefs.adoc
mkdir -p $target/controller/upgrade-migration-guide/upgrade-migration-guide

# Copy converted asciidoc content downstream.
cp -r $source/sync/controller-docs/upgrade-migration-guide/source/* $target/controller/upgrade-migration-guide/upgrade-migration-guide

# Copy the table of contents.
cp -r $source/titles/controller/upgrade-migration-guide/stories.adoc $target/controller/upgrade-migration-guide/stories.adoc

# Copy the images.
cp -r $source/sync/controller-docs/common/source/images/ $target/controller/upgrade-migration-guide/

# Copy the cross-references.
cp -r $source/titles/controller/xrefs/controller-xrefs.adoc $target/controller/upgrade-migration-guide/controller-xrefs.adoc

############
# User guide
############

# Clean existing downstream content.
rm -rf $target/controller/userguide/userguide
rm -f $target/controller/userguide/stories.adoc
rm -f $target/controller/userguide/controller-xrefs.adoc
mkdir -p $target/controller/userguide/userguide

# Copy converted asciidoc content downstream.
cp -r $source/sync/controller-docs/userguide/source/* $target/controller/userguide/userguide

# Copy the table of contents.
cp -r $source/titles/controller/userguide/stories.adoc $target/controller/userguide/stories.adoc

# Copy the images.
cp -r $source/sync/controller-docs/common/source/images/ $target/controller/userguide/

# Copy the cross-references.
cp -r $source/titles/controller/xrefs/controller-xrefs.adoc $target/controller/userguide/controller-xrefs.adoc
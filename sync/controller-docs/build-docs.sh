#!/bin/bash -xe

#
# Requirements
#
PIP=pip3 make requirements

#
# Build docs
#
make html # pre-build to get cross-linking working
make html
make latexpdf
make accesshtmlarchive

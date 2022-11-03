# Since master.adoc and docinfo.xml are not in the aap-docs repo, you can't use bccutil / ccutil to build aap-docs.
# This function fetches files from Gitlab, runs bccutil, and deletes the added files.
# 
# Add this function to your ~/.zshrc or ~/.bashrc file, then run source ~/.bashrc or source ~/.zshrc
#
# Prerequisites:
# * You must be connected to the VPN to run this function, as it fetches files from Gitlab.
#   Error message when you run function when not connected to the VPN:
#     ssh: Could not resolve hostname gitlab.cee.redhat.com: nodename nor servname provided, or not known
# * You must have set up a git remote called "gitlab" for the Gitlab production repo. 
#   To check your git remotes, run the following command:
#     git remote -v
#   Error message when you run function without gitlab remote set up:
#     fatal: 'test' does not appear to be a git repository
#     fatal: Could not read from remote repository.
#
# Procedure:
# Run this function from a title directory, for example aap-on-aws
# To run this function, type aap-docs-build <title-directory>, for example:
# aap-docs-build aap-on-azure
# aap-docs-build aap-on-aws
# aap-docs-build aap-on-gcp
#
    function aap-docs-build () {
    #
    # Fetch files from Gitlab
    git fetch gitlab aap-clouds-latest
    printf "*** Building $1 docs ***\n"
    git show gitlab/aap-clouds-latest:$1/master.adoc > master.adoc
    git show gitlab/aap-clouds-latest:$1/docinfo.xml > docinfo.xml
    git show gitlab/aap-clouds-latest:$1/title-attributes.adoc > title-attributes.adoc
    #
    # Substitute the command that you use when you build the docs with ccutil / bccutil.
    # Delete the hashtag before the command.
    # The following example is for a mac. Modify this line to reflect your leviathin setup.
    # ~/repos/build-aap-docs/leviathin/runCCutil.sh
    # The following example is for RHEL. Modify this line to reflect your bccutil setup.
    # bccutil compile --lang en-US --format html-single --open
    #
    # After the build is complete, delete the files fetched from Gitlab.
    rm master.adoc docinfo.xml title-attributes.adoc
}

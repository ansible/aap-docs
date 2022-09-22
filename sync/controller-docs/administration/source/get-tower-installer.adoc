Both installers have automation controller and Automation Hub; and
provide the exact same feature set.

* Installing _with_ internet access. Download the latest version of the
online installer, `ansible-automation-platform-setup-latest.tar.gz`,
from https://access.redhat.com[access.redhat.com] then extract the
installation/upgrade tool:

________________________________________________________________________________________________________________________________________________________________________________________________________________
....
root@localhost:~$ tar xvzf ansible-automation-platform-setup-latest.tar.gz
root@localhost:~$ cd ansible-automation-platform-setup-<platform_version>
....

Installing with internet access will retrieve the latest required
repositories, packages, and dependencies. You must have a valid
subscription to activate the Ansible Automation Platform programs.

After installation or upgrade, start by editing the inventory file in
the `ansible-automation-platform-setup-<platform_version>` directory,
replacing `<platform_version>` with the version number, i.e., `2.0`.
________________________________________________________________________________________________________________________________________________________________________________________________________________

* Installing *without* internet. Download the
`bundled installer <bundled_install>`. Use this method when you do not
have direct access to online repositories, or your environment enforces
a proxy.

== Red Hat Ansible Automation Platform Controller Licensing, Updates, and Support

Red Hat Ansible Automation Platform controller ("*Automation
Controller*") is a software product provided as part of an annual Red
Hat Ansible Automation Platform subscription entered into between you
and Red Hat, Inc. ("*Red Hat*").

Ansible is an open source software project and is licensed under the GNU
General Public License version 3, as detailed in the Ansible source
code: https://github.com/ansible/ansible/blob/devel/COPYING

You *must* have valid subscriptions attached before installing the
Ansible Automation Platform. See `attach_subscriptions` for detail.

=== Support

Red Hat offers support to paid Red Hat Ansible Automation Platform
customers.

If you or your company has purchased a subscription for Ansible
Automation Platform, you can contact the support team at
https://access.redhat.com. To better understand the levels of support
which match your Ansible Automation Platform subscription, refer to
`subscription-types`. For details of what is covered under an Ansible
Automation Platform subscription, please see the Scopes of Support at:
https://access.redhat.com/support/policy/updates/ansible-tower#scope-of-coverage-4
and https://access.redhat.com/support/policy/updates/ansible-engine.

[[trial-licenses]]
=== Trial / Evaluation

While a license is required for automation controller to run, there is
no fee for a trial license.

* Trial licenses for Red Hat Ansible Automation are available at:
http://ansible.com/license
* Support is not included in a trial license or during an evaluation of
the automation controller software.

=== Subscription Types

Red Hat Ansible Automation Platform is provided at various levels of
support and number of machines as an annual Subscription.

* Standard::
  ** Manage any size environment
  ** Enterprise 8x5 support and SLA
  ** Maintenance and upgrades included
  ** Review the SLA at:
  https://access.redhat.com/support/offerings/production/sla
  ** Review the Red Hat Support Severity Level Definitions at:
  https://access.redhat.com/support/policy/severity
* Premium::
  ** Manage any size environment, including mission-critical
  environments
  ** Premium 24x7 support and SLA
  ** Maintenance and upgrades included
  ** Review the SLA at:
  https://access.redhat.com/support/offerings/production/sla
  ** Review the Red Hat Support Severity Level Definitions at:
  https://access.redhat.com/support/policy/severity

All Subscription levels include regular updates and releases of
automation controller, Ansible, and any other components of the
Platform.

For more information, contact Ansible via the Red Hat Customer portal at
https://access.redhat.com/ or at http://www.ansible.com/contact-us/.

=== Node Counting in Licenses

The Red Hat Ansible Automation Platform controller license defines the
number of Managed Nodes that can be managed as part of a Red Hat Ansible
Automation Platform subscription. A typical license will say ‘License
Count: 500’, which sets the maximum number of Managed Nodes at 500.

For more information on managed node requirements for licensing, please
see https://access.redhat.com/articles/3331481.

[[attach_subscriptions]]
=== Attaching Subscriptions

You *must* have valid subscriptions attached before installing the
Ansible Automation Platform. Attaching an Ansible Automation Platform
subscription enables Automation Hub repositories. A valid subscription
needs to be attached to the Automation Hub node only. Other nodes do
not need to have a valid subscription/pool attached, even if the
*[automationhub]* group is blank, given this is done at the `repos_el`
role level and that this role is run on both *[default]* and
*[automationhub]* hosts.

Note

Attaching subscriptions is unnecessary if your Red Hat account enabled
https://access.redhat.com/articles/simple-content-access[Simple Content
Access Mode]. But you still need to register to RHSM or Satellite before
installing the Ansible Automation Platform.

To find out the `pool_id` of your Ansible Automation Platform
subscription:

....
#subscription-manager list --available --all | grep "Ansible Automation Platform" -B 3 -A 6
....

The command returns the following:

....
Subscription Name: Red Hat Ansible Automation Platform, Premium (5000 Managed Nodes)
Provides: Red Hat Ansible Engine
Red Hat Single Sign-On
Red Hat Ansible Automation Platform
SKU: MCT3695
Contract: ********
Pool ID: ********************
Provides Management: No
Available: 4999
Suggested: 1
....

To attach this subscription:

....
#subscription-manager attach --pool=<pool_id>
....

If this is properly done, and all nodes have Red Hat Ansible Automation
Platform attached, then it will find the Automation Hub repositories
correctly.

To check whether the subscription was successfully attached:

....
#subscription-manager list --consumed
....

To remove this subscription:

....
#subscription-manager remove --pool=<pool_id>
....

=== Component Licenses

To view the license information for the components included within
automation controller, refer to
`/usr/share/doc/automation-controller-<version>/README` where
`<version>` refers to the version of automation controller you have
installed.

To view a specific license, refer to
`+/usr/share/doc/automation-controller-<version>/*.txt+`, where `*` is
replaced by the license file name to which you are referring.

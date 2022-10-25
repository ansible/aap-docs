[[ug_organizations]]
== Organizations

An `Organization` is a logical collection of *Users*, *Teams*,
*Projects*, and *Inventories*, and is the highest level in the
automation controller object hierarchy.

image:TowerHierarchy.png[tower hierarchy]

Access the Organizations page by clicking *Organizations* from the left
navigation bar. The Organizations page displays all of the existing
organizations for your installation. Organizations can be searched by
*Name* or *Description*. Modify and remove organizations using the
*Edit* and *Delete* buttons.

Note

A default organization is automatically created.

image:organizations-home-showing-example-organization.png[Organizations
- home showing example organization]

From this list view, you can edit the details of an organization
(image:edit-button.png[edit button]) from the
*Actions* menu.

[[ug_organizations_create]]
=== Creating a New Organization

[arabic]
. You can create a new organization by clicking the *Add* button.

image:organizations-new-organization-form.png[Organizations
- new organization form]

[arabic, start=2]
. An organization has several attributes that may be configured:

* Enter the *Name* for your organization (required).
* Enter a *Description* for the organization.
* The *Max Hosts* is only editable by a superuser to set an upper limit
on the number of license hosts that an organization can have. Setting
this value to *0* signifies no limit. If you try to add a host to an
organization that has reached or exceeded its cap on hosts, an error
message displays:
+
image:organizations-max-hosts-error.png[image]

The inventory sync output view also shows the host limit error. Click
*Details* for additional detail about the error.

_____________________________________________________________________________________
image:organizations-max-hosts-error-output-view.png[image]
_____________________________________________________________________________________

* Enter *Instance Groups* on which to run this organization.
* Enter the name of the execution environment or search for an existing
*Default Execution Environment* on which to run this organization. See
`upgrade_venv` in the Ansible Automation Platform Upgrade and Migration
Guide for more information.
* If used, enter the *Galaxy Credentials* or search from a list of
existing ones.

[arabic, start=3]
. Click *Save* to finish creating the organization.

Once created, automation controller displays the Organization details,
and allows for the managing access and execution environments for the
organization.

image:organizations-show-record-for-example-organization.png[Organizations
- show record for example organization]

From the *Details* tab, you can edit or delete the organization.

include::work_items_deletion_warning.adoc[]

=== Work with Access

pair; organizations; teams

Clicking on *Access* (beside *Details* when viewing your organization),
displays all the Users associated with this Organization and their
roles.

image:organizations-show-users-permissions-organization.png[Organizations
- show users for example organization]

As you can manage the user membership for this Organization here, you
can manage user membership on a per-user basis from the Users page by
clicking *Users* from the left navigation bar. Organizations have a
unique set of roles not described here. You can assign specific users
certain levels of permissions within your organization, or allow them to
act as an admin for a particular resource. Refer to `rbac-ug` for more
information.

Clicking on a user brings up that user's details, allowing you to
review, grant, edit, and remove associated permissions for that user.
For more information, refer to {ug_users}.

==== Add a User or Team

In order to add a user or team to an organization, the user or team must
already be created. See xref:ug_users_create` and {ug_team_create} for
additional detail. To add existing users or team to the Organization:

include::permissions.adoc[]

Note

A user or team with roles associated will retain them even after they
have been reassigned to another organization.

=== Work with Notifications

Clicking the *Notifications* tab allows you to review any notification
integrations you have setup.

image:organizations-notifications-samples-list.png[image]

Use the toggles to enable or disable the notifications to use with your
particular organization. For more detail, see {ug_notifications_on_off}.

If no notifications have been set up, you must create them from the
*Notifications* option on the left navigation bar.

image:organization-notifications-empty.png[image]

Refer to {ug_notifications_types} for additional details on configuring
various notification types.

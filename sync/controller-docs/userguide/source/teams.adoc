[[ug_teams]]
== Teams

A `Team` is a subdivision of an organization with associated users,
projects, credentials, and permissions. Teams provide a means to
implement role-based access control schemes and delegate
responsibilities across organizations. For instance, permissions may be
granted to a whole Team rather than each user on the Team.

You can create as many Teams of users as make sense for your
Organization. Each Team can be assigned permissions, just as with Users.
Teams can also scalably assign ownership for Credentials, preventing
multiple interface click-throughs to assign the same Credentials to the
same user.

Access the Teams page by clicking *Teams* from the left navigation bar.
The team list may be sorted and searched by *Name* or *Organization*.

image:organizations-teams-list.png[image]

Clicking the Edit
(image:edit-button.png[edit-button]) button
next to the list of *Teams* allows you to edit details about the team.
You can also review *Users* and *Permissions* associated with this Team.

[[ug_team_create]]
=== Create a Team

To create a new Team:

[arabic]
. Click the *Add* button.

image:teams-create-new-team.png[Teams -
create new team]

[arabic, start=2]
. Enter the appropriate details into the following fields:

* Name
* Description (optional)
* Organization (Choose from an existing organization)

[arabic, start=3]
. Click *Save*.

Once the Team is successfully created, automation controller opens the
*Details* dialog, which also allows you to review and edit your Team
information.

image:teams-example-team-successfully-created.png[Teams
- example team successfully created]

==== Team Access

This tab displays the list of Users that are members of this Team. This
list may be searched by *Username*, *First Name*, or *Last Name*. For
more information, refer to {ug_users}.

image:teams-users-list.png[Teams - users
list]

[[ug_teams_permissions]]
===== Add a User

In order to add a user to a team, the user must already be created.
Refer to {ug_users_create} to create a user. Adding a user to a team
adds them as a member only, specifying a role for the user on different
resources can be done in the *Access* tab . To add existing users to the
Team:

[arabic]
. In the *Access* tab, click the *Add* button.
. Follow the prompts to add user(s) and assign them to roles.
. Click *Save* when done.

To remove roles for a particular user, click the disassociate (x) button
next to its resource.

image:permissions-disassociate.png[image]

This launches a confirmation dialog, asking you to confirm the
disassociation.

image:permissions-disassociate-confirm.png[image]

==== Team Roles

Selecting the *Roles* view displays a list of the permissions that are
currently available for this Team. The permissions list may be sorted
and searched by *Resource Name*, *Type*, or *Role*.

image:teams-permissions-sample-roles.png[Teams
- permissions list]

The set of privileges assigned to Teams that provide the ability to
read, modify, and administer projects, inventories, and other automation
controller elements are permissions. By default, the Team is given the
"read" permission (also called a role).

Permissions must be set explicitly via an Inventory, Project, Job
Template, or within the Organization view.

===== Add Team Permissions

To add permissions to a Team:

[arabic]
. Click the *Add* button, which opens the Add Permissions Wizard.

image:teams-users-add-permissions-form.png[Add Permissions Form]

[arabic, start=2]
. Click to select the object for which the team will have access and
click *Next*.
. Click to select the resource to assign team roles and click *Next*.

image:teams-permissions-templates-select.png[image]

[arabic, start=4]
. Click the checkbox beside the role to assign that role to your chosen
type of resource. Different resources have different options available.

image:teams-permissions-template-roles.png[image]

[arabic, start=5]
. Click *Save* when done, and the Add Permissions Wizard closes to
display the updated profile for the user with the roles assigned for
each selected resource.

image:teams-permissions-sample-roles.png[image]

To remove Permissions for a particular resource, click the disassociate
(x) button next to its resource. This launches a confirmation dialog,
asking you to confirm the disassociation.

Note

You can also add teams, individual, or multiple users and assign them
permissions at the object level (projects, inventories, job templates,
and workflow templates) as well. This feature reduces the time for an
organization to onboard many users at one time.

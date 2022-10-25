== Users

A `User` is someone who has access to automation controller with
associated permissions and credentials. Access the Users page by
clicking *Users* from the left navigation bar. The User list may be
sorted and searched by *Username*, *First Name*, or *Last Name* and
click the headers to toggle your sorting preference.

image:users-home-with-example-users.png[Users - home with example users]

You can easily view permissions and user type information by looking
beside their user name in the User overview screen.

[[ug_users_create]]
=== Create a User

To create a new user:

[arabic]
. Click the *Add* button, which opens the Create User dialog.
. Enter the appropriate details about your new user. Fields marked with
an asterisk (*) are required.

Note

When modifying your own password, log out and log back in again in order
for it to take effect.

Three types of Users can be assigned:

* *Normal User*: Normal Users have read and write access limited to the
resources (such as inventory, projects, and job templates) for which
that user has been granted the appropriate roles and privileges.
* *System Auditor*: Auditors implicitly inherit the read-only capability
for all objects within the environment.
* *System Administrator*: A System Administrator (also known as
Superuser) has full system administration privileges -- with full read
and write privileges over the entire installation. A System
Administrator is typically responsible for managing all aspects of
automation controller and delegating responsibilities for day-to-day
work to various Users. Assign with caution!

image:users-create-user-form-types.png[User Types]

Note

The initial user (usually "admin") created by the installation process
is a Superuser. One Superuser must always exist. To delete the "admin"
user account, you must first create another Superuser account.

[arabic, start=3]
. Select *Save* when finished.

Once the user is successfully created, the *User* dialog opens for that
newly created User.

image:users-edit-user-form.png[Edit User Form]

You may delete the user from its Details screen by clicking *Delete*, or
once you exit the details screen, you can delete users from a list of
current users. See xref:ug_users_delete[] for more detail.

The count for the number of users has also been updated, and a new entry
for the new user is added to the list of users below the edit form. The
same window opens whether you click on the user's name, or the Edit
(image:edit-button.png[edit-button]) button
beside the user. Here, the User's *Organizations*, *Teams*, and
*Permissions*, as well as other user membership details, may be reviewed
and modified.

Note

If the user is not a newly-created user, the user's details screen
displays the last login activity of that user.

image:users-last-login-info.png[image]

When you log in as yourself, and view the details of your own user
profile, you can manage tokens from your user profile. See
{ug_users_tokens} for more detail.

image:user-with-token-button.png[image]

[[ug_users_delete]]
=== Delete a User

Before you can delete a user, you must have user permissions. When you
delete a user account, the name and email of the user are permanently
removed from automation controller.

[arabic]
. Expand the *_Access_* menu from the left navigation bar, and
click *_Users_* to display a list of the current users.
. Select the check box(es) for the user(s) that you want to remove and
click *_Delete_*.

image:users-home-users-checked-delete.png[image]

[arabic, start=3]
. Click *_Delete_* in the confirmation warning message to permanently
delete the user.

=== Users - Organizations

This displays the list of organizations of which that user is a member.
This list may be searched by Organization Name or Description.
Organization membership cannot be modified from this display panel.

image:users-organizations-list-for-example-user.png[Users
- Organizations list for example user]

=== Users - Teams

This displays the list of teams of which that user is a member. This
list may be searched by *Team Name* or *Description*. Team membership
cannot be modified from this display panel. For more information, refer
to xref:ug_teams[].

Until a Team has been created and the user has been assigned to that
team, the assigned Teams Details for the User appears blank.

image:users-teams-list-for-example-user.png[Users
- teams list for example user]

[[ug_users_permissions]]
=== Users - Permissions

The set of Permissions assigned to this user (role-based access
controls) that provide the ability to read, modify, and administer
projects, inventories, job templates, and other automation controller
elements are Privileges.

Note

It is important to note that the job template administrator may not have
access to any inventory, project, or credentials associated with the
template. Without access to these, certain fields in the job template
aren't editable.

This screen displays a list of the roles that are currently assigned to
the selected User and can be sorted and searched by *Name*, *Type*, or
*Role*.

image:users-permissions-list-for-example-user.png[Users
- permissions list for example user]

==== Add Permissions

To add permissions to a particular user:

[arabic]
. Click the *Add* button, which opens the Add Permissions Wizard.

image:users-add-permissions-form.png[Add Permissions Form]

[arabic, start=2]
. Click to select the object for which the user will have access and
click *Next*.
. Click to select the resource to assign team roles and click *Next*.

image:users-permissions-inventory-select.png[image]

[arabic, start=4]
. Click the checkbox beside the role to assign that role to your chosen
type of resource. Different resources have different options available.

image:users-permissions-inventory-roles.png[image]

[arabic, start=5]
. Click *Save* when done, and the Add Permissions Wizard closes to
display the updated profile for the user with the roles assigned for
each selected resource.

image:users-permissions-sample-roles.png[image]

To remove Permissions for a particular resource, click the disassociate
(x) button next to its resource. This launches a confirmation dialog,
asking you to confirm the disassociation.

Note

You can also add teams, individual, or multiple users and assign them
permissions at the object level (projects, inventories, job templates,
and workflow templates) as well. This feature reduces the time for an
organization to onboard many users at one time.

[[ug_users_tokens]]
=== Users - Tokens

The *Tokens* tab will only be present for your user (yourself). Before
you add a token for your user, you may want to
`create an application <ug_applications_auth_create>` if you want to
associate your token to it. You may also create a personal access token
(PAT) without associating it with any application. To create a token for
your user:

[arabic]
. If not already selected, click on your user from the Users list view
to configure your OAuth 2 tokens.

include::add-token.adoc[]

include::configure_tower_overview.adoc[]

Each tab contains fields with a *Reset* button, allowing you to revert
any value entered back to the default value. *Reset All* allows you to
revert all the values to their factory default values.

*Save* applies changes you make, but it does not exit the edit dialog.
To return to the Settings screen, click *Settings* from the left
navigation bar or use the breadcrumbs at the top of the current view.

== Authentication

include::configure_tower_authentication.adoc[]

[[configure_tower_jobs]]
== Jobs

The Jobs tab allows you to configure the types of modules that are
allowed to be used by the controller's Ad Hoc Commands feature, set
limits on the number of jobs that can be scheduled, define their output
size, and other details pertaining to working with Jobs in the
controller.

[arabic]
. From the left navigation bar, click *Settings* from the left
navigation bar and select *Jobs settings* from the Settings screen.
. Set the configurable options from the fields provided. Click the
tooltip image:tooltips-icon.png[help] icon
next to the field that you need additional information or details about.
Refer to the xref:ug_galaxy[] section for details about configuring Galaxy
settings.

Note

The values for all the timeouts are in seconds.

image:configure-tower-jobs.png[image]

[arabic, start=3]
. Click *Save* to apply the settings or *Cancel* to abandon the changes.

[[configure_tower_system]]
== System

The System tab allows you to define the base URL for the controller
host, configure alerts, enable activity capturing, control visibility of
users, enable certain controller features and functionality through a
license file, and configure logging aggregation options.

[arabic]
. From the left navigation bar, click *Settings*.
. The right side of the Settings window is a set of configurable System
settings. Select from the following options:

__________________________________________________________________________________________________________________________________________________________________________________________________________
* *Miscellaneous System settings*: define the base URL for the
controller host, enable controller administration alerts, and allow all
users to be visible to organization administrators.
* *Activity Stream settings*: enable or disable activity stream.
* *Logging settings*: configure logging options based on the type you
choose:
+
image:configure-tower-system-logging-types.png[image]
+
For more information about each of the logging aggregation types, refer
to the `Controller Logging and Aggregation <administration:ag_logging>`
section of the Automation Controller Administration Guide.
__________________________________________________________________________________________________________________________________________________________________________________________________________

[arabic, start=3]
. Set the configurable options from the fields provided. Click the
tooltip image:tooltips-icon.png[help] icon
next to the field that you need additional information or details about.

image:configure-tower-system.png[image]

Note

The *Allow External Users to Create Oauth2 Tokens* setting is disabled
by default. This ensures external users cannot _create_ their own
tokens. If you enable then disable it, any tokens created by external
users in the meantime will still exist, and are not automatically
revoked.

[arabic, start=4]
. Click *Save* to apply the settings or *Cancel* to abandon the changes.

[[configure_tower_ui]]
== User Interface

The User Interface tab allows you to set controller analytics settings,
as well as configure custom logos and login messages.

Access the User Interface settings by clicking *Settings* from the left
navigation bar and select *User Interface settings* from the Settings
screen.

image:configure-tower-ui.png[image]

include::user-data-tracking.adoc[]

=== Custom Logos and Images

include::logos_branding.adoc[]

== License

include::import_license.adoc[]

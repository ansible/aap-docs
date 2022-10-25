== The User Interface

The User Interface offers a friendly graphical framework for your IT
orchestration needs. The left navigation bar provides quick access to
resources, such as *Projects*, *Inventories*, *Job Templates*, and
*Jobs*.

Across the top-right side of the interface, you can access your user
profile, the About page, view related documentation, and log out. Right
below these options, you can view the activity stream for that user by
clicking on the Activity Stream
image:activitystream.png[activitystream]
button.

image:ug-dashboard-top-nav.png[image]

[[ug_activitystreams]]
=== Activity Streams

Most screens have an Activity Stream
(image:activitystream.png[activitystream])
button. Clicking this brings up the *Activity Stream* for this object.

image:users-activity-stream.png[Users -
Activity Stream]

An Activity Stream shows all changes for a particular object. For each
change, the Activity Stream shows the time of the event, the user that
initiated the event, and the action. The information displayed varies
depending on the type of event. Clicking on the Examine
(image:examine-button.png[examine]) button
shows the event log for the change.

image:activity-stream-event-log.png[event
log]

The Activity Stream can be filtered by the initiating user (or the
system, if it was system initiated), and by any related object, such as
a particular credential, job template, or schedule.

The Activity Stream on the main Dashboard shows the Activity Stream for
the entire instance. Most pages allow viewing an activity stream
filtered for that specific object.

=== Views

The User Interface provides several options for viewing information.

==== Dashboard view

The *Dashboard* view begins with a summary of your hosts, inventories,
and projects. Each of these is linked to the corresponding objects for
easy access.

image:ug-dashboard-topsummary.png[image]

On the main Dashboard screen, a summary appears listing your current
*Job Status*. The *Job Status* graph displays the number of successful
and failed jobs over a specified time period. You can choose to limit
the job types that are viewed, and to change the time horizon of the
graph.

Also available for view are summaries of *Recent Jobs* and *Recent
Templates* on their respective tabs.

The *Recent Jobs* section displays which jobs were most recently run,
their status, and time when they were run as well.

image:ug-dashboard-recent-jobs.png[image]

The *Recent Templates* section of this display shows a summary of the
most recently used templates. You can also access this summary by
clicking *Templates* from the left navigation bar.

image:ug-dashboard-recent-templates.png[image]

Note

Clicking on *Dashboard* from the left navigation bar or the Ansible
Automation Platform logo at any time returns you to the Dashboard.

==== Jobs view

Access the *Jobs* view by clicking *Jobs* from the left navigation bar.
This view shows all the jobs that have ran, including projects,
templates, management jobs, SCM updates, playbook runs, etc.

image:ug-dashboard-jobs-view.png[image]

==== Schedules view

Access the Schedules view by clicking *Schedules* from the left
navigation bar. This view shows all the scheduled jobs that are
configured.

image:ug-dashboard-schedule-view.png[image]

=== Resources and Access

The *Resources* and *Access* menus provide you access to the various
components of automation controller and allow you to configure who has
permissions for which of those resources.

image:left-nav-resources-access.png[image]

=== Administration Menu

The *Administration* menu provides access to the various administrative
options:

image:left-nav-administration.png[image]

From here, you can create, view, and edit
`custom credential types <ug_credential_types>`,
`notifications <ug_notifications>`, management jobs,
`tokens and applications <ug_applications_auth>`, and configure
{ug_execution_environments}.

=== The Settings Menu

Configuring global and system-level settings is accomplished through the
*Settings* menu, which is described in further detail in the proceeding
section. The *Settings* menu offers access to administrative
configuration options.

include::settings-menu.adoc[]

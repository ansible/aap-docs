[[ug_JobTemplates]]
== Job Templates

A `job template` is a definition and set of parameters for running an
Ansible job. Job templates are useful to execute the same job many
times. Job templates also encourage the reuse of Ansible playbook
content and collaboration between teams.

The *Templates* menu opens a list of the job templates that are
currently available. The default view is collapsed (Compact), showing
the template name, template type, and the timestamp of last job that ran
using that template. You can click *Expanded* (arrow next to each entry)
to expand to view more information. This list is sorted alphabetically
by name, but you can sort by other criteria, or search by various fields
and attributes of a template.

image:job-templates-home-with-example-job-template.png[Job
templates - home with example job template]

From this screen, you can launch
(image:launch-button.png[launch]), edit
(image:edit-button.png[edit]), and copy
(image:copy-button.png[copy]) a job template.
To delete a job template, you must select one or more templates and
click the *Delete* button. Before deleting a job template, be sure it is
not used in a workflow job template.

include::work_items_deletion_warning.adoc[]

Note

Job templates can be used to build a workflow template. For templates
that show the Workflow Visualizer
(image:wf-viz-icon.png[wf-viz-icon]) icon
next to them are workflow templates. Clicking it allows you to
graphically build a workflow. Many parameters in a job template allow
you to enable *Prompt on Launch* that can be modified at the workflow
level, and do not affect the values assigned at the job template level.
For instructions, see the xref:ug_wf_editor[] section.

=== Create a Job Template

To create a new job template:

[arabic]
. Click the *Add* button then select *Job Template* from the menu list.
. Enter the appropriate details into the following fields:

* *Name*: Enter a name for the job.
* *Description*: Enter an arbitrary description as appropriate
(optional).
* *Job Type*: Choose a job type:

______________________________________________________________________________________________________________________________________________________________________________________________________________
--
* *Run*: Execute the playbook when launched, running Ansible tasks on
the selected hosts.
* *Check*: Perform a "dry run" of the playbook and report changes that
would be made without actually making them. Tasks that do not support
check mode will be skipped and will not report potential changes.

______________________________________________________________________________________________________________________________________________
* *Prompt on Launch*: If selected, even if a default value is supplied,
you will be prompted upon launch to choose a job type of run or check.
______________________________________________________________________________________________________________________________________________

Note

More information on job types can be found in the
http://docs.ansible.com/playbooks_special_topics.html[Playbooks: Special
Topics] section of the Ansible documentation.

--
______________________________________________________________________________________________________________________________________________________________________________________________________________

* *Inventory*: Choose the inventory to be used with this job template
from the inventories available to the currently logged in user.

_________________________________________________________________________________________________________________________________________________________________
* *Prompt on Launch*: If selected, even if a default value is supplied,
you will be prompted upon launch to choose an inventory to run this job
template against.
_________________________________________________________________________________________________________________________________________________________________

* *Project*: Choose the project to be used with this job template from
the projects available to the currently logged in user.
* *SCM Branch*: This field is only present if you chose a project that
allows branch override. Specify the overriding branch to use in your job
run. If left blank, the specified SCM branch (or commit hash or tag)
from the project is used. For more detail, see
`job branch overriding <ug_job_branching>`.
** *Prompt on Launch*: If selected, even if a default value is supplied,
you will be prompted upon launch to choose an SCM branch.
* *Playbook*: Choose the playbook to be launched with this job template
from the available playbooks. This field automatically populates with
the names of the playbooks found in the project base path for the
selected project. Alternatively, you can enter the name of the playbook
if it is not listed, such as the name of a file (like `foo.yml`) you
want to use to run with that playbook. If you enter a filename that is
not valid, the template will display an error, or cause the job to fail.
* *Credentials*: Click the button to open a separate window. Choose the
credential from the available options to be used with this job template.
Use the drop-down menu list to filter by credential type if the list is
extensive.

Note

Some credential types are not listed because they do not apply to
certain job templates.

image:job-templates-credentials-selection-box.png[image]

* *Prompt on Launch*: If selected, upon launching a job template that
has a default machine credential, you will not be able to remove the
default machine credential in the Prompt dialog without replacing it
with another machine credential before it can launch. Alternatively, you
can add more credentials as you see fit. Below is an example of such a
message:

* *Forks*: The number of parallel or simultaneous processes to use while
executing the playbook. A value of zero uses the Ansible default
setting, which is 5 parallel processes unless overridden in
`/etc/ansible/ansible.cfg`.
* *Limit*: A host pattern to further constrain the list of hosts managed
or affected by the playbook. Multiple patterns can be separated by
colons (":"). As with core Ansible, "a:b" means "in group a or b",
"a:b:&c" means "in a or b but must be in c", and "a:!b" means "in a, and
definitely not in b".

______________________________________________________________________________________________________________________________
* *Prompt on Launch*: If selected, even if a default value is supplied,
you will be prompted upon launch to choose a limit.
+
Note

For more information and examples refer to
http://docs.ansible.com/intro_patterns.html[Patterns] in the Ansible
documentation.
______________________________________________________________________________________________________________________________

* *Verbosity*: Control the level of output Ansible produces as the
playbook executes. Choose the verbosity from Normal to various Verbose
or Debug settings. This only appears in the "details" report view.
Verbose logging includes the output of all commands. Debug logging is
exceedingly verbose and includes information on SSH operations that can
be useful in certain support instances. Most users do not need to see
debug mode output.
+
Warning

Verbosity 5 causes automation controller to block heavily when jobs are
running, which could delay reporting that the job has finished (even
though it has) and can cause the browser tab to lock up.

_______________________________________________________________________________________________________________________________
* *Prompt on Launch*: If selected, even if a default value is supplied,
you will be prompted upon launch to choose a verbosity.
_______________________________________________________________________________________________________________________________

* *Job Tags*: Provide a comma-separated list of playbook tags to specify
what parts of the playbooks should be executed. For more information and
examples refer to http://docs.ansible.com/playbooks_tags.html[Tags] in
the Ansible documentation.

_____________________________________________________________________________________________________________________________
* *Prompt on Launch*: If selected, even if a default value is supplied,
you will be prompted upon launch to choose a job tag.
_____________________________________________________________________________________________________________________________

* *Skip Tags*: Provide a comma-separated list of playbook tags to skip
certain tasks or parts of the playbooks to be executed. For more
information and examples refer to
http://docs.ansible.com/playbooks_tags.html[Tags] in the Ansible
documentation.

__________________________________________________________________________________________________________________________________
* *Prompt on Launch*: If selected, even if a default value is supplied,
you will be prompted upon launch to choose tag(s) to skip.
__________________________________________________________________________________________________________________________________

* *Labels*: Supply optional labels that describe this job template, such
as "dev" or "test". Labels can be used to group and filter job templates
and completed jobs in the display.

________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________
* Labels are created when they are added to the Job Template. Labels are
associated to a single Organization using the Project that is provided
in the Job Template. Members of the Organization can create labels on a
Job Template if they have edit permissions (such as admin role).
* Once the Job Template is saved, the labels appear in the Job Templates
overview in the _Expanded_ view.
* Click on the "x" beside a label to remove it. When a label is removed,
and is no longer associated with a Job or Job Template, the label is
permanently deleted from the list of Organization labels.
* Jobs inherit labels from the Job Template at the time of launch. If a
label is deleted from a Job Template, it is also deleted from the Job.
________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

* *Instance Groups*: Click the button to open a separate window. Choose
the instance groups on which you want to run this job template. If the
list is extensive, use the search to narrow the options.
* *Job Slicing*: Specify the number of slices you want this job template
to run. Each slice will run the same tasks against a portion of the
inventory. For more information about job slices, see xref:ug_job_slice[].
* *Timeout*: Allows you to specify the length of time (in seconds) that
the job may run before it is canceled. Defaults to 0 for no job timeout.
* *Show Changes*: Allows you to see the changes made by Ansible tasks.

__________________________________________________________________________________________________________________________________________________
* *Prompt on Launch*: If selected, even if a default value is supplied,
you will be prompted upon launch to choose whether or not to show
changes.
__________________________________________________________________________________________________________________________________________________

* *Options*: Specify options for launching this template, if necessary.

________________________________________________________________________________________________________________________________________________________________________________________________________________________________________
* *Privilege Escalation*: If checked, you enable this playbook to run as
an administrator. This is the equivalent of passing the `--become`
option to the `ansible-playbook` command.
* *Provisioning Callbacks*: If checked, you enable a host to call back
to automation controller via the REST API and invoke the launch of a job
from this job template. Refer to xref:ug_provisioning_callbacks[] for
additional information.
* *Enable Webhook*: Turns on the ability to interface with a predefined
SCM system web service that is used to launch a job template. Currently
supported SCM systems are GitHub and GitLab.
________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

[[ug_jt_enable_webhooks]]
_________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________
--
If you enable webhooks, other fields display, prompting for additional
information:

_________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________
image:job-templates-options-webhooks.png[image]

* *Webhook Service*: Select which service to listen for webhooks from
* *Webhook URL*: Automatically populated with the URL for the webhook
service to POST requests to.
* *Webhook Key*: Generated shared secret to be used by the webhook
service to sign payloads sent to automation controller. This must be
configured in the settings on the webhook service in order for
automation controller to accept webhooks from this service.
* *Webhook Credential*: Optionally, provide a GitHub or GitLab personal
access token (PAT) as a credential to use to send status updates back to
the webhook service. Before you can select it, the credential must
exist. See xref:ug_credentials_cred_types[] to create one.

For additional information on setting up webhooks, see {ug_webhooks}.
_________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

* *Concurrent Jobs*: If checked, you are allowing jobs in the queue to
run simultaneously if not dependent on one another. Check this box if
you want to run job slices simultaneously. Refer to xref:ug_job_concurrency[]
for additional information.
* *Enable Fact Storage*: When checked, automation controller will store
gathered facts for all hosts in an inventory related to the job running.

--
_________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

* *Extra Variables*:

_____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________
* Pass extra command line variables to the playbook. This is the "-e" or
"--extra-vars" command line parameter for ansible-playbook that is
documented in the Ansible documentation at
http://docs.ansible.com/playbooks_variables.html#passing-variables-on-the-command-line[Passing
Variables on the Command Line].
* Provide key/value pairs using either YAML or JSON. These variables
have a maximum value of precedence and overrides other variables
specified elsewhere. An example value might be:
+
....
git_branch: production
release_version: 1.5
....
+
See xref:ug_jobtemplates_extravars[] for more information.
* *Prompt on Launch*: If selected, even if a default value is supplied,
you will be prompted upon launch to choose command line variables.
_____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

Note

If you want to be able to specify `extra_vars` on a schedule, you must
select *Prompt on Launch* for *EXTRA VARIABLES* on the job template, or
a enable a survey on the job template, then those answered survey
questions become `extra_vars`.

image:job-templates-create-new-job-template.png[Job
templates - create new job template]

[arabic, start=3]
. When you have completed configuring the details of the job template,
click *Save*.

Saving the template does not exit the job template page but advances to
the Job Template Details tab for viewing. After saving the template, you
can click *Launch* to launch the job, or click *Edit* to add or change
the attributes of the template, such as permissions, notifications, view
completed jobs, and add a survey (if the job type is not a scan). You
must f.adoc[] save the template prior to launching, otherwise, the *Launch*
button remains grayed-out.

image:job-templates-job-template-saved.png[image]

You can verify the template is saved when the newly created template
appears on the Templates list view.

=== Add Permissions

include::permissions.adoc[]

=== Work with Notifications

Clicking the *Notifications* tab allows you to review any notification
integrations you have setup and their statuses, if they have ran.

image:job-template-completed-notifications-view.png[image]

Use the toggles to enable or disable the notifications to use with your
particular template. For more detail, see {ug_notifications_on_off}.

If no notifications have been set up, click the *Add* button to create a
new notification. Refer to {ug_notifications_types} for additional
details on configuring various notification types and extended
messaging.

=== View Completed Jobs

The *Completed Jobs* tab provides the list of job templates that have
ran. Click *Expanded* to view details of each job, including its status,
ID, and name; type of job, time started and completed, who started the
job; and which template, inventory, project, and credential were used.
You can filter the list of completed jobs using any of these criteria.

image:job-template-completed-jobs-view.png[image]

Sliced jobs that display on this list are labeled accordingly, with the
number of sliced jobs that have run:

image:sliced-job-shown-jobs-list-view.png[image]

=== Scheduling

Access the schedules for a particular job template from the *Schedules*
tab.

image:job-templates-schedules.png[Job
Templates - schedule launch]

==== Schedule a Job Template

To schedule a job template run, click the *Schedules* tab.

* If schedules are already set up; review, edit, or enable/disable your
schedule preferences.
* If schedules have not been set up, refer to {ug_scheduling} for more
information.

If *Prompt on Launch* was selected for the *Credentials* field, and you
create or edit scheduling information for your job template, a *Prompt*
button displays at the bottom of the Schedules form. You will not be
able to remove the default machine credential in the Prompt dialog
without replacing it with another machine credential before you can save
it. Below is an example of such a message:

Note

To able to set `extra_vars` on schedules, you must select *Prompt on
Launch* for *EXTRA VARIABLES* on the job template, or a enable a survey
on the job template, then those answered survey questions become
`extra_vars`.

[[ug_surveys]]
=== Surveys

Job types of Run or Check will provide a way to set up surveys in the
Job Template creation or editing screens. Surveys set extra variables
for the playbook similar to 'Prompt for Extra Variables' does, but in a
user-friendly question and answer way. Surveys also allow for validation
of user input. Click the *Survey* tab to create a survey.

Use cases for surveys are numerous. An example might be if operations
wanted to give developers a "push to stage" button they could run
without advanced Ansible knowledge. When launched, this task could
prompt for answers to questions such as, "What tag should we release?"

Many types of questions can be asked, including multiple-choice
questions.

[[ug_surveys_create]]
==== Create a Survey

To create a survey:

[arabic]
. Click the *Survey* tab and click the *Add* button.
. A survey can consist of any number of questions. For each question,
enter the following information:

* *Name*: The question to ask the user
* *Description*: (optional) A description of what's being asked of the
user.
* *Answer Variable Name*: The Ansible variable name to store the user's
response in. This is the variable to be used by the playbook. Variable
names cannot contain spaces.
* *Answer Type*: Choose from the following question types.
** _Text_: A single line of text. You can set the minimum and maximum
length (in characters) for this answer.
** _Textarea_: A multi-line text field. You can set the minimum and
maximum length (in characters) for this answer.
** _Password_: Responses are treated as sensitive information, much like
an actual password is treated. You can set the minimum and maximum
length (in characters) for this answer.
** _Multiple Choice (single select)_: A list of options, of which only
one can be selected at a time. Enter the options, one per line, in the
*Multiple Choice Options* box.
** _Multiple Choice (multiple select)_: A list of options, any number of
which can be selected at a time. Enter the options, one per line, in the
*Multiple Choice Options* box.
** _Integer_: An integer number. You can set the minimum and maximum
length (in characters) for this answer.
** _Float_: A decimal number. You can set the minimum and maximum length
(in characters) for this answer.
* *Required*: Whether or not an answer to this question is required from
the user.
* *Minimum length* and *Maximum length*: Specify if a certain length in
the answer is required.
* *Default Answer*: The default answer to the question. This value is
pre-filled in the interface and is used if the answer is not provided by
the user.

image:job-template-create-survey.png[image]

[arabic, start=3]
. Once you have entered the question information, click *Save* to add
the question.

The survey question displays in the Survey list. For any question, you
can click image:edit-button.png[edit] to edit
the question, or check the box next to each question and click *Delete*
to delete the question, or use the toggle button at the top of the
screen to enable or disable the survey prompt(s).

image:job-template-completed-survey.png[job-template-completed-survey]

If you have more than one survey question, use the *Edit Order* button
to rearrange the order of the questions by clicking and dragging on the
grid icon.

image:job-template-rearrange-survey.png[image]

[arabic, start=4]
. To add more questions, click the *Add* button to add additional
questions.

==== Optional Survey Questions

The *Required* setting on a survey question determines whether the
answer is optional or not for the user interacting with it.

Behind the scenes, optional survey variables can be passed to the
playbook in `extra_vars`, even when they aren't filled in.

* If a non-text variable (input type) is marked as optional, and is not
filled in, no survey `extra_var` is passed to the playbook.
* If a text input or text area input is marked as optional, is not
filled in, and has a minimum `length > 0`, no survey `extra_var` is
passed to the playbook.
* If a text input or text area input is marked as optional, is not
filled in, and has a minimum `length === 0`, that survey `extra_var` is
passed to the playbook, with the value set to an empty string ( "" ).

=== Launch a Job Template

A major benefit of automation controller is the push-button deployment
of Ansible playbooks. You can easily configure a template to store all
parameters you would normally pass to the ansible-playbook on the
command line--not just the playbooks, but the inventory, credentials,
extra variables, and all options and settings you can specify on the
command line.

Easier deployments drive consistency, by running your playbooks the same
way each time, and allow you to delegate responsibilities--even users
who aren’t Ansible experts can run playbooks written by others.

Launch a job template by any of the following ways:

* Access the job template list from the *Templates* menu on the left
navigation bar or while in the Job Template Details view, scroll to the
bottom to access the
image:launch-button.png[launch] button from
the list of templates.

image:job-templates-home-with-example-job-template-launch.png[image]

* While in the Job Template Details view of the job template you want to
launch, click *Launch*.

A job may require additional information to run. The following data may
be requested at launch:

* Credentials that were setup
* The option `Prompt on Launch` is selected for any parameter
* Passwords or passphrases that have been set to *Ask*
* A survey, if one has been configured for the job templates
* Extra variables, if requested by the job template

Note

If a job has user-provided values, then those are respected upon
relaunch. If the user did not specify a value, then the job uses the
default value from the job template. Jobs are not relaunched as-is. They
are relaunched with the user prompts re-applied to the job template.

Below is an example job launch that prompts for Job Tags, and runs the
example survey created in xref:ug_surveys[].

image:job-launch-with-prompt-at-launch-jobtags.png[job-launch-with-prompt-job-tags]

image:job-launch-with-prompt-at-launch-survey.png[job-launch-with-prompt-survey]

Note

Providing values on one tab, and going back to a previous tab, and then
continuing on to the next tab will result in having to re-provide values
on the rest of the tabs. Make sure you fill in the tabs in the order the
prompts appear to avoid this.

Along with any extra variables set in the job template and survey,
automation controller automatically adds the following variables to the
job environment. Also note, `awx_`* variables are defined by the system
and cannot be overridden. Variables about the job context, like
`awx_job_template_name` are not affected if they are set in
`extra_vars`.

* `awx_job_id`: The Job ID for this job run
* `awx_job_launch_type`: The description to indicate how the job was
started:
** *manual*: Job was started manually by a user.
** *relaunch*: Job was started via relaunch.
** *callback*: Job was started via host callback.
** *scheduled*: Job was started from a schedule.
** *dependency*: Job was started as a dependency of another job.
** *workflow*: Job was started from a workflow job.
** *sync*: Job was started from a project sync.
** *scm*: Job was created as an Inventory SCM sync.
* `awx_job_template_id`: The Job Template ID that this job run uses
* `awx_job_template_name`: The Job Template name that this job uses
* `awx_project_revision`: The revision identifier for the source tree
that this particular job uses (it is also the same as the job's field
`scm_revision`)
* `awx_project_scm_branch`: The configured default project SCM branch
for the project the job template uses
* `awx_job_scm_branch` If the SCM Branch is overwritten by the job, the
value is shown here
* `awx_user_email`: The user email of the controller user that started
this job. This is not available for callback or scheduled jobs.
* `awx_user_f.adoc[]_name`: The user's f.adoc[] name of the controller user
that started this job. This is not available for callback or scheduled
jobs.
* `awx_user_id`: The user ID of the controller user that started this
job. This is not available for callback or scheduled jobs.
* `awx_user_last_name`: The user's last name of the controller user that
started this job. This is not available for callback or scheduled jobs.
* `awx_user_name`: The user name of the controller user that started
this job. This is not available for callback or scheduled jobs.
* `awx_schedule_id`: If applicable, the ID of the schedule that launched
this job
* `awx_schedule_name`: If applicable, the name of the schedule that
launched this job
* `awx_workflow_job_id`: If applicable, the ID of the workflow job that
launched this job
* `awx_workflow_job_name`: If applicable, the name of the workflow job
that launched this job. Note this is also the same as the workflow job
template.
* `awx_inventory_id`: If applicable, the ID of the inventory this job
uses
* `awx_inventory_name`: If applicable, the name of the inventory this
job uses

For compatibility, all variables are also given an "awx" prefix, for
example, `awx_job_id`.

Upon launch, automation controller automatically redirects the web
browser to the Job Status page for this job under the *Jobs* tab.

Note

You can re-launch the most recent job from the list view to re-run on
all hosts or just failed hosts in the specified inventory. Refer to
{ug_jobs} in the Automation Controller User Guide for more detail.

When slice jobs are running, job lists display the workflow and job
slices, as well as a link to view their details individually.

image:sliced-job-shown-jobs-list-view.png[image]

=== Copy a Job Template

If you choose to copy Job Template, it *does not* copy any associated
schedule, notifications, or permissions. Schedules and notifications
must be recreated by the user or admin creating the copy of the Job
Template. The user copying the Job Template will be granted the admin
permission, but no permissions are assigned (copied) to the Job
Template.

[arabic]
. Access the job template list from the *Templates* menu on the left
navigation bar or while in the Job Template Details view, scroll to the
bottom to access it from the list of templates.

image:job-templates-home-with-example-job-template.png[Job
templates - home with example job template]

[arabic, start=2]
. Click the image:copy-button.png[copy]
button associated with the template you want to copy.

The new template with the name of the template from which you copied and
a timestamp displays in the list of templates.

[arabic, start=3]
. Click to open the new template and click *Edit*.
. Replace the contents of the *Name* field with a new name, and provide
or modify the entries in the other fields to complete this page.
. Click *Save* when done.

[[ug_jobtemplates_scanjobs]]
=== Scan Job Templates

Scan jobs are no longer supported starting with automation controller
3.2. This system tracking feature was used as a way to capture and store
facts as historical data. Facts are now stored in the controller via
fact caching. For more information, see xref:ug_fact_caching[].

If you have Job Template Scan Jobs in your system prior to automation
controller 3.2, they have been converted to type run (like normal job
templates) and retained their associated resources (i.e. inventory,
credential). Job Template Scan Jobs that do not have a related project
are assigned a special playbook by default, or you can specify a project
with your own scan playbook. A project was created for each organization
that points to https://github.com/ansible/tower-fact-modules and the Job
Template was set to the playbook,
https://github.com/ansible/tower-fact-modules/blob/master/scan_facts.yml.

==== Fact Scan Playbooks

The scan job playbook, `scan_facts.yml`, contains invocations of three
`fact scan modules` - packages, services, and files, along with
Ansible's standard fact gathering. The `scan_facts.yml` playbook file
looks like the following:

[source,sourceCode,python]
----
- hosts: all
  vars:
    scan_use_checksum: false
    scan_use_recursive: false
  tasks:
    - scan_packages:
    - scan_services:
    - scan_files:
        paths: '{{ scan_file_paths }}'
        get_checksum: '{{ scan_use_checksum }}'
        recursive: '{{ scan_use_recursive }}'
      when: scan_file_paths is defined
----

The `scan_files` fact module is the only module that accepts parameters,
passed via `extra_vars` on the scan job template.

[source,sourceCode,python]
----
scan_file_paths: '/tmp/'
scan_use_checksum: true
scan_use_recursive: true
----

* The `scan_file_paths` parameter may have multiple settings (such as
`/tmp/` or `/var/log`).
* The `scan_use_checksum` and `scan_use_recursive` parameters may also
be set to false or omitted. An omission is the same as a false setting.

Scan job templates should enable `become` and use credentials for which
`become` is a possibility. You can enable become by checking the *Enable
Privilege Escalation* from the Options menu:

image:job-templates-create-new-job-template-become.png[image]

==== Supported OSes for `scan_facts.yml`

If you use the `scan_facts.yml` playbook with use fact cache, ensure
that your OS is supported:

* Red Hat Enterprise Linux 5, 6, & 7
* Ubuntu 16.04 (Support for Unbuntu is deprecated and will be removed in
a future release)
* OEL 6 & 7
* SLES 11 & 12
* Debian 6, 7, 8
* Fedora 22, 23, 24
* Amazon Linux 2016.03
* Windows Server 2008 and later

Note that some of these operating systems may require initial
configuration in order to be able to run python and/or have access to
the python packages (such as `python-apt`) that the scan modules depend
on.

==== Pre-scan Setup

The following are examples of playbooks that configure certain
distributions so that scan jobs can be run against them.

*Bootstrap Ubuntu (16.04)*

....
---

- name: Get Ubuntu 16, and on ready
 hosts: all
 sudo: yes
 gather_facts: no

 tasks:

 - name: install python-simplejson
   raw: sudo apt-get -y update
   raw: sudo apt-get -y install python-simplejson
   raw: sudo apt-get install python-apt
....

*Bootstrap Fedora (23, 24)*

....
---

- name: Get Fedora ready
 hosts: all
 sudo: yes
 gather_facts: no

 tasks:

 - name: install python-simplejson
   raw: sudo dnf -y update
   raw: sudo dnf -y install python-simplejson
   raw: sudo dnf -y install rpm-python
....

==== Custom Fact Scans

A playbook for a custom fact scan is similar to the example of the Fact
Scan Playbook above. As an example, a playbook that only uses a custom
`scan_foo` Ansible fact module would look like this:

_scan_custom.yml_:

[source,sourceCode,python]
----
- hosts: all
  gather_facts: false
  tasks:
    - scan_foo:
----

_scan_foo.py_:

[source,sourceCode,python]
----
def main():
    module = AnsibleModule(
        argument_spec = dict())

    foo = [
      {
        "hello": "world"
      },
      {
        "foo": "bar"
      }
    ]
    results = dict(ansible_facts=dict(foo=foo))
    module.exit_json(**results)

main()
----

To use a custom fact module, ensure that it lives in the `/library/`
subdirectory of the Ansible project used in the scan job template. This
fact scan module is very simple, returning a hard-coded set of facts:

[source,sourceCode,python]
----
[
   {
     "hello": "world"
   },
   {
     "foo": "bar"
   }
 ]
----

Refer to the link:[Module Provided 'Facts'] section of the Ansible
documentation for more information.

[[ug_fact_caching]]
=== Fact Caching

Automation controller can store and retrieve facts on a per-host basis
through an Ansible Fact Cache plugin. This behavior is configurable on a
per-job template basis. Fact caching is turned off by default but can be
enabled to serve fact requests for all hosts in an inventory related to
the job running. This allows you to use job templates with `--limit`
while still having access to the entire inventory of host facts. A
global timeout setting that the plugin enforces per-host, can be
specified (in seconds) through the Jobs settings menu:

image:configure-tower-jobs-fact-cache-timeout.png[image]

Upon launching a job that uses fact cache (`use_fact_cache=True`), the
controller will store all `ansible_facts` associated with each host in
the inventory associated with the job. The Ansible Fact Cache plugin
that ships with automation controller will only be enabled on jobs with
fact cache enabled (`use_fact_cache=True`).

When a job that has fact cache enabled (`use_fact_cache=True`) finishes
running, the controller will restore all records for the hosts in the
inventory. Any records with update times _newer_ than the currently
stored facts per-host will be updated in the database.

New and changed facts will be logged via the controller's logging
facility. Specifically, to the `system_tracking` namespace or logger.
The logging payload will include the fields:

_________________
* `host_name`
* `inventory_id`
* `ansible_facts`
_________________

where `ansible_facts` is a dictionary of all Ansible facts for
`host_name` in the controller inventory, `inventory_id`.

Note

If a hostname includes a forward slash (`/`), fact cache will not work
for that host. If you have an inventory with 100 hosts and one host has
a `/` in the name, 99 of those hosts will still collect facts.

==== Benefits of Fact Caching

Fact caching saves a significant amount of time over running fact
gathering. If you have a playbook in a job that runs against a thousand
hosts and forks, you could easily spend 10 minutes gathering facts
across all of those hosts. But if you run a job on a regular basis, the
f.adoc[] run of it caches these facts and the next run will just pull them
from the database. This cuts the runtime of jobs against large
inventories, including Smart Inventories, by an enormous magnitude.

Note

Do not modify the `ansible.cfg` file to apply fact caching. Custom fact
caching could conflict with the controller's fact caching feature. It is
recommended to use the fact caching module that comes with automation
controller. Fact caching is not supported for isolated nodes.

You can choose to use cached facts in your job by enabling it in the
*Options* field of the Job Templates window.

image:job-templates-options-use-factcache.png[image]

To clear facts, you need to run the Ansible `clear_facts`
http://docs.ansible.com/ansible/latest/modules/meta_module.html#examples[meta
task]. Below is an example playbook that uses the Ansible `clear_facts`
meta task.

....
- hosts: all
  gather_facts: false
  tasks:
    - name: Clear gathered facts from all currently targeted hosts
      meta: clear_facts
....

The API endpoint for fact caching can be found at:
`http://<controller server name>/api/v2/hosts/x/ansible_facts`.

[[ug_CloudCredentials]]
=== Utilizing Cloud Credentials

Cloud Credentials can be used when syncing a respective cloud inventory.
Cloud Credentials may also be associated with a Job Template and
included in the runtime environment for use by a playbook. Cloud
Credentials currently supported:

==== OpenStack

The sample playbook below invokes the `nova_compute` Ansible OpenStack
cloud module and requires credentials to do anything meaningful, and
specifically requires the following information: `auth_url`, `username`,
`password`, and `project_name`. These fields are made available to the
playbook via the environmental variable `OS_CLIENT_CONFIG_FILE`, which
points to a YAML file written by the controller based on the contents of
the cloud credential. This sample playbook loads the YAML file into the
Ansible variable space.

`OS_CLIENT_CONFIG_FILE` example:

....
clouds:
  devstack:
    auth:
      auth_url: http://devstack.yoursite.com:5000/v2.0/
      username: admin
      password: your_password_here
      project_name: demo
....

Playbook example:

....
- hosts: all
  gather_facts: false
  vars:
    config_file: "{{ lookup('env', 'OS_CLIENT_CONFIG_FILE') }}"
    nova_tenant_name: demo
    nova_image_name: "cirros-0.3.2-x86_64-uec"
    nova_instance_name: autobot
    nova_instance_state: 'present'
    nova_flavor_name: m1.nano

    nova_group:
      group_name: antarctica
      instance_name: deceptacon
      instance_count: 3
  tasks:
    - debug: msg="{{ config_file }}"
    - stat: path="{{ config_file }}"
      register: st
    - include_vars: "{{ config_file }}"
      when: st.stat.exists and st.stat.isreg

    - name: "Print out clouds variable"
      debug: msg="{{ clouds|default('No clouds found') }}"

    - name: "Setting nova instance state to: {{ nova_instance_state }}"
      local_action:
        module: nova_compute
        login_username: "{{ clouds.devstack.auth.username }}"
        login_password: "{{ clouds.devstack.auth.password }}"
....

==== Amazon Web Services

Amazon Web Services cloud credentials are exposed as the following
environment variables during playbook execution (in the job template,
choose the cloud credential needed for your setup):

* `AWS_ACCESS_KEY_ID`
* `AWS_SECRET_ACCESS_KEY`

All of the AWS modules will implicitly use these credentials when run
via the controller without having to set the `aws_access_key_id` or
`aws_secret_access_key` module options.

==== Google

Google cloud credentials are exposed as the following environment
variables during playbook execution (in the job template, choose the
cloud credential needed for your setup):

* `GCE_EMAIL`
* `GCE_PROJECT`
* `GCE_CREDENTIALS_FILE_PATH`

All of the Google modules will implicitly use these credentials when run
via the controller without having to set the `service_account_email`,
`project_id`, or `pem_file` module options.

==== Azure

Azure cloud credentials are exposed as the following environment
variables during playbook execution (in the job template, choose the
cloud credential needed for your setup):

* `AZURE_SUBSCRIPTION_ID`
* `AZURE_CERT_PATH`

All of the Azure modules implicitly use these credentials when run via
the controller without having to set the `subscription_id` or
`management_cert_path` module options.

==== VMware

VMware cloud credentials are exposed as the following environment
variables during playbook execution (in the job template, choose the
cloud credential needed for your setup):

* `VMWARE_USER`
* `VMWARE_PASSWORD`
* `VMWARE_HOST`

The sample playbook below demonstrates usage of these credentials:

....
- vsphere_guest:
    vcenter_hostname: "{{ lookup('env', 'VMWARE_HOST') }}"
    username: "{{ lookup('env', 'VMWARE_USER') }}"
    password: "{{ lookup('env', 'VMWARE_PASSWORD') }}"
    guest: newvm001
    from_template: yes
    template_src: linuxTemplate
    cluster: MainCluster
    resource_pool: "/Resources"
    vm_extra_config:
      folder: MyFolder
....

[[ug_provisioning_callbacks]]
=== Provisioning Callbacks

Provisioning callbacks are a feature of Automation Controller that allow
a host to initiate a playbook run against itself, rather than waiting
for a user to launch a job to manage the host from the Automation
Controller console. Please note that provisioning callbacks are _only_
used to run playbooks on the calling host. Provisioning callbacks are
meant for cloud b.adoc[]ing (i.e. new instances with a need for client to
server communication for configuration (such as transmitting an
authorization key)), not to run a job against another host. This
provides for automatically configuring a system after it has been
provisioned by another system (such as AWS auto-scaling, or a OS
provisioning system like kickstart or preseed) or for launching a job
programmatically without invoking the Automation Controller API
directly. The Job Template launched only runs against the host
requesting the provisioning.

Frequently this would be accessed via a f.adoc[]boot type script, or from
cron.

To enable callbacks, check the _Provisioning Callbacks_ checkbox in the
Job Template. This displays the *Provisioning Callback URL* for this job
template.

Note

If you intend to use Automation Controller's provisioning callback
feature with a dynamic inventory, Update on Launch should be set for the
inventory group used in the Job Template.

image:provisioning-callbacks-config.png[image]

Callbacks also require a Host Config Key, to ensure that foreign hosts
with the URL cannot request configuration. Please provide a custom value
for Host Config Key. The host key may be reused across multiple hosts to
apply this job template against multiple hosts. Should you wish to
control what hosts are able to request configuration, the key may be
changed at any time.

To callback manually via REST, look at the callback URL in the UI, which
is of the form:

....
https://<CONTROLLER_SERVER_NAME>/api/v2/job_templates/7/callback/
....

The '7' in this sample URL is the job template ID in Automation
Controller.

The request from the host must be a POST. Here is an example using curl
(all on a single line):

....
curl -k -f -i -H 'Content-Type:application/json' -XPOST -d '{"host_config_key": "redhat"}' \ 
                  https://<CONTROLLER_SERVER_NAME>/api/v2/job_templates/7/callback/
....

The requesting host must be defined in your inventory for the callback
to succeed. If Automation Controller fails to locate the host either by
name or IP address in one of your defined inventories, the request is
denied. When running a Job Template in this way, the host initiating the
playbook run against itself must be in the inventory. If the host is
missing from the inventory, the Job Template will fail with a "No Hosts
Matched" type error message.

Note

If your host is not in inventory and `Update on Launch` is set for the
inventory group, Automation Controller attempts to update cloud based
inventory source before running the callback.

Successful requests result in an entry on the Jobs tab, where the
results and history can be viewed.

While the callback can be accessed via REST, the suggested method of
using the callback is to use one of the example scripts that ships with
Automation Controller - `/usr/share/awx/request_tower_configuration.sh`
(Linux/UNIX) or `/usr/share/awx/request_tower_configuration.ps1`
(Windows). Usage is described in the source code of the file by passing
the `-h` flag, as shown below:

....
./request_tower_configuration.sh -h
Usage: ./request_tower_configuration.sh <options>

Request server configuration from Ansible Tower.

OPTIONS:
 -h      Show this message
 -s      Controller server (e.g. https://ac.example.com) (required)
 -k      Allow insecure SSL connections and transfers
 -c      Host config key (required)
 -t      Job template ID (required)
 -e      Extra variables
....

This script has some intelligence, it knows how to retry commands and is
therefore a more robust way to use callbacks than a simple curl request.
As written, the script retries once per minute for up to ten minutes.

Note

Please note that this is an example script. You should edit this script
if you need more dynamic behavior when detecting failure scenarios, as
any non-200 error code may not be a transient error requiring retry.

Most likely you will use callbacks with dynamic inventory in Automation
Controller, such as pulling cloud inventory from one of the supported
cloud providers. In these cases, along with setting _Update On Launch_,
be sure to configure an inventory cache timeout for the inventory
source, to avoid hammering of your Cloud's API endpoints. Since the
`request_tower_configuration.sh` script polls once per minute for up to
ten minutes, a suggested cache invalidation time for inventory
(configured on the inventory source itself) would be one or two minutes.

While we recommend against running the `request_tower_configuration.sh`
script from a cron job, a suggested cron interval would be perhaps every
30 minutes. Repeated configuration can be easily handled by scheduling
in Automation Controller, so the primary use of callbacks by most users
is to enable a base image that is bootstrapped into the latest
configuration upon coming online. To do so, running at f.adoc[] boot is a
better practice. F.adoc[] boot scripts are just simple init scripts that
typically self-delete, so you would set up an init script that called a
copy of the `request_tower_configuration.sh` script and make that into
an autoscaling image.

==== Passing Extra Variables to Provisioning Callbacks

Just as you can pass `extra_vars` in a regular Job Template, you can
also pass them to provisioning callbacks. To pass `extra_vars`, the data
sent must be part of the body of the POST request as application/json
(as the content type). Use the following JSON format as an example when
adding your own `extra_vars` to be passed:

....
'{"extra_vars": {"variable1":"value1","variable2":"value2",...}}'
....

You can also pass extra variables to the Job Template call using `curl`,
such as is shown in the following example:

....
root@localhost:~$ curl -f -H 'Content-Type: application/json' -XPOST \
                 -d '{"host_config_key": "redhat", "extra_vars": "{\"foo\": \"bar\"}"}' \
                 https://<CONTROLLER_SERVER_NAME>/api/v2/job_templates/7/callback
....

For more information, refer to
`Launching Jobs with Curl<administration:launch_jobs_curl>`.

[[ug_jobtemplates_extravars]]
=== Extra Variables

Note

`extra_vars` passed to the job launch API are only honored if one of the
following is true:

* They correspond to variables in an enabled survey
* `ask_variables_on_launch` is set to True

When you pass survey variables, they are passed as extra variables
(`extra_vars`) within the controller. This can be tricky, as passing
extra variables to a job template (as you would do with a survey) can
override other variables being passed from the inventory and project.

For example, say that you have a defined variable for an inventory for
`debug = true`. It is entirely possible that this variable,
`debug = true`, can be overridden in a job template survey.

To ensure that the variables you need to pass are not overridden, ensure
they are included by redefining them in the survey. Keep in mind that
extra variables can be defined at the inventory, group, and host levels.

If specifying the `ALLOW_JINJA_IN_EXTRA_VARS` parameter, refer to the
`Controller Tips and Tricks <administration:ag_tips_jinja_extravars>`
section of the Automation Controller Administration Guide to configure
it in the Jobs Settings screen of the controller UI.

Note

The Job Template extra variables dictionary is merged with the Survey
variables.

Here are some simplified examples of extra_vars in YAML and JSON
formats:

The configuration in YAML format:

....
launch_to_orbit: true
satellites:
  - sputnik
  - explorer
  - satcom
....

The configuration in JSON format:

....
{
  "launch_to_orbit": true,
  "satellites": ["sputnik", "explorer", "satcom"]
}
....

The following table notes the behavior (hierarchy) of variable
precedence in automation controller as it compares to variable
precedence in Ansible.

*Automation Controller Variable Precedence Hierarchy (last listed wins)*

image:Architecture-Tower_Variable_Precedence_Hierarchy.png[image]

==== Relaunching Job Templates

Instead of manually relaunching a job, a relaunch is denoted by setting
`launch_type` to `relaunch`. The relaunch behavior deviates from the
launch behavior in that it *does not* inherit `extra_vars`.

Job relaunching does not go through the inherit logic. It uses the same
`extra_vars` that were calculated for the job being relaunched.

For example, say that you launch a Job Template with no `extra_vars`
which results in the creation of a Job called *j1*. Next, say that you
edit the Job Template and add in some `extra_vars` (such as adding
`"{ "hello": "world" }"`).

Relaunching *j1* results in the creation of *j2*, but because there is
no inherit logic and *j1* had no `extra_vars`, *j2* will not have any
`extra_vars`.

To continue upon this example, if you launched the Job Template with the
`extra_vars` you added after the creation of *j1*, the relaunch job
created (*j3*) will include the `extra_vars`. And relaunching *j3*
results in the creation of *j4*, which would also include `extra_vars`.

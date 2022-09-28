[[ug_webhooks]]
== Working with Webhooks

A `Webhook` provides the ability to execute specified commands between
apps over the web. automation controller currently provides webhook
integration with GitHub and GitLab. This section describes the procedure
for setting up a webhook through their respective services.

The webhook post-status-back functionality for GitHub and GitLab is
designed for work only under certain CI events. Receiving another kind
of event will result in messages like the one below in the service log:

....
awx.main.models.mixins Webhook event did not have a status API endpoint associated, skipping.
....

=== GitHub webhook setup

Automation controller has the ability to run jobs based on a triggered
webhook event coming in. Job status information (pending, error,
success) can be sent back only for pull request events. If you determine
you do not want automation controller to post job statuses back to the
webhook service, skip steps 1-2, and go directly to
`step 3 <ug_webhooks_setup_github>`.

[arabic]
. Optionally generate a personal access token (PAT) for use with
automation controller.
+
________________________________________________________________________________________________________________________________________________________________________________________________________
[loweralpha]
.. In the profile settings of your GitHub account, click *Settings*.
.. At the very bottom of the settings, click *<> Developer Settings*.
.. In the Developer settings, click *Personal access tokens*.
.. From the Personal access tokens screen, click *Generate new token*.
.. When prompted, enter your GitHub account password to continue.
.. In the *Note* field, enter a brief description about what this PAT
will be used for.
.. In the Scope fields, the automation webhook only needs repo scope
access, with the exception of invites. For information about other
scopes, click the link right above the table to access the docs.

image:webhooks-create-webhook-github-scope.png[image]

[loweralpha, start=8]
.. Click the *Generate Token* button.
.. Once the token is generated, make sure you copy the PAT, as it will
be used in a later step. You will not be able to access this token again
in GitHub.
________________________________________________________________________________________________________________________________________________________________________________________________________
. Use the PAT to optionally create a GitHub credential:
+
_________________________________________________________________________________________________________________________________________________
[loweralpha]
.. Go to your instance, and
`create a new credential for the GitHub PAT <ug_credentials_github>`
using the above generated token.
.. Make note of the name of this credential, as it will be used in the
job template that posts back to GitHub.

image:webhooks-create-credential-github-PAT-token.png[image]

[loweralpha, start=3]
.. Go to the job template with which you want to enable webhooks, and
select the webhook service and credential you created in the previous
step.

image:webhooks-job-template-gh-webhook-credential.png[image]

[verse]
--

--

[loweralpha, start=4]
.. Click *Save*. Now your job template is set up to be able to post back
to GitHub. An example of one may look like this:

image:webhooks-tower-to-github-status.png[image]
_________________________________________________________________________________________________________________________________________________

[[ug_webhooks_setup_github]]
[arabic, start=3]
. Go to a specific GitHub repo you want to configure webhooks and click
*Settings*.

image:webhooks-github-repo-settings.png[image]

[arabic, start=4]
. Under Options, click *Webhooks*.

image:webhooks-github-repo-settings-options.png[image]

[arabic, start=5]
. On the Webhooks page, click *Add webhook*.
. To complete the Add Webhook page, you need to
`enable webhooks in a job template <ug_jt_enable_webhooks>` (or in a
`workflow job template <ug_wfjt_enable_webhooks>`), which will provide
you with the following information:
+
_________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________
--
[loweralpha]
.. Copy the contents of the *Webhook URL* from the job template, and
paste it in the *Payload URL* field. GitHub uses this address to send
results to.
.. Set the *Content type* to *application/json*.
.. Copy the contents of the *Webhook Key* from the job template above
and paste it in the *Secret* field.
.. Leave *Enable SSL verification* selected.

____________________________________________________________________________
image:webhooks-github-repo-add-webhook.png[image]
____________________________________________________________________________

[verse]
--

--

[loweralpha, start=5]
.. Next, you must select the types of events you want to trigger a
webhook. Any such event will trigger the Job or Workflow. In order to
have job status (pending, error, success) sent back to GitHub, you must
select *Pull requests* in the individual events section.

image:webhooks-github-repo-choose-events.png[image]

[loweralpha, start=6]
.. Leave *Active* checked and click *Add Webhook*.

__________________________________________________________________________________
image:webhooks-github-repo-add-webhook-actve.png[image]
__________________________________________________________________________________

--
_________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________
. After your webhook is configured, it displays in the list of webhooks
active for your repo, along with the ability to edit or delete it. Click
on a webhook, and it brings you to the Manage webhook screen. Scroll to
the very bottom of the screen to view all the delivery attempts made to
your webhook and whether they succeeded or failed.

image:webhooks-github-repo-webhooks-deliveries.png[image]

For more information, refer to the
https://developer.github.com/webhooks/[GitHub Webhooks developer
documentation].

=== GitLab webhook setup

Automation controller has the ability to run jobs based on a triggered
webhook event coming in. Job status information (pending, error,
success) can be sent back only for merge request events. If you
determine you do not want automation controller to post job statuses
back to the webhook service, skip steps 1-2, and go directly to
`step 3 <ug_webhooks_setup_gitlab>`.

[arabic]
. Optionally, generate a personal access token (PAT). This token gives
automation controller the ability to post statuses back when we run jobs
based on a webhook coming in.
+
__________________________________________________________________________________________________________________________________________________________
[loweralpha]
.. In the profile settings of your GitLab account, click *Settings*.
.. On the sidebar, under User Settings, click *Access Tokens*.
+
___________________________________________________________________________________
image:webhooks-create-webhook-gitlab-settings.png[image]
___________________________________________________________________________________
.. In the *Name* field, enter a brief description about what this PAT
will be used for.
.. Skip the *Expires at* field unless you want to set an expiration date
for your webhook.
.. In the Scopes fields, select the ones applicable to your integration.
For automation controller, API is the only selection necessary.

image:webhooks-create-webhook-gitlab-scope.png[image]

[loweralpha, start=6]
.. Click the *Create personal access token* button.
.. Once the token is generated, make sure you copy the PAT, as it will
be used in a later step. You will not be able to access this token again
in GitLab.
__________________________________________________________________________________________________________________________________________________________
. Use the PAT to optionally create a GitLab credential:
+
_________________________________________________________________________________________________________________________________________________
[loweralpha]
.. Go to your instance, and
`create a new credential for the GitLab PAT <ug_credentials_gitlab>`
using the above generated token.
.. Make note of the name of this credential, as it will be used in the
job template that posts back to GitHub.

image:webhooks-create-credential-gitlab-PAT-token.png[image]

[loweralpha, start=3]
.. Go to the job template with which you want to enable webhooks, and
select the webhook service and credential you created in the previous
step.

image:webhooks-job-template-gl-webhook-credential.png[image]

[verse]
--

--

[loweralpha, start=4]
.. Click *Save*. Now your job template is set up to be able to post back
to GitLab. An example of one may look like this:

image:webhooks-tower-to-gitlab-status.png[image]
_________________________________________________________________________________________________________________________________________________

[[ug_webhooks_setup_gitlab]]
[arabic, start=3]
. Go to a specific GitLab repo you want to configure webhooks and click
*Settings > Integrations*.

image:webhooks-gitlab-repo-settings.png[image]

[arabic, start=4]
. To complete the Integrations page, you need to
`enable webhooks in a job template <ug_jt_enable_webhooks>` (or in a
`workflow job template <ug_wfjt_enable_webhooks>`), which will provide
you with the following information:
+
______________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________
[loweralpha]
.. Copy the contents of the *Webhook URL* from the job template above,
and paste it in the *URL* field. GitLab uses this address to send
results to.
.. Copy the contents of the *Webhook Key* from the job template above
and paste it in the *Secret Token* field.
.. Next, you must select the types of events you want to trigger a
webhook. Any such event will trigger the Job or Workflow. In order to
have job status (pending, error, success) sent back to GitLab, you must
select *Merge request events* in the Trigger section.
.. Leave *Enable SSL verification* selected.
.. Click *Add webhook*.
______________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

image:webhooks-gitlab-repo-add-webhook.png[image]

[arabic, start=5]
. After your webhook is configured, it displays in the list of Project
Webhooks for your repo, along with the ability to test events, edit or
delete the webhook. Testing a webhook event displays the results at the
top of the page whether it succeeded or failed.

For more information, refer to the
https://docs.gitlab.com/ee/user/project/integrations/webhooks.html[GitLab
webhooks integrations documentation].

=== Payload output

The entire payload is exposed as an extra variable. To view the payload
information, go to the Jobs Detail view of the job template that ran
with the webhook enabled. In the *Extra Variables* field of the Details
pane, view the payload output from the `awx_webhook_payload` variable,
as shown in the example below.

image:webhooks-jobs-extra-vars-payload.png[image]

image:webhooks-jobs-extra-vars-payload-expanded.png[image]

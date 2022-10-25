[[ug_credentials]]
== Credentials

Credentials are utilized for authentication when launching Jobs against
machines, synchronizing with inventory sources, and importing project
content from a version control system.

You can grant users and teams the ability to use these credentials,
without actually exposing the credential to the user. If you have a user
move to a different team or leave the organization, you don’t have to
re-key all of your systems just because that credential was available in
the automation controller.

Note

The automation controller encrypts passwords and key information in the
database and never makes secret information visible via the API. See
`Automation Controller Administration Guide <administration:ag_secret_handling>`
for details.

[[how_credentials_work]]
=== Understanding How Credentials Work

The automation controller uses SSH to connect to remote hosts (or the
Windows equivalent). In order to pass the key from the automation
controller to SSH, the key must be decrypted before it can be written a
named pipe. The automation controller then uses that pipe to send the
key to SSH (so that it is never written to disk).

If passwords are used, the automation controller handles those by
responding directly to the password prompt and decrypting the password
before writing it to the prompt.

=== Getting Started with Credentials

Click *Credentials* from the left navigation bar to access the
Credentials page. The Credentials page displays a search-able list of
all available Credentials and can be sorted by *Name*.

image:credentials-demo-edit-details.png[Credentials
- home with example credentials]

Credentials added to a Team are made available to all members of the
Team, whereas credentials added to a User are only available to that
specific User by default.

include::work_items_deletion_warning.adoc[]

To help you get started, a Demo Credential has been created for your
use.

Clicking on the link for the *Demo Credential* takes you to the
*Details* view of this Credential.

image:credentials-home-with-demo-credential-details.png[Credentials
- home with demo credential details]

Clicking the *Access* tab shows you users and teams associated with this
Credential and their granted roles (owner, admin, auditor, etc.)

image:credentials-home-with-permissions-detail.png[Credentials
- home with permissions credential details]

Note

A credential with roles associated will retain them even after the
credential has been reassigned to another organization.

You can click the *Add* button to assign this *Demo Credential* to
additional users. If no users exist, add them from the *Users* menu and
refer to the {ug_users} section for further detail.

[[ug_credentials_add]]
=== Add a New Credential

To create a new credential:

[arabic]
. Click the *Add* button from the *Credentials* screen.

image:credentials-create-credential.png[Create
credential]

[arabic, start=2]
. Enter the name for your new credential in the *Name* field.
. Optionally enter a description and enter or select the name of the
organization with which the credential is associated.

Note

A credential with a set of permissions associated with one organization
will remain even after the credential is reassigned to another
organization.

[arabic, start=4]
. Enter or select the credential type you want to create.

image:credential-types-drop-down-menu.png[image]

[arabic, start=5]
. Enter the appropriate details depending on the type of credential
selected, as described in the next section, xref:ug_credentials_cred_types[].
. Click *Save* when done.

[[ug_credentials_cred_types]]
=== Credential Types

The following credential types are supported with the automation
controller:

The credential types associated with Centrify, CyberArk, HashiCorp
Vault, Microsoft Azure Key Management System (KMS), and Thycotic are
part of the credential plugins capability that allows an external system
to lookup your secrets information. See the xref:ug_credential_plugins[]
section for further detail.

[[ug_credentials_aws]]
==== Amazon Web Services

Selecting this credential type enables synchronization of cloud
inventory with Amazon Web Services.

The automation controller uses the following environment variables for
AWS credentials and are fields prompted in the user interface:

....
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_SECURITY_TOKEN
....

image:credentials-create-aws-credential.png[Credentials
- create AWS credential]

Traditional Amazon Web Services credentials consist of the AWS *Access
Key* and *Secret Key*.

The automation controller provides support for EC2 STS tokens (sometimes
referred to as IAM STS credentials). Security Token Service (STS) is a
web service that enables you to request temporary, limited-privilege
credentials for AWS Identity and Access Management (IAM) users. To learn
more about the IAM/EC2 STS Token, refer to:
http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp.html

Note

If the value of your tags in EC2 contain booleans (yes/no/true/false),
you must remember to quote them.

Warning

To use implicit IAM role credentials, do not attach AWS cloud
credentials in the automation controller when relying on IAM roles to
access the AWS API. While it may seem to make sense to attach your AWS
cloud credential to your job template, doing so will force the use of
your AWS credentials and will not "fall through" to use your IAM role
credentials (this is due to the use of the boto library.)

==== Ansible Galaxy/Automation Hub API Token

Selecting this credential allows the automation controller to access
Galaxy or use a collection published on a local Automation Hub. See
xref:ug_collections_usage[] for detail. Entering the Galaxy server URL is the
only required value on this screen.

image:credentials-create-galaxy-credential.png[Credentials
- create galaxy credential]

==== Centrify Vault Credential Provider Lookup

This is considered part of the secret management capability. See
xref:ug_credentials_centrify[] for more detail.

==== Container Registry

Selecting this credential allows the automation controller to access a
collection of container images. See
https://www.redhat.com/en/topics/cloud-native-apps/what-is-a-container-registry[What
is a container registry?] for more information.

Aside from specifying a name, the *Authentication URL* is the only
required field on this screen, and it is already pre-populated with a
default value. You may change this default by specifying the
authentication endpoint for a different container registry.

image:credentials-create-container-credential.png[Credentials
- create container credential]

==== CyberArk AIM Credential Provider Lookup

This is considered part of the secret management capability. See
xref:ug_credentials_cyberarkaim[] for more detail.

==== CyberArk Conjur Secret Lookup

This is considered part of the secret management capability. See
xref:ug_credentials_cyberarkconjur[] for more detail.

[[ug_credentials_github]]
==== GitHub Personal Access Token

Selecting this credential allows you to access GitHub using a Personal
Access Token (PAT), which is obtained through GitHub. See {ug_webhooks}
for detail. Entering the provided token is the only required value in
this screen.

image:credentials-create-webhook-github-credential.png[Credentials
- create GitHub credential]

GitHub PAT credentials require a value in the *Token* field, which is
provided in your GitHub profile settings.

This credential can be used for establishing an API connection to GitHub
for use in webhook listener jobs, to post status updates.

[[ug_credentials_gitlab]]
==== GitLab Personal Access Token

Selecting this credential allows you to access GitLab using a Personal
Access Token (PAT), which is obtained through GitLab. See {ug_webhooks}
for detail. Entering the provided token is the only required value in
this screen.

image:credentials-create-webhook-gitlab-credential.png[Credentials
- create GitLab credential]

GitLab PAT credentials require a value in the *Token* field, which is
provided in your GitLab profile settings.

This credential can be used for establishing an API connection to GitLab
for use in webhook listener jobs, to post status updates.

==== Google Compute Engine

Selecting this credential type enables synchronization of cloud
inventory with Google Compute Engine (GCE).

The automation controller uses the following environment variables for
GCE credentials and are fields prompted in the user interface:

....
GCE_EMAIL
GCE_PROJECT
GCE_CREDENTIALS_FILE_PATH
....

image:credentials-create-gce-credential.png[Credentials
- create GCE credential]

GCE credentials have the following inputs that are required:

* *Service Account Email Address*: The email address assigned to the
Google Compute Engine *service account*.
* *Project*: Optionally provide the GCE assigned identification or the
unique project ID you provided at project creation time.
* *Service Account JSON File*: Optionally upload a GCE service account
file. Use the folder
(image:file-browser-button.png[file-browser])
icon to browse for the file that contains the special account
information that can be used by services and applications running on
your GCE instance to interact with other Google Cloud Platform APIs.
This grants permissions to the service account and virtual machine
instances.
* *RSA Private Key*: The PEM file associated with the service account
email.

==== HashiCorp Vault Secret Lookup

This is considered part of the secret management capability. See
xref:ug_credentials_hashivault[] for more detail.

==== HashiCorp Vault Signed SSH

This is considered part of the secret management capability. See
xref:ug_credentials_hashivaultssh[] for more detail.

==== Insights

Selecting this credential type enables synchronization of cloud
inventory with Red Hat Insights.

image:credentials-create-insights-credential.png[Credentials
- create Insights credential]

Insights credentials consist of the Insights *Username* and *Password*,
which is the user’s Red Hat Customer Portal Account username and
password.

==== Machine

Machine credentials enable the automation controller to invoke Ansible
on hosts under your management. Just like using Ansible on the command
line, you can specify the SSH username, optionally provide a password,
an SSH key, a key password, or even have the automation controller
prompt the user for their password at deployment time. They define ssh
and user-level privilege escalation access for playbooks, and are used
when submitting jobs to run playbooks on a remote host. Network
connections (`httpapi`, `netconf`, and `network_cli`) use *Machine* for
the credential type.

Machine/SSH credentials do not use environment variables. Instead, they
pass the username via the `ansible -u` flag, and interactively write the
SSH password when the underlying SSH client prompts for it.

image:credentials-create-machine-credential.png[Credentials
- create machine credential]

Machine credentials have several attributes that may be configured:

* *Username*: The username to be used for SSH authentication.
* *Password*: The actual password to be used for SSH authentication.
This password will be stored encrypted in the database, if entered.
Alternatively, you can configure the automation controller to ask the
user for the password at launch time by selecting *Prompt on launch*. In
these cases, a dialog opens when the job is launched, promoting the user
to enter the password and password confirmation.
* *SSH Private Key*: Copy or drag-and-drop the SSH private key for the
machine credential.
* *Private Key Passphrase*: If the SSH Private Key used is protected by
a password, you can configure a Key Password for the private key. This
password will be stored encrypted in the database, if entered.
Alternatively, you can configure the automation controller to ask the
user for the password at launch time by selecting *Prompt on launch*. In
these cases, a dialog opens when the job is launched, prompting the user
to enter the password and password confirmation.
* *Privilege Escalation Method*: Specifies the type of escalation
privilege to assign to specific users. This is equivalent to specifying
the `--become-method=BECOME_METHOD` parameter, where `BECOME_METHOD`
could be any of the typical methods described below, or a custom method
you've written. Begin entering the name of the method, and the
appropriate name auto-populates.

image:credentials-create-machine-credential-priv-escalation.png[image]

* empty selection: If a task/play has `become` set to `yes` and is used
with an empty selection, then it will default to `sudo`
* *sudo*: Performs single commands with super user (root user)
privileges
* *su*: Switches to the super user (root user) account (or to other user
accounts)
* *pbrun*: Requests that an application or command be run in a
controlled account and provides for advanced root privilege delegation
and keylogging
* *pfexec*: Executes commands with predefined process attributes, such
as specific user or group IDs
* *dzdo*: An enhanced version of sudo that uses RBAC information in an
Centrify's Active Directory service (see Centrify's
http://community.centrify.com/t5/Centrify-Server-Suite/FAQ-What-is-DirectAuthorize-dzdo-dzwin/td-p/21193[site
on DZDO])
* *pmrun*: Requests that an application is run in a controlled account
(refer to
http://documents.software.dell.com/privilege-manager-for-unix/6.0/administrators-guide/privilege-manager-programs/pmrun[Privilege
Manager for Unix 6.0])
* *runas*: Allows you to run as the current user
* *enable*: Switches to elevated permissions on a network device
* *doas*: Allows your remote/login user to execute commands as another
user via the doas ("Do as user") utility
* *ksu*: Allows your remote/login user to execute commands as another
user via Kerberos access
* *machinectl*: Allows you to manage containers via the systemd machine
manager
* *sesu*: Allows your remote/login user to execute commands as another
user via the CA Privileged Access Manager

Note

Custom `become` plugins are available only starting with Ansible 2.8.
For more detail on this concept, refer to [.title-ref]#Und.adoc[]anding
Privilege Escalation
https://docs.ansible.com/ansible/latest/user_guide/become.html# and the
[.title-ref]#list of become plugins
https://docs.ansible.com/ansible/latest/plugins/become.html#plugin-list#.

* *Privilege Escalation Username* field is only seen if an option for
privilege escalation is selected. Enter the username to use with
escalation privileges on the remote system.
* *Privilege Escalation Password*: field is only seen if an option for
privilege escalation is selected. Enter the actual password to be used
to authenticate the user via the selected privilege escalation type on
the remote system. This password will be stored encrypted in the
database, if entered. Alternatively, you may configure the automation
controller to ask the user for the password at launch time by selecting
*Prompt on launch*. In these cases, a dialog opens when the job is
launched, promoting the user to enter the password and password
confirmation.

Note

Sudo Password must be used in combination with SSH passwords or SSH
Private Keys, since the automation controller must f.adoc[] establish an
authenticated SSH connection with the host prior to invoking sudo to
change to the sudo user.

Warning

Credentials which are used in _Scheduled Jobs_ must not be configured as
"*Prompt on launch*".

==== Microsoft Azure Key Vault

This is considered part of the secret management capability. See
xref:ug_credentials_azurekeyvault[] for more detail.

==== Microsoft Azure Resource Manager

Selecting this credential type enables synchronization of cloud
inventory with Microsoft Azure Resource Manager.

image:credentials-create-azure-credential.png[Credentials
- create Azure credential]

Microsoft Azure Resource Manager credentials have several attributes
that may be configured:

* *Subscription ID*: The Subscription UUID for the Microsoft Azure
account (required).
* *Username*: The username to use to connect to the Microsoft Azure
account.
* *Password*: The password to use to connect to the Microsoft Azure
account.
* *Client ID*: The Client ID for the Microsoft Azure account.
* *Client Secret*: The Client Secret for the Microsoft Azure account.
* *Tenant ID*: The Tenant ID for the Microsoft Azure account.
* *Azure Cloud Environment*: The variable associated with Azure cloud or
Azure stack environments.

These fields are equivalent to the variables in the API. To pass service
principal credentials, define the following variables:

....
AZURE_CLIENT_ID
AZURE_SECRET
AZURE_SUBSCRIPTION_ID
AZURE_TENANT
AZURE_CLOUD_ENVIRONMENT
....

To pass an Active Directory username/password pair, define the following
variables:

....
AZURE_AD_USER
AZURE_PASSWORD
AZURE_SUBSCRIPTION_ID
....

You can also pass credentials as parameters to a task within a playbook.
The order of precedence is parameters, then environment variables, and
finally a file found in your home directory.

To pass credentials as parameters to a task, use the following
parameters for service principal credentials:

....
client_id
secret
subscription_id
tenant
azure_cloud_environment
....

Or, pass the following parameters for Active Directory
username/password:

....
ad_user
password
subscription_id
....

==== Network

Select the Network credential type *only* if you are using a
[.title-ref]#local# connection with [.title-ref]#provider# to use
Ansible networking modules to connect to and manage networking devices.
When connecting to network devices, the credential type must match the
connection type:

* For `local` connections using `provider`, credential type should be
*Network*
* For all other network connections (`httpapi`, `netconf`, and
`network_cli`), credential type should be *Machine*

For an overview of connection types available for network devices, refer
to link:[Multiple Communication Protocols].

The automation controller uses the following environment variables for
Network credentials and are fields prompted in the user interface:

....
ANSIBLE_NET_USERNAME
ANSIBLE_NET_PASSWORD
....

image:credentials-create-network-credential.png[Credentials
- create network credential]

Network credentials have several attributes that may be configured:

* *Username*: The username to use in conjunction with the network device
(required).
* *Password*: The password to use in conjunction with the network
device.
* *SSH Private Key*: Copy or drag-and-drop the actual SSH Private Key to
be used to authenticate the user to the network via SSH.
* *Private Key Passphrase*: The actual passphrase for the private key to
be used to authenticate the user to the network via SSH.
* *Authorize*: Select this from the Options field to control whether or
not to enter privileged mode.
* If *Authorize* is checked, enter a password in the *Authorize
Password* field to access privileged mode.

For more information, refer to the _Inside Playbook_ blog,
https://www.ansible.com/blog/porting-ansible-network-playbooks-with-new-connection-plugins[Porting
Ansible Network Playbooks with New Connection Plugins].

[[ug_credentials_ocp_k8s]]
==== OpenShift or Kubernetes API Bearer Token

Selecting this credential type allows you to create instance groups that
point to a Kubernetes or OpenShift container. For more information about
this concept, refer to {ag_ext_exe_env}.

image:credentials-create-containers-credential.png[Credentials
- create Containers credential]

Container credentials have the following inputs:

* *OpenShift or Kubernetes API Endpoint* (required): the endpoint to be
used to connect to an OpenShift or Kubernetes container
* *API Authentication Bearer Token* (required): The token to use to
authenticate the connection
* *Verify SSL*: Optionally you can check this option to verify the
server’s SSL certificate is valid and trusted. Environments that use
internal or private CA’s should leave this option unchecked to disable
verification.
* *Certificate Authority Data*: include the `BEGIN CERTIFICATE` and
`END CERTIFICATE` lines when pasting the certificate, if provided

include::get-creds-from-service-account.adoc[]

==== OpenStack

Selecting this credential type enables synchronization of cloud
inventory with OpenStack.

image:credentials-create-openstack-credential.png[Credentials
- create OpenStack credential]

OpenStack credentials have the following inputs that are required:

* *Username*: The username to use to connect to OpenStack.
* *Password (API Key)*: The password or API key to use to connect to
OpenStack.
* *Host (Authentication URL)*: The host to be used for authentication.
* *Project (Tenant Name)*: The Tenant name or Tenant ID used for
OpenStack. This value is usually the same as the username.
* *Project (Domain Name)*: Optionally provide the project name
associated with your domain.
* *Domain name*: Optionally provide the FQDN to be used to connect to
OpenStack.

If you are interested in using OpenStack Cloud Credentials, refer to
xref:ug_CloudCredentials[] in this guide for more information, including a
sample playbook.

==== Red Hat Ansible Automation Platform

Selecting this credential allows you to access another automation
controller instance.

image:credentials-create-at-credential.png[Credentials
- create tower credential]

Automation controller credentials have the following inputs that are
required:

* *Controller Hostname*: The base URL or IP address of the other
instance to connect to.
* *Username*: The username to use to connect to it.
* *Password*: The password to use to connect to it.
* *Oauth Token*: If username and password is not used, provide an OAuth
token to use to authenticate.

==== Red Hat Satellite 6

Selecting this credential type enables synchronization of cloud
inventory with Red Hat Satellite 6.

The automation controller writes a Satellite configuration file based on
fields prompted in the user interface. The absolute path to the file is
set in the following environment variable:

....
FOREMAN_INI_PATH
....

image:credentials-create-rh-sat-credential.png[Credentials
- create Red Hat Satellite 6 credential]

Satellite credentials have the following inputs that are required:

* *Satellite 6 URL*: The Satellite 6 URL or IP address to connect to.
* *Username*: The username to use to connect to Satellite 6.
* *Password*: The password to use to connect to Satellite 6.

==== Red Hat Virtualization

This credential allows the automation controller to access Ansible's
`oVirt4.py` dynamic inventory plugin, which is managed by Red Hat
Virtualization (RHV).

The automation controller uses the following environment variables for
Red Hat Virtualization credentials and are fields in the user interface:

....
OVIRT_URL
OVIRT_USERNAME
OVIRT_PASSWORD
....

image:credentials-create-rhv-credential.png[Credentials
- create rhv credential]

RHV credentials have the following inputs that are required:

* *Host (Authentication URL)*: The host URL or IP address to connect to.
In order to sync with the inventory, the credential URL needs to include
the `ovirt-engine/api` path.
* *Username*: The username to use to connect to oVirt4. This needs to
include the domain profile to succeed, for example
`username@ovirt.host.com`.
* *Password*: The password to use to connect to it.
* *CA File*: Optionally provide an absolute path to the oVirt
certificate file (it may end in `.pem`, `.cer` and `.crt` extensions,
but preferably `.pem` for consistency)

==== Source Control

SCM (source control) credentials are used with Projects to clone and
update local source code repositories from a remote revision control
system such as Git or Subversion.

image:credentials-create-scm-credential.png[Credentials
- create SCM credential]

Source Control credentials have several attributes that may be
configured:

* *Username*: The username to use in conjunction with the source control
system.
* *Password*: The password to use in conjunction with the source control
system.
* *SCM Private Key*: Copy or drag-and-drop the actual SSH Private Key to
be used to authenticate the user to the source control system via SSH.
* *Private Key Passphrase*: If the SSH Private Key used is protected by
a passphrase, you may configure a Key Passphrase for the private key.

Note

Source Control credentials cannot be configured as "*Prompt on launch*".
If you are using a GitHub account for a Source Control credential and
you have 2FA (Two Factor Authenication) enabled on your account, you
will need to use your Personal Access Token in the password field rather
than your account password.

==== Thycotic DevOps Secrets Vault

This is considered part of the secret management capability. See
xref:ug_credentials_thycoticvault[] for more detail.

==== Thycotic Secret Server

This is considered part of the secret management capability. See
xref:ug_credentials_thycoticserver[] for more detail.

==== Vault

Selecting this credential type enables synchronization of inventory with
Ansible Vault.

image:credentials-create-vault-credential.png[Credentials
- create Vault credential]

Vault credentials require the *Vault Password* and an optional *Vault
Identifier* if applying multi-Vault credentialing. For more information
on the automation controller Multi-Vault support, refer to the
{ag_multi_vault} section of the Automation Controller Administration
Guide.

You may configure the automation controller to ask the user for the
password at launch time by selecting *Prompt on launch*. In these cases,
a dialog opens when the job is launched, promoting the user to enter the
password and password confirmation.

Warning

Credentials which are used in _Scheduled Jobs_ must not be configured as
"*Prompt on launch*".

For more information about Ansible Vault, refer to:
http://docs.ansible.com/ansible/playbooks_vault.html

==== VMware vCenter

Selecting this credential type enables synchronization of inventory with
VMware vCenter.

The automation controller uses the following environment variables for
VMware vCenter credentials and are fields prompted in the user
interface:

....
VMWARE_HOST
VMWARE_USER
VMWARE_PASSWORD
VMWARE_VALIDATE_CERTS
....

image:credentials-create-vmware-credential.png[Credentials
- create VMware credential]

VMware credentials have the following inputs that are required:

* *vCenter Host*: The vCenter hostname or IP address to connect to.
* *Username*: The username to use to connect to vCenter.
* *Password*: The password to use to connect to vCenter.

Note

If the VMware guest tools are not running on the instance, VMware
inventory sync may not return an IP address for that instance.

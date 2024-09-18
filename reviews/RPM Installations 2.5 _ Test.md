# Installing on virtual machines

Thank you for your interest in Red Hat Ansible Automation Platform. Ansible Automation Platform is a commercial offering that helps teams manage complex multi-tier deployments by adding control, knowledge, and delegation to Ansible-powered environments.

This guide helps you to understand the installation requirements and processes behind installing Ansible Automation Platform. This document has been updated to include information for the latest release of Ansible Automation Platform.

## Providing feedback on Red Hat documentation

If you have a suggestion to improve this documentation, or find an error, you can contact technical support at [https://access.redhat.com](https://access.redhat.com) to open a request.

## 1\. Red Hat Ansible Automation Platform installation overview

The Red Hat Ansible Automation Platform installation program offers you flexibility, allowing you to install Ansible Automation Platform by using several supported installation scenarios.

Regardless of the installation scenario you choose, installing Ansible Automation Platform involves the following steps:

**Editing the Red Hat Ansible Automation Platform installer inventory file**

The Ansible Automation Platform installer inventory file allows you to specify your installation scenario and describe host deployments to Ansible. The examples provided in this document show the parameter specifications needed to install that scenario for your deployment.

**Running the Red Hat Ansible Automation Platform installer setup script**

The setup script installs Ansible Automation Platform by using the required parameters defined in the inventory file.

**Verifying your Ansible Automation Platform installation**

After installing Ansible Automation Platform, you can verify that the installation has been successful by logging in to the platform UI and seeing the relevant functionality.

*Additional resources*

1. For more information about the supported installation scenarios, see the [Red Hat Ansible Automation Platform Planning Guide](https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.5/html/red_hat_ansible_automation_platform_planning_guide/index).  
2. For more information on available topologies, see [Tested deployment models](https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.5/html-single/tested_deployment_models).

### 1.1. Prerequisites

* You chose and obtained a platform installer from the [Red Hat Ansible Automation Platform Product Software](https://access.redhat.com/downloads/content/480/ver=2.5/rhel---9/2.5/x86_64/product-software).  
* You are installing on a machine that meets base system requirements.  
* You have updated all of the packages to the recent version of your RHEL nodes.

| Warning | To prevent errors, upgrade your RHEL nodes fully before installing Ansible Automation Platform. |
| :---: | :---- |

*   
  You have created a Red Hat Registry Service Account, by using the instructions in [Creating Registry Service Accounts](https://access.redhat.com/RegistryAuthentication#creating-registry-service-accounts-6).

*Additional resources*

For more information about obtaining a platform installer or system requirements, see the [Red Hat Ansible Automation Platform system requirements](https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.5/html/red_hat_ansible_automation_platform_planning_guide/platform-system-requirements) in the *Red Hat Ansible Automation Platform Planning Guide*.

## 2\. System requirements

Use this information when planning your Red Hat Ansible Automation Platform installations and designing automation mesh topologies that fit your use case.

*Prerequisites*

* You can obtain root access either through the sudo command, or through privilege escalation. For more on privilege escalation, see [Understanding privilege escalation](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_privilege_escalation.html).  
* You can de-escalate privileges from root to users such as: AWX, PostgreSQL, Event-Driven Ansible, or Pulp.  
* You have configured an NTP client on all nodes. For more information, see [Configuring NTP server using Chrony](https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.5/html/red_hat_ansible_automation_platform_upgrade_and_migration_guide/migrate-isolated-execution-nodes#automation_controller_configuration_requirements).

### 2.1. Red Hat Ansible Automation Platform system requirements

Your system must meet the following minimum system requirements to install and run Red Hat Ansible Automation Platform. A resilient deployment requires 10 virtual machines with a minimum of 16 gigabytes(GB) of ram and 4 virtual cpus(vCPU). See, [Tested deployment models](https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.5/html-single/tested_deployment_models) for more information on topology options.

| Requirement | Required | Notes |
| :---- | :---- | :---- |
| **Subscription** | Valid Red Hat Ansible Automation Platform |  |
| **OS** | Red Hat Enterprise Linux 8.8 or later for Red Hat Enterprise Linux 8 and 9.2 or later for Red Hat Enterprise Linux 9 64-bit (x86, ppc64le, s390x, aarch64) | Red Hat Ansible Automation Platform is also supported on OpenShift, see [Deploying the Red Hat Ansible Automation Platform operator on OpenShift Container Platform](https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.5/html/deploying_the_red_hat_ansible_automation_platform_operator_on_openshift_container_platform/index) for more information. |
| **Ansible-core** | Ansible-core version 2.16 or later | Ansible Automation Platform uses the system-wide ansible-core package to install the platform, but uses ansible-core 2.16 for both its control plane and built-in execution environments. |
| **Database** | PostgreSQL version 15 |  |

| Component | RAM | VCPU | Storage |
| :---- | :---- | :---- | :---- |
| Platform gateway | 16GB | 4 | 20GB minimum |
| Control nodes | 16GB | 4 | 80GB minimum with at least 20GB available under /var/lib/awx |
| Execution nodes | 16GB | 4 | 40GB minimum |
| Hop nodes | 16GB | 4 | 40GB minimum |
| Automation hub | 16GB | 4 | 40GB minimum allocated to /var/lib/pulp |
| Database | 16GB | 4 | 100GB minimum allocated to /var/lib/pgsql |
| Event-Driven Ansible controller | 16GB | 4 | 40GB minimum |

| Note | These are minimum requirements and can be increased for larger workloads in increments of 2x (for example 16GB becomes 32GB and 4 vCPU becomes 8vCPU). See the horizontal scaling guide for more information. |
| :---: | :---- |

The following are necessary for you to work with project updates and collections:

* Ensure that the [network ports and protocols](https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.5/html/red_hat_ansible_automation_platform_planning_guide/ref-network-ports-protocols_planning) listed in *Table 5.3. Automation Hub* are available for successful connection and download of collections from automation hub or Ansible Galaxy server.

*Additional notes for Red Hat Ansible Automation Platform requirements*

* If performing a bundled Ansible Automation Platform installation, the installation setup.sh script attempts to install ansible-core (and its dependencies) from the bundle for you.  
* If you have installed Ansible-core manually, the Ansible Automation Platform installation setup.sh script detects that Ansible has been installed and does not attempt to reinstall it.

| Note | You must use Ansible-core, which is installed via dnf. Ansible-core version 2.16 is required for versions 2.5 and later. |
| :---: | :---- |

### 2.2. Platform gateway system requirements

The platform gateway is the service that handles authentication and authorization for Ansible Automation Platform. It provides a single entry into the platform and serves the platform’s user interface.

### 2.3. Automation controller system requirements

Automation controller is a distributed system, where different software components can be co-located or deployed across multiple compute nodes. In the installer, four node types are provided as abstractions to help you design the topology appropriate for your use case: control, hybrid, execution, and hop nodes.

Use the following recommendations for node sizing:

**Execution nodes**

Execution nodes run automation. Increase memory and CPU to increase capacity for running more forks.

| Note | The RAM and CPU resources stated are minimum recommendations to handle the job load for a node to run an average number of jobs simultaneously. Recommended RAM and CPU node sizes are not supplied. The required RAM or CPU depends directly on the number of jobs you are running in that environment. For capacity based on forks in your configuration, see [Automation controller capacity determination and job impact](https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.5/html/automation_controller_user_guide/controller-jobs#controller-capacity-determination). . For further information about required RAM and CPU levels, see [Performance tuning for automation controller](https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.5/html/automation_controller_administration_guide/assembly-controller-improving-performance). |
| :---: | :---- |

**Control nodes**

Control nodes process events and run cluster jobs including project updates and cleanup jobs. Increasing CPU and memory can help with job event processing.

Control nodes have the following storage requirements:

* 40GB minimum with at least 20GB available under /var/lib/awx  
* Storage volume must be rated for a minimum baseline of 1500 IOPS  
* Projects are stored on control and hybrid nodes, and for the duration of jobs, are also stored on execution nodes. If the cluster has many large projects, consider doubling the GB in /var/lib/awx/projects, to avoid disk space errors.

**Hop nodes**

Hop nodes serve to route traffic from one part of the automation mesh to another (for example, a hop node could be a bastion host into another network). RAM can affect throughput, CPU activity is low. Network bandwidth and latency are generally a more important factor than either RAM or CPU.

* Actual RAM requirements vary based on how many hosts automation controller manages simultaneously (which is controlled by the forks parameter in the job template or the system ansible.cfg file). To avoid possible resource conflicts, Ansible recommends 1 GB of memory per 10 forks and 2 GB reservation for automation controller. See [Automation controller capacity determination and job impact](https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.5/html/automation_controller_user_guide/controller-jobs#controller-capacity-determination). If forks is set to 400, 42 GB of memory is recommended.  
* Automation controller hosts check if umask is set to 0022\. If not, the setup fails. Set umask=0022 to avoid this error.  
* A larger number of hosts can be addressed, but if the fork number is less than the total host count, more passes across the hosts are required. You can avoid these RAM limitations by using any of the following approaches:  
  * Use rolling updates.  
  * Use the provisioning callback system built into automation controller, where each system requesting configuration enters a queue and is processed as quickly as possible.  
  * In cases where automation controller is producing or deploying images such as AMIs.

*Additional resources*

* For more information about obtaining an automation controller subscription, see [Importing a subscription](https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.5/html/automation_controller_user_guide/controller-managing-subscriptions#controller-importing-subscriptions).  
* For questions, contact Ansible support through the [Red Hat Customer Portal](https://access.redhat.com/).

### 2.4. Automation hub system requirements

Automation hub allows you to discover and use new certified automation content from Red Hat Ansible and Certified Partners. On Ansible automation hub, you can discover and manage Ansible Collections, which are supported automation content developed by Red Hat and its partners for use cases such as cloud automation, network automation, and security automation.

| Note | Private automation hub If you install private automation hub from an internal address, and have a certificate which only encompasses the external address, this can result in an installation which cannot be used as container registry without certificate issues. To avoid this, use the automationhub\_main\_url inventory variable with a value such as https://pah.example.com linking to the private automation hub node in the installation inventory file. This adds the external address to /etc/pulp/settings.py. This implies that you only want to use the external address. For information about inventory file variables, see [Inventory file variables](https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.5/html/red_hat_ansible_automation_platform_installation_guide/appendix-inventory-files-vars) in the *Red Hat Ansible Automation Platform Installation Guide*. |
| :---: | :---- |

#### 2.4.1. High availability automation hub requirements

Before deploying a high availability (HA) automation hub, ensure that you have a shared filesystem installed in your environment and that you have configured your network storage system, if applicable.

##### Required shared filesystem

A high availability automation hub requires you to have a shared file system, such as NFS, already installed in your environment. Before you run the Red Hat Ansible Automation Platform installer, verify that you installed the /var/lib/pulp directory across your cluster as part of the shared file system installation. The Red Hat Ansible Automation Platform installer returns an error if /var/lib/pulp is not detected in one of your nodes, causing your high availability automation hub setup to fail.

If you receive an error stating /var/lib/pulp is not detected in one of your nodes, ensure /var/lib/pulp is properly mounted in all servers and re-run the installer.

##### Installing firewalld for HA hub deployment

If you intend to install a HA automation hub using a network storage on the automation hub nodes itself, you must first install and use firewalld to open the necessary ports as required by your shared storage system before running the Ansible Automation Platform installer.

Install and configure firewalld by executing the following commands:

1. Install the firewalld daemon:  
   $ dnf install firewalld  
2. Add your network storage under \<service\> using the following command:  
   $ firewall-cmd \--permanent \--add-service=\<service\>

| Note | For a list of supported services, use the $ firewall-cmd \--get-services command |
| :---- | :---- |

3.   
   Reload to apply the configuration:  
   $ firewall-cmd \--reload

### 2.5. Event-Driven Ansible controller system requirements

The Event-Driven Ansible controller is a single-node system capable of handling a variable number of long-running processes (such as rulebook activations) on-demand, depending on the number of CPU cores.

Use the following minimum requirements to run, by default, a maximum of 12 simultaneous activations:

| Important | If you are running Red Hat Enterprise Linux 8 and want to set your memory limits, you must have cgroup v2 enabled before you install Event-Driven Ansible. For specific instructions, see the Knowledge-Centered Support (KCS) article, [Ansible Automation Platform Event-Driven Ansible controller for Red Hat Enterprise Linux 8 requires cgroupv2](https://access.redhat.com/solutions/7054905). When you activate an Event-Driven Ansible rulebook under standard conditions, it uses about 250 MB of memory. However, the actual memory consumption can vary significantly based on the complexity of your rules and the volume and size of the events processed. In scenarios where a large number of events are anticipated or the rulebook complexity is high, conduct a preliminary assessment of resource usage in a staging environment. This ensures that your maximum number of activations is based on the capacity of your resources. See [Single automation controller, single automation hub, and single Event-Driven Ansible controller node with external (installer managed) database](https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.5/html-single/red_hat_ansible_automation_platform_installation_guide/index#ref-single-controller-hub-eda-with-managed-db) for an example on setting Event-Driven Ansible controller maximum running activations. |
| :---: | :---- |

### 2.6. PostgreSQL requirements

Red Hat Ansible Automation Platform uses PostgreSQL 15\. PostgreSQL user passwords are hashed with SCRAM-SHA-256 secure hashing algorithm before storing in the database.

To determine if your automation controller instance has access to the database, you can do so with the command, awx-manage check\_db command.

| Note | Automation controller data is stored in the database. Database storage increases with the number of hosts managed, number of jobs run, number of facts stored in the fact cache, and number of tasks in any individual job. For example, a playbook runs every hour (24 times a day) across 250 hosts, with 20 tasks, stores over 800000 events in the database every week. If not enough space is reserved in the database, the old job runs and facts must be cleaned on a regular basis. For more information, see [Management Jobs](https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.5/html-single/automation_controller_administration_guide/index#assembly-controller-management-jobs) in the *Automation Controller Administration Guide*. |
| :---: | :---- |

*PostgreSQL Configurations*

Optionally, you can configure the PostgreSQL database as separate nodes that are not managed by the Red Hat Ansible Automation Platform installer. When the Ansible Automation Platform installer manages the database server, it configures the server with defaults that are generally recommended for most workloads. For more information about the settings you can use to improve database performance, see [Database Settings](https://docs.ansible.com/automation-controller/latest/html/administration/performance.html#database-settings).

*Additional resources*

For more information about tuning your PostgreSQL server, see the [PostgreSQL documentation](https://wiki.postgresql.org/wiki/Main_Page).

#### 2.6.1. Setting up an external (customer supported) database

| Important | Red Hat does not support the use of external (customer supported) databases, however they are used by customers. The following guidance on initial configuration, from a product installation perspective only, is provided to avoid related support requests. |
| :---: | :---- |

To create a database, user and password on an external PostgreSQL compliant database for use with automation controller, use the following procedure.

*Procedure*

1. Install and then connect to a PostgreSQL compliant database server with superuser privileges.  
   \# psql \-h \<hostname\> \-U superuser \-p 5432 \-d postgres \<password\_for\_user\_superuser\>

Where the default value for \<hostname\> is **hostname**:  
\-h hostname

2. \--host=hostname

Specify the hostname of the machine on which the server is running. If the value begins with a slash, it is used as the directory for the UNIX-domain socket.  
\-d dbname

3. \--dbname=dbname

Specify the name of the database to connect to. This is equal to specifying dbname as the first non-option argument on the command line. The dbname can be a connection string. If so, connection string parameters override any conflicting command line options.  
\-U username

4. \--username=username  
5. Connect to the database as the user username instead of the default (you must have permission to do so).  
6. Create the user, database, and password with the createDB or administrator role assigned to the user. For further information, see [Database Roles](https://www.postgresql.org/docs/13/user-manag.html).

Add the database credentials and host details to the automation controller inventory file as an external database. The default values are used in the following example:  
\[database\]  
  pg\_host='db.example.com'  
  pg\_port=5432  
  pg\_database='awx'  
  pg\_username='awx'

7.   pg\_password='redhat'  
8. Run the installer. If you are using a PostgreSQL database with automation controller, the database is owned by the connecting user and must have a createDB or administrator role assigned to it.  
9. Check that you are able to connect to the created database with the user, password and database name.  
10. Check the permission of the user. The user should have the createDB or administrator role.

| Note | During this procedure, you must check the External Database coverage. For further information, see [https://access.redhat.com/articles/4010491](https://access.redhat.com/articles/4010491) |
| :---: | :---- |

#### 2.6.2. Enabling the hstore extension for the automation hub PostgreSQL database

Added in Ansible Automation Platform 2.5, the database migration script uses hstore fields to store information, therefore the hstore extension to the automation hub PostgreSQL database must be enabled.

This process is automatic when using the Ansible Automation Platform installer and a managed PostgreSQL server.

If the PostgreSQL database is external, you must enable the hstore extension to the automation hub PostreSQL database manually before automation hub installation.

If the hstore extension is not enabled before automation hub installation, a failure is raised during database migration.

*Procedure*

1. Check if the extension is available on the PostgreSQL server (automation hub database).  
   $ psql \-d \<automation hub database\> \-c "SELECT \* FROM pg\_available\_extensions WHERE name='hstore'"

Where the default value for \<automation hub database\> is automationhub.  
**Example output with** hstore **available**:  
name  | default\_version | installed\_version |comment  
\------+-----------------+-------------------+---------------------------------------------------  
 hstore | 1.7           |                   | data type for storing sets of (key, value) pairs  
(1 row)  
**Example output with** hstore **not available**:  
 name | default\_version | installed\_version | comment  
\------+-----------------+-------------------+---------

2. (0 rows)  
3. On a RHEL based server, the hstore extension is included in the postgresql-contrib RPM package, which is not installed automatically when installing the PostgreSQL server RPM package.  
   To install the RPM package, use the following command:  
   dnf install postgresql-contrib

Create the hstore PostgreSQL extension on the automation hub database with the following command:  
$ psql \-d \<automation hub database\> \-c "CREATE EXTENSION hstore;"  
The output of which is:  
CREATE EXTENSION  
In the following output, the installed\_version field contains the hstore extension used, indicating that hstore is enabled.  
name | default\_version | installed\_version | comment  
\-----+-----------------+-------------------+------------------------------------------------------  
hstore  |     1.7      |       1.7         | data type for storing sets of (key, value) pairs

4. (1 row)

#### 2.6.3. Benchmarking storage performance for the Ansible Automation Platform PostgreSQL database

Check whether the minimum Ansible Automation Platform PostgreSQL database requirements are met by using the Flexible I/O Tester (FIO) tool. FIO is a tool used to benchmark read and write IOPS performance of the storage system.

*Prerequisites*

* You have installed the Flexible I/O Tester (fio) storage performance benchmarking tool.  
  To install fio, run the following command as the root user:  
  \# yum \-y install fio  
* You have adequate disk space to store the fio test data log files.  
  The examples shown in the procedure require at least 60GB disk space in the /tmp directory:  
  * numjobs sets the number of jobs run by the command.  
  * size=10G sets the file size generated by each job.  
* You have adjusted the value of the size parameter. Adjusting this value reduces the amount of test data.

*Procedure*

Run a random write test:  
$ fio \--name=write\_iops \--directory=/tmp \--numjobs=3 \--size=10G \\  
\--time\_based \--runtime=60s \--ramp\_time=2s \--ioengine=libaio \--direct=1 \\  
\--verify=0 \--bs=4K \--iodepth=64 \--rw=randwrite \\  
\--group\_reporting=1 \> /tmp/fio\_benchmark\_write\_iops.log \\

1. 2\>\> /tmp/fio\_write\_iops\_error.log

Run a random read test:  
$ fio \--name=read\_iops \--directory=/tmp \\  
\--numjobs=3 \--size=10G \--time\_based \--runtime=60s \--ramp\_time=2s \\  
\--ioengine=libaio \--direct=1 \--verify=0 \--bs=4K \--iodepth=64 \--rw=randread \\  
\--group\_reporting=1 \> /tmp/fio\_benchmark\_read\_iops.log \\

2. 2\>\> /tmp/fio\_read\_iops\_error.log

Review the results:  
In the log files written by the benchmark commands, search for the line beginning with iops. This line shows the minimum, maximum, and average values for the test.  
The following example shows the line in the log file for the random read test:  
$ cat /tmp/fio\_benchmark\_read\_iops.log  
read\_iops: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=64  
\[…\]  
   iops        : min=50879, max=61603, avg=56221.33, stdev=679.97, samples=360

3. \[…\]

| Note | The above is a baseline to help evaluate the best case performance on your systems. Systems can and will change and performance may vary depending on what else is happening on your systems, storage or network at the time of testing. You must review, monitor, and revisit the log files according to your own business requirements, application workloads, and new demands. |
| :---- | :---- |

## 3\. Installing Red Hat Ansible Automation Platform

Ansible Automation Platform is a modular platform. The platform gateway deploys automation platform components, such as automation controller, automation hub, and Event-Driven Ansible controller.

For more information about the components provided with Ansible Automation Platform, see [Red Hat Ansible Automation Platform components](https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.5/html/red_hat_ansible_automation_platform_planning_guide/planning-installation#ref-platform-components) in [Planning your installation](https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.5/html-single/planning_your_installation).

There are several supported installation scenarios for Red Hat Ansible Automation Platform. To install Red Hat Ansible Automation Platform, you must edit the inventory file parameters to specify your installation scenario. You can use one of the following as a basis for your own inventory file:

* Single platform gateway and automation controller with an external (installer managed) database  
* Single platform gateway, automation controller, and automation hub with an external (installer managed) database  
* Single platform gateway, automation controller, automation hub, and Event-Driven Ansible controller node with an external (installer managed) database

*Additional resources*

For a comprehensive list of pre-defined variables used in Ansible installation inventory files, see [A.6. Ansible variables](https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.5/html-single/red_hat_ansible_automation_platform_installation_guide/index#ref-ansible-inventory-variables).

### 3.1. Editing the Red Hat Ansible Automation Platform installer inventory file

You can use the Red Hat Ansible Automation Platform installer inventory file to specify your installation scenario.

*Procedure*

1. Navigate to the installer:  
   1. \[RPM installed package\]  
      $ cd /opt/ansible-automation-platform/installer/  
   2. \[bundled installer\]  
      $ cd ansible-automation-platform-setup-bundle-\<latest-version\>  
   3. \[online installer\]  
      $ cd ansible-automation-platform-setup-\<latest-version\>  
2. Open the inventory file with a text editor.  
3. Edit inventory file parameters to specify your installation scenario. You can use one of the supported Installation scenario examples as the basis for your inventory file.

*Additional resources*

* For a comprehensive list of pre-defined variables used in Ansible installation inventory files, see Inventory file variables.

### 3.2. Inventory file examples based on installation scenarios

Red Hat supports several installation scenarios for Ansible Automation Platform. You can develop your own inventory files using the example files as a basis, or you can use the example closest to your preferred installation scenario.

#### 3.2.1. Inventory file recommendations based on installation scenarios

Before selecting your installation method for Ansible Automation Platform, review the following recommendations. Familiarity with these recommendations will streamline the installation process.

* Provide a reachable IP address or fully qualified domain name (FQDN) for the \[automationhub\] and \[automationcontroller\] hosts to ensure users can sync and install content from automation hub from a different node.  
  The FQDN must not contain either the \- or the \_ symbols, as it will not be processed correctly.  
  Do not use localhost.  
* admin is the default user ID for the initial log in to Ansible Automation Platform and cannot be changed in the inventory file.  
* Use of special characters for pg\_password is limited. The \!, \#, 0 and @ characters are supported. Use of other special characters can cause the setup to fail.  
* Enter your Red Hat Registry Service Account credentials in registry\_username and registry\_password to link to the Red Hat container registry.  
* The inventory file variables registry\_username and registry\_password are only required if a non-bundle installer is used.

#### 3.2.2. Setting registry\_username and registry\_password

If you intend to use the registry\_username and registry\_password variables in an inventory file you are recommended to use the following method to create a Registry Service Account to set a token with an expiration in the plaintext inventory/vars.yml file instead of using a plaintext username and password, for reasons of security.

Registry service accounts provide named tokens that can be used in environments where credentials are shared, such as deployment systems.

*Procedure*

1. Navigate to [https://access.redhat.com/terms-based-registry/accounts](https://access.redhat.com/terms-based-registry/accounts)  
2. On the **Registry Service Accounts** page click **New Service Account**.  
3. Enter a name for the account using only the accepted characters.  
4. Optionally enter a description for the account.  
5. Click **Create account**.  
6. Find the created account in the list. The list of accounts is long so you might have to click **Next** multiple times before finding the account you created. Alternatively, if you know the name of your token, you can go directly to the page by entering the URL https://access.redhat.com/terms-based-registry/token/\<name-of-your-token\>  
7. Click the name of the account that you created.  
8. A **token** page opens, displaying a generated Username (different to the account name) and a token.  
   If no Username and token are displayed, click **Regenerate token**. You can also click this to generate a new Username and token.  
9. Copy the service account name and use it to set registry\_username.  
10. Copy the token and use it to set registry\_password.

##### Single platform gateway and automation controller with an external (installer managed) database

Use this example to see what is minimally needed within the inventory file to deploy single instances of platform gateway and automation controller with an external (installer managed) database.

\[automationcontroller\]  
controller.example.com

\[automationgateway\]  
gateway.example.com

\[database\]  
data.example.com

\[all:vars\]  
admin\_password='\<password\>'  
pg\_host='data.example.com'  
pg\_port=5432  
pg\_database='awx'  
pg\_username='awx'  
pg\_password='\<password\>'  
pg\_sslmode='prefer' \# set to 'verify-full' for client-side enforced SSL

registry\_url='registry.redhat.io'  
registry\_username='\<registry username\>'  
registry\_password='\<registry password\>'

\# Automation Gateway configuration  
automationgateway\_admin\_password=''

automationgateway\_pg\_host='data.example.com'  
automationgateway\_pg\_port=5432

automationgateway\_pg\_database='automationgateway'  
automationgateway\_pg\_username='automationgateway'  
automationgateway\_pg\_password=''  
automationgateway\_pg\_sslmode='prefer'

\# The main automation gateway URL that clients will connect to (e.g. https://\<load balancer host\>).  
\# If not specified, the first node in the \[automationgateway\] group will be used when needed.  
\# automationgateway\_main\_url \= ''

\# Certificate and key to install in Automation Gateway  
\# automationgateway\_ssl\_cert=/path/to/automationgateway.cert  
\# automationgateway\_ssl\_key=/path/to/automationgateway.key

\# SSL-related variables  
\# If set, this will install a custom CA certificate to the system trust store.  
\# custom\_ca\_cert=/path/to/ca.crt  
\# Certificate and key to install in nginx for the web UI and API  
\# web\_server\_ssl\_cert=/path/to/tower.cert  
\# web\_server\_ssl\_key=/path/to/tower.key  
\# Server-side SSL settings for PostgreSQL (when we are installing it).  
\# postgres\_use\_ssl=False  
\# postgres\_ssl\_cert=/path/to/pgsql.crt

\# postgres\_ssl\_key=/path/to/pgsql.key

##### Single platform gateway, automation controller, and automation hub with an external (installer managed) database

Use this example to populate the inventory file to deploy single instances of platform gateway, automation controller, and automation hub with an external (installer managed) database.

\[automationcontroller\]  
controller.example.com

\[automationhub\]  
automationhub.example.com

\[automationgateway\]  
gateway.example.com

\[database\]  
data.example.com

\[all:vars\]  
admin\_password='\<password\>'  
pg\_host='data.example.com'  
pg\_port='5432'  
pg\_database='awx'  
pg\_username='awx'  
pg\_password='\<password\>'  
pg\_sslmode='prefer'  \# set to 'verify-full' for client-side enforced SSL

registry\_url='registry.redhat.io'  
registry\_username='\<registry username\>'  
registry\_password='\<registry password\>'

automationhub\_admin\_password= \<PASSWORD\>

automationhub\_pg\_host='data.example.com'  
automationhub\_pg\_port=5432

automationhub\_pg\_database='automationhub'  
automationhub\_pg\_username='automationhub'  
automationhub\_pg\_password=\<PASSWORD\>  
automationhub\_pg\_sslmode='prefer'

\# The default install will deploy a TLS enabled Automation Hub.  
\# If for some reason this is not the behavior wanted one can  
\# disable TLS enabled deployment.  
\#  
\# automationhub\_disable\_https \= False  
\# The default install will generate self-signed certificates for the Automation  
\# Hub service. If you are providing valid certificate via automationhub\_ssl\_cert  
\# and automationhub\_ssl\_key, one should toggle that value to True.  
\#  
\# automationhub\_ssl\_validate\_certs \= False  
\# SSL-related variables  
\# If set, this will install a custom CA certificate to the system trust store.  
\# custom\_ca\_cert=/path/to/ca.crt  
\# Certificate and key to install in Automation Hub node  
\# automationhub\_ssl\_cert=/path/to/automationhub.cert  
\# automationhub\_ssl\_key=/path/to/automationhub.key

\# Automation Gateway configuration  
automationgateway\_admin\_password=''

automationgateway\_pg\_host=''  
automationgateway\_pg\_port=5432

automationgateway\_pg\_database='automationgateway'  
automationgateway\_pg\_username='automationgateway'  
automationgateway\_pg\_password=''  
automationgateway\_pg\_sslmode='prefer'

\# The main automation gateway URL that clients will connect to (e.g. https://\<load balancer host\>).  
\# If not specified, the first node in the \[automationgateway\] group will be used when needed.  
\# automationgateway\_main\_url \= ''

\# Certificate and key to install in Automation Gateway  
\# automationgateway\_ssl\_cert=/path/to/automationgateway.cert  
\# automationgateway\_ssl\_key=/path/to/automationgateway.key

\# Certificate and key to install in nginx for the web UI and API  
\# web\_server\_ssl\_cert=/path/to/tower.cert  
\# web\_server\_ssl\_key=/path/to/tower.key  
\# Server-side SSL settings for PostgreSQL (when we are installing it).  
\# postgres\_use\_ssl=False  
\# postgres\_ssl\_cert=/path/to/pgsql.crt

\# postgres\_ssl\_key=/path/to/pgsql.key

##### Single platform gateway, automation controller, automation hub, and Event-Driven Ansible controller with an external (installer managed) database

Use this example to populate the inventory file to deploy single instances of platform gateway, automation controller, automation hub, and Event-Driven Ansible controller with an external (installer managed) database.

| Important | This scenario requires a minimum of automation controller 2.4 for successful deployment of Event-Driven Ansible controller. Event-Driven Ansible controller must be installed on a separate server and cannot be installed on the same host as automation hub and automation controller. When you activate an Event-Driven Ansible rulebook under standard conditions, it uses approximately 250 MB of memory. However, the actual memory consumption can vary significantly based on the complexity of your rules and the volume and size of the events processed. In scenarios where a large number of events are anticipated or the rulebook complexity is high, conduct a preliminary assessment of resource usage in a staging environment. This ensures that your maximum number of activations is based on the capacity of your resources. In the following example, the default automationedacontroller\_max\_running\_activations setting is 12, but you can adjust according to your capacity. |
| :---: | :---- |

\[automationcontroller\]  
controller.example.com

\[automationhub\]  
automationhub.example.com

\[automationedacontroller\]  
automationedacontroller.example.com

\[automationgateway\]  
gateway.example.com

\[database\]  
data.example.com

\[all:vars\]  
admin\_password='\<password\>'  
pg\_host='data.example.com'  
pg\_port='5432'  
pg\_database='awx'  
pg\_username='awx'  
pg\_password='\<password\>'  
pg\_sslmode='prefer'  \# set to 'verify-full' for client-side enforced SSL

registry\_url='registry.redhat.io'  
registry\_username='\<registry username\>'  
registry\_password='\<registry password\>'

\# Automation hub configuration

automationhub\_admin\_password= \<PASSWORD\>

automationhub\_pg\_host='data.example.com'  
automationhub\_pg\_port=5432

automationhub\_pg\_database='automationhub'  
automationhub\_pg\_username='automationhub'  
automationhub\_pg\_password=\<PASSWORD\>  
automationhub\_pg\_sslmode='prefer'

\# Automation Event-Driven Ansible controller configuration

automationedacontroller\_admin\_password='\<eda-password\>'

automationedacontroller\_pg\_host='data.example.com'  
automationedacontroller\_pg\_port=5432

automationedacontroller\_pg\_database='automationedacontroller'  
automationedacontroller\_pg\_username='automationedacontroller'  
automationedacontroller\_pg\_password='\<password\>'

\# Keystore file to install in SSO node  
\# sso\_custom\_keystore\_file='/path/to/sso.jks'

\# This install will deploy SSO with sso\_use\_https=True  
\# Keystore password is required for https enabled SSO  
sso\_keystore\_password=''

\# This install will deploy a TLS enabled Automation Hub.  
\# If for some reason this is not the behavior wanted one can  
\# disable TLS enabled deployment.  
\#  
\# automationhub\_disable\_https \= False  
\# The default install will generate self-signed certificates for the Automation  
\# Hub service. If you are providing valid certificate via automationhub\_ssl\_cert  
\# and automationhub\_ssl\_key, one should toggle that value to True.  
\#  
\# automationhub\_ssl\_validate\_certs \= False  
\# SSL-related variables  
\# If set, this will install a custom CA certificate to the system trust store.  
\# custom\_ca\_cert=/path/to/ca.crt  
\# Certificate and key to install in Automation Hub node  
\# automationhub\_ssl\_cert=/path/to/automationhub.cert  
\# automationhub\_ssl\_key=/path/to/automationhub.key

\# Automation Gateway configuration  
automationgateway\_admin\_password=''

automationgateway\_pg\_host=''  
automationgateway\_pg\_port=5432

automationgateway\_pg\_database='automationgateway'  
automationgateway\_pg\_username='automationgateway'  
automationgateway\_pg\_password=''  
automationgateway\_pg\_sslmode='prefer'

\# The main automation gateway URL that clients will connect to (e.g. https://\<load balancer host\>).  
\# If not specified, the first node in the \[automationgateway\] group will be used when needed.  
\# automationgateway\_main\_url \= ''

\# Certificate and key to install in Automation Gateway  
\# automationgateway\_ssl\_cert=/path/to/automationgateway.cert  
\# automationgateway\_ssl\_key=/path/to/automationgateway.key

\# Certificate and key to install in nginx for the web UI and API  
\# web\_server\_ssl\_cert=/path/to/tower.cert  
\# web\_server\_ssl\_key=/path/to/tower.key  
\# Server-side SSL settings for PostgreSQL (when we are installing it).  
\# postgres\_use\_ssl=False  
\# postgres\_ssl\_cert=/path/to/pgsql.crt  
\# postgres\_ssl\_key=/path/to/pgsql.key

\# Boolean flag used to verify Automation Controller's  
\# web certificates when making calls from Automation Event-Driven Ansible controller.  
\# automationedacontroller\_controller\_verify\_ssl \= true  
\#  
\# Certificate and key to install in Automation Event-Driven Ansible controller node  
\# automationedacontroller\_ssl\_cert=/path/to/automationeda.crt

\# automationedacontroller\_ssl\_key=/path/to/automationeda.key

*Additional resources*

For more information about these inventory variables, refer to the [Ansible automation hub variables](https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.5/html-single/installing_on_virtual_machines/index#ref-hub-variables).

##### High availability automation hub

Use the following examples to populate the inventory file to install a highly available automation hub. This inventory file includes a highly available automation hub with a clustered setup.

You can configure your HA deployment further to enable a high availability deployment of automation hub on SELinux.

*Specify database host IP*

* Specify the IP address for your database host, using the automation\_pg\_host and automation\_pg\_port inventory variables. For example:

automationhub\_pg\_host='192.0.2.10'

automationhub\_pg\_port=5432

* Also specify the IP address for your database host in the \[database\] section, using the value in the automationhub\_pg\_host inventory variable:

\[database\]

192.0.2.10

*List all instances in a clustered setup*

* If installing a clustered setup, replace localhost ansible\_connection=local in the \[automationhub\] section with the hostname or IP of all instances. For example:

\[automationhub\]  
automationhub1.testing.ansible.com ansible\_user=cloud-user  
automationhub2.testing.ansible.com ansible\_user=cloud-user

automationhub3.testing.ansible.com ansible\_user=cloud-user

*Next steps*

Check that the following directives are present in /etc/pulp/settings.py in each of the private automation hub servers:

USE\_X\_FORWARDED\_PORT \= True

USE\_X\_FORWARDED\_HOST \= True

| Note | If automationhub\_main\_url is not specified, the first node in the \[automationhub\] group will be used as default. |
| :---: | :---- |

##### Enabling a high availability (HA) deployment of automation hub on SELinux

You can configure the inventory file to enable high availability deployment of automation hub on SELinux. You must create two mount points for /var/lib/pulp and /var/lib/pulp/pulpcore\_static, and then assign the appropriate SELinux contexts to each.

| Note | You must add the context for /var/lib/pulp pulpcore\_static and run the Ansible Automation Platform installer before adding the context for /var/lib/pulp. |
| :---: | :---- |

*Prerequisites*

* You have already configured a NFS export on your server.

*Procedure*

1. Create a mount point at /var/lib/pulp:  
   $ mkdir /var/lib/pulp/

Open /etc/fstab using a text editor, then add the following values:  
srv\_rhel8:/data /var/lib/pulp nfs defaults,\_netdev,nosharecache,context="system\_u:object\_r:var\_lib\_t:s0" 0 0

2. srv\_rhel8:/data/pulpcore\_static /var/lib/pulp/pulpcore\_static nfs defaults,\_netdev,nosharecache,context="system\_u:object\_r:httpd\_sys\_content\_rw\_t:s0" 0 0  
3. Run the reload systemd manager configuration command:  
   $ systemctl daemon-reload  
4. Run the mount command for /var/lib/pulp:  
   $ mount /var/lib/pulp  
5. Create a mount point at /var/lib/pulp/pulpcore\_static:  
   $ mkdir /var/lib/pulp/pulpcore\_static  
6. Run the mount command:  
   $ mount \-a  
7. With the mount points set up, run the Ansible Automation Platform installer:  
   $ setup.sh \-- \-b \--become-user root  
8. After the installation is complete, unmount the /var/lib/pulp/ mount point.

*Next steps*

1. Apply the appropriate SELinux context.  
2. Configure the pulpcore.serivce.

*Additional Resources*

* See the [SELinux Requirements on the Pulp Project documentation](https://docs.pulpproject.org/en/2.16/user-guide/scaling.html#selinux-requirements) for a list of SELinux contexts.  
* See the [Filesystem Layout](https://docs.pulpproject.org/pulpcore/installation/hardware-requirements.html#filesystem-layout) for a full description of Pulp folders.

###### Configuring pulpcore.service

After you have configured the inventory file, and applied the SELinux context, you now need to configure the pulp service.

*Procedure*

1. With the two mount points set up, shut down the Pulp service to configure pulpcore.service:  
   $ systemctl stop pulpcore.service  
2. Edit pulpcore.service using systemctl:  
   $ systemctl edit pulpcore.service

Add the following entry to pulpcore.service to ensure that automation hub services starts only after starting the network and mounting the remote mount points:  
\[Unit\]

3. After=network.target var-lib-pulp.mount  
4. Enable remote-fs.target:  
   $ systemctl enable remote-fs.target  
5. Reboot the system:  
   $ systemctl reboot

*Troubleshooting*

A bug in the pulpcore SELinux policies can cause the token authentication public/private keys in etc/pulp/certs/ to not have the proper SELinux labels, causing the pulp process to fail. When this occurs, run the following command to temporarily attach the proper labels:

$ chcon system\_u:object\_r:pulpcore\_etc\_t:s0 /etc/pulp/certs/token\_{private,public}\_key.pem

Repeat this command to reattach the proper SELinux labels whenever you relabel your system.

###### Applying the SELinux context

After you have configured the inventory file, you must now apply the context to enable the high availability (HA) deployment of automation hub on SELinux.

*Procedure*

1. Shut down the Pulp service:  
   $ systemctl stop pulpcore.service  
2. Unmount /var/lib/pulp/pulpcore\_static:  
   $ umount /var/lib/pulp/pulpcore\_static  
3. Unmount /var/lib/pulp/:  
   $ umount /var/lib/pulp/  
4. Open /etc/fstab using a text editor, then replace the existing value for /var/lib/pulp with the following:  
   srv\_rhel8:/data /var/lib/pulp nfs defaults,\_netdev,nosharecache,context="system\_u:object\_r:pulpcore\_var\_lib\_t:s0" 0 0  
5. Run the mount command:  
   $ mount \-a

##### Configuring content signing on private automation hub

To successfully sign and publish Ansible Certified Content Collections, you must configure private automation hub for signing.

*Prerequisites*

* Your GnuPG key pairs have been securely set up and managed by your organization.  
* Your public-private key pair has proper access for configuring content signing on private automation hub.

*Procedure*

1. Create a signing script that accepts only a filename.

| Note | This script acts as the signing service and must generate an ascii-armored detached gpg signature for that file using the key specified through the PULP\_SIGNING\_KEY\_FINGERPRINT environment variable. |
| :---- | :---- |

2.   
   The script prints out a JSON structure with the following format.  
   {"file": "filename", "signature": "filename.asc"}  
   All the file names are relative paths inside the current working directory. The file name must remain the same for the detached signature.  
   *Example:*  
   The following script produces signatures for content:

```

#!/usr/bin/env bash

FILE_PATH=$1
SIGNATURE_PATH="$1.asc"

ADMIN_ID="$PULP_SIGNING_KEY_FINGERPRINT"
PASSWORD="password"

# Create a detached signature
gpg --quiet --batch --pinentry-mode loopback --yes --passphrase \
   $PASSWORD --homedir ~/.gnupg/ --detach-sign --default-key $ADMIN_ID \
   --armor --output $SIGNATURE_PATH $FILE_PATH

# Check the exit status
STATUS=$?
if [ $STATUS -eq 0 ]; then
   echo {\"file\": \"$FILE_PATH\", \"signature\": \"$SIGNATURE_PATH\"}
else
   exit $STATUS
fi
```

5.   
   After you deploy a private automation hub with signing enabled to your Ansible Automation Platform cluster, new UI additions are displayed in collections.  
6. Review the Ansible Automation Platform installer inventory file for options that begin with automationhub\_\*.

```

[all:vars]
.
.
.
automationhub_create_default_collection_signing_service = True
automationhub_auto_sign_collections = True
automationhub_require_content_approval = True
automationhub_collection_signing_service_key = /abs/path/to/galaxy_signing_service.gpg
automationhub_collection_signing_service_script = /abs/path/to/collection_signing.sh
```

9.   
   The two new keys (**automationhub\_auto\_sign\_collections** and **automationhub\_require\_content\_approval**) indicate that the collections must be signed and approved after they are uploaded to private automation hub.

### 3.3. Running the Red Hat Ansible Automation Platform installer setup script

After you update the inventory file with required parameters, run the installer setup script.

*Procedure*

* Run the setup.sh script  
  $ sudo ./setup.sh

| Note | If you are running the setup as a non-root user with sudo privileges, you can use the following command: $ ANSIBLE\_BECOME\_METHOD='sudo' ANSIBLE\_BECOME=True ./setup.sh |
| :---: | :---- |

Installation of Red Hat Ansible Automation Platform will begin.

*Additional resources*

See [Understanding privilege escalation](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_privilege_escalation.html) for additional setup.sh script examples.

### 3.4. Verifying installation of Ansible Automation Platform

Upon a successful login, your installation of Red Hat Ansible Automation Platform is complete.

| Important | If the installation fails and you are a customer who has purchased a valid license for Red Hat Ansible Automation Platform, contact Ansible through the [Red Hat Customer portal](https://docs.redhat.com/). |
| :---: | :---- |

*Additional resources*

See Link:https://docs.redhat.com/en/documentation/red\_hat\_ansible\_automation\_platform/2.5/html-single/getting\_started\_with\_ansible\_automation\_platform\[Getting started with Ansible Automation Platform\] for post installation instructions.

### 3.5. Adding a subscription manifest to Ansible Automation Platform

Before you first log in, you must add your subscription information to the platform. To add a subscription to Ansible Automation Platform, see [Obtaining a manifest file](https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.5/html-single/operating_ansible_automation_platform/index#assembly-aap-obtain-manifest-files) in the Link:https://docs.redhat.com/en/documentation/red\_hat\_ansible\_automation\_platform/2.5/html-single/access\_management\_and\_authentication\[Access management and authentication\].

## 4\. Horizontal Scaling in Red Hat Ansible Automation Platform

You can set up multi-node deployments for components across Ansible Automation Platform. Whether you require horizontal scaling for Automation Execution, Automation Decisions, or automation mesh, you can scale your deployments based on your organization’s needs.

### 4.1. Horizontal scaling in Event-Driven Ansible controller

With Event-Driven Ansible controller, you can set up horizontal scaling for your events automation. This multi-node deployment enables you to define as many nodes as you prefer during the installation process. You can also increase or decrease the number of nodes at any time according to your organizational needs.

The following node types are used in this deployment:

**API node type**

Responds to the HTTP REST API of Event-Driven Ansible controller.

**Worker node type**

Runs an Event-Driven Ansible worker, which is the component of Event-Driven Ansible that not only manages projects and activations, but also executes the activations themselves.

**Hybrid node type**

Is a combination of the API node and the worker node.

The following example shows how you would set up an inventory file for horizontal scaling of Event-Driven Ansible controller on Red Hat Enterprise Linux VMs using the host group name \[automationedacontroller\] and the node type variable eda\_node\_type:

\[automationedacontroller\]

3.88.116.111  
routable\_hostname=automationedacontroller-api.example.com eda\_node\_type=api

\# worker node

3.88.116.112 routable\_hostname=automationedacontroller-api.example.com eda\_node\_type=worker

#### 4.1.1. Sizing and scaling guidelines

API nodes process user requests (interactions with the UI or API) while worker nodes process the activations and other background tasks required for Event-Driven Ansible to function properly. The number of API nodes you require correlates to the desired number of users of the application and the number of worker nodes correlates to the desired number of activations you want to run.

Since activations are variable and controlled by worker nodes, the supported approach for scaling is to use separate API and worker nodes instead of hybrid nodes due to the efficient allocation of hardware resources by worker nodes. By separating the nodes, you can scale each type independently based on specific needs, leading to better resource utilization and cost efficiency.

An example of an instance in which you might consider scaling up your node deployment is when you want to deploy Event-Driven Ansible for a small group of users who will run a large number of activations. In this case, one API node is adequate, but if you require more, you can scale up to three additional worker nodes.

To set up a multi-node deployment, follow the procedure in Setting up horizontal scaling for Event-Driven Ansible controller.

#### 4.1.2. Setting up horizontal scaling for Event-Driven Ansible controller

To scale up (add more nodes) or scale down (remove nodes), you must update the content of the inventory to add or remove nodes and rerun the installer.

*Procedure*

Update the inventory to add two more worker nodes:  
\[automationedacontroller\]

3.88.116.111 routable\_hostname=automationedacontroller-api.example.com eda\_node\_type=api

3.88.116.112 routable\_hostname=automationedacontroller-api.example.com eda\_node\_type=worker

\# two more worker nodes  
3.88.116.113 routable\_hostname=automationedacontroller-api.example.com eda\_node\_type=worker

1. 3.88.116.114 routable\_hostname=automationedacontroller-api.example.com eda\_node\_type=worker  
2. Re-run the installer.

## 5\. Disconnected installation

If you are not connected to the internet or do not have access to online repositories, you can install Red Hat Ansible Automation Platform without an active internet connection.

### 5.1. Prerequisites

Before installing Ansible Automation Platform on a disconnected network, you must meet the following prerequisites:

1. A subscription manifest that you can upload to the platform. See [Obtaining a manifest file](https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.5/html/red_hat_ansible_automation_platform_operations_guide/assembly-aap-obtain-manifest-files#doc-wrapper) for more information.  
2. The Ansible Automation Platform setup bundle at [Customer Portal](https://access.redhat.com/downloads/content/480/ver=2.5/rhel---9/2.5/x86_64/product-software) is downloaded.  
3. The [DNS records](https://docs.ansible.com/ansible/latest/collections/community/general/nsupdate_module.html) for the automation controller and private automation hub servers are created.

### 5.2. Ansible Automation Platform installation on disconnected RHEL

You can install Ansible Automation Platform without an internet connection by using the installer-managed database located on the automation controller. The setup bundle is recommended for disconnected installation because it includes additional components that make installing Ansible Automation Platform easier in a disconnected environment. These include the Ansible Automation Platform Red Hat package managers (RPMs) and the default execution environment (EE) images.

*Additional Resources*

For a comprehensive list of pre-defined variables used in Ansible installation inventory files, see Ansible variables.

#### 5.2.1. System requirements for disconnected installation

Ensure that your system has all the hardware requirements before performing a disconnected installation of Ansible Automation Platform. You can find these in system requirements.

#### 5.2.2. RPM Source

RPM dependencies for Ansible Automation Platform that come from the BaseOS and AppStream repositories are not included in the setup bundle. To add these dependencies, you must first obtain access to BaseOS and AppStream repositories. Use Satellite to sync repositories and add dependencies. If you prefer an alternative tool, you can choose between the following options:

* Reposync  
* The RHEL Binary DVD

| Note | The RHEL Binary DVD method requires the DVD for supported versions of RHEL. See [Red Hat Enterprise Linux Life Cycle](https://access.redhat.com/support/policy/updates/errata) for information on which versions of RHEL are currently supported. |
| :---: | :---- |

*Additional resources*

* [Satellite](https://docs.redhat.com/en/documentation/red_hat_satellite/6.15/html/installing_satellite_server_in_a_disconnected_network_environment/index)

### 5.3. Synchronizing RPM repositories using reposync

To perform a reposync you need a RHEL host that has access to the internet. After the repositories are synced, you can move the repositories to the disconnected network hosted from a web server.

*Procedure*

Attach the BaseOS and AppStream required repositories:  
\# subscription-manager repos \\  
    \--enable rhel-8-for-x86\_64-baseos-rpms \\

1.     \--enable rhel-8-for-x86\_64-appstream-rpms

Perform the reposync:  
\# dnf install yum-utils  
\# reposync \-m \--download-metadata \--gpgcheck \\

2.     \-p /path/to/download  
   1. Use reposync with \--download-metadata and without \--newest-only. See RHEL 8 Reposync.  
      * If you are not using \--newest-only, the repos downloaded will be \~90GB.  
      * If you are using \--newest-only, the repos downloaded will be \~14GB.  
3. After the reposync is completed, your repositories are ready to use with a web server.  
4. Move the repositories to your disconnected network.

### 5.4. Creating a new web server to host repositories

If you do not have an existing web server to host your repositories, you can create one with your synced repositories.

*Procedure*

1. Install prerequisites:  
   $ sudo dnf install httpd

Configure httpd to serve the repo directory:  
/etc/httpd/conf.d/repository.conf

DocumentRoot '/path/to/repos'

\<LocationMatch "^/+$"\>  
    Options \-Indexes  
    ErrorDocument 403 /.noindex.html  
\</LocationMatch\>

\<Directory '/path/to/repos'\>  
    Options All Indexes FollowSymLinks  
    AllowOverride None  
    Require all granted

2. \</Directory\>  
3. Ensure that the directory is readable by an apache user:  
   $ sudo chown \-R apache /path/to/repos

Configure SELinux:  
$ sudo semanage fcontext \-a \-t httpd\_sys\_content\_t "/path/to/repos(/.\*)?"

4. $ sudo restorecon \-ir /path/to/repos  
5. Enable httpd:  
   $ sudo systemctl enable \--now httpd.service

Open firewall:  
$ sudo firewall-cmd \--zone=public \--add-service=http –add-service=https \--permanent

6. $ sudo firewall-cmd \--reload

On automation services, add a repo file at */etc/yum.repos.d/local.repo*, and add the optional repos if needed:  
\[Local-BaseOS\]  
name=Local BaseOS  
baseurl=http://\<webserver\_fqdn\>/rhel-8-for-x86\_64-baseos-rpms  
enabled=1  
gpgcheck=1  
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release

\[Local-AppStream\]  
name=Local AppStream  
baseurl=http://\<webserver\_fqdn\>/rhel-8-for-x86\_64-appstream-rpms  
enabled=1  
gpgcheck=1

7. gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release

### 5.5. Accessing RPM repositories from a locally mounted DVD

If you plan to access the repositories from the RHEL binary DVD, you must first set up a local repository.

*Procedure*

1. Mount DVD or ISO:  
   1. DVD  
      \# mkdir /media/rheldvd && mount /dev/sr0 /media/rheldvd  
   2. ISO  
      \# mkdir /media/rheldvd && mount \-o loop rhrhel-8.6-x86\_64-dvd.iso /media/rheldvd

Create yum repo file at /etc/yum.repos.d/dvd.repo  
\[dvd-BaseOS\]  
name=DVD for RHEL \- BaseOS  
baseurl=file:///media/rheldvd/BaseOS  
enabled=1  
gpgcheck=1  
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release

\[dvd-AppStream\]  
name=DVD for RHEL \- AppStream  
baseurl=file:///media/rheldvd/AppStream  
enabled=1  
gpgcheck=1

2. gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release  
3. Import the gpg key:  
   \# rpm \--import /media/rheldvd/RPM-GPG-KEY-redhat-release

| Note | If the key is not imported you will see an error similar to \# Curl error (6): Couldn't resolve host name for https://www.redhat.com/security/data/fd431d51.txt \[Could not resolve host: www.redhat.com\] |
| :---: | :---- |

*Additional Resources*

For further detail on setting up a repository see [Need to set up yum repository for locally-mounted DVD on Red Hat Enterprise Linux 8](https://access.redhat.com/solutions/3776721).

### 5.6. Downloading and installing the Ansible Automation Platform setup bundle

Choose the setup bundle to download Ansible Automation Platform for disconnected installations. This bundle includes the RPM content for Ansible Automation Platform and the default execution environment images that will be uploaded to your private automation hub during the installation process.

*Procedure*

1. Download the Ansible Automation Platform setup bundle package by navigating to the [Red Hat Ansible Automation Platform download](https://access.redhat.com/downloads/content/480/ver=2.5/rhel---9/2.5/x86_64/product-software) page and clicking **Download Now** for the Ansible Automation Platform 2.5 Setup Bundle.

On control node, untar the bundle:  
$ tar xvf \\  
   ansible-automation-platform-setup-bundle-2.5-1.tar.gz

2. $ cd ansible-automation-platform-setup-bundle-2.5-1  
3. Edit the inventory file to include variables based on your host names and desired password values.

| Note | See section 3.2 Inventory file examples base on installation scenarios for a list of examples that best fits your scenario. |
| :---: | :---- |

### 5.7. Completing post installation tasks

After you have completed the installation of Ansible Automation Platform, ensure that automation hub and automation controller deploy properly.

Before your first login, you must add your subscription information to the platform. To obtain your subscription information in uploadable form, see [Obtaining a manifest file](https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.5/html/red_hat_ansible_automation_platform_operations_guide/assembly-aap-obtain-manifest-files#assembly-aap-obtain-manifest-files) in the Access management and authentication guide.

Once you have obtained your subscription manifest, see [Getting started with Ansible Automation Platform](https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.5/html/getting_started/with/Ansible_automation_platform) for instructions on how to upload your subscription information.

Now that you have successfully installed Ansible Automation Platform, to begin using its features, see the following guides for your next steps:

[Getting started with Ansible Automation Platform](https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.5/html/getting_started/with/Ansible_automation_platform)

[Managing content in automation hub](https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.5/html/managing_content_in_automation_hub/index)

[Creating and consuming execution environments](https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.5/html/creating_and_consuming_execution_environments/index)

## Appendix A: Inventory file variables

The following tables contain information about the pre-defined variables used in Ansible installation inventory files. Not all of these variables are required.

### A.1. General variables

| Variable | Description |
| :---- | :---- |
| enable\_insights\_collection | The default install registers the node to the Red Hat Insights for Red Hat Ansible Automation Platform Service if the node is registered with Subscription Manager. Set to False to disable. Default \= true |
| nginx\_user\_http\_config | List of nginx configurations for /etc/nginx/nginx.conf under the http section. Each element in the list is provided into http nginx config as a separate line. Default \= empty list |
| registry\_password | registry\_password is only required if a non-bundle installer is used. Password credential for access to registry\_url. Used for both \[automationcontroller\] and \[automationhub\] groups. Enter your Red Hat Registry Service Account credentials in registry\_username and registry\_password to link to the Red Hat container registry. When registry\_url is registry.redhat.io, username and password are required if not using a bundle installer. For more information, see Setting registry\_username and registry\_password. |
| registry\_url | Used for both \[automationcontroller\] and \[automationhub\] groups. Default \= registry.redhat.io. |
| registry\_username | registry\_username is only required if a non-bundle installer is used. User credential for access to registry\_url. Used for both \[automationcontroller\] and \[automationhub\] groups, but only if the value of registry\_url is registry.redhat.io. Enter your Red Hat Registry Service Account credentials in registry\_username and registry\_password to link to the Red Hat container registry. For more information, see Setting registry\_username and registry\_password. |
| routable\_hostname | routable hostname is used if the machine running the installer can only route to the target host through a specific URL, for example, if you use shortnames in your inventory, but the node running the installer can only resolve that host using FQDN. If routable\_hostname is not set, it should default to ansible\_host. If you do not set ansible\_host, inventory\_hostname is used as a last resort. This variable is used as a host variable for particular hosts and not under the \[all:vars\] section. For further information, see [Assigning a variable to one machine:host variables](https://docs.ansible.com/ansible/latest/inventory_guide/intro_inventory.html#assigning-a-variable-to-one-machine-host-variables). |

### A.2. Ansible automation hub variables

| Variable | Description |
| :---- | :---- |
| automationhub\_admin\_password | Required Passwords must be enclosed in quotes when they are provided in plain text in the inventory file. |
| automationhub\_api\_token | If upgrading from Ansible Automation Platform 2.0 or earlier, you must either: provide an existing Ansible automation hub token as automationhub\_api\_token, or set generate\_automationhub\_token to true to generate a new token Generating a new token invalidates the existing token. |
| automationhub\_auto\_sign\_collections | If a collection signing service is enabled, collections are not signed automatically by default. Setting this parameter to true signs them by default. Default \= false. |
| automationhub\_backup\_collections | *Optional* Ansible automation hub provides artifacts in /var/lib/pulp. Automation controller automatically backs up the artifacts by default. You can also set automationhub\_backup\_collections to false and the backup/restore process does not then backup or restore /var/lib/pulp. Default \= true. |
| automationhub\_collection\_download\_count | *Optional* Determines whether download count is displayed on the UI. Default \= false. |
| automationhub\_collection\_seed\_repository | When you run the bundle installer, validated content is uploaded to the validated repository, and certified content is uploaded to the rh-certified repository. By default, both certified and validated content are uploaded. Possible values of this variable are 'certified' or 'validated'. If you do not want to install content, set automationhub\_seed\_collections to false to disable the seeding. If you only want one type of content, set automationhub\_seed\_collections to true and automationhub\_collection\_seed\_repository to the type of content you do want to include. |
| automationhub\_collection\_signing\_service\_key | If a collection signing service is enabled, you must provide this variable to ensure that collections can be properly signed. /absolute/path/to/key/to/sign |
| automationhub\_collection\_signing\_service\_script | If a collection signing service is enabled, you must provide this variable to ensure that collections can be properly signed. /absolute/path/to/script/that/signs |
| automationhub\_create\_default\_collection\_signing\_service | Set this variable to true to create a collection signing service. Default \= false. |
| automationhub\_container\_signing\_service\_key | If a container signing service is enabled, you must provide this variable to ensure that containers can be properly signed. /absolute/path/to/key/to/sign |
| automationhub\_container\_signing\_service\_script | If a container signing service is enabled, you must provide this variable to ensure that containers can be properly signed. /absolute/path/to/script/that/signs |
| automationhub\_create\_default\_container\_signing\_service | Set this variable to true to create a container signing service. Default \= false. |
| automationhub\_disable\_hsts | The default installation deploys a TLS enabled Ansible automation hub. Use this variable if you deploy automation hub with *HTTP Strict Transport Security* (HSTS) web-security policy enabled. This variable disables, the HSTS web-security policy mechanism. Default \= false. |
| automationhub\_disable\_https | *Optional* If Ansible automation hub is deployed with HTTPS enabled. Default \= false. |
| automationhub\_enable\_api\_access\_log | When set to true, this variable creates a log file at /var/log/galaxy\_api\_access.log that logs all user actions made to the platform, including their username and IP address. Default \= false. |
| automationhub\_enable\_analytics | A Boolean indicating whether to enable pulp analytics for the version of pulpcore used in automation hub in Ansible Automation Platform 2.5. To enable pulp analytics, set automationhub\_enable\_analytics to true. Default \= false. |
| automationhub\_enable\_unauthenticated\_collection\_access | Set this variable to true to enable unauthorized users to view collections. Default \= false. |
| automationhub\_enable\_unauthenticated\_collection\_download | Set this variable to true to enable unauthorized users to download collections. Default \= false. |
| automationhub\_importer\_settings | *Optional* Dictionary of setting to pass to galaxy-importer. At import time collections can go through a series of checks. Behavior is driven by galaxy-importer.cfg configuration. Examples are ansible-doc, ansible-lint, and flake8. This parameter enables you to drive this configuration. |
| automationhub\_main\_url | The main automation hub URL that clients connect to. For example, https://\<load balancer host\>. If not specified, the first node in the \[automationhub\] group is used. |
| automationhub\_pg\_database | *Required* The database name. Default \= automationhub. |
| automationhub\_pg\_host | Required if not using an internal database. The hostname of the remote PostgreSQL database used by automation hub. Default \= 127.0.0.1. |
| automationhub\_pg\_password | The password for the automation hub PostgreSQL database. Use of special characters for automationhub\_pg\_password is limited. The \!, \#, 0 and @ characters are supported. Use of other special characters can cause the setup to fail. |
| automationhub\_pg\_port | Required if not using an internal database. Default \= 5432\. |
| automationhub\_pg\_sslmode | Required. Default \= prefer. |
| automationhub\_pg\_username | Required Default \= automationhub. |
| automationhub\_require\_content\_approval | *Optional* Value is true if automation hub enforces the approval mechanism before collections are made available. By default when you upload collections to automation hub an administrator must approve it before they are made available to the users. If you want to disable the content approval flow, set the variable to false. Default \= true. |
| automationhub\_seed\_collections | A Boolean that defines whether or not preloading is enabled. When you run the bundle installer, validated content is uploaded to the validated repository, and certified content is uploaded to the rh-certified repository. By default, both certified and validated content are uploaded. If you do not want to install content, set automationhub\_seed\_collections to false to disable the seeding. If you only want one type of content, set automationhub\_seed\_collections to true and automationhub\_collection\_seed\_repository to the type of content you do want to include. Default \= true. |
| automationhub\_ssl\_cert | *Optional* /path/to/automationhub.cert Same as web\_server\_ssl\_cert but for automation hub UI and API. |
| automationhub\_ssl\_key | *Optional* /path/to/automationhub.key. Same as web\_server\_ssl\_key but for automation hub UI and API |
| automationhub\_ssl\_validate\_certs | For Red Hat Ansible Automation Platform 2.2 and later, this value is no longer used. Set value to true if automation hub must validate certificates when requesting itself because by default, Ansible Automation Platform deploys with self-signed certificates. Default \= false. |
| automationhub\_upgrade | **Deprecated** For Ansible Automation Platform 2.2.1 and later, the value of this has been fixed at true. Automation hub always updates with the latest packages. |
| automationhub\_user\_headers | List of nginx headers for Ansible automation hub’s web server. Each element in the list is provided to the web server’s nginx configuration as a separate line. Default \= empty list |
| ee\_from\_hub\_only | When deployed with automation hub the installer pushes execution environment images to automation hub and configures automation controller to pull images from the automation hub registry. To make automation hub the only registry to pull execution environment images from, set this variable to true. If set to false, execution environment images are also taken directly from Red Hat. Default \= true when the bundle installer is used. |
| generate\_automationhub\_token | If upgrading from Red Hat Ansible Automation Platform 2.0 or earlier, choose one of the following options: provide an existing Ansible automation hub token as automationhub\_api\_token set generate\_automationhub\_token to true to generate a new token. Generating a new token will invalidate the existing token. |
| nginx\_hsts\_max\_age | This variable specifies how long, in seconds, the system should be considered as a *HTTP Strict Transport Security* (HSTS) host. That is, how long HTTPS is used exclusively for communication. Default \= 63072000 seconds, or two years. |
| nginx\_tls\_protocols | Defines support for ssl\_protocols in Nginx. Values available TLSv1, TLSv1.1, \`TLSv1.2, TLSv1.3 The TLSv1.1 and TLSv1.2 parameters only work when OpenSSL 1.0.1 or higher is used. The TLSv1.3 parameter only works when OpenSSL 1.1.1 or higher is used. If nginx\_tls-protocols \= \['TLSv1.3'\] only TLSv1.3 is enabled. To set more than one protocol use nginx\_tls\_protocols \= \['TLSv1.2', 'TLSv.1.3'\] Default \= TLSv1.2. |
| pulp\_db\_fields\_key | Relative or absolute path to the Fernet symmetric encryption key that you want to import. The path is on the Ansible management node. It is used to encrypt certain fields in the database, such as credentials. If not specified, a new key will be generated. |

### A.3. Automation controller variables

| Variable | Description |
| :---- | :---- |
| admin\_password | The admin password used to connect to the automation controller instance. Passwords must be enclosed in quotes when they are provided in plain text in the inventory file. |
| automation\_controller\_main\_url | The full URL used by Event-Driven Ansible to connect to a controller host. This URL is required if there is no automation controller configured in the inventory file. Format example: automation\_controller\_main\_url='https://\<hostname\>' |
| admin\_username | The username used to identify and create the admin superuser in automation controller. |
| admin\_email | The email address used for the admin user for automation controller. |
| nginx\_http\_port | The nginx HTTP server listens for inbound connections. Default \= 80 |
| nginx\_https\_port | The nginx HTTPS server listens for secure connections. Default \= 443 |
| nginx\_hsts\_max\_age | This variable specifies how long, in seconds, the system must be considered as a *HTTP Strict Transport Security* (HSTS) host. That is, how long HTTPS is used exclusively for communication. Default \= 63072000 seconds, or two years. |
| nginx\_tls\_protocols | Defines support for ssl\_protocols in Nginx. Values available TLSv1, TLSv1.1, \`TLSv1.2, TLSv1.3 The TLSv1.1 and TLSv1.2 parameters only work when OpenSSL 1.0.1 or higher is used. The TLSv1.3 parameter only works when OpenSSL 1.1.1 or higher is used. If nginx\_tls-protocols \= \['TLSv1.3'\] only TLSv1.3 is enabled. To set more than one protocol use nginx\_tls\_protocols \= \['TLSv1.2', 'TLSv.1.3'\] Default \= TLSv1.2. |
| nginx\_user\_headers | List of nginx headers for the automation controller web server. Each element in the list is provided to the web server’s nginx configuration as a separate line. Default \= empty list |
| node\_state | *Optional* The status of a node or group of nodes. Valid options are active, deprovision to remove a node from a cluster, or iso\_migrate to migrate a legacy isolated node to an execution node. Default \= active. |
| node\_type | For \[automationcontroller\] group. Two valid node\_types can be assigned for this group. A node\_type=control means that the node only runs project and inventory updates, but not regular jobs. A node\_type=hybrid can run everything. Default for this group \= hybrid For \[execution\_nodes\] group: Two valid node\_types can be assigned for this group. A node\_type=hop implies that the node forwards jobs to an execution node. A node\_type=execution implies that the node can run jobs. Default for this group \= execution. |
| peers | *Optional* The peers variable is used to indicate which nodes a specific host or group connects to. Wherever this variable is defined, an outbound connection to the specific host or group is established. This variable is used to add tcp-peer entries in the receptor.conf file used for establishing network connections with other nodes. The peers variable can be a comma-separated list of hosts and groups from the inventory. This is resolved into a set of hosts that is used to construct the receptor.conf file. |
| pg\_database | The name of the postgreSQL database. Default \= awx. |
| pg\_host | The postgreSQL host, which can be an externally managed database. |
| pg\_password | The password for the postgreSQL database. Use of special characters for pg\_password is limited. The \!, \#, 0 and @ characters are supported. Use of other special characters can cause the setup to fail. NOTE You no longer have to provide a pg\_hashed\_password in your inventory file at the time of installation because PostgreSQL 13 can now store user passwords more securely. When you supply pg\_password in the inventory file for the installer, PostgreSQL uses the SCRAM-SHA-256 hash to secure that password as part of the installation process. |
| pg\_port | The postgreSQL port to use. Default \= 5432 |
| pg\_ssl\_mode | Choose one of the two available modes: prefer and verify-full. Set to verify-full for client-side enforced SSL. Default \= prefer. |
| pg\_username | Your postgreSQL database username. Default \= awx. |
| postgres\_ssl\_cert | Location of the postgreSQL SSL certificate. /path/to/pgsql\_ssl.cert |
| postgres\_ssl\_key | Location of the postgreSQL SSL key. /path/to/pgsql\_ssl.key |
| postgres\_use\_cert | Location of the postgreSQL user certificate. /path/to/pgsql.crt |
| postgres\_use\_key | Location of the postgreSQL user key. /path/to/pgsql.key |
| postgres\_use\_ssl | Use this variable if postgreSQL uses SSL. |
| postgres\_max\_connections | Maximum database connections setting to apply if you are using installer-managed postgreSQL. See [PostgreSQL database configuration](https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.5/html-single/automation_controller_administration_guide/index#ref-controller-database-settings) in the automation controller administration guide for help selecting a value. Default for VM-based installations \= 200 for a single node and 1024 for a cluster. |
| receptor\_listener\_port | Port to use for receptor connection. Default \= 27199 |
| supervisor\_start\_retry\_count | When specified, it adds startretries \= \<value specified\> to the supervisor config file (/etc/supervisord.d/tower.ini). See [program:x Section Values](http://supervisord.org/configuration.html#program-x-section-values) for more information about startretries. No default value exists. |
| web\_server\_ssl\_cert | *Optional* /path/to/webserver.cert Same as automationhub\_ssl\_cert but for web server UI and API. |
| web\_server\_ssl\_key | *Optional* /path/to/webserver.key Same as automationhub\_server\_ssl\_key but for web server UI and API. |

### A.4. Ansible variables

The following variables control how Ansible Automation Platform interacts with remote hosts.

For more information about variables specific to certain plugins, see the documentation for [Ansible.Builtin](https://docs.ansible.com/ansible-core/devel/collections/ansible/builtin/index.html).

For a list of global configuration options, see [Ansible Configuration Settings](https://docs.ansible.com/ansible-core/devel/reference_appendices/config.html).

| Variable | Description |
| :---- | :---- |
| ansible\_connection | The connection plugin used for the task on the target host. This can be the name of any of Ansible connection plugin. SSH protocol types are smart, ssh or paramiko. Default \= smart |
| ansible\_host | The ip or name of the target host to use instead of inventory\_hostname. |
| ansible\_port | The connection port number. Default: 22 for ssh |
| ansible\_user | The user name to use when connecting to the host. |
| ansible\_password | The password to authenticate to the host. Never store this variable in plain text. Always use a vault. |
| ansible\_ssh\_private\_key\_file | Private key file used by SSH. Useful if using multiple keys and you do not want to use an SSH agent. |
| ansible\_ssh\_common\_args | This setting is always appended to the default command line for sftp, scp, and ssh. Useful to configure a ProxyCommand for a certain host or group. |
| ansible\_sftp\_extra\_args | This setting is always appended to the default sftp command line. |
| ansible\_scp\_extra\_args | This setting is always appended to the default scp command line. |
| ansible\_ssh\_extra\_args | This setting is always appended to the default ssh command line. |
| ansible\_ssh\_pipelining | Determines if SSH pipelining is used. This can override the pipelining setting in ansible.cfg. If using SSH key-based authentication, the key must be managed by an SSH agent. |
| ansible\_ssh\_executable | Added in version 2.2. This setting overrides the default behavior to use the system SSH. This can override the ssh\_executable setting in ansible.cfg. |
| ansible\_shell\_type | The shell type of the target system. Do not use this setting unless you have set the ansible\_shell\_executable to a non-Bourne (sh) compatible shell. By default commands are formatted using sh-style syntax. Setting this to csh or fish causes commands executed on target systems to follow the syntax of those shells instead. |
| ansible\_shell\_executable | This sets the shell that the Ansible controller uses on the target machine, and overrides the executable in ansible.cfg which defaults to /bin/sh. Do not change this variable unless /bin/sh is not installed on the target machine or cannot be run from sudo. |
| inventory\_hostname | This variable takes the hostname of the machine from the inventory script or the Ansible configuration file. You cannot set the value of this variable. Because the value is taken from the configuration file, the actual runtime hostname value can vary from what is returned by this variable. |

### A.5. Event-Driven Ansible controller variables

| Variable | Description |
| :---- | :---- |
| automationedacontroller\_admin\_password | The admin password used by the Event-Driven Ansible controller instance. Passwords must be enclosed in quotes when they are provided in plain text in the inventory file. |
| automationedacontroller\_admin\_username | Username used by django to identify and create the admin superuser in Event-Driven Ansible controller. Default \= admin |
| automationedacontroller\_admin\_email | Email address used by django for the admin user for Event-Driven Ansible controller. Default \= admin@example.com |
| automationedacontroller\_allowed\_hostnames | List of additional addresses to enable for user access to Event-Driven Ansible controller. Default \= empty list |
| automationedacontroller\_controller\_verify\_ssl | Boolean flag used to verify automation controller’s web certificates when making calls from Event-Driven Ansible controller. Verified is true; not verified is false. Default \= false |
| automationedacontroller\_disable\_https | Boolean flag to disable HTTPS Event-Driven Ansible controller. Default \= false |
| automationedacontroller\_disable\_hsts | Boolean flag to disable HSTS Event-Driven Ansible controller. Default \= false |
| automationedacontroller\_gunicorn\_workers | Number of workers for the API served through gunicorn. Default \= (\# of cores or threads) \* 2 \+ 1 |
| automationedacontroller\_max\_running\_activations | The number of maximum activations running concurrently per node. This is an integer that must be greater than 0\. Default \= 12 |
| automationedacontroller\_nginx\_tls\_files\_remote | Boolean flag to specify whether cert sources are on the remote host (true) or local (false). Default \= false |
| automationedacontroller\_pg\_database | The Postgres database used by Event-Driven Ansible controller. Default \= automtionedacontroller. |
| automationnedacontroller\_pg\_host | The hostname of the Postgres database used by Event-Driven Ansible controller, which can be an externally managed database. |
| automationedacontroller\_pg\_password | The password for the Postgres database used by Event-Driven Ansible controller. Use of special characters for automationedacontroller\_pg\_password is limited. The \!, \#, 0 and @ characters are supported. Use of other special characters can cause the setup to fail. |
| automationedacontroller\_pg\_port | The port number of the Postgres database used by Event-Driven Ansible controller. Default \= 5432. |
| automationedacontroller\_pg\_username | The username for your Event-Driven Ansible controller Postgres database. Default \= automationedacontroller. |
| automationedacontroller\_rq\_workers | Number of Redis Queue (RQ) workers used by Event-Driven Ansible controller. RQ workers are Python processes that run in the background. Default \= (\# of cores or threads) \* 2 \+ 1 |
| automationedacontroller\_ssl\_cert | *Optional* /root/ssl\_certs/eda.*\<example\>*.com.crt Same as automationhub\_ssl\_cert but for Event-Driven Ansible controller UI and API. |
| automationedacontroller\_ssl\_key | *Optional* /root/ssl\_certs/eda.*\<example\>*.com.key Same as automationhub\_server\_ssl\_key but for Event-Driven Ansible controller UI and API. |
| automationedacontroller\_user\_headers | List of additional nginx headers to add to Event-Driven Ansible controller’s nginx configuration. Default \= empty list |

### A.6. Platform gateway variables

| Variable | Description |
| :---- | :---- |
| automationgateway\_admin\_username | The username used to identify and create the admin superuser in platform gateway. |
| automationgateway\_admin\_password | The admin password used to connect to the platform gateway instance. Passwords must be enclosed in quotes when they are provided in plain text in the inventory file. |
| automationgateway\_admin\_email | The email address used for the admin user for platform gateway. |
| automationgateway\_pg\_host | The hostname of the Postgres database used by platform gateway, which can be an externally managed database. |
| automationgateway\_pg\_port | The port number of the Postgres database used by platform gateway. Default \= 5432. |
| automationgateway\_pg\_database | The Postgres database used by platform gateway. Default \= automationgateway. |
| automationgateway\_pg\_username | The username for your platform gateway Postgres database. Default \= automationgateway. |
| automationgateway\_pg\_password | The password for the Postgres database used by platform gateway. Use of special characters for automationgateway\_pg\_password is limited. The \!, \#, 0 and @ characters are supported. Use of other special characters can cause the setup to fail. |
| automationgateway\_pg\_sslmode | Choose one of the two available modes: prefer and verify-full. Set to verify-full for client-side enforced SSL. Default \= prefer. |
| automationgateway\_main\_url | The main platform gateway URL that clients will connect to (e.g. [https://\<gateway-node\>](https://\<gateway-node\>);). If not specified, the first node in the \[automationgateway\] group will be used when needed. |
| automationgateway\_ssl\_cert | Optional /path/to/automationgateway.cert Same as automationhub\_ssl\_cert but for platform gateway UI and API. |
| automationgateway\_ssl\_key | Optional /path/to/automationgateway.key Same as automationhub\_server\_ssl\_key but for platform gateway UI and API. |

Last updated 2024-08-13 10:05:42 \-0400  

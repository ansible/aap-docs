[[ag_custom_inventory_script]]
== Custom Inventory Scripts

Inventory scripts have been discontinued. For more information, see
xref:ug_customscripts[] in the Automation Controller User Guide.

If you use custom inventory scripts, migrate to sourcing these scripts
from a project. See {ag_inv_import} in the subsequent chapter, and also
refer to xref:ug_inventory_sources[] in the Automation Controller User Guide
for more detail.

If you are setting up an inventory file, refer to the
https://access.redhat.com/documentation/en-us/red_hat_ansible_automation_platform/2.1/html/red_hat_ansible_automation_platform_installation_guide/single-machine-scenario[Red
Hat Ansible Automation Platform Installation Guide] on
https://access.redhat.com/documentation/en-us/red_hat_ansible_automation_platform[access.redhat.com]
and find examples specific to your setup.

If you are migrating to execution environments, see:

* `upgrade_venv`
* https://access.redhat.com/documentation/en-us/red_hat_ansible_automation_platform/2.1/html/red_hat_ansible_automation_platform_automation_mesh_guide/assembly-standalone-controller-non-inst-database[Designing
a mesh deployment in your environment]
* `mesh_topology_ee` in the Ansible Automation Platform Upgrade and
Migration Guide to validate your topology

To learn more about automation mesh, refer to the
https://access.redhat.com/documentation/en-us/red_hat_ansible_automation_platform/2.1/html/red_hat_ansible_automation_platform_automation_mesh_guide/assembly-planning-mesh[Red
Hat Ansible Automation Mesh Guide] on
https://access.redhat.com/documentation/en-us/red_hat_ansible_automation_platform[access.redhat.com].

If you already have a mesh topology set up and want to view node type,
node health, and specific details about each node, see
{ag_topology_viewer} later in this guide.

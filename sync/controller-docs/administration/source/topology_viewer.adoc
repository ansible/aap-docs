[[ag_topology_viewer]]
== Topology Viewer

Note

The topology viewer is in tech preview and is subject to change in a
future release.

The topology viewer allows you to view node type, node health, and
specific details about each node if you already have a mesh topology
deployed. To learn more about automation mesh, refer to the
https://access.redhat.com/documentation/en-us/red_hat_ansible_automation_platform/2.1/html/red_hat_ansible_automation_platform_automation_mesh_guide/assembly-planning-mesh[Red
Hat Ansible Automation Mesh Guide] on
https://access.redhat.com/documentation/en-us/red_hat_ansible_automation_platform[access.redhat.com].

To access the topology viewer from the controller user interface:

[arabic]
. In the Administration menu from left navigation bar, click *Topology
View*.

The Topology View opens and displays a graphic representation of how
each receptor node links together.

image:topology-viewer-initial-view.png[image]

[arabic, start=2]
. To adjust the zoom levels, or manipulate the graphic views, use the
control buttons on the upper right-hand corner of the window.

image:topology-viewer-view-controls.png[image]

You can also click and drag to pan around; and use the scroll wheel on
your mouse or trackpad to zoom. The fit-to-screen feature automatically
scales the graphic to fit on the screen and repositions it in the
center. It is particularly useful when you want to see a large mesh in
its entirety.

image:topology-viewer-zoomed-view.png[image]

To reset the view to its default view, click *Reset zoom*.

[arabic, start=3]
. Refer to the Legend to the left of the graphic to identify the type of
nodes that are represented. See
https://access.redhat.com/documentation/en-us/red_hat_ansible_automation_platform/2.1/html/red_hat_ansible_automation_platform_automation_mesh_guide/assembly-planning-mesh#con-automation-mesh-node-types[Control
and execution planes] for more information on each type of node.

Note

If the Legend is not present, use the toggle on the upper right corner
of the window to enable it.

The Legend shows the `node status <node_statuses>` by color, which is
indicative of the health of the node. The status of *Error* in the
legend encompasses the *Unavailable* state (as displayed in the
Instances list view) plus any future error conditions encountered in
later versions of the controller. Also depicted in the legend are the
link statuses:

____________________________________________________________________________________________________________________________________
* *Established*: this is a link state that indicates a peer connection
between nodes that are either ready, unavailable, or disabled
* *Adding*: this is a link state indicating a peer connection between
nodes that was selected to be added to the mesh topology
* *Removing*: this is a link state indicating a peer connection between
nodes that was selected to be removed from the topology
____________________________________________________________________________________________________________________________________

[arabic, start=4]
. Hover over a node and the connectors highlight to show its immediate
connected nodes (peers) or click on a node to retrieve details about it,
such as its hostname, node type, and status.

image:topology-viewer-node-hover-click.png[image]

[arabic, start=5]
. Click on the link for instance hostname from the details displayed,
and you will be redirected to its Details page that provides more
information about that node, most notably for information about an
`Error` status, as in the example below.

image:topology-viewer-node-view.png[image]

image:topology-viewer-instance-details.png[image]

At the bottom of the Details view, you can remove the instance, run a
health check on the instance on an as-needed basis, or unassign jobs
from the instance. By default, jobs can be assigned to each node.
However, you can disable it to exclude the node from having any jobs
running on it.

For more information on creating new nodes and scaling the mesh, refer
to xref:ag_instances[] in this guide for more detail.

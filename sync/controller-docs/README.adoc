== product-docs

Ansible Tower (and other) docs

With the way that mapping (intersphinx) works to create links from one
manual to another, an object.inv file must be created before the mapping
works. The caveat to this is that Sphinx builds the object.inv file
while creating the HTML.

If, upon running 'make html' the very first time you checkout the doc
set, errors are received regarding labels that can't be found or
referenced, trying running 'make html' again. This should only be
necessary upon a clean checkout and inital builds. Subsequent builds
should work without having to run this twice.

Also, if a new section or chapter (etc.) is linked to with a label, the
manuals which included the label to be referenced must be built (make
html) before the manual where the link is actually included is built.
Else, you'll get a label can't reference/can't find it error.

For example, when linking from the Admin Guide to the Tower API guide's
chapter on tower-cli, the label must be placed in the tower-cli file
(above the title or content section for the link) and then the Tower API
guide will need to be rebuilt (which allows Sphinx to map the new label
in the objects.inv file for that guide). Once this is done and the link
has been coded into the Admin Guide's content, you can build the Admin
Guide and it will access the Tower API Guide's object.inv file while
Sphinx builds the HTML, ensuring your links are mapped and working.

=== Building

First, install:

* Docker
* Docker Compose

From the root of the repo, run:

[source,sourceCode,shell]
----
$ docker-compose run docs-builder
----

The first time this is run, it will build the Docker image which will
take a significant amount of time. Things will speed up substantially on
subsequent runs.

If any changes are made to the `Dockerfile`, run:

[source,sourceCode,shell]
----
$ docker-compose build
$ docker-compose run docs-builder
----

If you want a shell inside of the container, run:

[source,sourceCode,shell]
----
$ docker-compose run docs-builder bash
----

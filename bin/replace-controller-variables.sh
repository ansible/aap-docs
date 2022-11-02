#!/bin/bash

rstfiles=$(find ../sync/controller-docs/ -name '*.rst')

# Expand variables in Controller docs.
sed -i -e 's/|atversion|/Automation Controller Version 4.3.0/g' \
 -e 's/|atversionshortest|/Automation Controller 4.3.0/g' \
 -e 's/|versionshortest|/4.3.0/g' \
 -e 's/|at|/automation controller/g' \
 -e 's/|At|/Automation controller/g' \
 -e 's/|atqi|/Ansible Automation Platform Quick Installation Guide/g' \
 -e 's/|atqs|/Automation Controller Quick Setup Guide/g' \
 -e 's/|atir|/Ansible Automation Platform Installation and Reference Guide/g' \
 -e 's/|ata|/Automation Controller Administration Guide/g' \
 -e 's/|atu|/Automation Controller User Guide/g' \
 -e 's/|atumg|/Ansible Automation Platform Upgrade and Migration Guide/g' \
 -e 's/|atapi|/Automation Controller API Guide/g' \
 -e 's/|atrn|/Automation Controller Release Notes/g' \
 -e 's/|aa|/Ansible Automation/g' \
 -e 's/|AA|/Automation Analytics/g' \
 -e 's/|aap|/Ansible Automation Platform/g' \
 -e 's/|ab|/ansible-builder/g' \
 -e 's/|ap|/Automation Platform/g' \
 -e 's/|ah|/Automation Hub/g' \
 -e 's/|EE|/Execution Environment/g' \
 -e 's/|EEs|/Execution Environments/g' \
 -e 's/|Ee|/Execution environment/g' \
 -e 's/|Ees|/Execution environments/g' \
 -e 's/|ee|/execution environment/g' \
 -e 's/|ees|/execution environments/g' \
 -e 's/|rhel|/Red Hat Enterprise Linux/g' \
 -e 's/|rhaa|/Red Hat Ansible Automation/g' \
 -e 's/|rhaap|/Red Hat Ansible Automation Platform/g' \
 -e 's/|RHAT|/Red Hat Ansible Automation Platform controller/g' \
 -e 's/|atng|/Automation Controller Networking Guide/g' \
 -e 's/|atn|/Controller Networking/g' $rstfiles
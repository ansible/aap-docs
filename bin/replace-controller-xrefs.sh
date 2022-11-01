#!/bin/bash

adocfiles=$(find ../sync/controller-docs/ -name '*.adoc')

# Replace unknown ID or title for internal cross references
# Administration Guide cross-refs
sed -i -e 's/xref:ag_backup_restore\[\]/{ag_backup_restore}/g' \
 -e 's/xref:ag_clustering\[\]/{ag_clustering}/g' \
 -e 's/xref:ag_configure_tower\[\]/{ag_configure_tower}/g' \
 -e 's/xref:ag_container_groups\[\]/{ag_container_groups}/g' \
 -e 's/xref:ag_ent_auth\[\]/{ag_ent_auth}/g' \
 -e 's/xref:ag_ext_exe_env\[\]/{ag_ext_exe_env}/g' \
 -e 's/xref:ag_instance_groups\[\]/{ag_instance_groups}/g' \
 -e 's/xref:ag_inv_import\[\]/{ag_inv_import}/g' \
 -e 's/xref:ag_inv_import`/{ag_inv_import}/g' \
 -e 's/xref:ag_manage_utility_revoke_tokens\[\]/{ag_manage_utility_revoke_tokens}/g' \
 -e 's/xref:ag_multi_vault\[\]/{ag_multi_vault}/g' \
 -e 's/xref:ag_oauth2_token_auth\[\]/{ag_oauth2_token_auth}/g' \
 -e 's/xref:ag_session_limits\[\]/{ag_session_limits}/g' \
 -e 's/xref:ag_social_auth`/{ag_social_auth}/g' \
 -e 's/xref:ag_topology_viewer\[\]/{ag_topology_viewer}/g' \
 -e 's/xref:ag_use_oauth_pat\[\]/{ag_use_oauth_pat}/g' \
 -e 's/xref:ag_oauth2_token_revoke\[\]/{ag_oauth2_token_revoke}/g' $adocfiles

# Replace unknown ID or title for internal cross references
# User Guide cross-refs
sed -i -e 's/xref:ug_build_ees\[\]/{ug_build_ees}/g' \
 -e 's/xref:ug_credentials_add\[\]/{ug_credentials_add}/g' \
 -e 's/xref:ug_execution_environments\[\]/{ug_execution_environments}/g' \
 -e 's/xref:ug_inventories_add\[\]/{ug_inventories_add}/g' \
 -e 's/xref:ug_jobs\[\]/{ug_jobs}/g' \
 -e 's/xref:ug_users\[\]/{ug_users}/g' \
 -e 's/xref:ug_users_create\[\]/{ug_users_create}/g' \
 -e 's/xref:ug_users_tokens\[\]/{ug_users_tokens}/g' \
 -e 's/xref:ug_team_create\[\]/{ug_team_create}/g' \
 -e 's/xref:ug_notifications\[\]/{ug_notifications}/g' \
 -e 's/xref:ug_notifications_on_off\[\]/{ug_notifications_on_off}/g' \
 -e 's/xref:ug_notifications_types\[\]/{ug_notifications_types}/g' \
 -e 's/xref:ug_notifications_create\[\]/{ug_notifications_create}/g' \
 -e 's/xref:ug_webhooks\[\]/{ug_webhooks}/g' \
 -e 's/xref:ug_manual\[\]/{ug_manual}/g' \
 -e 's/xref:ug_projects_scm_types\[\]/{ug_projects_scm_types}/g' \
 -e 's/xref:ug_customscripts\[\]/{ug_customscripts}/g' \
 -e 's/xref:ug_inventory_sources\[\]/{ug_inventory_sources}/g' \
 -e 's/xref:ug_inventories\[\]/{ug_inventories}/g' \
 -e 's/xref:ug_credentials_ocp_k8s\[\]/{ug_credentials_ocp_k8s}/g' \
 -e 's/xref:ug_activitystreams\[\]/{ug_activitystreams}/g' \
 -e 's/xref:ug_applications_auth\[\]/{ug_applications_auth}/g' \
 -e 's/xref:ug_galaxy\[\]/{ug_galaxy}/g' \
 -e 's/xref:ug_ldap_auth_perf_tips\[\]/{ug_ldap_auth_perf_tips}/g' \
 -e 's/xref:ug_scheduling\[\]/{ug_scheduling}/g' $adocfiles

# Replace other cross references
# 
sed -i -e 's/Token and session management <administration:ag_token_utility>/{ag_token_utility}/g' $adocfiles

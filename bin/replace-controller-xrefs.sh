#!/bin/bash

# Replace unknown ID or title for internal cross references
# Use single quotes to avoid expanding regex expressions

adocfiles=$(find ../sync/controller-docs/ -name '*.adoc')
safile=$(find ../sync/controller-docs/ -name 'get-creds-from-service-account.adoc')

# Administration Guide cross-references
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
 -e 's/xref:ag_oauth2_token_revoke\[\]/{ag_oauth2_token_revoke}/g' "$adocfiles"

# Administration Guide cross-references
sed -i -e 's/Token and session management <administration:ag_token_utility>/{ag_token_utility}/g' \
 -e 's/Backing Up and Restoring <administration:ag_backup_restore>/{ag_backup_restore}/g' \
 -e 's/LDAP <ag_auth_ldap>/{ag_auth_ldap}/g' \
 -e 's/SAML 2.0 <ag_auth_saml>/{ag_auth_saml}/g' \
 -e 's/OAuth providers <ag_social_auth>/{ag_social_auth}/g' \
 -e 's/LDAP settings <ag_auth_ldap>/{ag_auth_ldap}/g' \
 -e 's/Controller Logging and Aggregation <administration:ag_logging>/{ag_logging}/g' \
 -e 's/Launching Jobs with Curl<administration:launch_jobs_curl>/{launch_jobs_curl}/g' \
 -e 's/Administration Guide <administration:ag_start>/{ag_start}/g' \
 -e 's/Launching Jobs with Curl<administration:launch_jobs_curl>/{launch_jobs_curl}/g' \
 -e 's/to `usability_data_collection`./to {usability_data_collection}./g' \
 -e 's/in the `usability_data_collection` section/in the {usability_data_collection} section/g' \
 -e 's/`user_data_insights` section/{user_data_insights} section/g' "$adocfiles"

# Upgrade and Migration Guide cross-references
sed -i -e 's/`migrate_new_venv` for more detail/{migrate_new_venv} for more detail/g' \
 -e 's/`upgrade_venv` in the/{upgrade_venv} in the/g' \
 -e 's/`mesh_topology_ee` in the/{mesh_topology_ee} in the/g' \
 -e 's/`migrate_iso_to_exe` in the/{migrate_iso_to_exe} in the/g' "$adocfiles"

# User Guide cross-references
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
 -e 's/xref:ug_content_signing\[\]/{ug_content_signing}/g' \
 -e 's/xref:ug_scheduling\[\]/{ug_scheduling}/g' "$adocfiles"

# User Guide cross-references
sed -i -e 's/Credential types <userguide:ug_credential_types>/{ug_credential_types}/g' \
 -e 's/Secret Management System <userguide:ug_credential_plugins>/{ug_credential_plugins}/g' \
 -e 's/Instance Groups <userguide:ug_instance_groups>/{ug_instance_groups}/g' \
 -e 's/inventory source <ug_inventory_sources>/{ug_inventory_sources}/g' \
 -e 's/adding a source <ug_add_inv_common_fields>/{ug_add_inv_common_fields}/g' \
 -e 's/import_subscription in the Automation Controller User Guide/{import_subscription} in the Automation Controller User Guide/g' \
 -e 's/job branch overriding <ug_job_branching>/{ug_job_branching}/g' \
 -e 's/outlined in `ref_ee_definition`/outlined in {ref_ee_definition}/g' \
 -e 's/`ref_collections_metadata`./{ref_collections_metadata}./g' \
 -e 's/to `rbac-ug` for/to {rbac-ug} for/g' \
 -e 's/`rbac-ug` in the/{rbac-ug} in the/g' "$adocfiles"

# Replace containergroup service account yaml
sed -i -e 's|containergroup sa <..\/..\/common\/source\/containergroup-sa.yml>|{containergroup-sa-file}|g' "$safile"
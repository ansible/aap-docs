# Documentation Requirements

**Source**: Update AAP on Azure docs with new vm series
**Date**: 2026-07-28
**Release/Sprint**: 2026 Q3

## Summary

- Total requirements analyzed: 1
- New modules needed: 0
- Existing modules to update: 1
- Breaking changes requiring docs: 0

## Requirements by priority

### Medium

#### REQ-001: Update Azure Database for PostgreSQL VM SKU references from v3 to v5 series
- **Source**: [AAP-84330](https://redhat.atlassian.net/browse/AAP-84330)
- **Summary**: Update the Database shape configuration table in `con-azure-infrastructure-usage.adoc` to replace `Standard_D2s_v3` with `Standard_D2ds_v5` and `Standard_D4s_v3` with `Standard_D4ds_v5`.
- **User impact**: Customers referencing the Azure infrastructure usage documentation will see the correct, current VM SKU series for their PostgreSQL database tier. Without the update, the documented SKUs will not match deployed infrastructure.
- **Documentation action**:
  - [ ] Update `aap-clouds/topics/con-azure-infrastructure-usage.adoc` (CONCEPT) — Replace all VM SKU references in the Database shape configuration table from the Ds_v3 series to the Dds_v5 series
- **Acceptance criteria**:
  - [ ] Plan size 50 row shows `Standard_D2ds_v5` (was `Standard_D2s_v3`)
  - [ ] Plan size 400 row shows `Standard_D4ds_v5` (was `Standard_D4s_v3`)
  - [ ] Plan size 1000 row shows `Standard_D4ds_v5` (was `Standard_D4s_v3`)
  - [ ] Plan size 2500 row shows `Standard_D4ds_v5` (was `Standard_D4s_v3`)
  - [ ] Plan size 5000 row shows `Standard_D4ds_v5` (was `Standard_D4s_v3`)
  - [ ] Plan size 10000 row shows `Standard_D4ds_v5` (was `Standard_D4s_v3`)
  - [ ] No other content in the file is modified
- **References**:
  - [Azure infrastructure usage section](https://docs.redhat.com/en/documentation/ansible_on_clouds/2.x/html-single/red_hat_ansible_automation_platform_on_microsoft_azure_guide/index#con-azure-infrastructure-usage_azure-intro): Target documentation page

## Documentation scope

### Existing documentation to update

| Requirement | What changed | References |
|-------------|-------------|------------|
| REQ-001 | Database shape configuration VM SKUs updated from Ds_v3 to Dds_v5 series | [AAP-84330](https://redhat.atlassian.net/browse/AAP-84330) |

## Related tickets

| Ticket | Summary | Relationship |
|--------|---------|-------------|
| [AAP-79958](https://redhat.atlassian.net/browse/AAP-79958) | 2026 Q3 Management and Infrastructure improvements for Cloud | Parent Epic |

## Sources consulted

### JIRA tickets
- [AAP-84330](https://redhat.atlassian.net/browse/AAP-84330) — Update AAP on Azure docs with new vm series
- [AAP-79958](https://redhat.atlassian.net/browse/AAP-79958) — 2026 Q3 Management and Infrastructure improvements for Cloud

### Existing documentation
- [Azure infrastructure usage section](https://docs.redhat.com/en/documentation/ansible_on_clouds/2.x/html-single/red_hat_ansible_automation_platform_on_microsoft_azure_guide/index#con-azure-infrastructure-usage_azure-intro)

# Documentation Modules: AAP-84330

**Ticket:** [AAP-84330](https://redhat.atlassian.net/browse/AAP-84330)
**Generated:** 2026-07-28
**Placement mode:** UPDATE-IN-PLACE
**Build framework:** ccutil (asciidoctor-based, master.adoc entry point)
**Content root:** aap-clouds/

## Summary

Updated the Azure Database for PostgreSQL "Database shape configuration" table in the infrastructure usage concept module. Replaced all VM SKU references from the Ds_v3 series to the Dds_v5 series across all six plan size rows.

### Changes applied

| Plan size | Old value | New value |
|-----------|-----------|-----------|
| 50 | `Standard_D2s_v3` | `Standard_D2ds_v5` |
| 400 | `Standard_D4s_v3` | `Standard_D4ds_v5` |
| 1000 | `Standard_D4s_v3` | `Standard_D4ds_v5` |
| 2500 | `Standard_D4s_v3` | `Standard_D4ds_v5` |
| 5000 | `Standard_D4s_v3` | `Standard_D4ds_v5` |
| 10000 | `Standard_D4s_v3` | `Standard_D4ds_v5` |

## Files Written

| Path | Type | Description |
|------|------|-------------|
| /home/ifowler/aap-docs/aap-clouds/topics/con-azure-infrastructure-usage.adoc | CONCEPT (updated) | Replaced 6 VM SKU values in the Azure Database for PostgreSQL table from Ds_v3 to Dds_v5 series |

## Validation

- Vale linting: 0 errors (all warnings and suggestions are pre-existing, unrelated to this change)
- No new files created
- No navigation or TOC changes required
- No assembly structure changes required

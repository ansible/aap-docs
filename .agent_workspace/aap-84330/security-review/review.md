# Security and PII Review — AAP-84330

## Automated scan results

**Scanner findings:** 3 total (0 critical, 3 warnings)

All 3 findings are external URL warnings for legitimate links to Microsoft Azure documentation:

| Line | URL | Verdict |
|------|-----|---------|
| 41 | `learn.microsoft.com` (IOPS reference) | Safe — official Azure docs link |
| 52 | `azure.microsoft.com` (Pricing calculator) | Safe — official Azure tool |
| 53 | `azure.com/e/...` (Infrastructure estimate) | Safe — Azure pricing estimate link |

These are intentional, customer-facing external links to Azure documentation and tooling. No action required.

## Agent analysis

### Checklist results

| Check | Result |
|-------|--------|
| Real IP addresses (non-RFC 5737) | Pass — no IP addresses found |
| Real email addresses | Pass — no email addresses found |
| Credentials, tokens, API keys | Pass — no credentials found |
| Internal hostnames | Pass — no internal hostnames found |
| MAC addresses (non-RFC 7042) | Pass — no MAC addresses found |
| Customer-identifiable data | Pass — no customer data found |
| Hardcoded usernames or paths | Pass — uses AsciiDoc attributes for product names |
| Sensitive infrastructure details | Pass — VM SKU names and IOPS values are public Azure specifications |

### Summary

No security or PII issues found. The file contains only public Azure service specifications, product attribute references, and legitimate external links to Microsoft documentation. The VM SKU values (`Standard_D2ds_v5`, `Standard_D4ds_v5`) are publicly documented Azure VM series names.

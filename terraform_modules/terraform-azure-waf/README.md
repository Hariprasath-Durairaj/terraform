# Azure WAF Policy Terraform Module

This module provisions an Azure Web Application Firewall (WAF) policy with support for OWASP rule sets and custom rules.

## Usage

```hcl
module "waf" {
  source              = "../terraform-azure-waf"
  name                = "dhdp-qa-waf"
  location            = var.location
  resource_group_name = var.resource_group_name
  mode                = "Prevention"
  owasp_version       = "3.2"
  custom_rules        = []
  tags                = var.tags
}
```

## Outputs

- `waf_policy_id` — ID of the WAF policy
## Terraform Module: Azure Web Application Firewall (WAF) Policy

A general, reusable Terraform module for deploying an Azure Web Application Firewall (WAF) policy, supporting custom rules and OWASP managed rule sets.  
Can be used with Azure Application Gateway, Azure Front Door, and other supported services.

---

## Features

- Creates an Azure WAF policy resource.
- Supports custom rules (e.g., IP block/allow by RemoteAddr).
- Configurable OWASP managed ruleset version.
- Choice of Detection or Prevention mode.
- All parameters configurable via variables.
- Tagging support for resource management.

---

## Usage

```hcl
module "waf_policy" {
  source              = "github.com/<YOUR_ORG>/terraform-azure-waf"
  name                = "my-waf-policy"
  location            = "canadacentral"
  resource_group_name = "my-resource-group"
  mode                = "Prevention"
  owasp_version       = "3.2"
  custom_rules = [
    {
      name         = "BlockMaliciousIP"
      priority     = 1
      rule_type    = "MatchRule"
      match_values = ["1.2.3.4", "5.6.7.8"]
      action       = "Block"
    }
  ]
  tags = {
    Environment = "Production"
    Owner       = "cloud-team"
  }
}

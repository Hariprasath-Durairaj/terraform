# Azure Log Analytics Workspace Terraform Module

This module provisions an Azure Log Analytics workspace.

## Usage

```hcl
module "log_analytics" {
  source              = "../terraform-azure-log-analytics"
  name                = "dhdp-qa-logs"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = var.tags
}
```

## Outputs

- `workspace_id` — ID of the Log Analytics workspace
- `workspace_name` — Name of the workspace
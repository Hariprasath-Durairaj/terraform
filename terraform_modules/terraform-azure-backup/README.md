# Azure Recovery Services Vault Terraform Module

This module provisions an Azure Recovery Services Vault for use in backup and restore scenarios.

## Usage

```hcl
module "backup" {
  source              = "../terraform-azure-backup"
  name                = "dhdp-qa-backup"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  tags                = var.tags
}
```

## Outputs

- `vault_id` — ID of the Recovery Services Vault
- `vault_name` — Name of the vault
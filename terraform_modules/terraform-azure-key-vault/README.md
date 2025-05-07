# Azure Key Vault Terraform Module

This module provisions an Azure Key Vault with configurable network ACLs, soft delete, RBAC, and tagging support.

## Usage

```hcl
module "key_vault" {
  source              = "../terraform-azure-key-vault"
  name                = "dhdp-qa-kv"
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id
  tags                = var.tags
}
```

## Outputs

- `key_vault_id` — The ID of the Key Vault.
- `key_vault_name` — The name of the Key Vault.
- `key_vault_uri` — The URI for accessing secrets and keys.
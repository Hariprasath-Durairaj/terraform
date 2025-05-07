# Azure Disk Encryption Set Terraform Module

This module provisions an Azure Disk Encryption Set (DES) backed by a customer-managed key from Key Vault.

## Usage

```hcl
module "disk_encryption_set" {
  source              = "../terraform-azure-disk-encryption-set"
  name                = "dhdp-qa-des"
  location            = var.location
  resource_group_name = var.resource_group_name
  key_vault_key_id    = azurerm_key_vault_key.example.id
  tags                = var.tags
}
```

## Outputs

- `disk_encryption_set_id` — ID of the Disk Encryption Set
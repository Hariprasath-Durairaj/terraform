# Azure Container Registry (ACR) Terraform Module

This module provisions an Azure Container Registry with optional managed identity and access configuration.

## Usage

```hcl
module "acr" {
  source                         = "../terraform-azure-acr"
  name                           = "dhdpqaacr001"
  location                       = var.location
  resource_group_name            = var.resource_group_name
  sku                            = "Standard"
  admin_enabled                  = false
  public_network_access_enabled  = false
  identity_type                  = "SystemAssigned"
  tags                           = var.tags
}
```

## Outputs

- `acr_id` — ID of the ACR
- `acr_login_server` — Login server URL for Docker/Helm image push/pull
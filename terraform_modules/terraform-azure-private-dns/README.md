# Azure Private DNS Terraform Module

This module provisions an Azure Private DNS Zone and links it to a virtual network.

## Usage

```hcl
module "private_dns" {
  source                = "../terraform-azure-private-dns"
  name                  = "privatelink.azurecr.io"
  resource_group_name   = var.resource_group_name
  link_name             = "acr-dns-link"
  virtual_network_id    = azurerm_virtual_network.vnet.id
  registration_enabled  = false
  tags                  = var.tags
}
```

## Outputs

- `private_dns_zone_id` — ID of the Private DNS Zone
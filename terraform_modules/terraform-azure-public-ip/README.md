# Azure Public IP Terraform Module

This module provisions an Azure Public IP address resource.

## Usage

```hcl
module "public_ip" {
  source              = "../terraform-azure-public-ip"
  name                = "dhdp-qa-appgw-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}
```

## Outputs

- `public_ip_id` — ID of the Public IP
- `public_ip_address` — The assigned IP address
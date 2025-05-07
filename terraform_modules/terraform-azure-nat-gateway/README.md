# Azure NAT Gateway Terraform Module

This module provisions an Azure NAT Gateway and associates it with a public IP and a subnet.

## Usage

```hcl
module "nat_gateway" {
  source              = "../terraform-azure-nat-gateway"
  name                = "dhdp-qa-natgw"
  location            = var.location
  resource_group_name = var.resource_group_name
  public_ip_id        = azurerm_public_ip.nat.id
  subnet_id           = azurerm_subnet.private.id
  tags                = var.tags
}
```

## Outputs

- `nat_gateway_id` — ID of the NAT Gateway
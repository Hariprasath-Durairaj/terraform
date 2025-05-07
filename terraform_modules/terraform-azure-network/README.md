# Azure Network Terraform Module

This module creates an Azure Virtual Network (VNet) along with configurable subnets.

## Usage

```hcl
module "network" {
  source              = "../terraform-azure-network"
  vnet_name           = "dhdp-qa-vnet"
  address_space       = ["10.21.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
  subnets = {
    "aks-subnet"        = ["10.21.1.0/24"]
    "appgw-subnet"      = ["10.21.64.0/24"]
    "GatewaySubnet"     = ["10.21.32.0/24"]
  }
  tags = var.tags
}
```

## Outputs

- `vnet_id` — ID of the created VNet
- `subnet_ids` — Map of created subnet names to their IDs
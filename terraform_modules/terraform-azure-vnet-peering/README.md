# Azure VNet Peering Terraform Module

This module provisions a Virtual Network (VNet) peering between two VNets in Azure.

## Usage

```hcl
module "vnet_peering" {
  source                      = "../terraform-azure-vnet-peering"
  name                        = "dhdp-qa-to-core"
  resource_group_name         = var.resource_group_name
  virtual_network_name        = var.virtual_network_name
  remote_virtual_network_id   = var.remote_virtual_network_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = false
  allow_gateway_transit        = false
  use_remote_gateways          = false
}
```

## Outputs

- `vnet_peering_id` — ID of the VNet peering
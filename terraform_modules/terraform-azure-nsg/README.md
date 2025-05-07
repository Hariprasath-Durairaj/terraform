# Azure Network Security Group (NSG) Terraform Module

This module provisions an Azure Network Security Group (NSG) and allows for custom rule definitions.

## Usage

```hcl
module "nsg" {
  source              = "../terraform-azure-nsg"
  name                = "dhdp-qa-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
  security_rules = {
    "allow_ssh" = {
      name                       = "allow_ssh"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
  tags = var.tags
}
```

## Outputs

- `nsg_id` — ID of the Network Security Group
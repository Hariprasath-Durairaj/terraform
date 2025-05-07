# Azure Bastion Terraform Module

This module provisions an Azure Bastion Host in a specified subnet and associates it with a static public IP.

## Usage

```hcl
module "bastion" {
  source              = "../terraform-azure-bastion"
  name                = "dhdp-qa-bastion"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  public_ip_id        = var.public_ip_id
  tags                = var.tags
}
```

## Outputs

- `bastion_id` — The ID of the Bastion host
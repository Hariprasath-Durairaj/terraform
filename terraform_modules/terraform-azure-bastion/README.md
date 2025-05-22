Azure Bastion Host Terraform Module

Overview

This Terraform module deploys an Azure Bastion Host, enabling secure RDP and SSH access to your virtual machines through the Azure Portal without exposing them to the public internet.

Requirements

Terraform >= 1.3.0

AzureRM provider ~> 3.100

Providers

Name

Version

azurerm

~> 3.100

Resources

Name

Type

this

azurerm_bastion_host

Module Usage

module "bastion" {
  source              = "../path/to/module"

  # Core settings
  name                = "my-bastion-host"
  location            = "eastus"
  resource_group_name = "my-resource-group"

  # Networking
  # The subnet must be named 'AzureBastionSubnet' and have a /26 prefix or larger
  subnet_id           = azurerm_subnet.bastion.id

  # Public IP must be Standard SKU
  public_ip_id        = azurerm_public_ip.bastion.id

  # Optional tags
  tags = {
    environment = "dev"
    project     = "my-project"
  }
}

Inputs

Name

Description

Type

Default

Required

name

The name of the Bastion Host

string

n/a

yes

location

Azure region

string

n/a

yes

resource_group_name

Name of the resource group

string

n/a

yes

subnet_id

ID of the subnet (must be named AzureBastionSubnet)

string

n/a

yes

public_ip_id

ID of the Standard SKU Public IP for the Bastion Host

string

n/a

yes

tags

Tags to apply to the Bastion Host

map(string)

{}

no

Outputs

Name

Description

bastion_id

The ID of the created Bastion Host

Notes

Ensure the target subnet is named exactly AzureBastionSubnet and is large enough (minimum /26).

The public IP address must use the Standard SKU.

License

This module is released under the MIT License.


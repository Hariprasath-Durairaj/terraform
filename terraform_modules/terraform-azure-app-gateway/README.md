# Azure Application Gateway Terraform Module

This module provisions an Azure Application Gateway with basic HTTP routing rules and backend pool.

## Usage

```hcl
module "app_gateway" {
  source                = "../terraform-azure-app-gateway"
  name                  = "dhdp-qa-appgw"
  location              = var.location
  resource_group_name   = var.resource_group_name
  sku_name              = "WAF_v2"
  sku_tier              = "WAF_v2"
  capacity              = 2
  subnet_id             = var.subnet_id
  public_ip_id          = var.public_ip_id
  frontend_port         = 80
  backend_ip_addresses  = ["10.21.1.10", "10.21.1.11"]
  backend_port          = 8080
  tags                  = var.tags
}
```

## Outputs

- `app_gateway_id` — ID of the Application Gateway
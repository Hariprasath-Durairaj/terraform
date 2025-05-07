# ------------------------
# DHDP QA Environment Modules
# ------------------------

provider "azurerm" {
  features {}
}

# Network
module "vnet" {
  source              = "../../terraform_modules/terraform-azure-network"
  vnet_name           = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
  subnets             = var.subnets
  tags                = var.tags
}

module "nsg" {
  source              = "../../terraform_modules/terraform-azure-nsg"
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name
  security_rules      = var.security_rules
  tags                = var.tags
}

# Public IPs
module "public_ip_appgw" {
  source              = "../../terraform_modules/terraform-azure-public-ip"
  name                = var.public_ip_appgw_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

module "public_ip_bastion" {
  source              = "../../terraform_modules/terraform-azure-public-ip"
  name                = var.public_ip_bastion_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# NAT Gateway
module "nat_gateway" {
  source              = "../../terraform_modules/terraform-azure-nat-gateway"
  name                = var.nat_gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name
  public_ip_id        = module.public_ip_appgw.public_ip_id
  subnet_id           = module.vnet.subnet_ids["aks-subnet"]
  tags                = var.tags
}

# Bastion Host
module "bastion" {
  source              = "../../terraform_modules/terraform-azure-bastion"
  name                = var.bastion_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = module.vnet.subnet_ids["AzureBastionSubnet"]
  public_ip_id        = module.public_ip_bastion.public_ip_id
  tags                = var.tags
}

# Private DNS
module "private_dns" {
  source                = "../../terraform_modules/terraform-azure-private-dns"
  name                  = var.private_dns_name
  resource_group_name   = var.resource_group_name
  link_name             = var.private_dns_link_name
  virtual_network_id    = module.vnet.vnet_id
  registration_enabled  = false
  tags                  = var.tags
}

# VNet Peering
module "vnet_peering" {
  source                      = "../../terraform_modules/terraform-azure-vnet-peering"
  name                        = var.vnet_peering_name
  resource_group_name         = var.resource_group_name
  virtual_network_name        = var.vnet_name
  remote_virtual_network_id   = var.remote_virtual_network_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = false
  allow_gateway_transit        = false
  use_remote_gateways          = false
}

# Key Vault
module "key_vault" {
  source              = "../../terraform_modules/terraform-azure-key-vault"
  name                = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id
  tags                = var.tags
}

# Disk Encryption Set
module "disk_encryption_set" {
  source              = "../../terraform_modules/terraform-azure-disk-encryption-set"
  name                = var.disk_encryption_set_name
  location            = var.location
  resource_group_name = var.resource_group_name
  key_vault_key_id    = var.key_vault_key_id
  tags                = var.tags
}

# ACR
module "acr" {
  source              = "../../terraform_modules/terraform-azure-acr"
  name                = var.acr_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# AKS Cluster
module "aks" {
  source              = "../../terraform_modules/terraform-azure-aks"
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version
  node_resource_group = var.node_resource_group
  default_node_pool   = var.default_node_pool
  user_node_pools     = var.user_node_pools
  network_plugin      = var.network_plugin
  dns_service_ip      = var.dns_service_ip
  service_cidr        = var.service_cidr
  tags                = var.tags
}

# Log Analytics
module "log_analytics" {
  source              = "../../terraform_modules/terraform-azure-log-analytics"
  name                = var.log_analytics_name
  location            = var.location
  resource_group_name = var.resource_group_name
  retention_in_days   = var.log_retention
  tags                = var.tags
}

# Backup Vault
module "backup" {
  source              = "../../terraform_modules/terraform-azure-backup"
  name                = var.backup_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# WAF
module "waf" {
  source              = "../../terraform_modules/terraform-azure-waf"
  name                = var.waf_name
  location            = var.location
  resource_group_name = var.resource_group_name
  mode                = var.waf_mode
  owasp_version       = var.owasp_version
  custom_rules        = var.custom_rules
  tags                = var.tags
}

# App Gateway
module "app_gateway" {
  source                = "../../terraform_modules/terraform-azure-app-gateway"
  name                  = var.app_gateway_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  sku_name              = var.appgw_sku
  sku_tier              = var.appgw_sku_tier
  capacity              = var.appgw_capacity
  subnet_id             = module.vnet.subnet_ids["appgw-subnet"]
  public_ip_id          = module.public_ip_appgw.public_ip_id
  frontend_port         = var.appgw_frontend_port
  backend_ip_addresses  = var.appgw_backend_ips
  backend_port          = var.appgw_backend_port
  tags                  = var.tags
}

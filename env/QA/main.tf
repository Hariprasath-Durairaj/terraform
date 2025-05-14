provider "azurerm" {
  features {}
}
# Virtual Network
module "vnet" {
  source              = "../../terraform_modules/terraform-azure-network"
  vnet_name           = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = "dhdp-lab-resource-group"  # Static name for resource group
  subnets             = var.subnets
  tags                = var.tags
}

# Public IP for NGINX Ingress
module "public_ip_nginx" {
  source              = "../../terraform_modules/terraform-azure-public-ip"
  name                = var.public_ip_nginx_name
  location            = var.location
  resource_group_name = "dhdp-lab-resource-group"  # Static name for resource group
  tags                = var.tags
}

# AKS Cluster
module "aks" {
  source              = "../../terraform_modules/terraform-azure-aks"
  name                = var.aks_name
  location            = var.location
  resource_group_name = "dhdp-lab-resource-group"  # Static name for resource group
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version
  node_resource_group = var.node_resource_group
  default_node_pool   = merge(var.default_node_pool, {
  vnet_subnet_id = module.vnet.subnet_ids["aks-subnet"]
  temporary_name_for_rotation = "${var.default_node_pool.name}-temp"
  })
  user_node_pools     = {
    for k, v in var.user_node_pools : k => merge(v, {
      vnet_subnet_id = module.vnet.subnet_ids["aks-subnet"]
    })
  }
  network_plugin      = var.network_plugin
  dns_service_ip      = var.dns_service_ip
  service_cidr        = var.service_cidr
  tags                = var.tags
}

# Kubernetes provider using AKS kubeconfig output
provider "kubernetes" {
  host                   = module.aks.kube_config[0].host
  client_certificate     = base64decode(module.aks.kube_config[0].client_certificate)
  client_key             = base64decode(module.aks.kube_config[0].client_key)
  cluster_ca_certificate = base64decode(module.aks.kube_config[0].cluster_ca_certificate)
}

# Helm release for NGINX Ingress Controller with WAF
resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress"
  namespace  = "kube-system"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.0.6"

  set {
    name  = "controller.enableWAF"
    value = "true"
  }

  set {
    name  = "controller.waf.enable"
    value = "true"
  }

  set {
    name  = "controller.service.loadBalancerIP"
    value = module.public_ip_nginx.public_ip_id
  }

  depends_on = [module.aks]
}
provider "helm" {
  kubernetes {
    host                   = module.aks.host
    client_certificate     = base64decode(module.aks.client_certificate)
    client_key             = base64decode(module.aks.client_key)
    cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)
  }
}
# Private DNS Zone
module "private_dns" {
  source                = "../../terraform_modules/terraform-azure-private-dns"
  name                  = var.private_dns_name
  resource_group_name   = "dhdp-lab-resource-group"  # Static name for resource group
  link_name             = var.private_dns_link_name
  virtual_network_id    = module.vnet.vnet_id
  registration_enabled  = false
  tags                  = var.tags
}

# Key Vault
module "key_vault" {
  source              = "../../terraform_modules/terraform-azure-key-vault"
  name                = var.key_vault_name
  location            = var.location
  resource_group_name = "dhdp-lab-resource-group"  # Static name for resource group
  tenant_id           = var.tenant_id
  tags                = var.tags
}

# ACR
module "acr" {
  source              = "../../terraform_modules/terraform-azure-acr"
  name                = var.acr_name
  location            = var.location
  resource_group_name = "dhdp-lab-resource-group"  # Static name for resource group
  tags                = var.tags
}

# Log Analytics Workspace
module "log_analytics" {
  source              = "../../terraform_modules/terraform-azure-log-analytics"
  name                = var.log_analytics_name
  location            = var.location
  resource_group_name = "dhdp-lab-resource-group"  # Static name for resource group
  retention_in_days   = var.log_retention
  tags                = var.tags
}

# Outputs for public IP, WAF, and other resources
output "public_ip_nginx" {
  value = module.public_ip_nginx.public_ip_address
}

output "key_vault_id" {
  value = module.key_vault.key_vault_id
}

output "acr_id" {
  value = module.acr.acr_id
}

output "log_analytics_workspace_id" {
  value = module.log_analytics.workspace_id
}

output "nginx_ingress_controller_id" {
  value = helm_release.nginx_ingress.id
}

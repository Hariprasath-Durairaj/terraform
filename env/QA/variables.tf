# Declare input variables

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "tenant_id" {
  description = "Tenant ID"
  type        = string
}

variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
}

variable "address_space" {
  description = "Address space for the Virtual Network"
  type        = list(string)
}

variable "subnets" {
  description = "Subnets to be created in the VNet"
  type        = map(list(string))
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
}

variable "public_ip_nginx_name" {
  description = "Name of the public IP for NGINX Ingress"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version for AKS"
  type        = string
}

variable "node_resource_group" {
  description = "Resource group for AKS nodes"
  type        = string
}

variable "default_node_pool" {
  description = "Default node pool configuration"
  type        = map(any)
}

variable "user_node_pools" {
  description = "User node pools for AKS"
  type        = map(any)
}

variable "network_plugin" {
  description = "Network plugin for AKS"
  type        = string
}

variable "dns_service_ip" {
  description = "DNS service IP for AKS"
  type        = string
}

variable "service_cidr" {
  description = "Service CIDR for AKS"
  type        = string
}

variable "docker_bridge_cidr" {
  description = "Docker bridge CIDR"
  type        = string
}

variable "log_retention" {
  description = "Log retention in days"
  type        = number
}

# Declare missing variables that were referenced in main.tf

variable "aks_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "private_dns_name" {
  description = "Name of the private DNS zone"
  type        = string
}

variable "private_dns_link_name" {
  description = "Name of the private DNS link"
  type        = string
}

variable "key_vault_name" {
  description = "Name of the Azure Key Vault"
  type        = string
}

variable "acr_name" {
  description = "Name of the Azure Container Registry (ACR)"
  type        = string
}

variable "log_analytics_name" {
  description = "Name of the Log Analytics workspace"
  type        = string
}

# Declare missing variables from terraform.tfvars

variable "key_vault_key_id" {
  description = "Key Vault Key ID"
  type        = string
}

variable "remote_virtual_network_id" {
  description = "ID of the remote virtual network"
  type        = string
}

# Add any additional variables that you referenced in your terraform.tfvars

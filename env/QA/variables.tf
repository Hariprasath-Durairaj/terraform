# General Variables
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

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
}

# Virtual Network (VNet)
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

# Public IPs (for NGINX Ingress)
variable "public_ip_nginx_name" {
  description = "Name of the public IP for NGINX Ingress"
  type        = string
}

# Network Security Group (NSG)
variable "nsg_name" {
  description = "Name of the Network Security Group"
  type        = string
}

variable "security_rules" {
  description = "Security rules for the NSG"
  type        = map(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}

# NAT Gateway
variable "nat_gateway_name" {
  description = "Name of the NAT Gateway"
  type        = string
}

# Bastion
variable "bastion_name" {
  description = "Name of the Bastion host"
  type        = string
}

# Private DNS
variable "private_dns_name" {
  description = "Name of the private DNS zone"
  type        = string
}

variable "private_dns_link_name" {
  description = "Name of the private DNS link"
  type        = string
}

# VNet Peering
variable "vnet_peering_name" {
  description = "Name of the VNet peering"
  type        = string
}

variable "remote_virtual_network_id" {
  description = "ID of the remote virtual network"
  type        = string
}

# Key Vault and Encryption
variable "key_vault_name" {
  description = "Name of the Azure Key Vault"
  type        = string
}

variable "disk_encryption_set_name" {
  description = "Name of the Disk Encryption Set"
  type        = string
}

variable "key_vault_key_id" {
  description = "Key Vault Key ID"
  type        = string
}

# Azure Container Registry (ACR)
variable "acr_name" {
  description = "Name of the Azure Container Registry (ACR)"
  type        = string
}

# AKS Cluster Configuration
variable "aks_name" {
  description = "Name of the AKS cluster"
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

# Network Plugin and Service CIDR for AKS
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

# Log Analytics
variable "log_analytics_name" {
  description = "Name of the Log Analytics workspace"
  type        = string
}

variable "log_retention" {
  description = "Log retention in days"
  type        = number
}

variable "vnet_name" {
  type        = string
  description = "Name of the virtual network"
}

variable "address_space" {
  type        = list(string)
  description = "Address space for the VNet"
}

variable "subnets" {
  type        = map(list(string))
  description = "Subnets for the VNet"
}

variable "nsg_name" {
  type        = string
  description = "Name of the NSG"
}

variable "security_rules" {
  type = map(object({
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
  description = "NSG security rules"
}

variable "public_ip_appgw_name" {
  type        = string
  description = "Name of the public IP for App Gateway"
}

variable "public_ip_bastion_name" {
  type        = string
  description = "Name of the public IP for Bastion"
}

variable "nat_gateway_name" {
  type        = string
  description = "Name of the NAT Gateway"
}

variable "bastion_name" {
  type        = string
  description = "Name of the Bastion Host"
}

variable "private_dns_name" {
  type        = string
  description = "Private DNS zone name"
}

variable "private_dns_link_name" {
  type        = string
  description = "Link name for the Private DNS zone"
}

variable "vnet_peering_name" {
  type        = string
  description = "Name of the VNet Peering"
}

variable "remote_virtual_network_id" {
  type        = string
  description = "ID of the remote virtual network to peer with"
}

variable "key_vault_name" {
  type        = string
  description = "Name of the Key Vault"
}

variable "tenant_id" {
  type        = string
  description = "Azure AD Tenant ID"
}

variable "disk_encryption_set_name" {
  type        = string
  description = "Name of the Disk Encryption Set"
}

variable "key_vault_key_id" {
  type        = string
  description = "ID of the key in Key Vault used for disk encryption"
}

variable "acr_name" {
  type        = string
  description = "Name of the Azure Container Registry"
}

variable "aks_name" {
  type        = string
  description = "Name of the AKS cluster"
}

variable "dns_prefix" {
  type        = string
  description = "DNS prefix for AKS"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version for AKS"
}

variable "node_resource_group" {
  type        = string
  description = "Node resource group for AKS"
}

variable "default_node_pool" {
  type = object({
    name                = string
    vm_size             = string
    enable_auto_scaling = bool
    min_count           = number
    max_count           = number
    max_pods            = number
    os_disk_size_gb     = number
    type                = string
    node_labels         = map(string)
    tags                = map(string)
    vnet_subnet_id      = string
  })
  description = "Default node pool configuration for AKS"
}

variable "network_plugin" {
  type        = string
  description = "Network plugin for AKS (e.g., azure)"
}

variable "dns_service_ip" {
  type        = string
  description = "DNS service IP for AKS"
}

variable "service_cidr" {
  type        = string
  description = "Service CIDR for AKS"
}

variable "docker_bridge_cidr" {
  type        = string
  description = "Docker bridge CIDR for AKS"
}

variable "log_analytics_name" {
  type        = string
  description = "Name of the Log Analytics workspace"
}

variable "log_retention" {
  type        = number
  description = "Retention in days for Log Analytics"
}

variable "backup_vault_name" {
  type        = string
  description = "Name of the Recovery Services Backup Vault"
}

variable "waf_name" {
  type        = string
  description = "Name of the WAF policy"
}

variable "waf_mode" {
  type        = string
  description = "WAF mode (Detection or Prevention)"
}

variable "owasp_version" {
  type        = string
  description = "OWASP version to use in WAF policy"
}

variable "custom_rules" {
  type        = list(any)
  description = "Custom rules for the WAF policy"
  default     = []
}

variable "app_gateway_name" {
  type        = string
  description = "Name of the Application Gateway"
}

variable "appgw_sku" {
  type        = string
  description = "SKU name for App Gateway"
}

variable "appgw_sku_tier" {
  type        = string
  description = "SKU tier for App Gateway"
}

variable "appgw_capacity" {
  type        = number
  description = "Instance capacity for App Gateway"
}

variable "appgw_frontend_port" {
  type        = number
  description = "Frontend port for App Gateway"
}

variable "appgw_backend_ips" {
  type        = list(string)
  description = "List of backend IP addresses for App Gateway"
}

variable "appgw_backend_port" {
  type        = number
  description = "Backend port for App Gateway"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the Azure resource group"
}

variable "tags" {
  type        = map(string)
  description = "Common tags to apply to all resources"
  default     = {}
}
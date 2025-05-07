variable "name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version for the cluster"
  type        = string
}

variable "node_resource_group" {
  description = "The name of the node resource group"
  type        = string
}

variable "default_node_pool" {
  description = "Configuration for the default node pool"
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
}

variable "user_node_pools" {
  description = "Map of additional named user node pools"
  type = map(object({
    name            = string
    vm_size         = string
    os_disk_size_gb = number
    node_count      = number
    max_pods        = number
    mode            = string
    node_labels     = map(string)
    vnet_subnet_id  = string
    tags            = map(string)
  }))
  default = {}
}

variable "network_plugin" {
  description = "Network plugin to use"
  type        = string
}

variable "dns_service_ip" {
  description = "DNS service IP"
  type        = string
}

variable "service_cidr" {
  description = "Service CIDR"
  type        = string
}



variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

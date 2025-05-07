resource "azurerm_kubernetes_cluster" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version
  node_resource_group = var.node_resource_group

default_node_pool {
  name                = var.default_node_pool.name
  vm_size             = var.default_node_pool.vm_size
  enable_auto_scaling = var.default_node_pool.enable_auto_scaling
  min_count           = var.default_node_pool.min_count
  max_count           = var.default_node_pool.max_count
  max_pods            = var.default_node_pool.max_pods
  os_disk_size_gb     = var.default_node_pool.os_disk_size_gb
  node_labels         = var.default_node_pool.node_labels
  vnet_subnet_id      = var.default_node_pool.vnet_subnet_id
  mode                = "System"
  tags                = var.default_node_pool.tags
}


  identity {
    type = "SystemAssigned"
  }

role_based_access_control_enabled = true


  network_profile {
    network_plugin     = var.network_plugin
    dns_service_ip     = var.dns_service_ip
    service_cidr       = var.service_cidr
    docker_bridge_cidr = var.docker_bridge_cidr
  }

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "user_pools" {
  for_each = var.user_node_pools

  name                  = each.value.name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.this.id
  vm_size               = each.value.vm_size
  node_count            = each.value.node_count
  max_pods              = each.value.max_pods
  os_disk_size_gb       = each.value.os_disk_size_gb
  mode                  = each.value.mode
  node_labels           = each.value.node_labels
  vnet_subnet_id        = each.value.vnet_subnet_id
  orchestrator_version  = var.kubernetes_version
  tags                  = each.value.tags
}

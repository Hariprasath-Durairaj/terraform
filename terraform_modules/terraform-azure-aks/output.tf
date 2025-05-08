output "aks_id" {
  description = "ID of the AKS cluster"
  value       = azurerm_kubernetes_cluster.this.id
}

output "kube_config" {
  description = "Kube config raw output"
  value       = azurerm_kubernetes_cluster.this.kube_config_raw
  sensitive   = true
}

output "kube_config_file" {
  description = "Kube config block for use with kubectl"
  value = {
    host                   = azurerm_kubernetes_cluster.this.kube_config[0].host
    client_certificate     = azurerm_kubernetes_cluster.this.kube_config[0].client_certificate
    client_key             = azurerm_kubernetes_cluster.this.kube_config[0].client_key
    cluster_ca_certificate = azurerm_kubernetes_cluster.this.kube_config[0].cluster_ca_certificate
    username               = azurerm_kubernetes_cluster.this.kube_config[0].username
    password               = azurerm_kubernetes_cluster.this.kube_config[0].password
  }
}

output "host" {
  value = azurerm_kubernetes_cluster.this.kube_config.0.host
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.this.kube_config.0.client_certificate
}

output "client_key" {
  value = azurerm_kubernetes_cluster.this.kube_config.0.client_key
}

output "cluster_ca_certificate" {
  value = azurerm_kubernetes_cluster.this.kube_config.0.cluster_ca_certificate
}

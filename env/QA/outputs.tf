# Remove the duplicate outputs as they are already defined in main.tf

# You can leave this file empty if outputs are defined in main.tf

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

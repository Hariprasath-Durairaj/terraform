output "public_ip_nginx" {
  value       = module.public_ip_nginx.public_ip_address
  description = "Public IP address for NGINX Ingress"
}

output "key_vault_id" {
  value       = module.key_vault.key_vault_id
  description = "Key Vault ID"
}

output "acr_id" {
  value       = module.acr.acr_id
  description = "Azure Container Registry ID"
}

output "log_analytics_workspace_id" {
  value       = module.log_analytics.workspace_id
  description = "Log Analytics Workspace ID"
}

output "nginx_ingress_controller_id" {
  value       = helm_release.nginx_ingress.id
  description = "NGINX Ingress Controller ID"
}

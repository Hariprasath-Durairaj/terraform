# Output for VNet ID
output "vnet_id" {
  value       = module.vnet.vnet_id
  description = "ID of the Virtual Network"
}

# Output for Subnet IDs (if applicable)
output "subnet_ids" {
  value       = module.vnet.subnet_ids
  description = "Map of subnet names to subnet IDs"
}

# Output for AKS Cluster ID
output "aks_id" {
  value       = module.aks.aks_id
  description = "ID of the AKS Cluster"
}

# Output for Kubeconfig (Sensitive)
output "kube_config" {
  value       = module.aks.kube_config
  description = "Raw kubeconfig content"
  sensitive   = true
}

# Output for Log Analytics Workspace ID
output "log_analytics_workspace_id" {
  value       = module.log_analytics.workspace_id
  description = "ID of the Log Analytics Workspace"
}

# Output for Backup Vault ID
output "backup_vault_id" {
  value       = module.backup.vault_id
  description = "ID of the Recovery Services Vault"
}

# If you are not using the Bastion module, remove this output
output "public_ip_bastion" {
  value       = module.public_ip_bastion.public_ip_address
  description = "Public IP address assigned to Bastion Host"
}

# If you are not using the Application Gateway or WAF, remove these outputs
output "public_ip_appgw" {
  value       = module.public_ip_appgw.public_ip_address
  description = "Public IP address assigned to Application Gateway"
}

# If you are not using WAF, remove this output
output "waf_policy_id" {
  value       = module.waf.waf_policy_id
  description = "ID of the WAF Policy"
}

# If you are not using Application Gateway, remove this output
output "app_gateway_id" {
  value       = module.app_gateway.app_gateway_id
  description = "ID of the Application Gateway"
}

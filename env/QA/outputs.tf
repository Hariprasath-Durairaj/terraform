output "vnet_id" {
  value       = module.vnet.vnet_id
  description = "ID of the Virtual Network"
}

output "subnet_ids" {
  value       = module.vnet.subnet_ids
  description = "Map of subnet names to subnet IDs"
}

output "bastion_id" {
  value       = module.bastion.bastion_id
  description = "ID of the Bastion Host"
}

output "aks_id" {
  value       = module.aks.aks_id
  description = "ID of the AKS Cluster"
}

output "kube_config" {
  value       = module.aks.kube_config
  description = "Raw kubeconfig content"
  sensitive   = true
}

output "public_ip_appgw" {
  value       = module.public_ip_appgw.public_ip_address
  description = "Public IP address assigned to Application Gateway"
}

output "public_ip_bastion" {
  value       = module.public_ip_bastion.public_ip_address
  description = "Public IP address assigned to Bastion Host"
}

output "log_analytics_workspace_id" {
  value       = module.log_analytics.workspace_id
  description = "ID of the Log Analytics Workspace"
}

output "backup_vault_id" {
  value       = module.backup.vault_id
  description = "ID of the Recovery Services Vault"
}

output "waf_policy_id" {
  value       = module.waf.waf_policy_id
  description = "ID of the WAF Policy"
}

output "app_gateway_id" {
  value       = module.app_gateway.app_gateway_id
  description = "ID of the Application Gateway"
}
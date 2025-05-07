output "waf_policy_id" {
  description = "The ID of the WAF policy"
  value       = azurerm_web_application_firewall_policy.this.id
}
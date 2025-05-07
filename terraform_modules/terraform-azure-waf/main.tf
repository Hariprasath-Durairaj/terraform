resource "azurerm_web_application_firewall_policy" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  policy_settings {
    enabled                     = true
    mode                        = var.mode
    request_body_check          = true
    file_upload_limit_in_mb     = 100
    max_request_body_size_in_kb = 128
  }

  custom_rules = var.custom_rules

  managed_rules {
    managed_rule_set {
      type    = "OWASP"
      version = var.owasp_version
    }
  }

  tags = var.tags
}
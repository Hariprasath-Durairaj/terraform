variable "name" {
  description = "The name of the WAF policy."
  type        = string
}

variable "location" {
  description = "Azure region for the WAF policy."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group in which to create the WAF policy."
  type        = string
}

variable "mode" {
  description = "WAF mode: Prevention or Detection."
  type        = string
  default     = "Prevention"
}

variable "owasp_version" {
  description = "OWASP managed ruleset version (e.g., 3.2)."
  type        = string
  default     = "3.2"
}

variable "file_upload_limit_in_mb" {
  description = "File upload limit in MB."
  type        = number
  default     = 100
}

variable "max_request_body_size_in_kb" {
  description = "Maximum request body size in KB."
  type        = number
  default     = 128
}

variable "custom_rules" {
  description = "List of custom WAF rules."
  type = list(object({
    name         = string
    priority     = number
    rule_type    = string
    match_values = list(string)
    action       = string # 'Allow' | 'Block' | 'Log'
  }))
  default = []
}

variable "tags" {
  description = "Tags to apply to the WAF policy."
  type        = map(string)
  default     = {}
}

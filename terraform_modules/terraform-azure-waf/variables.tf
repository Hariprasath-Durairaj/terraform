variable "name" {
  description = "The name of the WAF policy"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "mode" {
  description = "The mode of the WAF policy (Prevention or Detection)"
  type        = string
  default     = "Prevention"
}

variable "owasp_version" {
  description = "The OWASP rule set version"
  type        = string
  default     = "3.2"
}

variable "custom_rules" {
  description = "List of custom rules for the WAF policy"
  type        = list(any)
  default     = []
}

variable "tags" {
  description = "Tags to apply to the WAF policy"
  type        = map(string)
  default     = {}
}
terraform {
  backend "azurerm" {
    resource_group_name  = "dhdp-qa-resource-group"
    storage_account_name = "dhdpqatfstg"
    container_name       = "tfstate"
    key                  = "qa.terraform.tfstate"
  }
}

location            = "canadacentral"
resource_group_name = "dhdp-lab-resource-group"
tenant_id           = "c25c5028-2135-4990-9b82-d8c62774306a"

tags = {
  Environment = "QA"
  Project     = "DHDP"
  ManagedBy   = "Terraform"
}

vnet_name     = "dhdp-qa-vnet"
address_space = ["10.21.0.0/16"]

subnets = {
  "aks-subnet"         = ["10.21.1.0/24"]
  "appgw-subnet"       = ["10.21.64.0/24"]
  "AzureBastionSubnet" = ["10.21.80.0/27"]
  "webapp-subnet"      = ["10.21.96.0/24"]
}

nsg_name = "dhdp-qa-nsg"

security_rules = {
  "allow_ssh" = {
    name                       = "allow_ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

public_ip_appgw_name   = "dhdp-qa-appgw-pip"
public_ip_bastion_name = "dhdp-qa-bastion-pip"

nat_gateway_name = "dhdp-qa-natgw"
bastion_name     = "dhdp-qa-bastion"

private_dns_name       = "privatelink.azurecr.io"
private_dns_link_name  = "acr-dns-link"
vnet_peering_name      = "dhdp-qa-peering"
remote_virtual_network_id = "/subscriptions/accf2f42-1262-48a4-8ab5-980bdf8aa8b8/resourceGroups/dhdp-mgmt-resource-group/providers/Microsoft.Network/virtualNetworks/dhdp-mgmt-vnet"

key_vault_name           = "dhdp-qa-kv"
disk_encryption_set_name = "dhdp-qa-des"
key_vault_key_id         = "https://dhdp-qa-kv.vault.azure.net/keys/dhdp-qa-acr-cmk-key/d362cbd7f7e349ceaa138e143f608321"

acr_name = "dhdpqaacr"

aks_name            = "dhdp-qa-aks"
dns_prefix          = "dhdpqa"
kubernetes_version  = "1.27.3"
node_resource_group = "MC_dhdp-qa-resource-group_dhdp-qa-aks_canadacentral"

default_node_pool = {
  name                = "system"
  vm_size             = "Standard_DS2_v2"
  enable_auto_scaling = true
  min_count           = 1
  max_count           = 3
  max_pods            = 110
  os_disk_size_gb     = 50
  type                = "System"
  node_labels         = { "type" = "system" }
  tags                = {}
  vnet_subnet_id      = "/subscriptions/accf2f42-1262-48a4-8ab5-980bdf8aa8b8/resourceGroups/dhdp-lab-resource-group/providers/Microsoft.Network/virtualNetworks/dhdp-qa-vnet/subnets/aks-subnet"
}

user_node_pools = {
  bitnobi = {
    name            = "bitnobi"
    vm_size         = "Standard_DS2_v2"
    os_disk_size_gb = 50
    node_count      = 1
    max_pods        = 110
    mode            = "User"
    node_labels     = { "app" = "bitnobi" }
    vnet_subnet_id  = "/subscriptions/accf2f42-1262-48a4-8ab5-980bdf8aa8b8/resourceGroups/dhdp-lab-resource-group/providers/Microsoft.Network/virtualNetworks/dhdp-qa-vnet/subnets/aks-subnet"
    tags            = { "app" = "bitnobi" }
  },
  candig = {
    name            = "candig"
    vm_size         = "Standard_DS2_v2"
    os_disk_size_gb = 50
    node_count      = 1
    max_pods        = 110
    mode            = "User"
    node_labels     = { "app" = "candig" }
    vnet_subnet_id  = "/subscriptions/accf2f42-1262-48a4-8ab5-980bdf8aa8b8/resourceGroups/dhdp-lab-resource-group/providers/Microsoft.Network/virtualNetworks/dhdp-qa-vnet/subnets/aks-subnet"
    tags            = { "app" = "candig" }
  },
  keycloak = {
    name            = "keycloak"
    vm_size         = "Standard_DS2_v2"
    os_disk_size_gb = 50
    node_count      = 1
    max_pods        = 110
    mode            = "User"
    node_labels     = { "app" = "keycloak" }
    vnet_subnet_id  = "/subscriptions/accf2f42-1262-48a4-8ab5-980bdf8aa8b8/resourceGroups/dhdp-lab-resource-group/providers/Microsoft.Network/virtualNetworks/dhdp-qa-vnet/subnets/aks-subnet"
    tags            = { "app" = "keycloak" }
  },
  integrateai = {
    name            = "integrateai"
    vm_size         = "Standard_DS2_v2"
    os_disk_size_gb = 50
    node_count      = 1
    max_pods        = 110
    mode            = "User"
    node_labels     = { "app" = "integrateai" }
    vnet_subnet_id  = "/subscriptions/accf2f42-1262-48a4-8ab5-980bdf8aa8b8/resourceGroups/dhdp-lab-resource-group/providers/Microsoft.Network/virtualNetworks/dhdp-qa-vnet/subnets/aks-subnet"
    tags            = { "app" = "integrateai" }
  },
  webapp = {
    name            = "webapp"
    vm_size         = "Standard_DS2_v2"
    os_disk_size_gb = 50
    node_count      = 1
    max_pods        = 110
    mode            = "User"
    node_labels     = { "app" = "webapp" }
    vnet_subnet_id  = "/subscriptions/accf2f42-1262-48a4-8ab5-980bdf8aa8b8/resourceGroups/dhdp-lab-resource-group/providers/Microsoft.Network/virtualNetworks/dhdp-qa-vnet/subnets/webapp-subnet"
    tags            = { "app" = "webapp" }
  }
}

network_plugin     = "azure"
dns_service_ip     = "10.2.0.10"
service_cidr       = "10.2.0.0/24"
docker_bridge_cidr = "172.17.0.1/16"

log_analytics_name = "dhdp-qa-log"
log_retention      = 30

backup_vault_name = "dhdp-qa-backup"

waf_name      = "dhdp-qa-waf"
waf_mode      = "Prevention"
owasp_version = "3.2"
custom_rules  = []

app_gateway_name    = "dhdp-qa-appgw"
appgw_sku           = "WAF_v2"
appgw_sku_tier      = "WAF_v2"
appgw_capacity      = 2
appgw_frontend_port = 80
appgw_backend_ips   = ["10.21.1.4", "10.21.1.5"]
appgw_backend_port  = 8080

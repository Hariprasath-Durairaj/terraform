# General
location            = "canadacentral"
resource_group_name = "dhdp-lab-resource-group"
tenant_id           = "c25c5028-2135-4990-9b82-d8c62774306a"

tags = {
  Environment = "QA"
  Project     = "DHDP"
  ManagedBy   = "Terraform"
}

# Virtual Network
vnet_name     = "dhdp-qa-vnet"
address_space = ["10.31.0.0/16"]

subnets = {
  "aks-subnet"         = ["10.31.1.0/24"]
  "appgw-subnet"       = ["10.31.64.0/24"]
  "AzureBastionSubnet" = ["10.31.80.0/27"]
  "webapp-subnet"      = ["10.31.96.0/24"]
}

# NSG
nsg_name = "dhdp-qa-nsg"

nsg_security_rules = [
  {
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
]

# Public IPs
public_ip_nginx_name   = "dhdp-qa-nginx-ingress-pip"
public_ip_bastion_name = "dhdp-qa-bastion-pip"

# NAT Gateway & Bastion
nat_gateway_name = "dhdp-qa-natgw"
bastion_name     = "dhdp-qa-bastion"

# Private DNS
private_dns_name      = "privatelink.azurecr.io"
private_dns_link_name = "acr-dns-link"

# VNet Peering
vnet_peering_name         = "dhdp-qa-peering"
remote_virtual_network_id = "/subscriptions/accf2f42-1262-48a4-8ab5-980bdf8aa8b8/resourceGroups/dhdp-mgmt-resource-group/providers/Microsoft.Network/virtualNetworks/dhdp-mgmt-vnet"

# Key Vault & Encryption
key_vault_name   = "dhdp-qa-kv-unique"
des_name         = "dhdp-qa-des"
key_vault_key_id = "https://dhdp-qa-kv-unique.vault.azure.net/keys/dhdp-qa-acr-cmk-key/d362cbd7f7e349ceaa138e143f608321"

# Backup
backup_vault_name = "dhdp-qa-backup-vault"

# ACR
acr_name = "dhdpqaacr1221"

# AKS
aks_name            = "dhdp-qa-aks"
dns_prefix          = "dhdpqa"
kubernetes_version  = "1.32.3"
node_resource_group = "MC_dhdp-qa-resource-group_dhdp-qa-aks_canadacentral"

default_node_pool = {
  name                        = "system"
  vm_size                     = "Standard_DS2_v2"
  temporary_name_for_rotation = "system-temp"
  enable_auto_scaling         = true
  min_count                   = 1
  max_count                   = 3
  node_count                  = 1
  max_pods                    = 30
  os_disk_size_gb             = 50
  type                        = "System"
  node_labels                 = { type = "system" }
  tags                        = {}
  vnet_subnet_id              = ""  # Always empty here; set in main.tf
  availability_zones          = ["1", "2", "3"]
}

user_node_pools = {
  bitnobi = {
    name                = "bitnobi"
    vm_size             = "Standard_DS3_v2"
    os_disk_size_gb     = 100
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 3
    node_count          = 1
    max_pods            = 60
    mode                = "User"
    node_labels         = { app = "bitnobi" }
    vnet_subnet_id      = ""  # Always empty in tfvars!
    tags                = { app = "bitnobi" }
    taints              = ["app=bitnobi:NoSchedule"]
    availability_zones  = ["1", "2", "3"]
  }

  candig = {
    name                = "candig"
    vm_size             = "Standard_DS2_v3"
    os_disk_size_gb     = 50
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 3
    node_count          = 1
    max_pods            = 30
    mode                = "User"
    node_labels         = { app = "candig" }
    vnet_subnet_id      = ""
    tags                = { app = "candig" }
    taints              = ["app=candig:NoSchedule"]
    availability_zones  = ["1", "2", "3"]
  }

  keycloak = {
    name                = "keycloak"
    vm_size             = "Standard_DS2_v3"
    os_disk_size_gb     = 50
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 2
    node_count          = 1
    max_pods            = 30
    mode                = "User"
    node_labels         = { app = "keycloak" }
    vnet_subnet_id      = ""
    tags                = { app = "keycloak" }
    taints              = ["app=keycloak:NoSchedule"]
    availability_zones  = ["1", "2", "3"]
  }

  integrateai = {
    name                = "integrateai"
    vm_size             = "Standard_DS2_v3"
    os_disk_size_gb     = 50
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 2
    node_count          = 1
    max_pods            = 30
    mode                = "User"
    node_labels         = { app = "integrateai" }
    vnet_subnet_id      = ""
    tags                = { app = "integrateai" }
    taints              = ["app=integrateai:NoSchedule"]
    availability_zones  = ["1", "2", "3"]
  }

  webapp = {
    name                = "webapp"
    vm_size             = "Standard_DS2_v3"
    os_disk_size_gb     = 50
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 2
    node_count          = 1
    max_pods            = 30
    mode                = "User"
    node_labels         = { app = "webapp" }
    vnet_subnet_id      = ""
    tags                = { app = "webapp" }
    taints              = ["app=webapp:NoSchedule"]
    availability_zones  = ["1", "2", "3"]
  }
}

# AKS Networking
network_plugin     = "azure"
dns_service_ip     = "10.2.0.10"
service_cidr       = "10.2.0.0/24"
docker_bridge_cidr = "172.17.0.1/16"

# Monitoring and Security
log_analytics_name              = "dhdp-qa-log"
log_retention                   = 30
enable_monitoring               = true
private_cluster_enabled         = false
api_server_authorized_ip_ranges = []


module "app_gateway" {
  source              = "../../terraform_modules/terraform-azure-app-gateway"
  name                = "dhdp-qa-appgw"
  location            = var.location
  resource_group_name = var.resource_group_name

  # Use the dedicated subnet for App Gateway from your vnet module
  subnet_id           = module.vnet.subnet_ids["appgw-subnet"]

  # Public IP for the Application Gateway frontend
  public_ip_id        = module.public_ip_nginx.public_ip_id

  # Frontend port (HTTP 80 example)
  frontend_port       = 80

  # Backend IP addresses (replace with your actual AKS Ingress Controller/private service IPs)
  backend_ip_addresses = ["10.31.1.4"]  # <-- Replace with your real backend IP(s) or output

  # Backend HTTP settings
  backend_port        = 80

  # SKU for WAF v2
  sku_name            = "WAF_v2"
  sku_tier            = "WAF_v2"
  capacity            = 2

  # Attach your WAF policy here
  firewall_policy_id  = module.waf_policy.id

  tags                = var.tags
}





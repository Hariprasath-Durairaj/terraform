# General Variables
location            = "canadacentral"
resource_group_name = "dhdp-lab-resource-group"
tenant_id           = "c25c5028-2135-4990-9b82-d8c62774306a"

tags = {
  Environment = "QA"
  Project     = "DHDP"
  ManagedBy   = "Terraform"
}

# Virtual Network (VNet)
vnet_name     = "dhdp-qa-vnet"
address_space = ["10.31.0.0/16"]

subnets = {
  "aks-subnet"         = ["10.31.1.0/24"]
  "appgw-subnet"       = ["10.31.64.0/24"]
  "AzureBastionSubnet" = ["10.31.80.0/27"]
  "webapp-subnet"      = ["10.31.96.0/24"]
}

# Network Security Group (NSG)
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

# Public IPs (for NGINX Ingress)
public_ip_nginx_name   = "dhdp-qa-nginx-ingress-pip"
public_ip_bastion_name = "dhdp-qa-bastion-pip"

# NAT Gateway
nat_gateway_name = "dhdp-qa-natgw"

# Bastion
bastion_name = "dhdp-qa-bastion"

# Private DNS
private_dns_name      = "privatelink.azurecr.io"
private_dns_link_name = "acr-dns-link"

# VNet Peering
vnet_peering_name           = "dhdp-qa-peering"
remote_virtual_network_id    = "/subscriptions/accf2f42-1262-48a4-8ab5-980bdf8aa8b8/resourceGroups/dhdp-mgmt-resource-group/providers/Microsoft.Network/virtualNetworks/dhdp-mgmt-vnet"

# Key Vault and Encryption
key_vault_name           = "dhdp-qa-kv-unique"
disk_encryption_set_name = "dhdp-qa-des"
key_vault_key_id         = "https://dhdp-qa-kv-unique.vault.azure.net/keys/dhdp-qa-acr-cmk-key/d362cbd7f7e349ceaa138e143f608321"

# Azure Container Registry (ACR)
acr_name = "dhdpqaacr1221"

# AKS Cluster Configuration
aks_name            = "dhdp-qa-aks"
dns_prefix          = "dhdpqa"
kubernetes_version  = "1.32.3"
node_resource_group = "MC_dhdp-qa-resource-group_dhdp-qa-aks_canadacentral"

# Default Node Pool Configuration
default_node_pool = {
  name                = "system"
  vm_size             = "Standard_DS2_v2"
  enable_auto_scaling = true
  min_count           = 1
  max_count           = 3
  max_pods            = 30
  os_disk_size_gb     = 50   # Correct number value here
  type                = "System"
  node_labels         = { type = "system" }
  tags                = {}
  aks_subnet_id = "/subscriptions/accf2f42-1262-48a4-8ab5-980bdf8aa8b8/resourceGroups/dhdp-lab-resource-group/providers/Microsoft.Network/virtualNetworks/dhdp-qa-vnet/subnets/aks-subnet"
  vnet_subnet_id      = "/subscriptions/accf2f42-1262-48a4-8ab5-980bdf8aa8b8/resourceGroups/dhdp-lab-resource-group/providers/Microsoft.Network/virtualNetworks/dhdp-qa-vnet/subnets/aks-subnet"
}



# User Node Pools Configuration
user_node_pools = {
  bitnobi = {
    name                = "bitnobi"
    vm_size             = "Standard_DS3_v2"
    os_disk_size_gb     = 100
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 3
    max_pods            = 60
    mode                = "User"
    node_labels         = { app = "bitnobi" }
    vnet_subnet_id      = var.aks_subnet_id
    tags                = { app = "bitnobi" }
    taints              = ["app=bitnobi:NoSchedule"]
  },

  candig = {
    name                = "candig"
    vm_size             = "Standard_DS2_v3"
    os_disk_size_gb     = 50
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 3
    max_pods            = 30
    mode                = "User"
    node_labels         = { app = "candig" }
    vnet_subnet_id      = var.aks_subnet_id
    tags                = { app = "candig" }
    taints              = ["app=candig:NoSchedule"]
  },

  keycloak = {
    name                = "keycloak"
    vm_size             = "Standard_DS2_v3"
    os_disk_size_gb     = 50
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 2
    max_pods            = 30
    mode                = "User"
    node_labels         = { app = "keycloak" }
    vnet_subnet_id      = var.aks_subnet_id
    tags                = { app = "keycloak" }
    taints              = ["app=keycloak:NoSchedule"]
  },

  integrateai = {
    name                = "integrateai"
    vm_size             = "Standard_DS2_v3"
    os_disk_size_gb     = 50
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 2
    max_pods            = 30
    mode                = "User"
    node_labels         = { app = "integrateai" }
    vnet_subnet_id      = var.aks_subnet_id
    tags                = { app = "integrateai" }
    taints              = ["app=integrateai:NoSchedule"]
  },

  webapp = {
    name                = "webapp"
    vm_size             = "Standard_DS2_v3"
    os_disk_size_gb     = 50
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 2
    max_pods            = 30
    mode                = "User"
    node_labels         = { app = "webapp" }
    vnet_subnet_id      = var.aks_subnet_id
    tags                = { app = "webapp" }
    taints              = ["app=webapp:NoSchedule"]
  }
}


# Network Plugin and Service CIDR for AKS
network_plugin     = "azure"
dns_service_ip     = "10.2.0.10"
service_cidr       = "10.2.0.0/24"
docker_bridge_cidr = "172.17.0.1/16"

# Log Analytics
log_analytics_name = "dhdp-qa-log"
log_retention      = 30

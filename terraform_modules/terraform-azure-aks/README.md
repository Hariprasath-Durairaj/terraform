# Azure Kubernetes Service (AKS) Terraform Module

This module provisions an Azure Kubernetes Service (AKS) cluster with a configurable default node pool and network profile.

## Usage

```hcl
module "aks" {
  source              = "../terraform-azure-aks"
  name                = "dhdp-qa-aks"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "dhdpqa"
  kubernetes_version  = "1.27.3"
  node_resource_group = "MC_dhdp-qa-rg_dhdp-qa-aks_canadacentral"
  default_node_pool   = var.default_node_pool
  network_plugin      = "azure"
  dns_service_ip      = "10.2.0.10"
  service_cidr        = "10.2.0.0/24"
  docker_bridge_cidr  = "172.17.0.1/16"
  tags                = var.tags
}
```

## Outputs

- `aks_id` — ID of the AKS cluster
- `kube_config` — Raw kubeconfig output (sensitive)
- `kube_config_file` — Config elements for kubectl access
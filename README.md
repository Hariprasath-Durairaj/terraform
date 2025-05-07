
# DHDP Infrastructure (dhdp-infra)

## Overview

The DHDP Infrastructure repository provides an Infrastructure as Code (IaC) solution, enabling efficient and standardized management of Azure Kubernetes Service (AKS) environments through Terraform, deployment automation via Ansible, and comprehensive CI/CD automation with Azure DevOps Pipelines.

---

## 🚀 Repository Structure

```
dhdp-infra/
├── .azure-pipelines/
│   ├── azure-pipelines.yml
│   └── templates/
│       ├── terraform-init.yml
│       ├── terraform-plan.yml
│       └── terraform-apply.yml
│
├── environments/
│   ├── development/
│   │   ├── backend.tf
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── version.tf
│   │   ├── outputs.tf
│   │   └── terraform.tfvars
│   ├── qa/
│   │   ├── backend.tf
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── version.tf
│   │   ├── outputs.tf
│   │   └── terraform.tfvars
│   └── production/
│       ├── backend.tf
│       ├── main.tf
│       ├── variables.tf
│       ├── version.tf
│       ├── outputs.tf
│       └── terraform.tfvars
│
├── modules/
│   ├── aks/
│   ├── network/
│   ├── compute/
│   ├── storage/
│   └── labels/
│
├── ansible/
│   ├── inventories/
│   │   ├── development.ini
│   │   ├── qa.ini
│   │   └── production.ini
│   ├── playbooks/
│   │   └── deploy-app.yml
│   └── roles/
│       ├── common/
│       ├── monitoring/
│       └── your-app/
│
├── docs/
│   └── infrastructure_guide.md
│
├── README.md
├── .gitignore
└── LICENSE
```

---

## 🔧 Prerequisites

- Terraform >= 1.6.6
- Azure CLI authenticated to appropriate subscriptions
- Ansible >= 4.x
- Azure DevOps Service Connection (`terraform-spn-aks`) with Contributor access
- SSH keys securely configured in Azure DevOps

---

## 🏁 Deployment Procedures

### Clone Repository
```bash
git clone git@ssh.dev.azure.com:v3/dhdp-tfri/DHDP-TFRI/dhdp-infra
cd dhdp-infra
```

### Terraform Initialization and Deployment (e.g., QA Environment)
```bash
cd environments/qa

# Initialize Terraform backend
terraform init \
  -backend-config="resource_group_name=rg-dhdp-qa" \
  -backend-config="storage_account_name=stacctdhdpqa" \
  -backend-config="container_name=tfstate" \
  -backend-config="key=qa.tfstate"

# Validate and Plan Terraform
terraform validate
terraform plan -var-file=terraform.tfvars

# Apply Terraform configuration
terraform apply -var-file=terraform.tfvars
```

### CI/CD with Azure DevOps Pipelines

#### Pipeline Structure:
- Initialization: Validates Terraform code and initializes state.
- Plan: Securely generates and publishes infrastructure plan.
- Apply: Manual gate approval for applying infrastructure changes.

#### Setting Up Azure DevOps Pipelines:
- Navigate to Azure DevOps → Pipelines → New pipeline.
- Select the YAML configuration file: `/.azure-pipelines/azure-pipelines.yml`.

### Application Deployment using Ansible
```bash
cd ansible
ansible-playbook \
  -i inventories/qa.ini \
  playbooks/deploy-app.yml \
  --extra-vars "@../environments/qa/terraform.tfvars"
```

Ansible roles will manage:
- Container image deployments
- Kubernetes deployments
- Database migrations and configurations

---

## ⚙️ Terraform Modules

Detailed modular Terraform components are documented individually within their directories in `modules/`:
- AKS Clusters
- Managed Identities
- RBAC settings
- Network architecture

---

## 🤝 Workflow

1. Branch from `main`.
2. Implement required changes (Terraform modules, pipeline templates, Ansible playbooks).
3. Commit, push changes, and initiate a Pull Request.
4. Code changes are automatically validated and linted.
5. Obtain code review and merge upon approval.

---


# Azure DevOps CI/CD Pipeline for Infrastructure as Code (Terraform)

An automated Azure DevOps multi-stage CI/CD pipeline designed to validate, plan, and deploy Azure infrastructure using Terraform and remote backend state management.

---

## Architecture Overview

This project provisions a hub-and-spoke networking topology in Azure using Terraform and Azure DevOps:

* **Networking:** Virtual Network (`vnet-app`) with dedicated subnets for Application Gateway (`10.0.1.0/24`) and App Service (`10.0.2.0/24`).
* **Ingress & Compute:** Azure Application Gateway (`Standard_v2` SKU) routing HTTP/80 traffic to a Linux Web App (`P1v2` App Service Plan).
* **State Management:** Secure remote backend stored in an Azure Blob Storage container.

---

## Prerequisites

1. **Azure DevOps Marketplace Plugin:** Install the [HashiCorp Terraform Extension](https://marketplace.visualstudio.com/items?itemName=ms-devlabs.custom-terraform-tasks&utm_source=gemini) into your Azure DevOps organization.
2. **Azure Service Connection:** Create an Azure Resource Manager Service Connection (Service Principal with `Contributor` role access at the subscription level).
3. **Backend Storage Account:** Provision an Azure Blob Storage account to host the `.tfstate` file (can be done via VS Code using Azure CLI or local Terraform CLI).

---

## Configuration & Pipeline Variables

Ensure the following pipeline variables (or Variable Group entries) are configured in Azure DevOps:

| Variable Name | Example Value | Description |
| --- | --- | --- |
| `serviceConnection` | `devtest-service-connection` | Name of the Azure DevOps ARM Service Connection |
| `tfResourceGroup` | `rg-tf-backend` | Resource Group containing the storage account |
| `tfStorageAccount` | `sttfstate1234` | Azure Storage Account name for Terraform backend |
| `tfContainerName` | `tfstate` | Storage Container name for state files |
| `tfStateKey` | `devpipeline.terraform.tfstate` | Blob file name for storing `.tfstate` |

---

## Deployment Procedure

### 1. Repository Setup

Clone or import all project files (`main.tf`, `variables.tf`, `outputs.tf`, `providers.tf`, and `azure-pipelines.yml`) into your Azure DevOps Repository or linked GitHub Repository.

### 2. Branching & Pipeline Creation

1. Create a feature or deployment branch (e.g., `feature/deploy-infra`).
2. Navigate to **Azure DevOps > Pipelines** and select **New Pipeline**.
3. Select your repository location and select **Existing Azure Pipelines YAML file** pointing to `azure-pipelines.yml`.

### 3. Dry-Run (Validation & Planning Phase)

1. Run the pipeline against the `tfvalidate` and `tfplan` stages.
2. Verify that `terraform plan` completes cleanly without validation or permission errors.
3. Review the generated deployment plan output in the job execution logs.

### 4. Infrastructure Deployment (Apply Phase)

1. Select **Run Pipeline** and pass your desired environment parameter (`dev`, `uat`, or `prod`).
2. Upon reaching the **Terraform Apply** stage, review the pipeline environment approval gate (if configured).
3. Approve the deployment run and wait for `terraform apply` to finish executing.
4. Verify created resources directly inside the Azure Portal or via Azure CLI (`az group show --name rg-appgw-webapp`).

---

## Repository Structure

├── azure-pipelines.yml  # Multi-stage CI/CD pipeline definition (Validate -> Plan -> Apply)
├── main.tf              # Primary infrastructure definitions (VNet, App Gateway, Web App)
├── outputs.tf           # Output values (App Gateway Public IP, Web App Hostname)
├── providers.tf         # Terraform required providers and AzureRM configuration
└── variables.tf         # Input variable declarations

```

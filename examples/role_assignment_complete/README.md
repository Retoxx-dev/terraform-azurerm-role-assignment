# Azure Role Assignment Module

Terraform module that assigns `BUILT IN` IAM roles to groups, service principals and users.

## Usage

```hcl
# Configure the Azure provider
provider "azurerm" {
  features {}
}

# Create a resource group to reference it in the role assignments module
resource "azurerm_resource_group" "this" {
  name     = "rg-terraform-northeu-001"
  location = "northeurope"
}

# Create a log analytics workspace to reference it in the role assignments module
resource "azurerm_log_analytics_workspace" "this" {
  name                = "log-terraform-northeu-001"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# Use the role assignments module to assign roles to groups, service principals and users
module "role_assignments" {
  source = "retoxx-dev/role-assignment/azurerm"

  role_assignments = [
    {
      scope       = azurerm_resource_group.this.id
      group_names = ["group1", "group2", "group3"]
      role_names  = ["Reader", "Web Plan Contributor"]
    },
    {
      scope      = azurerm_log_analytics_workspace.this.id
      sp_names   = ["spname1", "spname2", "spname3"]
      role_names = ["Reader", "Web Plan Contributor"]
    },
    {
      scope                = azurerm_resource_group.this.id
      user_principal_names = ["user1@contoso.com", "user2@contoso.com"]
      role_names           = ["Reader", "Web Plan Contributor"]
    },
    {
      scope         = azurerm_log_analytics_workspace.this.id
      principal_ids = ["xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"]
      role_names    = ["Reader"]
    }
  ]
}
```

## Terraform

To run this example you need to execute:

```bash
terraform init
terraform plan
terraform apply
```

You can destroy created resources with `terraform destroy`.
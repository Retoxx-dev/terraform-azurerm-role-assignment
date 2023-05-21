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

# Use the role assignments module to assign roles to service principals
module "role_assignments" {
  source = "retoxx-dev/role-assignment/azurerm"

  scope = azurerm_resource_group.this.id

  role_assignments = [
    {
      sp_names   = ["spname1", "spname2", "spname3"]
      role_names = ["Reader", "Web Plan Contributor"]
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
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "this" {
  name     = "rg-terraform-northeu-001"
  location = "northeurope"
}

module "role_assignments" {
  source  = "retoxx-dev/role-assignment/azurerm"
  version = "1.0.1"

  role_assignments = [
    {
      scope      = azurerm_resource_group.this.id
      sp_names   = ["spname1", "spname2", "spname3"]
      role_names = ["Reader", "Web Plan Contributor"]
    }
  ]
}
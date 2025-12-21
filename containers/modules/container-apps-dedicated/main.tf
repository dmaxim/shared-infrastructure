
data "azurerm_resource_group" "container_apps" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_log_analytics_workspace" "container_apps" {
  name                = join("-", ["law", var.namespace, var.environment, var.location_abbreviation])
  location            = data.azurerm_resource_group.container_apps.location
  resource_group_name = data.azurerm_resource_group.container_apps.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = var.tags
}


resource "azurerm_subnet" "container_apps_subnet_primary" {
  name                 = join("-", ["snet", var.namespace, var.environment, var.location_abbreviation])
  resource_group_name  = data.azurerm_resource_group.container_apps.name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.subnet_address_prefixes

  delegation {
    name = "container-environment"
    service_delegation {
      name = "Microsoft.App/environments"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }

}

resource "azurerm_container_app_environment" "container_apps_primary" {
  name                       = join("-", ["cae", var.namespace, var.environment, var.location_abbreviation])
  location                   = data.azurerm_resource_group.container_apps.location
  resource_group_name        = data.azurerm_resource_group.container_apps.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.container_apps.id
  infrastructure_subnet_id   = azurerm_subnet.container_apps_subnet_primary.id

  # dapr {
  #     enabled = true
  #     app_port = 80
  # }
  tags = var.tags


  workload_profile {
    name                  = "mxinfo-001"
    workload_profile_type = "D4"
    maximum_count         = var.maximum_vm_count
    minimum_count         = var.minimum_vm_count
  }
}

# resource "azurerm_resource_group" "observability" {
#   name     = join("-", ["rg", var.namespace, var.environment, var.location_abbreviation])
#   location = var.location
#   tags = {
#     environment = var.environment

#   }
# }
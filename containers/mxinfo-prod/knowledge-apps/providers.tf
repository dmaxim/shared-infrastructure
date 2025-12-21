provider "azuread" {
  tenant_id = var.tenant_id
}

provider "azurerm" {
  alias = "verida-prod"
  features {}
  subscription_id = var.prod_subscription_id
}

# provider "kubernetes" {

#   config_path    = var.kube_config_path
#   config_context = var.kube_config_context
# }

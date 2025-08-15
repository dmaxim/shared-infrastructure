resource "azurerm_resource_group" "pact_broker" {
  name     = join("-", ["rg", var.namespace, var.environment, var.location_abbreviation])
  location = var.location

  tags = local.tags
}

resource "azurerm_user_assigned_identity" "pact_broker" {
  location            = azurerm_resource_group.pact_broker.location
  name                = join("-", [var.service_account_name, var.environment, var.location_abbreviation])
  resource_group_name = azurerm_resource_group.pact_broker.name
}


resource "kubernetes_namespace" "pact_broker" {
  metadata {
    name = var.kubernetes_namespace
  }
}

resource "kubernetes_service_account" "pact_broker" {
  metadata {
    name      = var.service_account_name
    namespace = var.kubernetes_namespace
    annotations = {
      "azure.workload.identity/client-id" = azurerm_user_assigned_identity.pact_broker.client_id
    }
  }

  }

resource "azurerm_federated_identity_credential" "pact_broker" {
  name                = "pact-broker-poc"
  resource_group_name = azurerm_resource_group.pact_broker.name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = var.oidc_issuer_url
  parent_id           = azurerm_user_assigned_identity.pact_broker.id
  subject             = "system:serviceaccount:pact-broker-poc:pact-broker"
}


data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "pact_broker" {
  name                        = join("-", ["kv", var.namespace])
  location                    = azurerm_resource_group.pact_broker.location
  resource_group_name         = azurerm_resource_group.pact_broker.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = "standard"

  tags = local.tags

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }
}

resource "azurerm_key_vault_access_policy" "pact_broker_managed_identity" {
  key_vault_id = azurerm_key_vault.pact_broker.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_user_assigned_identity.pact_broker.principal_id

  secret_permissions = [
    "Get",
    "List",
  ]
}

resource "azurerm_key_vault_access_policy" "secret_managers" {
  for_each = local.key_vault_secret_managers

  key_vault_id = azurerm_key_vault.pact_broker.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = each.value.object_id

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Recover",
    "Backup",
    "Restore",
    "Purge",
  ]
}

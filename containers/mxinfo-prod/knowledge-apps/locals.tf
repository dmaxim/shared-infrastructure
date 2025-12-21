
data "azuread_user" "dan_maxim" {
  user_principal_name = "dmaxim@mxinformatics.com"
}


locals {
  tags = {
    "environment" = var.environment
    "application" = "mxinfo-bio-apps"

  }

  key_vault_secret_managers = {
    dan_maxim = {
      object_id = data.azuread_user.dan_maxim.object_id
    }
  }


  default_node_pool = {
    name          = "mx01"
    node_count    = 2
    vm_size       = var.default_node_pool_vm_size
    subnet_index  = 1
    max_pod_count = 70
  }

  node_pools = {
    pool_two = {
      name          = "mx02"
      node_count    = 1
      vm_size       = var.default_node_pool_vm_size
      environment   = var.environment
      subnet_index  = 2
      max_pod_count = 70
    }
  }
}
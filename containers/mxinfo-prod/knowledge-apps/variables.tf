# infrastructure/azure/variables.tf

variable "namespace" {
  type        = string
  description = "Namespace for resource names"
  default     = "mxinfo-bio-apps"
}

variable "environment" {
  type        = string
  description = "Environment used in resource names"
  default     = "prod"
}

variable "location" {
  type        = string
  description = "Azure Region for resources"
  default     = "eastus"
}

variable "location_abbreviation" {
  type        = string
  description = "Azure Region abbreviation used in resource names"
  default     = "eus"
}

variable "prod_subscription_id" {
  type        = string
  description = "Azure Subscription ID for production resources"

}

variable "tenant_id" {
  type        = string
  description = "Azure Tenant ID"

}

variable "key_vault_name" {
  type        = string
  description = "Key Vault name"
  default     = "kv-mxinfo-bio-prod"
}


variable "vnet_address_space" {
  type        = list(string)
  description = "CIDR address space for the virtual network"
  default     = ["10.130.0.0/20"]
}


variable "default_node_pool_vm_size" {
  type        = string
  description = "Default VM Size"
  default     = "Standard_D4ds_V5"
}

variable "small_node_pool_vm_size" {
  type        = string
  description = "Small VM Size"
  default     = "Standard_D2ds_V5"
}


variable "k8s_version" {
  type        = string
  description = "Kubernetes version to use for the cluster"
  default     = "1.33.5"
}

variable "authorized_ips" {
  type        = list(string)
  description = "IP Addresses with access to the cluster API"
  sensitive   = true
}

variable "admin_group_id" {
  type        = string
  description = "The Azure AD group ID for the admin group"
  default     = "2abd3702-0398-4173-af6b-d7bb9914005c"
}


# Container Apps Variables
variable "container_apps_subnet_address_prefixes" {
  type        = list(string)
  description = "The address prefixes for the Container Apps subnet."
  default     = ["10.130.16.0/24"]
}

variable "container_apps_maximum_vm_count" {
  type        = number
  description = "The maximum number of VMs for the Container Apps workload profile."
  default     = 3
}

variable "container_apps_minimum_vm_count" {
  type        = number
  description = "The minimum number of VMs for the Container Apps workload profile."
  default     = 1
}

# variable "kube_config_path" {
#   type        = string
#   description = "Path to kube config file"
#   default     = "~/.kube/config"
# }

# variable "kube_config_context" {
#   type        = string
#   description = "Kube config context to use"
#   default     = "aks-mxinfo-bio-prod-eus-admin"

# }

# variable "kubernetes_namespace" {
#   type        = string
#   description = "Kubernetes namespace for the application"
#   default     = "kb-applications"
# }

# variable "service_account_name" {
#   type        = string
#   description = "Kubernetes service account name"
#   default     = "kb-applications"
# }

# variable "oidc_issuer_url" {
#   type        = string
#   description = "OIDC issuer URL for the AKS cluster"

# }


# variable "cert_manager_namespace" {
#   type        = string
#   description = "Kubernetes namespace where cert-manager is installed"
#   default     = "cert-manager"
# }

# variable "cert_manager_service_account_name" {
#   type        = string
#   description = "Kubernetes service account name for cert-manager"
#   default     = "cert-manager"

# }

# variable "dns_zone_name" {
#   type        = string
#   description = "DNS Zone name"
#   default     = "veridadev.com"
# }
# variable "dns_zone_resource_group" {
#   type        = string
#   description = "Resource group name where the DNS Zone is located"
#   default     = "rg-verida-dns"
# }


# variable "asb_sender_role_id" {
#   type        = string
#   description = "The role ID for the Azure Service Bus Data Sender role"
#   default     = "69a216fc-b8fb-44d8-bc22-1f3c2cd27a39" # Azure Service Bus Data Sender
# }

# variable "asb_receiver_role_id" {
#   type        = string
#   description = "The role ID for the Azure Service Bus Data Receiver role"
#   default     = "4f6d3b9b-027b-4f4c-9142-0e5a2a2247e0" # Azure Service Bus Data Receiver
# }

# variable "asb_data_owner_role_id" {
#   type        = string
#   description = "The role ID for the Azure Service Bus Data Owner role"
#   default     = "090c5cfd-751d-490a-894a-3ce6f1109419" # Azure Service Bus Data Owner
# }
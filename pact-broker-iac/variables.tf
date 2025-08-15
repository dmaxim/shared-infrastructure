# infrastructure/azure/variables.tf

variable "namespace" {
  type        = string
  description = "Namespace for resource names"
  default     = "mxinfo-pact-broker"
}

variable "environment" {
  type        = string
  description = "Environment used in resource names"
  default     = "poc"
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

variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID"

}

variable "tenant_id" {
  type        = string
  description = "Azure Tenant ID"

}


variable "oidc_issuer_url" {
  type        = string
  description = "OIDC issuer URL for the AKS cluster"

}

variable "service_account_name" {
  type        = string
  description = "Service account name for the Pact Broker"
  default     = "pact-broker"
}

variable "kube_config_path" {
  type        = string
  description = "Path to the kube config file to use when deploying to the cluster"
  default     = "~/.kube/config"
}

variable "kube_config_context" {
  type        = string
  description = "Context name from the kube config file for deploying to the cluster"
  default     = "aks-mxinfo-apps-poc-eus-admin"
}

variable "kubernetes_namespace" {
  type        = string
  description = "Kubernetes namespace to deploy the Pact Broker"
  default     = "pact-broker-poc"
}
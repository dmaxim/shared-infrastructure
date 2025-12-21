terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.35.0"


    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.31.0"
    }
  }

}

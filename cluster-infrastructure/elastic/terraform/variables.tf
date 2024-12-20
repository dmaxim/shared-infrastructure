variable "namespace" {
  type        = string
  description = "Namespace for resource names"
  default     = "mxinfo-obs"
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

#--- modules/aks-cluster/outputs.tf ---#

output "virtual_network_name" {
  description = "Name of the virtual network created for the AKS cluster"
  value       = azurerm_virtual_network.cluster_network.name
}

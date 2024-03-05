output "ssh_access" {
  value = "ssh redhat@${azurerm_public_ip.public_ip.ip_address}"
  description = "SSH Access"
}

output "public_ip" {
  value = azurerm_public_ip.public_ip.ip_address
  description = "Virtual Machine Public IP address"
}

output "private_ip" {
  value = azurerm_network_interface.network_interface.private_ip_address
  description = "Virtual Machine Private IP address"
}
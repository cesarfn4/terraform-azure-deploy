output "public_ip" {
  value       = azurerm_public_ip.public_ip.ip_address
  description = "Virtual Machine Public IP address"
}
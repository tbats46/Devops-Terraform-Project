output "app_gateway_public_ip" {
  value       = azurerm_public_ip.appgw_pip.ip_address
  description = "The public IP address of the Application Gateway."
}

output "web_app_default_hostname" {
  value       = azurerm_linux_web_app.webapp.default_hostname
  description = "The default hostname of the Web App."
}
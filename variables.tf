variable "location" {
  type        = string
  default     = "canadacentral"
  description = "Azure region"
}

variable "rg_name" {
  type        = string
  default     = "rg-appgw-webapp"
  description = "Resource group name"
}

variable "vnet_name" {
  type        = string
  default     = "vnet-app"
}

variable "vnet_address_space" {
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "appgw_subnet_name" {
  type        = string
  default     = "subnet-appgw"
}

variable "appgw_subnet_prefix" {
  type        = string
  default     = "10.0.1.0/24"
}

variable "appsvc_subnet_name" {
  type        = string
  default     = "subnet-appsvc"
}

variable "appsvc_subnet_prefix" {
  type        = string
  default     = "10.0.2.0/24"
}

variable "app_service_plan_name" {
  type        = string
  default     = "asp-webapp"
}

variable "web_app_name" {
  type        = string
  default     = "mywebapp-astro"
}

variable "app_gateway_name" {
  type        = string
  default     = "agw-webapp"
}

variable "waf_policy_name" {
  type        = string
  default     = "wafpolicy-webapp"
}

variable "app_gateway_public_ip_name" {
  type        = string
  default     = "pip-appgw"
}

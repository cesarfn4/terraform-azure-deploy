variable "resource_group" {
  type = string
  description = "Azure Resource Group name"
  default = "openenv-vcxnt"
}

variable "location" {
  type = string
  description = "Azure location"
  default = "West Europe"
}

variable "instance_name" {
  type = string
  description = "Azure instance name"
  default = "terraform"
}

variable "instance_type" {
  type = string
  description = "Azure instance type"
  default = "Standard_B1ms"
}

variable "admin_password" {
  type = string
  description = "Admin Password"
  default = "T3mP0r4L!1213"
}

variable "sku" {
  type = string
  description = "Azure instance sku"
  default = "9-lvm-gen2"
}
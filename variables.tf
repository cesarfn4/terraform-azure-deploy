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

variable "sku" {
  type = string
  description = "Azure instance sku"
  default = "9-lvm-gen2"
}

variable "ssh_key" {
  type = string
  description = "SSH key"
}

variable "instance_type" {
  type = string
  description = "Azure instance type"
  default = "Standard_B1ms"
}

variable "instance_name" {
  type = string
  description = "Azure instance name"
  default = "terraform"
}
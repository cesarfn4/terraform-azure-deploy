resource "azurerm_ssh_public_key" "ssh_key" {
  name                = "${var.instance_name}-key"
  resource_group_name = var.resource_group
  location            = var.location
  public_key          = var.ssh_key
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.instance_name}-net"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.instance_name}-subnet"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "public_ip" {
  name                = "${var.instance_name}-ip"
  resource_group_name = var.resource_group
  location            = var.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "network_interface" {
  name                = "${var.instance_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_network_security_group" "nsg" {
  name                = "${var.instance_name}-nsg"
  location            = var.location
  resource_group_name = var.resource_group

  security_rule {
    name                       = "SSH"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.instance_name
  resource_group_name = var.resource_group
  location            = var.location
  size                = var.instance_type
  admin_username      = "redhat"
  network_interface_ids = [
    azurerm_network_interface.network_interface.id,
  ]

  admin_ssh_key {
    username   = "redhat"
    public_key = azurerm_ssh_public_key.ssh_key.public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = var.sku
    version   = "latest"
  }
}
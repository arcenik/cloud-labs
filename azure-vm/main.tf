resource "azurerm_resource_group" "main" {
  name = "${var.name}-rg"
  location = var.region
  tags = var.tags
}

resource "azurerm_virtual_network" "main" {
  name = "${var.name}-network"
  address_space = ["10.0.0.0/16"]
  location = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags = var.tags
}

resource "azurerm_subnet" "main" {
  name = "${var.name}-internal-subnet"
  address_prefixes = ["10.0.0.0/24"]
  resource_group_name = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
}

resource "azurerm_network_security_group" "main" {
  #checkov:skip=CKV_AZURE_10:Direct SSH access for lab without bastion/vpn
  name                = "acceptanceTestSecurityGroup1"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name                       = "inbound-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Production"
  }
}

resource "azurerm_subnet_network_security_group_association" "main" {
  subnet_id = azurerm_subnet.main.id
  network_security_group_id = azurerm_network_security_group.main.id
}

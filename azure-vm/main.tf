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

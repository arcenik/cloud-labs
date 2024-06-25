resource "azurerm_resource_group" "main" {
  name = "${var.name}-rg"
  location = var.region
  tags = var.tags
}

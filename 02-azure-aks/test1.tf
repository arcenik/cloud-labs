resource "azurerm_kubernetes_cluster" "test1" {
  name                = "${var.name}-aks-test1"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = "${var.name}-aks-test1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  local_account_disabled = false

  #
  # https://github.com/Azure/AKS/issues/1172
  #
  # linux_profile {
  #   admin_username = "fs"
  #   ssh_key {
  #     key_data = file("~/.ssh/id_ed25519.pub")
  #   }
  # }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      default_node_pool # .upgrade_settings
    ]
  }

}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.test1.kube_config[0].client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.test1.kube_config_raw
  sensitive = true
}

output "get_credentials_command" {
  value = "az aks get-credentials --resource-group ${azurerm_resource_group.main.name} --name ${azurerm_kubernetes_cluster.test1.name}"
}

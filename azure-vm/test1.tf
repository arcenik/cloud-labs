resource "azurerm_public_ip" "test1" {
  name = "${var.name}-test1-ip"
  location = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method = "Static"
  tags = var.tags
}

resource "azurerm_network_interface" "test1" {
  name = "${var.name}-test1-nic"
  location = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  ip_configuration {
    name = "test1"
    subnet_id = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.test1.id
  }
  tags = var.tags
}

resource "azurerm_virtual_machine" "test1" {
  name = "${var.name}-test1-vm"
  location = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  network_interface_ids = [
    azurerm_network_interface.test1.id
  ]
  vm_size = "Standard_A1_v2"

  delete_os_disk_on_termination = true
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  storage_os_disk {
    name              = "test1-os-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
    
  }

  os_profile {
    computer_name = "test1"
    admin_username = "fs"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = file("~/.ssh/id_ed25519.pub")
      path = "/home/fs/.ssh/authorized_keys"
    }
  }

  tags = var.tags
}

output "vm_public_ip" {
  value = azurerm_public_ip.test1.ip_address
}

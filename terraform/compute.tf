data "azurerm_key_vault_secret" "ssh_pub" {
  name         = "ssh-public-key"
  key_vault_id = azurerm_key_vault.vault.id
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "CP2"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic.id]
  size                  = "Standard_B1s"
  computer_name         = "unir-cp2"
  admin_username        = var.username

  tags = {
    environment = "CP2"
  }

  os_disk {
    name                 = "disk_cp2"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "22.04-LTS"
    version   = "latest"
  }

  admin_ssh_key {
    username = var.username
    public_key = data.azurerm_key_vault_secret.ssh_pub.value
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.storage.primary_blob_endpoint
  }
}
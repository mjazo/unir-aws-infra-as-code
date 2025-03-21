# Create storage account for boot diagnostics
resource "azurerm_storage_account" "storage" {
  name                     = "unir${random_id.random_id.hex}"
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "CP2"
  }
}

resource "azurerm_storage_container" "container" {
  name                    = "unir-container-cp2-${random_id.random_id.hex}"
  storage_account_name    = azurerm_storage_account.storage.name
  container_access_type   = "private"
}
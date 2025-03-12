# Create vault
resource "azurerm_key_vault" "vault" {
  name                = "cp2-keyvault"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
}

# Permission to vault
resource "azurerm_key_vault_access_policy" "terraform" {
  key_vault_id = azurerm_key_vault.vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.client_id

  secret_permissions = ["Get", "List", "Set", "Delete"]
}

# Create secret for ssh
resource "azurerm_key_vault_secret" "ssh_pub" {
  name                = "ssh-public-key"
  value               = file("~/.ssh/id_rsa_terraform.pub")
  key_vault_id        = azurerm_key_vault.vault.id
}
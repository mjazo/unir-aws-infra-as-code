resource "azurerm_kubernetes_cluster" "aks" {
  name                = "terraform-aks-unir"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "terraformaksunir"

  default_node_pool {
    name        = "default"
    node_count  = 1
    vm_size     = "Standard_DS2_v2"
  }

  identity {
      type = "SystemAssigned"
  }

  tags = {
    environment = "CP2"
  }
}

resource "azurerm_role_assignment" "unir_acr_role" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}
data "azurerm_client_config" "current" {}

# Random suffix so the Key Vault name is globally unique
resource "random_string" "kv_suffix" {
  length  = 4
  special = false
  upper   = false
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_key_vault" "kv" {
  name                       = "kv-${var.resource_name}-${random_string.kv_suffix.result}"
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = var.key_vault_sku
  soft_delete_retention_days = 7
  purge_protection_enabled   = false

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get", "List", "Set", "Delete", "Purge", "Recover"
    ]
  }

  tags = var.tags
}

# Example secret stored in the vault, proving end-to-end provisioning
resource "azurerm_key_vault_secret" "example" {
  name         = "example-secret"
  value        = "srn-197-shanmukha-demo-value"
  key_vault_id = azurerm_key_vault.kv.id
}

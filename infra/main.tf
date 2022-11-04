# Configure the Microsoft Azure provider
provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

# Create a Resource Group if it doesn’t exist
resource "azurerm_resource_group" "tfexample" {
  name     = "my-terraform-rg"
  location = "West Europe"
}
# Create a Virtual Network
resource "azurerm_virtual_network" "tfexample" {
  name                = "my-terraform-vnet"
  location            = azurerm_resource_group.tfexample.location
  resource_group_name = azurerm_resource_group.tfexample.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_key_vault" "kv" {
  name                    = "abc"
  location                  = azurerm_resource_group.tfexample.location
  resource_group_name       = azurerm_resource_group.tfexample.name
  purge_protection_enabled  = false
  sku_name                  = "standard"
  enabled_for_disk_encryption = false
  tenant_id                   = data.azurerm_client_config.current.tenant_id
}

resource "azurerm_resource_group" "production" {
  name     = "demo-terraform-azure"
  location = "West Europe"
}

resource "azurerm_storage_account" "production" {
  name                     = "appteststevenewstead"
  resource_group_name      = "${azurerm_resource_group.production.name}"
  location                 = "${azurerm_resource_group.production.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "production" {
  name                = "azure-functions-stevenewstead"
  location            = "${azurerm_resource_group.production.location}"
  resource_group_name = "${azurerm_resource_group.production.name}"
  kind                = "FunctionApp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_function_app" "production" {
  name                      = "test-azure-stevenewstead"
  location                  = "${azurerm_resource_group.production.location}"
  resource_group_name       = "${azurerm_resource_group.production.name}"
  app_service_plan_id       = "${azurerm_app_service_plan.production.id}"
  storage_connection_string = "${azurerm_storage_account.production.primary_connection_string}"
}

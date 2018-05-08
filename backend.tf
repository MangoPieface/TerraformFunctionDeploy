terraform {
  backend "azurerm" {
	storage_account_name= "#{StorageAccountName}"
	resource_group_name= "#{AzureResourceGroupName}"
	container_name= "#{ContainerName}"
	access_key= "#{StorageAccessKey}"
	key = "#{BlobKey}"
  }
}
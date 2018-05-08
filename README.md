# Terraform - Azure Function Deploy
Some notes and code to show Azure funcitons being deployed via Terraform and Octopus. 

## Terraform Azure Blob Provider
In order to allow Terraform correctly maintain the state of our infrastructure we need to move the location of the state file to another source, as we're deploying an Azure Function it would make sense for this to live in Azure storage.

To do this you need to follow the steps detailed in [this blog](https://medium.com/@trstringer/use-azure-blob-storage-for-remote-terraform-state-5f809b95215a).

The output will be a [file](https://github.com/MangoPieface/TerraformFunctionDeploy/blob/master/backend.tf) which has the following information about an Azure blob:

| Value                 | Description   |
| -------------         |:-------------:|
| resource_group_name   | The resource group the container has been deployed in  |
| storage_account_name  | The name of he storage account  
| access_key            | The access key to get to the blob |
| key                   | The 'name' of the blob |

![](https://raw.githubusercontent.com/MangoPieface/TerraformFunctionDeploy/master/Readme%20Images/AzureStorage.png)

![](https://raw.githubusercontent.com/MangoPieface/TerraformFunctionDeploy/master/Readme%20Images/AzureBlobStorage.png)

Once this has been setup then the state for Terraform infratstructure will be stored in Azure and we can manage our infrastructure as code deployments via Octopus.

### References
* https://www.terraform.io/docs/backends/config.html
* https://medium.com/@trstringer/use-azure-blob-storage-for-remote-terraform-state-5f809b95215a

## Zipping for Octopus
Octopus has first class support for Terraform infrastructure deployments and so can deploy from a zip file of all relevant ts and .tsvar files - an example being [TerraformTest.1.0.4.zip](https://github.com/MangoPieface/TerraformFunctionDeploy/blob/master/Example%20zip%20for%20Octopus/TerraformTest.1.0.4.zip).

These could either be formed on the build server and deployed across as a zip file or as Octopus recommend:

>Given that Terraform templates and variable files are plain text, you may find it convenient to use the GitHub Repository Feed to provide the packages used by Terraform steps. Using GitHub releases means you do not have to manually create and upload a package, and can instead tag a release and download it directly from GitHub.

### Octopus deploy transforms

Octopus will trawl through all the .tfvar and .tf files to transform and variables - I've only shown examples of this for setting up and accessing the backend in Azure and the connection to Azure for Azure Function deployments - but this can also be completed on transforms for resource group names, function names in [main.tf](https://github.com/MangoPieface/TerraformFunctionDeploy/blob/master/main.tf).

### References
https://octopus.com/docs/deploying-applications/terraform-deployments
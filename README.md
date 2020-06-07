# 201-solution-azurestack-networker

This Template Deploys and Configures DEL|EMC DataDomain Virtual Edition onto Azurestack

Prework and Requirements:
  -  Have Custom Script for Linux extensions Available on AzureStackHub
  -  Upload DataDomain  VHD for Azure* to Blob in Subscription




AZ CLI Deployment Example:

```azurecli-interactive
az group create --name ddve_from_cli --location local
```

```azurecli-interactive
az deployment group validate  \
--template-uri https://raw.githubusercontent.com/bottkars/201-solution-azurestack-networker/master/azuredeploy.json \
--parameters https://raw.githubusercontent.com/bottkars/201-solution-azurestack-datadomain/master/azuredeploy.parameters.json \
--resource-group ddve_from_cli
```

```azurecli-interactive
az group create --name ddve_from_cli --location local
az deployment group create  \
--template-uri https://raw.githubusercontent.com/bottkars/201-solution-azurestack-datadomain/master/azuredeploy.json \
--parameters https://raw.githubusercontent.com/bottkars/201-solution-azurestack-datadomain/master/azuredeploy.parameters.json \
--resource-group ddve_from_cli
```
delete

```azurecli-interactive
az group delete --name ddve_from_cli  -y
```





AZ CLI Deployment Example:

```azurecli-interactive
export FILE="/mnt/c/Users/Karsten_Bott/workspace/201-solution-azurestack-datadomain"
az group create --name ddve_from_cli --location local
```

```azurecli-interactive
az deployment group validate  \
--template-file ${FILE}/azuredeploy.json \
--parameters ${FILE}/azuredeploy.parameters.json \
--resource-group ddve_from_cli
```

```azurecli-interactive
az group create --name ddve_from_cli --location local
az deployment group create  \
--template-file ${FILE}/azuredeploy.json \
--parameters ${FILE}/azuredeploy.parameters.json \
--resource-group ddve_from_cli
```
delete

```azurecli-interactive
az group delete --name ddve_from_cli  -y
```

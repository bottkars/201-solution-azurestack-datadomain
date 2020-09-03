# 201-solution-azurestack-networker

This Template Deploys and Configures DEL|EMC Avamar Virtual Edition onto Azurestack

Prework and Requirements:
  -  Have Custom Script for Linux extensions Available on AzureStackHub
  -  Upload DDVE VHD for Azure* to Blob in Subscription


## upload DDVE VHD Example
```bash
export AZCOPY_DEFAULT_SERVICE_API_VERSION=2017-11-09
azcopy  copy --recursive /you/file/directory/ddve https://your.atzurestack.image.blob/container<sastoken>
ddve-azure-7.4.0.0-665201/ddve-7.4.0.0-665201.vhd
```
AZ CLI Deployment Example:

```azurecli-interactive
az group create --name ddve_from_cli --location local
```

```azurecli-interactive
az deployment group validate  \
--template-uri https://raw.githubusercontent.com/bottkars/201-solution-azurestack-networker/master/azuredeploy.json \
--parameters https://raw.githubusercontent.com/bottkars/201-solution-azurestack-networker/master/azuredeploy.parameters.json \
--resource-group ddve_from_cli
```

```azurecli-interactive
az group create --name ddve_from_cli --location local
az deployment group create  \
--template-uri https://raw.githubusercontent.com/bottkars/201-solution-azurestack-networker/master/azuredeploy.json \
--parameters https://raw.githubusercontent.com/bottkars/201-solution-azurestack-networker/master/azuredeploy.parameters.json \
--resource-group ddve_from_cli
```
delete

```azurecli-interactive
az group delete --name ddve_from_cli  -y
```





AZ CLI Deployment Example:

```azurecli-interactive
export FILE="~/workspace/201-solution-azurestack-datadomain"
az group create --name ddve_from_cli --location local
```

```azurecli-interactive
SSH_KEYDATA=$(ssh-keygen -y -f ~/.ssh/id_rsa)
az deployment group validate  \
--template-file ${FILE}/azuredeploy.json \
--parameters ${FILE}/azuredeploy.parameters.json \
--parameters ddvePasswordOrKey="{SSH_KEYDATA}"
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

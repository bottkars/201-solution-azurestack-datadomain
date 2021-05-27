# 201-solution-azurestack-datadomain

This Template Deploys and Configures DEL|EMC Avamar Virtual Edition onto Azurestack

Prework and Requirements:
  -  Have Custom Script for Linux extensions Available on AzureStackHub
  -  Upload DDVE VHD for Azure* to Blob in Subscription


## Prepare the vhd from the Azure Source
get the source package for ddve-azure.
make sure vi  azure-metadata.sh provides you a valid machine type for /boot/.instance_type




## Prepare the vhd to become fixed size
```bash

ddrelease=ddve-7.6.0.5-685135
rawdisk="${ddrelease}.raw"
vhddisk="${ddrelease}.vhd"
qemu-img convert -f vpc -O raw $vhddisk $rawdisk
MB=$((1024*1024))
size=$(qemu-img info -f raw --output json "$rawdisk" | \
gawk 'match($0, /"virtual-size": ([0-9]+),/, val) {print val[1]}')
rounded_size=$(((($size+$MB-1)/$MB)*$MB))
echo "Rounded Size = $rounded_size"
qemu-img resize $rawdisk $rounded_size
qemu-img convert -f raw -o subformat=fixed,force_size -O vpc $rawdisk $vhddisk
```
## upload DDVE VHD Example
```bash
SAS_TOKEN=<you sas token>
export AZCOPY_DEFAULT_SERVICE_API_VERSION=2017-11-09
azcopy cp ./ddve-7.4.0.5-670852.vhd \
"https://opsmanagerimage.blob.local.azurestack.external/images/powerprotectdd/ddve-azure-7.4.0.5-670852/ddve-7.4.0.5-670852.vhd$SAS_TOKEN"


# or
azcopy  copy --recursive /you/file/directory/ddve https://your.atzurestack.image.blob/container<sastoken>
ddve-azure-7.4.0.0-665201/ddve-7.4.0.0-665201.vhd
```
AZ CLI Deployment Example:

```azurecli-interactive
az group create --name ddve_from_cli --location local
az deployment group validate  \
--template-uri https://raw.githubusercontent.com/bottkars/201-solution-azurestack-datadomain/master/azuredeploy.json \
--parameters https://raw.githubusercontent.com/bottkars/201-solution-azurestack-datadomain/master/azuredeploy.parameters.json \
--resource-group ddve_from_cli
```

```azurecli-interactive
az group create --name ddve_from_cli --location local
az deployment group create  \
--template-file $HOME/workspace/201-solution-azurestack-datadomain/azuredeploy.json \
--parameters $HOME/workspace/201-solution-azurestack-datadomain/azuredeploy.parameters.json \
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



## direnv GitOps from Repo
```
az group create --name ${AZS_RESOURCE_GROUP} \
  --location ${AZS_LOCATION}

az deployment group create  \
--template-uri https://raw.githubusercontent.com/bottkars/201-solution-azurestack-datadomain/master/azuredeploy.json \
--parameters https://raw.githubusercontent.com/bottkars/201-solution-azurestack-datadomain/master/azuredeploy.parameters.json \
--parameters ddveName=${AZS_HOSTNAME} \
--parameters ddveImageURI=${AZS_IMAGE_URI} \
--resource-group ${AZS_RESOURCE_GROUP}
```

## direnv GitOps locally
```
az deployment group create  \
--template-file ${HOME}/workspace/201-solution-azurestack-datadomain/azuredeploy.json \
--parameters ${HOME}/workspace//201-solution-azurestack-datadomain/azuredeploy.parameters.json \
--parameters ddveName=${AZS_HOSTNAME} \
--parameters ddveImageURI=${AZS_IMAGE_URI} \
--resource-group ${AZS_RESOURCE_GROUP}
```



delete

```azurecli-interactive
az group delete --name ddve_from_cli  -y
```

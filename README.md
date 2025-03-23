# unir-aws-infra-as-code


## Terraform Setup
```
cd terraform

terraform init
terraform plan -out main.tfplan
terraform apply main.tfplan

```

## Ansible Setup
```
cd ansible
cd playbook

// Pull and Push podman images to azure container registry
ansible-playbook acr.yml

// Deployment to Azure AKS
ansible-playbook aks.yml

cd ..

// Up podman container
ansible-playbook -i inventory.yml playbook/vm.yml --ask-vault-pass

// Stop podman container
ansible-playbook -i inventory.yml playbook/stop-webapp.yml



```

## AKS Deployment Manual
```
cd aks

kubectl create namespace unir

kubectl create secret docker-registry acr-secret \
  --docker-server=<ACR_NAME>.azurecr.io \
  --docker-username=<ACR_USERNAME> \
  --docker-password=<ACR_PASSWORD> \
  --namespace=unir

kubectl apply -f ./deployment.yml -n unir
```
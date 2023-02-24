# **Terraform**

## **1. Install Terraform on MacOS**

- Link -> https://developer.hashicorp.com/terraform/downloads

```console
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
terraform --version
```

## **2. Arquitectura**

Modulo Raiz      | Desciption
---------------- | -------------
providers.tf     | Configuracion de proovedores
variables.tf     | Deficinicion de variables
terraform.tfvars | Valores para las variables
main.tf          | Recursos a desplegar
outputs.tf       | Salidas de pantallas (final)
data.tf          | Obtener datos infraestructura (inicio)

Link -> <https://registry.terraform.io/namespaces/hashicorp>

****

## **BASICS COMMANDS**

1. Init Terraform

```terraform
terraform init
```

2. Validate Terrafoorm

```terraform
terraform validate
```

3. Aplicar | por default aplica el archivo **terraform.tfvars**

```terraform
terraform apply
```

4. Aplicar cambiando el valor de la variable

```terraform
terraform apply -var ambiente="Production" -var nombre-proyecto="Nuevo Proyecto"
```

5. Aplicar usando un archivo de variables.

```terraform
terraform apply -var-file="NewVariables.tfvars"
```

5. Analiza los componentes a desplegar y compara con la infra actual, mostrando un plan de implementacion

```terraform
terraform plan
```

6. Terraform destroy destruye todos los componentes creados.

```terraform
terraform destroy
```

7. Permiteo al desarrollador verificar la sintaxis y congruencia de los archivos de terraform.

```terraform
terraform validate
```
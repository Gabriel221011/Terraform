/* Bloque de configuración de Terraform para proveedores. 
Con este boque se especifica el proveedor AWS y su versión.
Aquí es donde Terraform:
-- Sabe qué proveedor usar.
-- Descarga los “plugins” (providers) con terraform init
*/
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
/*
Bloque provider (configuración de AWS). 
Aquí defines:
-- Perfil AWS CLI.
-- Región.
RECUERDA: 
1. El perfil debe estar configurado previamente en tu AWS CLI (archivo ~/.aws/credentials).
2. Crea un perfil por cada laboratorio de AWS Academy para evitar conflictos según el proyecto en el que trabajes.
*/

provider "aws" {
  profile = "awsacademy-terraform"
  region  = "us-east-1"
}


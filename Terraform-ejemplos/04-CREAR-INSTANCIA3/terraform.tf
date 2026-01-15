# Bloque terraform para definir el proveedor AWS. 
# Esto no crea nada en AWS, solo indica a Terraform qué proveedor usar.
# Sirve para decirle a Terraform:
#   - Qué proveedor usar (AWS en este caso)
#   - De dónde obtener el proveedor (HashiCorp Registry) 
#   - Qué versión del proveedor usar (5.x en este caso)
# Solo necesitamos declararlo una vez por proyecto porque:
# - Terraform lee todos los archivos .tf en el directorio del proyecto
# - Combina la configuración de todos esos archivos antes de ejecutar cualquier acción.
# Este bloque se suele colocar en un archivo separado (como terraform.tf)
# para mantener la configuración organizada, pero podría estar en main.tf también.
# Cuando ejecutemos "terraform init", Terraform descargará e instalará
# el proveedor AWS según esta configuración y lo dejará en .terraform/plugins.
#
# "El bloque Terraform configura la herramienta; los bloques resource crean recursos en la nube."

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
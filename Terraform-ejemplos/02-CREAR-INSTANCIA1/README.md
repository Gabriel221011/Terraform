
# 🚀 Despliegue de una instancia EC2 en AWS con Terraform

## 1️⃣ Título del proyecto
**Terraform: EC2 mínima en AWS**

## 2️⃣ Descripción del proyecto
Este repositorio contiene un ejemplo **mínimo y didáctico** de Terraform para desplegar una instancia **Amazon EC2** en **AWS**. Está pensado para introducir a alumnado del módulo de Computación en la Nube a la **Infraestructura como Código (IaC)** con un caso simple, entendible y reproducible en el aula.

> **Qué hace exactamente**: crea una instancia EC2 tipo `t3.micro` en la región `us-east-1` usando un AMI público concreto.

## 3️⃣ Requisitos previos
- **Cuenta de AWS** con permisos para crear recursos EC2 (instancias, claves, etc.).
- **Credenciales configuradas** en tu equipo (por ejemplo, con `aws configure` o con un perfil de AWS CLI).
- **Terraform** instalado (v1.4+ recomendado). Comprueba con:
  ```bash
  terraform -version
  ```
- **AWS CLI** instalado (opcional pero recomendado):
  ```bash
  aws --version
  ```

> 💡 En este ejemplo se usa el perfil `awsacademy-CN2526-1TRIM-2`. Puedes cambiarlo por el tuyo o eliminar la línea `profile` para que use las credenciales por defecto.

## 4️⃣ Estructura del proyecto
```
.
├── main.tf        # Código principal de Terraform (proveedor + recurso EC2)
└── README.md      # Este documento
```

## 5️⃣ Explicación del código
A continuación, el contenido del archivo `main.tf` comentado por bloques:

```hcl
# Bloque terraform para definir el proveedor AWS. 
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
```
- **`terraform.required_providers`**: indica que usaremos el proveedor oficial de AWS de HashiCorp.
- **`version = "~> 5.0"`**: permite cualquier versión `5.x` compatible (protege de cambios mayores rompientes).

```hcl
# Configure the AWS provider
provider "aws" {
  profile = "awsacademy-CN2526-1TRIM-2"
  region  = "us-east-1"
}
```
- **`provider "aws"`**: configura cómo Terraform se conecta a AWS.
- **`profile`**: nombre del perfil de credenciales de AWS CLI en tu equipo (ajústalo a tu caso, o elimínalo para usar el perfil por defecto).
- **`region`**: región de AWS donde se crearán los recursos (aquí, **N. Virginia** `us-east-1`).

```hcl
# Create an EC2 instance
resource "aws_instance" "example" {
  ami           = "ami-0ecb62995f68bb549"
  instance_type = "t3.micro"
}
```
- **`resource "aws_instance" "example"`**: define una instancia EC2. El nombre local es `example`.
- **`ami`**: ID de la imagen del sistema operativo a lanzar. **Importante**: los AMI cambian con el tiempo y por región. Este ID está fijado para `us-east-1`.
- **`instance_type`**: tamaño de la instancia. `t3.micro` suele entrar en **capa gratuita** en muchas cuentas educativas (verifica límites en tu cuenta).

## 6️⃣ Cómo ejecutar el proyecto (paso a paso)
> Estos pasos asumen que ya tienes credenciales de AWS configuradas y acceso a la región `us-east-1`.

1. **Clona el repositorio** (o copia el `main.tf` en una carpeta vacía):
   ```bash
   git clone <URL-de-tu-repo>
   cd <carpeta-del-repo>
   ```

2. **(Opcional) Ajusta el perfil y la región** en `main.tf` si no usas `awsacademy-CN2526-1TRIM-2` o si trabajas en otra región.

3. **Inicializa Terraform** (descarga el proveedor de AWS):
   ```bash
   terraform init
   ```

4. **Valida la sintaxis** del proyecto:
   ```bash
   terraform validate
   ```

5. **Previsualiza el plan de cambios**:
   ```bash
   terraform plan
   ```
   Revisa que va a crear **1 recurso** `aws_instance.example`.

6. **Aplica el plan (despliegue)**:
   ```bash
   terraform apply
   ```
   - Escribe `yes` cuando Terraform te lo pida.
   - Al terminar, Terraform mostrará los **outputs** (si los hubiera) y confirmará que los recursos se han creado.

7. **(Comprobación opcional)**: ve a la consola de AWS → EC2 → Instances y verifica que la instancia está **running** en `us-east-1`.

8. **Destruye los recursos** cuando termines (para no generar costes):
   ```bash
   terraform destroy
   ```
   Confirma con `yes` cuando se te solicite.

> ⚠️ **Costes**: aunque este ejemplo es mínimo, crear recursos en AWS puede generar costes. Destruye la infraestructura al finalizar la práctica.

## 8️⃣ Posibles mejoras / ampliaciones (muy didáctico)
Estas ideas ayudan a progresar desde el ejemplo mínimo hacia mejores prácticas de IaC. Se proponen en orden creciente de complejidad.

1. **Variables y `terraform.tfvars`**  
   - Parametriza `region`, `profile`, `instance_type` y `ami` con variables (`variables.tf`).  
   - Crea un archivo `terraform.tfvars` para valores por defecto del aula.

2. **Tags (etiquetas) organizativas**  
   - Añade etiquetas como `Name`, `Owner`, `Environment`, `Course`, `Lesson`.  
   - Útiles para gobierno, costes y búsqueda.

---

## 🧪 Actividades sugeridas para clase
- Cambia el `instance_type` y observa el nuevo `plan`.
- Añade una etiqueta `Name = "tf-ec2-alumno-<tu_nombre>"` y verifica en la consola. 
- Prueba a destruir y volver a crear la instancia cambiando el AMI.

## ❓ Resolución de problemas (FAQ)
- **`InvalidAMIID.NotFound`**: el AMI no existe en tu región. Cambia la región o el AMI.  
- **Autenticación fallida**: revisa `aws configure list` o el `profile` usado.  
- **`InsufficientInstanceCapacity`**: el tipo no está disponible temporalmente; prueba otro `instance_type` o zona de disponibilidad.

## 🔒 Buenas prácticas mínimas
- Nunca subas **claves privadas** ni archivos con secretos al repositorio.  
- Usa **variables** y **backends remotos** cuando trabajes en equipo.  
- Etiqueta todos los recursos para facilitar el control de costes.

---

### Créditos
Creado con fines docentes para introducir Terraform y AWS EC2.

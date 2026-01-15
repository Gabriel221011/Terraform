/* BLOQUE PROVIDER: configuración de AWS. 
Aquí defines:
-- Perfil AWS CLI.
-- Región.
RECUERDA: 
1. El perfil debe estar configurado previamente en tu AWS CLI (archivo ~/.aws/credentials).
2. Crea un perfil por cada laboratorio de AWS Academy para evitar conflictos según el proyecto en el que trabajes.

CONCLUSIÓN: El bloque provider{} especifica "cómo me conecto".
*/

provider "aws" {
  profile = "awsacademy-proyectopruebas"
  region  = "us-east-1"
}


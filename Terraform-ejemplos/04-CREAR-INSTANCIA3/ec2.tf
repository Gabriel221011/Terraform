/* OBJETIVO: Crear una instancia EC2 en la VPC default con Ubuntu 24.04 LTS. 
En este ejemplo observar que: 

  resource → crear EC2
 
 data → consultar VPC, subnets, AMI
 
 referencias → ami = data.aws_ami.ubuntu_2404.id, subnet_id = data.aws_subnet_ids.default.ids[0]
 
  tags → buenas prácticas
*/

# Leer la VPC default existente
data "aws_vpc" "default" {
  default = true
}

# Leer las subnets públicas por defecto de la VPC default (map public IP on launch)
data "aws_subnets" "public_default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
  filter {
    name   = "map-public-ip-on-launch"
    values = ["true"]
  }
}

# Buscar la última AMI de Ubuntu 24.04 LTS
data "aws_ami" "ubuntu_2404" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-24.04*", "ubuntu/images/*24.04*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["099720109477"] # Canonical
}

# Crear la instancia EC2 (usando la keypair ya existente 'vockey')
/* BLOQUE RESOURCE: cada bloque resource tiene la estructura:
resource "TIPO_RECURSO" "NOMBRE_RECURSO" {  
}
El "TIPO_RECURSO" define qué tipo de recurso se va a crear (aquí: aws_instance, que es una instancia EC2).
El "NOMBRE_RECURSO" es un identificador único dentro del proyecto Terraform (aquí: ec2_ejemplo).
Dentro del bloque se definen los atributos del recurso, como:   
-- ami: la AMI a usar (aquí: la obtenida en el data source anterior).
-- instance_type: el tipo de instancia (aquí: t3.small).  
-- key_name: el key pair para acceso SSH (aquí: vockey).
-- subnet_id: la subred donde se lanzará la instancia (aquí: la default de la VPC default).
-- tags: etiquetas para identificar el recurso (buenas prácticas).   
CONCLUSIÓN: Este bloque resource crea una instancia EC2 en la VPC default con Ubuntu 24.04 LTS.
*/
resource "aws_instance" "ec2_ejemplo" {
  ami           = data.aws_ami.ubuntu_2404.id
  instance_type = "t3.small"
  key_name      = "vockey"

  subnet_id = data.aws_subnets.public_default.ids[0]

  tags = {
    Name = "ec2-ejemplo"
  }
}


# === Data source: Busca la AMI oficial de Ubuntu 24.04 LTS (Noble) en us-east-1 ===
# "data" no crea recursos; solo consulta información en AWS para usarla después.
data "aws_ami" "ubuntu_2404" {
  # Toma la AMI más reciente que cumpla los filtros
  most_recent = true

  # ID de cuenta de Canonical en AWS (propietaria de las AMIs oficiales de Ubuntu)
  owners = ["099720109477"]

  # Filtra por el patrón de nombre de las AMIs de Ubuntu 24.04 (Noble) en HVM/SSD para amd64
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-noble-24.04-amd64-server-*"]
  }

  # Asegura que la AMI use virtualización HVM (requisito típico para instancias modernas)
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  # Asegura que el disco raíz sea EBS (lo más común y administrable)
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  # Recomendable: fija arquitectura x86_64 para evitar seleccionar arm64 accidentalmente
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# === Recurso EC2: Crea la instancia bastión en una subred pública ===
resource "aws_instance" "ec2_bastion" {
  # Usa el ID de la AMI obtenida en el data source anterior
  ami           = data.aws_ami.ubuntu_2404.id

  # Tipo de instancia (t3.small es una opción x86_64 con buen balance costo/desempeño)
  instance_type = "t3.small"

  # Coloca la instancia en tu subred pública (debe existir y estar en el VPC deseado)
  subnet_id = aws_subnet.public.id

  # Aplica el Security Group con reglas de entrada/salida de tu bastión
  vpc_security_group_ids = [aws_security_group.ec2_public_sg.id]

  # Pide IP pública para poder acceder desde Internet (típico en un bastión)
  associate_public_ip_address = true

  # Nombre del key pair que ya existe en la región (útil para SSH)
  key_name = "vockey"

  # Etiquetas para identificar el recurso (buenas prácticas de inventario/gestión)
  tags = {
    Name = "ec2-bastion"
  }
}


# SG de la instancia privada: no acepta tráfico de Internet
resource "aws_security_group" "private_sg" {
  name        = "terraform1-ec2-private-ssh"
  description = "SSH solo desde la instancia pública (bastion)"
  vpc_id      = aws_vpc.main.id

  # Egresos: salida permitida (necesario si luego añades NAT para actualizar paquetes)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "terraform1-ec2-private-ssh" }
}

# Regla de ingreso: permitir SSH desde el SG de la instancia pública
# (para referenciar otro SG como origen, usamos el recurso aws_security_group_rule)
resource "aws_security_group_rule" "private_allow_ssh_from_public_sg" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.private_sg.id
  source_security_group_id = aws_security_group.ec2_public_sg.id
  description              = "Permite SSH desde la instancia publica"
}


resource "aws_security_group" "ec2_public_sg" {
  name        = "terraform1-ec2-public-ssh"
  description = "Permite SSH a la instancia publica"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Mejor: "TU_IP/32"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "terraform1-ec2-public-ssh" }
}

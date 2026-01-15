terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  profile = var.aws_profile
}


# Security group para permitir SSH y HTTP
resource "aws_security_group" "ansible_sg" {
  name        = "ansible_sg"
  description = "Permitir SSH y HTTP"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Crear dos instancias EC2
resource "aws_instance" "ansible_node" {
  count         = 2
  ami           = var.ubuntu_ami
  instance_type = var.instance_type
  key_name      = "vockey"
  security_groups = [aws_security_group.ansible_sg.name]

  tags = {
    Name = "AnsibleNode-${count.index + 1}"
  }
}

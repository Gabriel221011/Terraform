variable "aws_profile" {
  description = "Perfil de AWS a usar"
  type        = string
  default     = "Academy"  # puedes poner un valor por defecto
}


variable "aws_region" {
  description = "Región de AWS"
  type        = string
  default     = "us-east-1"
}

variable "ubuntu_ami" {
  description = "AMI Ubuntu 24.04"
  type        = string
  default     = "ami-0ecb62995f68bb549" # Cambiar por la AMI de Ubuntu 24.04 de AWS Academy
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t2.micro"
}


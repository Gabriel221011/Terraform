# Bloque terraform para definir el proveedor AWS. 
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
# Configure the AWS provider
provider "aws" {
  profile = "awsacademy-CN2526-1TRIM-2"
  region  = "us-east-1"
}

# Create an EC2 instance
resource "aws_instance" "example" {
  ami           = "ami-0ecb62995f68bb549"
  instance_type = "t3.micro"
}

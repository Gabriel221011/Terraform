resource "aws_vpc" "vpc_clase" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vpc-clase"
  }
}

resource "aws_subnet" "subred_publica" {
  vpc_id            = aws_vpc.vpc_clase.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "subred-publica"
  }
}

resource "aws_vpc" "vpc_main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "cn-vpc-main"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_main.id

  tags = {
    Name = "cn-igw"
  }
}

resource "aws_subnet" "subnet_public" {
  vpc_id                  = aws_vpc.vpc_main.id
  cidr_block               = "10.0.1.0/24"
  map_public_ip_on_launch  = true

  tags = {
    Name = "cn-subnet-public"
  }
}

resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.vpc_main.id

  tags = {
    Name = "cn-rt-public"
  }
}

resource "aws_route" "route_public_internet" {
  route_table_id         = aws_route_table.rt_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "rt_assoc_public" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.rt_public.id
}

resource "aws_security_group" "sg_web_ssh" {
  name        = "cn-sg-web-ssh"
  description = "Allow SSH(22), HTTP(80) and HTTPS(443) from anywhere (lab only)"
  vpc_id      = aws_vpc.vpc_main.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
    tags = {
    Name = "cn-sg-web-ssh"
  }
}
resource "aws_instance" "ec2_public" {
  ami                    = "ami-0ecb62995f68bb549"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.subnet_public.id
  vpc_security_group_ids = [aws_security_group.sg_web_ssh.id]

  associate_public_ip_address = true

  tags = {
    Name = "cn-ec2-public"
  }
}
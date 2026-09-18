provider "aws" {
  region = var.region
}

data "aws_caller_identity" "actual" {}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_vpc" "principal" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${var.nombre_proyecto}-vpc"
  }
}

resource "aws_internet_gateway" "principal" {
  vpc_id = aws_vpc.principal.id

  tags = {
    Name = "${var.nombre_proyecto}-igw"
  }
}

resource "aws_subnet" "publica" {
  vpc_id                  = aws_vpc.principal.id
  cidr_block              = var.subnet_publica_cidr
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.nombre_proyecto}-subnet-publica"
  }
}

resource "aws_subnet" "privada" {
  vpc_id            = aws_vpc.principal.id
  cidr_block        = var.subnet_privada_cidr
  availability_zone = "us-east-1b"

  tags = {
    Name = "${var.nombre_proyecto}-subnet-privada"
  }
}

resource "aws_route_table" "publica" {
  vpc_id = aws_vpc.principal.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.principal.id
  }

  tags = {
    Name = "${var.nombre_proyecto}-rt-publica"
  }
}

resource "aws_route_table_association" "publica" {
  subnet_id      = aws_subnet.publica.id
  route_table_id = aws_route_table.publica.id
}

resource "aws_security_group" "ec2" {
  name        = "${var.nombre_proyecto}-sg"
  description = "Permite trafico SSH y HTTP"
  vpc_id      = aws_vpc.principal.id

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

  egress {
    description = "Todo el trafico saliente"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.nombre_proyecto}-sg"
  }
}

resource "aws_instance" "web" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.publica.id
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  associate_public_ip_address = true

  tags = {
    Name = "${var.nombre_proyecto}-ec2"
  }
}

resource "aws_s3_bucket" "principal" {
  bucket = lower("${var.nombre_proyecto}-${data.aws_caller_identity.actual.account_id}-terraform")

  tags = {
    Name = "${var.nombre_proyecto}-bucket"
  }
}

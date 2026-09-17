provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "vpc_aula" {
  cidr_block = "10.10.0.0/16"
}

resource "aws_subnet" "publica" {
  vpc_id                  = aws_vpc.vpc_aula.id
  cidr_block              = "10.10.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_aula.id
}

resource "aws_route_table" "publica" {
  vpc_id = aws_vpc.vpc_aula.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "publica" {
  subnet_id      = aws_subnet.publica.id
  route_table_id = aws_route_table.publica.id
}
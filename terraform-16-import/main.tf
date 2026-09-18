provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "ejercicio-16" {
  cidr_block = "10.0.0.0/24"
}
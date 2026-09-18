variable "region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.10.0.0/16"
}

variable "subnet_publica_cidr" {
  type    = string
  default = "10.10.1.0/24"
}

variable "subnet_privada_cidr" {
  type    = string
  default = "10.10.2.0/24"
}

variable "nombre_proyecto" {
  type    = string
  default = "proyecto-final"
}

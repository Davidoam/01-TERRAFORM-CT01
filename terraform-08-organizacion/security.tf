resource "aws_security_group" "web" {
  name   = "terraform-web"
  vpc_id = aws_vpc.vpc_aula.id
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
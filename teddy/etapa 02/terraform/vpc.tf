# Criar um VPC
resource "aws_vpc" "teddy" {
  cidr_block = "10.0.0.0/16"
}
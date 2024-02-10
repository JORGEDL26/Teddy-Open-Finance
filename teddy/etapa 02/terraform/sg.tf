# Criar um security group para o servidor
resource "aws_security_group" "vpn_sg" {
  name = "teddysg"
  description = "acesso ssh"
  vpc_id = ["${aws_vpc.teddy.id}"]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Liberar a porta 22 para ser acessada de qualquer lugar
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
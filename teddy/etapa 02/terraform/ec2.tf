# Criando EC2 com docker
resource "aws_instance" "teddy_server_docker" {
  ami           = "ami-0c94855ba95c71c99"
  instance_type = "t3.micro"
  key_name      = "service"
  subnet_id     = ["${aws_subnet.subnet1.id}"]
  security_group = ["${aws_security_group.vpn_sg.id}"]
  user_data     = "${file("install_docker.sh")}" 
  tags          = {
                    Name = "Server"
                    AMB  = "PRD"
  }
}
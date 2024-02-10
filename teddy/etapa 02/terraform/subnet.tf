# Criar duas subnets no VPC
resource "aws_subnet" "subnet1" {
  vpc_id     = ["${aws_vpc.teddy.id}"]
  cidr_block = "10.0.1.0/24"
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.teddy.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
}

resource "aws_route_table_association" "route_table_association" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.teddy.id
  tags = {
    Name = "InternetGateway"
  }
}
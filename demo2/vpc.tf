resource "aws_vpc" "bcs_hacks_demo_vpc" {
  cidr_block = "10.0.128.0/17"

  tags = {
    Name = "bcs-hacks-demo-vpc"
  }
}

resource "aws_subnet" "bcs_hacks_demo_subnet_1" {
  vpc_id                  = aws_vpc.bcs_hacks_demo_vpc.id
  cidr_block              = "10.0.211.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "bcs-hacks-demo-subnet-1"
  }
}

resource "aws_subnet" "bcs_hacks_demo_subnet_2" {
  vpc_id                  = aws_vpc.bcs_hacks_demo_vpc.id
  availability_zone       = "us-east-1b"
  cidr_block              = "10.0.212.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "bcs-hacks-demo-subnet-2"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.bcs_hacks_demo_vpc.id

  tags = {
    Name = "BCS-Hacks-Demo-Internet-Gateway"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.bcs_hacks_demo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "rt_association_1" {
  subnet_id      = aws_subnet.bcs_hacks_demo_subnet_1.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "rt_association_2" {
  subnet_id      = aws_subnet.bcs_hacks_demo_subnet_2.id
  route_table_id = aws_route_table.rt.id
}
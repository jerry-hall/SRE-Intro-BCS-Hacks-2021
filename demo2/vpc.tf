resource "aws_vpc" "bcs_hacks_demo_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "bcs-hacks-demo-vpc"
  }
}

resource "aws_subnet" "bcs_hacks_demo_subnet" {
  vpc_id                  = aws_vpc.bcs_hacks_demo_vpc.id
  cidr_block              = "10.0.0.0/16"
  map_public_ip_on_launch = true

  tags = {
    Name = "bcs-hacks-demo-subnet"
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

resource "aws_route_table_association" "rt_association" {
  subnet_id      = aws_subnet.bcs_hacks_demo_subnet.id
  route_table_id = aws_route_table.rt.id
}

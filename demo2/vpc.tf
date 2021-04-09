# For this demo, we will create our own VPC which is a logically isolated network in which 
# our infrastructure lives.

# Diagram of VPC: https://docs.google.com/drawings/d/1St1O8_Xz8ToO3wH4IA-ZoYtbmgrCbosBuE9dLPop8iU/edit?usp=sharing
resource "aws_vpc" "bcs_hacks_demo_vpc" {
  cidr_block = "10.0.128.0/17"

  tags = {
    Name = "bcs-hacks-demo-vpc"
  }
}

# Subnet #1: Two subnets are required by the ALB
resource "aws_subnet" "bcs_hacks_demo_subnet_1" {
  vpc_id                  = aws_vpc.bcs_hacks_demo_vpc.id
  cidr_block              = "10.0.211.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "bcs-hacks-demo-subnet-1"
  }
}

# Subnet #2: Two subnets are required by the ALB
resource "aws_subnet" "bcs_hacks_demo_subnet_2" {
  vpc_id                  = aws_vpc.bcs_hacks_demo_vpc.id
  availability_zone       = "us-east-1b"
  cidr_block              = "10.0.212.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "bcs-hacks-demo-subnet-2"
  }
}

# Internet gateway must be attached to the VPC to allow egress 
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.bcs_hacks_demo_vpc.id

  tags = {
    Name = "BCS-Hacks-Demo-Internet-Gateway"
  }
}

# Route table specifies that the internet gateway above can access all IPs (0.0.0.0/0)
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.bcs_hacks_demo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

# Route table association attaches the above route table to subnet #1
resource "aws_route_table_association" "rt_association_1" {
  subnet_id      = aws_subnet.bcs_hacks_demo_subnet_1.id
  route_table_id = aws_route_table.rt.id
}

# Route table association attaches the above route table to subnet #2
resource "aws_route_table_association" "rt_association_2" {
  subnet_id      = aws_subnet.bcs_hacks_demo_subnet_2.id
  route_table_id = aws_route_table.rt.id
}
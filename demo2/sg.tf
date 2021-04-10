resource "aws_security_group" "BCS_Hacks_sg" {
  name        = "bcs_hacks_sg"
  description = "Allow http and ssh inbound traffic"
  vpc_id      = aws_vpc.bcs_hacks_demo_vpc.id

  # Whitelist ingress on port 80 (HTTP) from anywhere
  ingress {
    description = "http from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Whitelist ingress on port 22 (SSH) from anywhere
  ingress {
    description = "ssh from internet"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Whitelist egress on all ports to anywhere
  egress {
    description = "allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "BCS_Hacks_sg_ingress_from_alb" {
  name        = "BCS_Hacks_sg_ingress_from_alb"
  description = "Allow inbound traffic only from alb"
  vpc_id      = aws_vpc.bcs_hacks_demo_vpc.id

  # Whitelist ingress on port 80 (HTTP) from anywhere
  ingress {
    description     = "Ingress from sg"
    from_port       = 80
    to_port         = 80
    protocol        = "TCP"
    security_groups = [aws_security_group.BCS_Hacks_sg.id]
  }

  # Whitelist egress on all ports to anywhere
  egress {
    description = "allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
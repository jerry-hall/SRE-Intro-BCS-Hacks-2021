resource "aws_security_group" "BCS_Hacks_sg" {
  name        = "bcs_hacks_sg"
  description = "Allow http and ssh inbound traffic"
  vpc_id      = aws_vpc.bcs_hacks_demo_vpc.id

  ingress {
    description = "http from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ssh from internet"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
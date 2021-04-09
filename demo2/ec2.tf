# A data object retrieves data from a source.
# In this particular case, we are searching for a specific AMI.
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]     # Canonical
}

# For more info, see: 
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
resource "aws_instance" "bcs_hacks_ec2_instance" {
  ami                     = data.aws_ami.ubuntu.id
  instance_type           = "t2.micro"    
  user_data               = file("user_data.sh")
  # Note: You must create your own SSH key in AWS in order to SSH in to the instance
  key_name                = "jhall-dev-env"
  subnet_id               = aws_subnet.bcs_hacks_demo_subnet.id
  vpc_security_group_ids  = [aws_security_group.BCS_Hacks_sg.id]

  tags = {
    Name = "BCS-Hacks-EC2-Instance"
  }
}
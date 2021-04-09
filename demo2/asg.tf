resource "aws_autoscaling_group" "BCS_Hacks_demo_asg" {
  name                 = "BCS-Hacks-demo-asg"
  min_size             = "2"
  max_size             = "2"
  desired_capacity     = "2"
  force_delete         = false
  launch_configuration = aws_launch_configuration.BCS_Hacks_demo_lc.name

  vpc_zone_identifier = [
    aws_subnet.bcs_hacks_demo_subnet_1.id,
    aws_subnet.bcs_hacks_demo_subnet_2.id,
  ]

  target_group_arns = [
    aws_lb_target_group.front_end.arn,
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_configuration" "BCS_Hacks_demo_lc" {
  name          = "BCS-Hacks-demo-lc"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  user_data     = file("user_data.sh")
  # Note: You must create your own SSH key in AWS in order to SSH in to the instance
  key_name      = "jhall-dev-env"
  security_groups = [ aws_security_group.BCS_Hacks_sg.id ]
}

# Application Load Balancer is the single source of ingress 
resource "aws_lb" "BCS_Hacks_demo_alb" {
  name              = "BCS-Hacks-demo-alb"
  security_groups   = [ aws_security_group.BCS_Hacks_sg.id ]
  enable_http2      = false

  subnets = [
    aws_subnet.bcs_hacks_demo_subnet_1.id,
    aws_subnet.bcs_hacks_demo_subnet_2.id,
  ]
}

# Load Balancer Target Group connects the ALB with the ASG 
resource "aws_lb_target_group" "front_end" {
  name     = "BCS-Hacks-demo-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.bcs_hacks_demo_vpc.id

  health_check {
    healthy_threshold   = 2
    interval            = 10
    path                = "/"
    timeout             = 5
    protocol            = "HTTP"
    unhealthy_threshold = 2
    matcher             = 200
  }
}

# Load Balancer Listener connects the target group with the ALB
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.BCS_Hacks_demo_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end.arn
  }
}

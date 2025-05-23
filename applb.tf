# Create a Load Balancer
resource "aws_lb" "external" {
  name               = "netflix-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.netflix-alb-sg-1.id]
  subnets            = [aws_subnet.netflix-pub-sub-1.id, aws_subnet.netflix-pub-sub-2.id]

  enable_deletion_protection = false
}

# Create a Target Group
resource "aws_lb_target_group" "external-elb" {
  name     = "external-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.netflix-vpc.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
  }
}

# Attach Auto Scaling Group Instances to Target Group
resource "aws_autoscaling_attachment" "netflix-web-asg-attachment" {
  autoscaling_group_name = aws_autoscaling_group.netflix-web-asg.name
  lb_target_group_arn    = aws_lb_target_group.external-elb.arn
}


# Create a Listener for Load Balancer
resource "aws_lb_listener" "external" {
  load_balancer_arn = aws_lb.external.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.external-elb.arn
  }
}

# Create an Application Load Balancer
resource "aws_lb" "netflix-app-lb-external" {
  name               = "netflix-app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.netflix-sg-lb.id]
  subnets            = [aws_subnet.netflix-pub-sub-.id, aws_subnet.netflix-pub-sub2.id]
  enable_deletion_protection = false

}

# Target Group for App Servers
resource "aws_lb_target_group" "app_target_group" {
  name     = "netflix-app-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "aws_vpc.netflix-vpc.id"

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
  autoscaling_group_name = aws_autoscaling_group.netflix-web-server-asg.name
  lb_target_group_arn    = aws_lb_target_group.app_target_group.arn
}

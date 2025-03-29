# Create an Application Load Balancer
resource "aws_lb" "netflix-app-lb" {
  name               = "netflix-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.netflix-lb-sg.id]
  subnets            = ["subnet-xxxxxxxx", "subnet-yyyyyyyy"] # Replace with your subnet IDs
  enable_deletion_protection = false

}

# Target Group for App Servers
resource "aws_lb_target_group" "app_target_group" {
  name     = "netflix-app-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-xxxxxxxx" # Replace with your VPC ID

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
  }
}


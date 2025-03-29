# Create an Auto Scaling Group for Application Server
resource "aws_autoscaling_group" "app_server_asg" {
  desired_capacity     = 2
  max_size             = 3
  min_size             = 2
  vpc_zone_identifier  = 
  launch_template {
    id      = aws_launch_template.app_server_template.id
    version = "$Latest"
  }

  health_check_type          = "EC2"
  health_check_grace_period =   300
  force_delete               = true

  tags = 
}

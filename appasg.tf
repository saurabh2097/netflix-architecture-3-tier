# Auto Scaling Group for application server 
resource "aws_autoscaling_group" "netflix-app-server-asg" {
name = "netflix-app-asg"
launch template{
  id  = aws_launch_configuration.netflix-app_config.id
  version = "$Latest"
}
  vpc_zone_identifier = [
    aws_subnet.netflix-priv-sub-1.id,
    aws_subnet.netflix-priv-sub-1.id
  ]
  min_size             = 2
  max_size             = 3
  desired_capacity     = 2
}



# Launch Configuration for EC2 Instances for app server
resource "aws_launch_configuration" "netflix-app-server-asgg" {
  name          = "netflix-app-template"
  image_id      = "ami-02f624c08a83ca16f"  
  instance_type = "t2.micro"

  network_interfaces {
  security_groups = [aws_security_group.netflix-app-sg-app.id]
  associate_public_ip_address = false
}
  user_data = base64encode(<<-EOF
    #!/bin/bash

    sudo yum install mysql -y

  EOF
  )

  lifecycle {
    prevent_destroy = false
    ignore_changes  = all
  }
}

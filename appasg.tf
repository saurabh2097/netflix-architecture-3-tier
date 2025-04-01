# Auto Scaling Group for Application Server
resource "aws_autoscaling_group" "netflix-app-server-asg" {
  name = "netflix-app-asg"
  
  launch_template {
    id      = aws_launch_template.netflix-app-server-template.id
    version = "$Latest"
  }

  vpc_zone_identifier = [
    aws_subnet.netflix-priv-sub-1.id,
    aws_subnet.netflix-priv-sub-2.id
  ]

  min_size         = 2
  max_size         = 3
  desired_capacity = 2
}

# Launch Template for EC2 Instances for App Server
resource "aws_launch_template" "netflix-app-server-template" {
  name          = "netflix-app-template"
  image_id      = "ami-02f624c08a83ca16f"
  instance_type = "t2.micro"
  key_name      = "saurabhkeypair"

  network_interfaces {
    security_groups             = [aws_security_group.netflix-app-sg-app.id]
    associate_public_ip_address = false
  }

  user_data = base64encode(<<-EOF
    #!/bin/bash
    sudo yum install mysql -y
  EOF
  )

  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}

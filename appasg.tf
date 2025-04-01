# Create an EC2 Auto Scaling Group - app
resource "aws_autoscaling_group" "netflix-app-asg" {
  name = "netflix-app-asg"

  launch_template {
    id      = aws_launch_template.netflix-app-template.id
    version = "$Latest"
  }

  vpc_zone_identifier = [
    aws_subnet.netflix-pvt-sub-1.id,
    aws_subnet.netflix-pvt-sub-2.id
  ]

  min_size         = 2
  max_size         = 3
  desired_capacity = 2
}

# Create a launch template for the EC2 instances
resource "aws_launch_template" "netflix-app-template" {
  name_prefix   = "netflix-app-template"
  image_id      = "ami-02f624c08a83ca16f"
  instance_type = "t2.medium"
  key_name      = "saurabhteraformkeypair"

  network_interfaces {
    security_groups             = [aws_security_group.netflix-ec2-asg-sg-app.id]
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

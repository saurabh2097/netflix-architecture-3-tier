# Auto Scaling Group for web server
resource "aws_autoscaling_group" "netflix-web-server-asg" {
  name = "swiggy-web-asg"
  
  # Fixing Launch Template reference
  launch_template {
    id      = aws_launch_template.netflix-web-template.id
    version = "$Latest"
  }

  vpc_zone_identifier = [
    aws_subnet.netflix-pub-sub-1.id,
    aws_subnet.netflix-pub-sub-2.id
  ]

  min_size         = 2
  max_size         = 3
  desired_capacity = 2
}

# Launch Template for EC2 Instances
resource "aws_launch_template" "netflix-web-template" {
  name          = "netflix-web-template"
  image_id      = "ami-02f624c08a83ca16f"  
  instance_type = "t2.micro"

   network_interfaces {
    associate_public_ip_address = true
    security_groups = [aws_security_group.netflix-web-sg.id]
  }
  user_data = base64encode(file("netflix.sh"))  # Ensure the file exists

  lifecycle {
    prevent_destroy = false
    ignore_changes  = all
  }
}

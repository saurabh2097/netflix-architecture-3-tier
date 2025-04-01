###### Create an EC2 Auto Scaling Group - web ######
resource "aws_autoscaling_group" "netflix-web-asg" {
  name = "netflix-web-asg"
  launch_template {
    id      = aws_launch_template.netflix-web-template.id
    version = "$Latest"
  }
  vpc_zone_identifier = [aws_subnet.netflix-pub-sub-1.id, aws_subnet.netflix-pub-sub-2.id]
  min_size            = 2
  max_size            = 3
  desired_capacity    = 2
}

###### Create a Launch Template for the EC2 instances ######
resource "aws_launch_template" "netflix-web-template" {
  name_prefix   = "netflix-web-template"
  image_id      = "ami-02f624c08a83ca16f"
  instance_type = "t2.micro"
  key_name      = "saurabhkeypair"
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.netflix-ec2-asg-sg.id]
  }
  user_data = base64encode(file("netflix1.sh"))
  lifecycle {
    prevent_destroy = false
    ignore_changes  = all
  }
}

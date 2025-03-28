# Auto Scaling Group
resource "aws_autoscaling_group" "netflix-web-server-asg" {
name = "swiggy-web-asg"
launch template{
  id  = aws_launch_configuration.netflix-web_config.id
  version = "$Latest"
}
 vpc_zone_identifier = [aws_subnet.netflix-pub-sub-.id, aws_subnet.netflix-pub-sub2.id]
  min_size             = 2
  max_size             = 3
  desired_capacity     = 2
}



# Launch Configuration for EC2 Instances
resource "aws_launch_configuration" "netflix-web_config" {
  name          = "netflix-web-template"
  image_id      = "ami-02f624c08a83ca16f"  
  instance_type = "t2.micro"
  security_groups = [aws_security_group.netflix-web-sg.id]

  user_data = base64encode(file(netflix.sh))
  lifecycle {
    prevent_destroy = false
    ignore_changes  = all

  }
}

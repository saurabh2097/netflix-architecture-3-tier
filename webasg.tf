# Auto Scaling Group
resource "aws_autoscaling_group" "netflix-web-asg" {
name = "swiggy-web-asg"
launch template{
  id  = aws_launch_configuration.netflix-web_config.id
  version = "$Latest"
}
 vpc_zone_identifier = [aws_subnet.swiggy-pub-sub-1.id, aws_subnet.swiggy-pub-sub-2.id]
  min_size             = 2
  max_size             = 3
  desired_capacity     = 2
}



# Launch Configuration for EC2 Instances
resource "aws_launch_configuration" "netflix-web_config" {
  name          = "netflix-web-template"
  image_id      = "ami-0c55b159cbfafe1f0"  # Example AMI, use your own
  instance_type = "t2.micro"
  security_groups = [aws_security_group.web_sg.id]

  user_data = base64encode(file(netflix.sh))
  lifecycle {
    prevent_destroy = false
    ignore_changes  = all

  }
}

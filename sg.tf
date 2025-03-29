# Create a Security Group for web ASG
resource "aws_security_group" "netflix-web-sg" {
  name        = "netflix-web-server-sg"
  description = "Security group for web servers"

  # Allow HTTP traffic from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH access from your IP (replace with your IP)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["YOUR_IP/32"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
tags = {
    Name = "Netflix-web-server-sg"
  }
}

#------ Create a Security Group for Load Balancer
resource "aws_security_group" "netflix-sg-lb" {
  name        = "netflix-alb-security-group"
  description = "Security group for Application Load Balancer to allow HTTP and HTTPS traffic"

  # Allow HTTP traffic (port 80) from anywhere (0.0.0.0/0)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTPS traffic (port 443) from anywhere (0.0.0.0/0)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 # Allow HTTP traffic (port 22) from anywhere (0.0.0.0/0)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic (default behavior)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1 represents all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "netflix-alb-security-group"
  }
}

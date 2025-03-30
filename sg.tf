# Create a Security Group for web ASG
resource "aws_security_group" "netflix-web-sg" {
  name        = "netflix-web-server-sg"
  description = "Security group for web servers"
 vpc_id   = aws_vpc.netflix-vpc.id

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
    cidr_blocks = ["0.0.0.0/0"]
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
 vpc_id   = aws_vpc.netflix-vpc.id

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
    Name = "Netflix-alb-security-group"
  }
}


# Create a Security Group for Application Server-----
resource "aws_security_group" "netflix-app-sg-app" {
  name        = "netflix-app-server-sg"
  description = "Allow HTTP and SSH traffic"
   vpc_id   = aws_vpc.netflix-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP traffic from anywhere
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
tags = {
    Name = "Netflix-app-server-sg"
  }
}


# Security Group for Database
resource "aws_security_group" "netflix-db-sg" {
  name        = "netflix-db-sg"
  description = "Security group for Swiggy Database"
   vpc_id   = aws_vpc.netflix-vpc.id

  ingress {
    from_port = 3306 # MySQL/Aurora port
    to_port   = 3306
    protocol  = "tcp"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Netflix-db-sg"
  }
}

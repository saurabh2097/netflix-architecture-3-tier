# Create Public Subnets
resource "aws_subnet" "netflix-pub-sub-1" {
  vpc_id                  = aws_vpc.netflix-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "netflix-public-subnet-1"
  }
}

resource "aws_subnet" "netflix-pub-sub-2" {
  vpc_id                  = aws_vpc.netflix-vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "netflix-public-subnet-2"
  }
}

# Create Private Subnets for Application Servers
resource "aws_subnet" "netflix-priv-sub-1" {
  vpc_id                  = aws_vpc.netflix-vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "netflix-private-subnet-1"
  }
}

resource "aws_subnet" "netflix-priv-sub-2" {
  vpc_id                  = aws_vpc.netflix-vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "netflix-private-subnet-2"
  }
}

# Create Private Subnets for Databases
resource "aws_subnet" "netflix-db-sub-1" {
  vpc_id                  = aws_vpc.netflix-vpc.id
  cidr_block              = "10.0.5.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "netflix-db-subnet-1"
  }
}

resource "aws_subnet" "netflix-db-sub-2" {
  vpc_id                  = aws_vpc.netflix-vpc.id
  cidr_block              = "10.0.6.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "netflix-db-subnet-2"
  }
}

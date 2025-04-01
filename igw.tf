# Internet Gateway
resource "aws_internet_gateway" "netflix-igw" {
  tags = {
    Name = "netflix-igw"
  }
  vpc_id = aws_vpc.netflix-vpc.id
}

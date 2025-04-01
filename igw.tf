resource "aws_internet_gateway" "netflix-igw" {
  vpc_id = aws_vpc.netflix-vpc.id
  tags = {
    Name = "netflix-igw"
  }
}

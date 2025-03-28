resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.netflix-vpc.id

  tags = {
    Name = "netflix-gw"
  }
}

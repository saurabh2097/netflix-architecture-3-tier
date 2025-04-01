#NatGW
resource "aws_nat_gateway" "netflix-natgw-01" {
  allocation_id = aws_eip.netflix-nat-eip.id
  subnet_id     = aws_subnet.netflix-pub-sub-1.id

  tags = {
    Name = "netflix-natgw-01"
  }
  depends_on = [aws_internet_gateway.netflix-igw]
}

# Create a NAT Gateway
resource "aws_nat_gateway" "netflix-nat-gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "My-NAT-Gateway"
  }
}

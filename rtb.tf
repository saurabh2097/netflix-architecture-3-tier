# Create Route Table for Public Subnets
resource "aws_route_table" "netflix-public-rt" {
  vpc_id = aws_vpc.netflix-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.swiggy-igw.id
  }

  tags = {
    Name = "netflix-public-rt"
  }
}

# Associate Route Table with Public Subnets
resource "aws_route_table_association" "netflix-pub-assoc-1" {
  subnet_id      = aws_subnet.netflix-pub-sub-1.id
  route_table_id = aws_route_table.netflix-public-rt.id
}

resource "aws_route_table_association" "netflix-pub-assoc-2" {
  subnet_id      = aws_subnet.netflix-pub-sub-2.id
  route_table_id = aws_route_table.netflix-public-rt.id
}

# Create a NAT Gateway for Private Subnets
resource "aws_eip" "netflix-nat-eip" {
  domain = "vpc"
  tags = {
    Name = "netflix-nat-eip
}

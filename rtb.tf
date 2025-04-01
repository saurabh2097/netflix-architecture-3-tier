# Create a Route Table
resource "aws_route_table" "netflix-web-rt" {
  vpc_id = aws_vpc.netflix-vpc.id
  tags = {
    Name = "netflix-web-rt"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.netflix-igw.id
  }
}

resource "aws_route_table" "netflix-app-rt" {
  vpc_id = aws_vpc.netflix-vpc.id
  tags = {
    Name = "netflix-app-rt"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.netflix-natgw-01.id
  }
}

# Route Table Association
resource "aws_route_table_association" "netflix-rt-as-1" {
  subnet_id      = aws_subnet.netflix-pub-sub-1.id
  route_table_id = aws_route_table.netflix-web-rt.id
}

resource "aws_route_table_association" "netflix-rt-as-2" {
  subnet_id      = aws_subnet.netflix-pub-sub-2.id
  route_table_id = aws_route_table.netflix-web-rt.id
}

resource "aws_route_table_association" "netflix-rt-as-3" {
  subnet_id      = aws_subnet.netflix-pvt-sub-1.id
  route_table_id = aws_route_table.netflix-app-rt.id
}
resource "aws_route_table_association" "netflix-rt-as-4" {
  subnet_id      = aws_subnet.netflix-pvt-sub-2.id
  route_table_id = aws_route_table.netflix-app-rt.id
}

resource "aws_route_table_association" "netflix-rt-as-5" {
  subnet_id      = aws_subnet.netflix-pvt-sub-3.id
  route_table_id = aws_route_table.netflix-app-rt.id
}
resource "aws_route_table_association" "netflix-rt-as-6" {
  subnet_id      = aws_subnet.netflix-pvt-sub-4.id
  route_table_id = aws_route_table.netflix-app-rt.id
}

# Create an Elastic IP address for the NAT Gateway
resource "aws_eip" "netflix-nat-eip" {
  domain = "vpc"
  tags = {
    Name = "netflix-nat-eip"
  }
}

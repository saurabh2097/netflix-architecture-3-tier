# Create Route Table for Public Subnets
resource "aws_route_table" "netflix-web-rt" {
  vpc_id = aws_vpc.netflix-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.netflix-gw.id
  }

  tags = {
    Name = "netflix-web-rt"
  }
}

# Associate Route Table with Public Subnets
resource "aws_route_table_association" "netflix-pub-assoc-1" {
  subnet_id      = aws_subnet.netflix-pub-sub-1.id
  route_table_id = aws_route_table.netflix-web-rt.id
}

resource "aws_route_table_association" "netflix-pub-assoc-2" {
  subnet_id      = aws_subnet.netflix-pub-sub-2.id
  route_table_id = aws_route_table.netflix-web-rt.id
}


# Create Route Table for Private Subnets
resource "aws_route_table" "netflix-app-rt" {
  vpc_id = aws_vpc.netflix-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.netflix-gw.id
  }

  tags = {
    Name = "netflix-app-rt"
  }
}

# Associate Route Table with Private Subnets
resource "aws_route_table_association" "netflix-pvt-assoc-3" {
  subnet_id      = aws_subnet.netflix-priv-sub-1.id
  route_table_id = aws_route_table.netflix-app-rt.id
}

resource "aws_route_table_association" "netflix-pvt-assoc-4" {
  subnet_id      = aws_subnet.netflix-priv-sub-2.id
  route_table_id = aws_route_table.netflix-app-rt.id
}
# Associate Route Table with DB- Private Subnets
resource "aws_route_table_association" "netflix-pvt-assoc-5" {
  subnet_id      = aws_subnet.netflix-db-sub-1.id
  route_table_id = aws_route_table.netflix-app-rt.id
}

resource "aws_route_table_association" "netflix-pvt-assoc-6" {
  subnet_id      = aws_subnet.netflix-db-sub-2.id
  route_table_id = aws_route_table.netflix-app-rt.id
}

# Create a NAT Gateway for Private Subnets
resource "aws_eip" "netflix-nat-eip" {
  domain = "vpc"
  tags = {
    Name = "netflix-nat-eip"
}
}

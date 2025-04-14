# Create the Internet Gateway
resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "Internet Gateway"
  }
}

# Create NAT Gateway for private route table
resource "aws_eip" "nat_eip" {
  tags = {
    Name = "Elastic IP for NAT"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.public_subnet_ids[0] # Use the first public subnet for NAT Gateway
  depends_on = [ aws_internet_gateway.vpc_igw ]

  tags = {
    Name = "NAT Gateway"
  }
}

# Public Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id # Reference existing VPC ID

  tags = {
    Name = "Public Route Table"
  }
}

# Public Route for Internet Access
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc_igw.id
}

# Associate Public Subnets with the Public Route Table
resource "aws_route_table_association" "public_subnet_association" {
  count         = length(var.public_subnet_ids)
  subnet_id     = var.public_subnet_ids[count.index]
  route_table_id = aws_route_table.public_route_table.id
}

# Private Route Table
resource "aws_route_table" "private_route_table" {
  vpc_id = var.vpc_id # Reference existing VPC ID

  tags = {
    Name = "Private Route Table"
  }
}

# Private Route for NAT Gateway
resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id
  depends_on = [ aws_nat_gateway.nat_gw ]
}

# Associate Private Subnets with the Private Route Table
resource "aws_route_table_association" "private_subnet_association" {
  count         = length(var.private_subnet_ids)
  subnet_id     = var.private_subnet_ids[count.index]
  route_table_id = aws_route_table.private_route_table.id
}


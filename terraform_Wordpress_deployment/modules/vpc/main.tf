resource "aws_vpc" "vpc-dev" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-dev"
  }
}

# Public Subnets
resource "aws_subnet" "public_subnets" {
  vpc_id            = aws_vpc.vpc-dev.id                          
  cidr_block        = var.public_subnets[count.index]  
  availability_zone = data.aws_availability_zones.availability_zones.names[count.index]
  map_public_ip_on_launch = true                           

  count = length(var.public_subnets) # Create a subnet for each CIDR block

  tags = {
    Name = var.public_subnet_names[count.index]
  }
}

# Private Subnets
resource "aws_subnet" "private_subnets" {
  vpc_id            = aws_vpc.vpc-dev.id                         # Existing VPC ID
  cidr_block        = var.private_subnets[count.index]  # Assign CIDR blocks dynamically
  availability_zone = data.aws_availability_zones.availability_zones.names[count.index]   
  map_public_ip_on_launch = false                           # No public IP for private subnets

  count = length(var.private_subnets) # Create a subnet for each CIDR block

  tags = {
    Name = var.private_subnet_names[count.index]
  }
}

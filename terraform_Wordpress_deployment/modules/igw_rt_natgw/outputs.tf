output "aws_internet_gateway" {
  description = "Internet gateway ID"
  value = aws_internet_gateway.vpc_igw.id
}
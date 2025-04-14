variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type = string
}

variable "public_subnets" {
  description = "Cidr for public subnets"
  type = list(string)
}

variable "private_subnets" {
  description = "Cidr for public subnet 1b"
  type = list(string)
}

variable "public_subnet_names" {
  description = "public subnet names"
  type = list(string)
}

variable "private_subnet_names" {
  description = "private subnet names"
  type = list(string)
}

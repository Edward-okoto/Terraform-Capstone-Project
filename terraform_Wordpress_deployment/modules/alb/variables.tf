variable "alb_sg" {
  description = "alb-security-ID"
  type = string
}

variable "public_subnet_ids" {
  description = "public subnets"
  type = list(string)
}

variable "aws_internet_gateway" {
  description = "ig ID"
  type = string
}

variable "vpc_id" {
  description = "vpc ID for target group"
  type = string
}

variable "ec2_sg_sg" {
  description = "ec2-security group ID"
  type = string
}


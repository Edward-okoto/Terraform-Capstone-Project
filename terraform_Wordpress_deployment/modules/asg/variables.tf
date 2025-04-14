variable "alb-ec2-tg" {
  description = "target group for auto-scaling group"
  type = string
}

variable "private_subnet_ids" {
  description = "private subnet ID"
  type = list(string)
}

variable "launch-template" {
  description = "launch template ID"
  type = string
}
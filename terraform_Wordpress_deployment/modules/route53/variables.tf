variable "domain_name" {
  description = "domain-name"
  default = "invincible-cham.co.uk"
  type = string
}

variable "record_name" {
  description = "sub-domain-name"
  default = "www."
  type = string
}

variable "aws_lb_dns" {
  description = "alb dns-name for route53"
  type = string
}

variable "aws_lb_zone" {
  description = "alb zone ID for route53"
  type = string
}
variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
}

variable "public_subnets" {
  description = "Cidr for public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "Cidr for public subnet 1b"
  type        = list(string)
}

variable "public_subnet_names" {
  description = "public subnet names"
  type        = list(string)
}

variable "private_subnet_names" {
  description = "private subnet names"
  type        = list(string)
}

variable "db_name" {
  description = "Name of the database"
  type        = string

}

variable "db_username" {
  description = "Database admin username"
  type        = string
}

variable "db_password" {
  description = "Database admin password"
  type        = string
}

variable "domain_name" {
  description = "domain-name"
  default     = "invincible-cham.co.uk"
  type        = string
}

variable "record_name" {
  description = "sub-domain-name"
  default     = "www."
  type        = string
}
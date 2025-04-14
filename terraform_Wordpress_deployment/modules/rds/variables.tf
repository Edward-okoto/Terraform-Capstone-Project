variable "private_subnet_ids" {
  description = "private subnet group"
  type = list(string)
}

variable "rds_sg_id" {
  description = "rds-security-group"
  type = string
}

variable "db_name" {
  description = "Name of the database"
  type        = string
  default = "Wordpress_db"
  
}

variable "db_username" {
  description = "Database admin username"
  type        = string
}

variable "db_password" {
  description = "Database admin password"
  type        = string
}
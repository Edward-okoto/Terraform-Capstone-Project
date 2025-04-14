# Define BD subnet Group

resource "aws_db_subnet_group" "private_db_subnet_group" {
  name       = "private-db-subnet-group"
  subnet_ids = var.private_subnet_ids  # Pass your private subnet IDs here

  tags = {
    Name = "Private DB Subnet Group"
  }
}


# RDS instance

resource "aws_db_instance" "mysql_rds" {
  identifier              = "mysql-rds-instance"
  engine                  = "mysql"
  engine_version          = "8.0"                # Specify MySQL version
  instance_class          = "db.t3.micro"        # Adjust instance size based on requirements
  allocated_storage       = 20                   # Storage size in GB
  db_name                 = var.db_name          # Database name
  username                = var.db_username      # Admin username
  password                = var.db_password      # Admin password
  db_subnet_group_name    = aws_db_subnet_group.private_db_subnet_group.name
  vpc_security_group_ids  = [var.rds_sg_id]
  publicly_accessible     = false                # Ensure RDS instance is private
  multi_az                = true                 # Enables multi-AZ deployment for high availability
  skip_final_snapshot     = true

  tags = {
    Name = "MySQL RDS Instance"
  }
}
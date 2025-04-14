output "alb_sg" {
  description = "alb-sg ID"
  value = aws_security_group.alb_sg.id
}

output "ec2_sg_sg" {
  description = "ec2-sg ID"
  value = aws_security_group.ec2_sg.id
}

output "rds_sg_id" {
  description = "rds-sg-ID"
  value = aws_security_group.rds_sg.id
}


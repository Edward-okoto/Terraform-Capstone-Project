output "alb-ec2-tg" {
  description = "target group for alb-ec2 ARN"
  value = aws_lb_target_group.alb-ec2-tg.arn
}

output "launch-template" {
  description = "AWS launch template ID"
  value =  aws_launch_template.ec2-launch-template.id
}

output "aws_lb_dns" {
  description = "alb-dns-name"
  value = aws_lb.app_lb.dns_name
}

output "aws_lb_zone" {
  description = "alb-zone ID"
  value = aws_lb.app_lb.zone_id
}
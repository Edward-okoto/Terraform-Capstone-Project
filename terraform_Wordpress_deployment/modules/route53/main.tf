# Create a Hosted Zone for Your Domain

resource "aws_route53_zone" "hosted_zone" {
  name = var.domain_name

  tags = {
    Name = "Invincible Cham Hosted Zone"
  }
}

# Add DNS record set

resource "aws_route53_record" "www_a_record" {
  zone_id = aws_route53_zone.hosted_zone.zone_id
  name    = var.record_name
  type    = "A"
 
 alias {
   name = var.aws_lb_dns
   zone_id = var.aws_lb_zone
   evaluate_target_health = true
 }
}
# Auto-Scaling Group

resource "aws_autoscaling_group" "ec2-asg" {
  max_size = 5
  min_size = 2
  desired_capacity = 2
  name = "Auto scaling group for private instances"
  target_group_arns = [var.alb-ec2-tg]
  vpc_zone_identifier = var.private_subnet_ids

  launch_template {
    id = var.launch-template
    version = "$Latest"
  }
  
  health_check_type = "EC2"
}
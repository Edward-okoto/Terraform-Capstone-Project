# Application load Balancer
resource "aws_lb" "app_lb" {
  name = "app-lb"
  load_balancer_type = "application"
  internal = false
  security_groups = [var.alb_sg]
  subnets = var.public_subnet_ids
  depends_on = [ var.aws_internet_gateway]
}

# Target group for ALB

resource "aws_lb_target_group" "alb-ec2-tg" {
  name = "alb-ec2-target-group"
  port = "80"
  protocol = "HTTP"
  vpc_id = var.vpc_id

  tags = {
    Name = "alb-ec2-target-group"
  }
}

# Listeners

resource "aws_lb_listener" "alb-Listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port = "80"
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.alb-ec2-tg.arn
  }
  
  tags = {
    Name = "alb-Listener"
  }
}

# Launch Template for EC2 instances

resource "aws_launch_template" "ec2-launch-template" {
  name = "ecs-launch-template"
  image_id = "ami-00a929b66ed6e0de6"
  instance_type = "t2.micro"
  network_interfaces {
  associate_public_ip_address = "false"  
  security_groups = [var.ec2_sg_sg]
  }

  user_data = filebase64("${path.module}/userdata.sh")

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "ec2-Webserver"
    }
  }
}
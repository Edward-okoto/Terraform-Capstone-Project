module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = var.vpc_cidr
  public_subnets       = var.public_subnets
  private_subnets      = var.private_subnets
  public_subnet_names  = var.public_subnet_names
  private_subnet_names = var.private_subnet_names

}

module "igw_rt_natgw" {
  source             = "./modules/igw_rt_natgw"
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
}

module "sec_g" {
  source = "./modules/sec_g"
  vpc_id = module.vpc.vpc_id
}

module "asg" {
  source             = "./modules/asg"
  alb-ec2-tg         = module.alb.alb-ec2-tg
  private_subnet_ids = module.vpc.private_subnet_ids
  launch-template    = module.alb.launch-template
}

module "alb" {
  source               = "./modules/alb"
  alb_sg               = module.sec_g.alb_sg
  public_subnet_ids    = module.vpc.public_subnet_ids
  aws_internet_gateway = module.igw_rt_natgw.aws_internet_gateway
  vpc_id               = module.vpc.vpc_id
  ec2_sg_sg            = module.sec_g.ec2_sg_sg
}

module "rds" {
  source             = "./modules/rds"
  private_subnet_ids = module.vpc.private_subnet_ids
  rds_sg_id          = module.sec_g.rds_sg_id
  db_name            = var.db_name
  db_username        = var.db_username
  db_password        = var.db_password

}

module "route53" {
  source      = "./modules/route53"
  domain_name = var.domain_name
  record_name = var.record_name
  aws_lb_dns  = module.alb.aws_lb_dns
  aws_lb_zone = module.alb.aws_lb_zone
}
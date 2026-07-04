module "vpc" {
  source = "./modules/vpc"

  project_name = var.project_name
  environment  = var.environment

  cidr_block = var.cidr_block

  availability_zones = var.availability_zones

  public_subnet_cidrs = var.public_subnet_cidrs

  private_subnet_cidrs = var.private_subnet_cidrs
}

module "security_groups" {
  source = "./modules/security-groups"

  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.vpc.vpc_id
}

module "iam" {
  source = "./modules/iam"

  project_name = var.project_name
  environment  = var.environment
}

module "s3" {
  source = "./modules/s3"

  project_name = var.project_name
  environment  = var.environment
}

module "ec2" {
  source = "./modules/ec2"

  project_name          = var.project_name
  environment           = var.environment
  instance_type         = "t2.micro"

  subnet_id             = module.vpc.public_subnet_ids[0]
  security_group_id     = module.security_groups.ec2_security_group_id
  instance_profile_name = module.iam.ec2_instance_profile_name

  key_name = var.key_name
}

module "keypair" {
  source = "./modules/keypair"

  project_name = var.project_name
  environment  = var.environment
}
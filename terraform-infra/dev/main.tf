locals {
  account = var.account
  region = var.region
  account_id = data.aws_caller_identity.current.account_id
  tags = {
    env_prefix = var.env_prefix
  }
}

module "vpc" {
  source = "../modules/vpc"
  azs = var.azs
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_cidrs = var.public_subnet_cidrs
  tags = local.tags
}

module "argo-cd" {
  source = "../modules/argocd"
  tags = local.tags
}

module "ecr" {
  source = "../modules/ecr"
  tags = local.tags
  repos = var.repos
  branch = var.branch
}

module "jenkins" {
  source = "../modules/jenkins"
  jenkins_props = var.jenkins_properties
  tags = local.tags
  public_subnets = module.vpc.public_subnets
  vpc_id = module.vpc.vpc_id
}


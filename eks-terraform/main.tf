locals {
  cluster_name = "${var.project_name}-${var.environment}"
}

# Fetch available AZs dynamically
data "aws_availability_zones" "available" {
  state = "available"
}

# -- VPC ------------------------------------------------------------------------
module "vpc" {
  source = "./modules/vpc"

  name                = local.cluster_name
  vpc_cidr            = var.vpc_cidr
  availability_zones  = slice(data.aws_availability_zones.available.names, 0, 2)
  public_subnet_cidrs = var.public_subnet_cidrs
  cluster_name        = local.cluster_name # needed for EKS subnet tags
}

# -- IAM ------------------------------------------------------------------------
module "iam" {
  source = "./modules/iam"

  cluster_name = local.cluster_name
}

# -- EKS ------------------------------------------------------------------------
module "eks" {
  source = "./modules/eks"

  cluster_name      = local.cluster_name
  cluster_version   = var.cluster_version
  public_subnet_ids = module.vpc.public_subnet_ids
  cluster_role_arn  = module.iam.cluster_role_arn
  node_role_arn     = module.iam.node_role_arn
  node_groups       = var.node_groups
}

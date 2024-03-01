################################################################################
# Basic VPC
################################################################################

module "aws-basic-vpc" {
    source = "github.com/ludagoli/medium.git//modules/network?ref=v0.0.1"

    name = var.vpc_name
    vpc_cidr = var.vpc_cidr
    azs = var.vpc_azs
    tags = var.tags
    public_subnets = var.vpc_public_subnets
    private_subnets = var.vpc_private_subnets
}

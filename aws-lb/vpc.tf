locals {
  tags = {
    env = "lab",
    stack = "cloud-labs",
  }
  name = "lab-lb"

  region = "eu-central-1" # Frankfort
  azs_list = [ "a", "b", "c" ]

  vpc_cidr = "10.0.0.0/16"
  azs_cidr = [ "10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24" ]
}

module "vpc" {
  source = "../aws-modules/aws-vpc"

  name = local.name
  tags = local.tags

  vpc_cidr = local.vpc_cidr

  region = local.region
  azs_list = local.azs_list
  azs_cidr = local.azs_cidr
}

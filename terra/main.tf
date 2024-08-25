terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source = "/home/ronit/terra/vpc"

  vpc_cidr     = "10.0.0.0/16"
  subnet_count = 2
  subnet_cidr  = ["10.0.1.0/24", "10.0.2.0/24"]
  subnet_az    = ["ap-south-1a", "ap-south-1b"]
  # Variables will be asked during terraform apply if not provided
}



module "lb" {
 source = "./lb"
 vpc_id = module.vpc.vpc_id
 lb_name = "flask-lb"
 public_subnets = module.vpc.public_subnet_id
 instance_ids = module.ec2.instance_ids
}



module "ec2" {
 source = "./ec2"
 vpc_id = module.vpc.vpc_id
 subnet_id = module.vpc.public_subnet_id[0]
 ec2_count = 1
 lb_sg_id = module.lb.sg_id
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "us_west"
  region = "us-west-1"
}

module "vpc_A" {
  source     = "./modules/vpc"
  vpc_name   = var.vpcs["vpc_A"]["vpc_name"]
  vpc_cidr   = var.vpcs["vpc_A"]["cidr_block"]
  owner_name = var.owner_name
}

module "vpc_B" {
  source     = "./modules/vpc"
  vpc_name   = var.vpcs["vpc_B"]["vpc_name"]
  vpc_cidr   = var.vpcs["vpc_B"]["cidr_block"]
  owner_name = var.owner_name
  providers = {
    aws = aws.us_west
  }
}

module "subnetsForvpc_A" {
  for_each          = var.subnetsForvpc_A
  source            = "./modules/subnets"
  vpc_id            = module.vpc_A.vpc_id
  subnet_cidr       = var.subnetsForvpc_A[each.key]["subnet_cidr"]
  subnet_name       = var.subnetsForvpc_A[each.key]["subnet_name"]
  availability_zone = var.subnetsForvpc_A[each.key]["availability_zone"]
  owner_name        = var.owner_name
}

module "subnetsForvpc_B" {
  for_each          = var.subnetsForvpc_B
  source            = "./modules/subnets"
  vpc_id            = module.vpc_B.vpc_id
  subnet_cidr       = var.subnetsForvpc_B[each.key]["subnet_cidr"]
  subnet_name       = var.subnetsForvpc_B[each.key]["subnet_name"]
  availability_zone = var.subnetsForvpc_B[each.key]["availability_zone"]
  owner_name        = var.owner_name
  providers = {
    aws = aws.us_west
  }
}

module "ssh_sg_vpcA" {
  source              = "./modules/security-groups"
  sg_name             = var.sgs["ssh_sg"]["sg_name"]
  sg_description      = var.sgs["ssh_sg"]["sg_description"]
  ingress_description = var.sgs["ssh_sg"]["ingress_description"]
  ingress_from_port   = var.sgs["ssh_sg"]["ingress_from_port"]
  ingress_to_port     = var.sgs["ssh_sg"]["ingress_to_port"]
  ingress_protocol    = var.sgs["ssh_sg"]["ingress_protocol"]
  ingress_cidr_blocks = var.sg_cidr_blocks["ssh_sg"]["ingress_cidr_blocks"]
  owner_name          = var.owner_name
  vpc_id              = module.vpc_A.vpc_id
}

module "ssh_sg_vpcB" {
  source              = "./modules/security-groups"
  sg_name             = var.sgs["ssh_sg"]["sg_name"]
  sg_description      = var.sgs["ssh_sg"]["sg_description"]
  ingress_description = var.sgs["ssh_sg"]["ingress_description"]
  ingress_from_port   = var.sgs["ssh_sg"]["ingress_from_port"]
  ingress_to_port     = var.sgs["ssh_sg"]["ingress_to_port"]
  ingress_protocol    = var.sgs["ssh_sg"]["ingress_protocol"]
  ingress_cidr_blocks = var.sg_cidr_blocks["ssh_sg"]["ingress_cidr_blocks"]
  owner_name          = var.owner_name
  vpc_id              = module.vpc_B.vpc_id
  providers = {
    aws = aws.us_west
  }
}

module "icmp_sg_vpcA" {
  source              = "./modules/security-groups"
  sg_name             = var.sgs["icmp_sg"]["sg_name"]
  sg_description      = var.sgs["icmp_sg"]["sg_description"]
  ingress_description = var.sgs["icmp_sg"]["ingress_description"]
  ingress_from_port   = var.sgs["icmp_sg"]["ingress_from_port"]
  ingress_to_port     = var.sgs["icmp_sg"]["ingress_to_port"]
  ingress_protocol    = var.sgs["icmp_sg"]["ingress_protocol"]
  ingress_cidr_blocks = var.sg_cidr_blocks["icmp_sg"]["ingress_cidr_blocks_for_vpcA"]
  owner_name          = var.owner_name
  vpc_id              = module.vpc_A.vpc_id
}

module "icmp_sg_vpcB" {
  source              = "./modules/security-groups"
  sg_name             = var.sgs["icmp_sg"]["sg_name"]
  sg_description      = var.sgs["icmp_sg"]["sg_description"]
  ingress_description = var.sgs["icmp_sg"]["ingress_description"]
  ingress_from_port   = var.sgs["icmp_sg"]["ingress_from_port"]
  ingress_to_port     = var.sgs["icmp_sg"]["ingress_to_port"]
  ingress_protocol    = var.sgs["icmp_sg"]["ingress_protocol"]
  ingress_cidr_blocks = var.sg_cidr_blocks["icmp_sg"]["ingress_cidr_blocks_for_vpcB"]
  owner_name          = var.owner_name
  vpc_id              = module.vpc_B.vpc_id
  providers = {
    aws = aws.us_west
  }
}

module "ec2_vpcA" {
  source        = "./modules/ec2"
  subnet_id     = module.subnetsForvpc_A["subnet1"].subnet_id  
  ami_id        = var.ec2s["ec2_vpcA"]["ami_id"]
  instance_type = var.ec2s["ec2_vpcA"]["instance_type"]
  ec2_name      = var.ec2s["ec2_vpcA"]["ec2_name"]
  key_name      = var.ec2s["ec2_vpcA"]["key_name"]
  ssh_sg_id     = module.ssh_sg_vpcA.sg_id
  icmp_sg_id    = module.icmp_sg_vpcA.sg_id
  owner_name    = var.owner_name
}

module "ec2_vpcB" {
  source        = "./modules/ec2"
  subnet_id     = module.subnetsForvpc_B["subnet1"].subnet_id
  ami_id        = var.ec2s["ec2_vpcB"]["ami_id"]
  instance_type = var.ec2s["ec2_vpcB"]["instance_type"]
  ec2_name      = var.ec2s["ec2_vpcB"]["ec2_name"]
  key_name      = var.ec2s["ec2_vpcB"]["key_name"]
  ssh_sg_id     = module.ssh_sg_vpcB.sg_id
  icmp_sg_id    = module.icmp_sg_vpcB.sg_id
  owner_name    = var.owner_name
  providers = {
    aws = aws.us_west
  }
}

module "igw_vpcA" {
  source     = "./modules/internet-gateways"
  vpc_id     = module.vpc_A.vpc_id
  igw_name   = var.igws["igw_vpcA"]["name"]
  owner_name = var.owner_name
}

module "igw_vpcB" {
  source     = "./modules/internet-gateways"
  vpc_id     = module.vpc_B.vpc_id
  igw_name   = var.igws["igw_vpcB"]["name"]
  owner_name = var.owner_name
  providers = {
    aws = aws.us_west
  }
}

module "vpc_peering" {
  source       = "./modules/vpc-peering"
  peer_vpc_id  = module.vpc_B.vpc_id
  vpc_id       = module.vpc_A.vpc_id
  vpcpeer_name = var.vpcpeer_name
  owner_name   = var.owner_name
}

module "vpc_peering_accepter" {
  source         = "./modules/vpc-peering-accepter"
  vpc_peering_id = module.vpc_peering.aws_vpc_peering_connection_id
  owner_name     = var.owner_name
  providers = {
    aws = aws.us_west
  }
}

module "vpc_peering_configureA" {
  source                    = "./modules/vpc_peer_configure"
  vpc_peering_connection_id = module.vpc_peering_accepter.aws_vpc_peering_connection_accepter
}

module "vpc_peering_configureB" {
  source                    = "./modules/vpc_peer_configure"
  vpc_peering_connection_id = module.vpc_peering_accepter.aws_vpc_peering_connection_accepter
  providers = {
    aws = aws.us_west
  }
}

module "route_table_vpcA_pcgw" {
  source                    = "./modules/route-table"
  route_table_id            = module.vpc_A.default_route_table_id
  destination_cidr_block    = var.destination_cidr_blocks_for_routetable["for_route_vpcA"]["pcgw_cidr"]
  vpc_peering_connection_id = module.vpc_peering.aws_vpc_peering_connection_id
  gateway_id                = ""
}

module "route_table_vpcB_pcgw" {
  source                    = "./modules/route-table"
  route_table_id            = module.vpc_B.default_route_table_id
  destination_cidr_block    = var.destination_cidr_blocks_for_routetable["for_route_vpcB"]["pcgw_cidr"]
  vpc_peering_connection_id = module.vpc_peering.aws_vpc_peering_connection_id
  gateway_id                = ""
  providers = {
    aws = aws.us_west
  }
}

module "route_table_vpcA_igw" {
  source                    = "./modules/route-table"
  route_table_id            = module.vpc_A.default_route_table_id
  destination_cidr_block    = var.destination_cidr_blocks_for_routetable["for_route_vpcA"]["igw_cidr"]
  gateway_id                = module.igw_vpcA.igw_id
  vpc_peering_connection_id = ""
}

module "route_table_vpcB_igw" {
  source                    = "./modules/route-table"
  route_table_id            = module.vpc_B.default_route_table_id
  destination_cidr_block    = var.destination_cidr_blocks_for_routetable["for_route_vpcB"]["igw_cidr"]
  gateway_id                = module.igw_vpcB.igw_id
  vpc_peering_connection_id = ""
  providers = {
    aws = aws.us_west
  }
}
terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "~> 5.0"
      configuration_aliases = [aws.us_west]
    }
  }
}

provider "aws" {
  alias  = "us_west"
  region = "us-west-1"
}

resource "aws_vpc_peering_connection" "vpc_peering" {
  peer_vpc_id = var.peer_vpc_id
  vpc_id      = var.vpc_id
  peer_region = "us-west-1"
  tags = {
    Name       = var.vpcpeer_name
    Created_by = var.owner_name
  }
}
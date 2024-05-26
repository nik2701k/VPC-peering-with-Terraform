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

resource "aws_internet_gateway" "i_gw" {
  vpc_id = var.vpc_id

  tags = {
    Name       = var.igw_name
    created_by = var.owner_name
  }
}
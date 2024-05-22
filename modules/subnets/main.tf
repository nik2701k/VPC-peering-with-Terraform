terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
      # configuration_aliases = [aws.us_west]
    }
  }
}

# provider "aws" {
#   alias  = "us_west"
#   region = "us-west-1"
# }

resource "aws_subnet" "main_subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cidr
  availability_zone = var.availability_zone

  tags = {
    Name       = var.subnet_name
    Created_by = var.owner_name
  }
}
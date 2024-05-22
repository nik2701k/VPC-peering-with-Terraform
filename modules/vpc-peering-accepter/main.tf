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

resource "aws_vpc_peering_connection_accepter" "peer_vpc_AB" {
  provider = aws.us_west

  vpc_peering_connection_id = var.vpc_peering_id
  auto_accept               = true

  tags = {
    Side       = "Accepter"
    owner_name = var.owner_name
  }
}
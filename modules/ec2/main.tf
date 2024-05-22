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

resource "aws_instance" "my_ec2" {

  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  key_name                    = var.key_name

  tags = {
    Name       = var.ec2_name
    Created_by = var.owner_name
  }
}

resource "aws_network_interface_sg_attachment" "ssh_sg_attachment" {
  security_group_id    = var.ssh_sg_id
  network_interface_id = aws_instance.my_ec2.primary_network_interface_id
}

resource "aws_network_interface_sg_attachment" "icmp_sg_attachment" {
  security_group_id    = var.icmp_sg_id
  network_interface_id = aws_instance.my_ec2.primary_network_interface_id
}
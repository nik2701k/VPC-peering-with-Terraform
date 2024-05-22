owner_name = ""

vpcs = {
  "vpc_A" = {
    vpc_name   = ""
    cidr_block = ""
  }
  "vpc_B" = {
    vpc_name   = ""
    cidr_block = ""
  }
}

subnetsForvpc_A = {
  "subnet1" = {
    subnet_cidr       = ""
    subnet_name       = ""
    availability_zone = ""
  }
  "subnet2" = {
    subnet_cidr       = ""
    subnet_name       = ""
    availability_zone = ""
  }
  "subnet3" = {
    subnet_cidr       = ""
    subnet_name       = ""
    availability_zone = ""
  }
}

subnetsForvpc_B = {
  "subnet1" = {
    subnet_cidr       = ""
    subnet_name       = ""
    availability_zone = ""
  }
  "subnet2" = {
    subnet_cidr       = ""
    subnet_name       = ""
    availability_zone = ""
  }
}

sgs = {
  "ssh_sg" = {
    sg_name             = ""
    sg_description      = ""
    ingress_description = ""
    ingress_from_port   = ""
    ingress_to_port     = ""
    ingress_protocol    = ""
  }
  "icmp_sg" = {
    sg_name             = ""
    sg_description      = ""
    ingress_description = ""
    ingress_from_port   = ""
    ingress_to_port     = ""
    ingress_protocol    = ""
  }
}

sg_cidr_blocks = {
  "ssh_sg" = {
    ingress_cidr_blocks = [""]
  }
  "icmp_sg" = {
    ingress_cidr_blocks_for_vpcA = [""]
    ingress_cidr_blocks_for_vpcB = [""]
  }
}

ec2s = {
  "ec2_vpcA" = {
    ami_id        = ""
    instance_type = ""
    ec2_name      = ""
    key_name      = ""
  }
  "ec2_vpcB" = {
    ami_id        = ""
    instance_type = ""
    ec2_name      = ""
    key_name      = ""
  }
}

igws = {
  "igw_vpcA" = {
    name = ""
  }
  "igw_vpcB" = {
    name = ""
  }
}

vpcpeer_name = ""

destination_cidr_blocks_for_routetable = {
  "for_route_vpcA" = {
    pcgw_cidr = ""
    igw_cidr  = ""
  }
  "for_route_vpcB" = {
    pcgw_cidr = ""
    igw_cidr  = ""
  }
}
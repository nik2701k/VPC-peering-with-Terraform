owner_name = "NIKUNJ"

vpcs = {
  "vpc_A" = {
    vpc_name   = "vpc-us-east1"
    cidr_block = "10.1.0.0/16"
  }
  "vpc_B" = {
    vpc_name   = "vpc-us-west1"
    cidr_block = "10.2.0.0/16"
  }
}

subnetsForvpc_A = {
  "subnet1" = {
    subnet_cidr       = "10.1.0.0/20"
    subnet_name       = "subnet-us-east1a"
    availability_zone = "us-east-1a"
  }
  "subnet2" = {
    subnet_cidr       = "10.1.16.0/20"
    subnet_name       = "subnet-us-east1b"
    availability_zone = "us-east-1b"
  }
  "subnet3" = {
    subnet_cidr       = "10.1.32.0/20"
    subnet_name       = "subnet-us-east1c"
    availability_zone = "us-east-1c"
  }
}

subnetsForvpc_B = {
  "subnet1" = {
    subnet_cidr       = "10.2.0.0/20"
    subnet_name       = "subnet-us-west1a"
    availability_zone = "us-west-1a"
  }
  "subnet2" = {
    subnet_cidr       = "10.2.16.0/20"
    subnet_name       = "subnet-us-west1b"
    availability_zone = "us-west-1b"
  }
}

sgs = {
  "ssh_sg" = {
    sg_name             = "allow_ssh"
    sg_description      = "To allow SSH from MyIP"
    ingress_description = "SSH for MyIP"
    ingress_from_port   = "22"
    ingress_to_port     = "22"
    ingress_protocol    = "tcp"
  }
  "icmp_sg" = {
    sg_name             = "allow_ping_traffic"
    sg_description      = "To allow ping from MyIP"
    ingress_description = "Ping from MyIP"
    ingress_from_port   = "8"
    ingress_to_port     = "0"
    ingress_protocol    = "icmp"
  }
}

sg_cidr_blocks = {
  "ssh_sg" = {
    ingress_cidr_blocks = ["12.34.56.78/32"] #Mention the IP from where ssh to ec2 should be allowed
  }
  "icmp_sg" = {
    ingress_cidr_blocks_for_vpcA = ["10.2.0.0/16"]
    ingress_cidr_blocks_for_vpcB = ["10.1.0.0/16"]
  }
}

ec2s = {
  "ec2_vpcA" = {
    ami_id        = "ami-0e8a34246278c21e4"
    instance_type = "t2.micro"
    ec2_name      = "ec2-us-east1"
    key_name      = "us-east-1-demo"
  }
  "ec2_vpcB" = {
    ami_id        = "ami-09ab9d570789dfdd4"
    instance_type = "t2.micro"
    ec2_name      = "ec2-us-west1"
    key_name      = "us-west-1-demo"
  }
}

igws = {
  "igw_vpcA" = {
    name = "igw_vpcA"
  }
  "igw_vpcB" = {
    name = "igw_vpcB"
  }
}

vpcpeer_name = "vpc_AB_peering"

destination_cidr_blocks_for_routetable = {
  "for_route_vpcA" = {
    pcgw_cidr = "10.2.0.0/16"
    igw_cidr  = "0.0.0.0/0"
  }
  "for_route_vpcB" = {
    pcgw_cidr = "10.1.0.0/16"
    igw_cidr  = "0.0.0.0/0"
  }
}
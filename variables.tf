variable "vpcs" {
  type = map(map(string))
}

variable "subnetsForvpc_A" {
  type = map(map(string))
}

variable "subnetsForvpc_B" {
  type = map(map(string))
}

variable "sgs" {
  type = map(map(string))
}

variable "owner_name" {
  type = string
}

variable "ec2s" {
  type = map(map(string))
}

variable "sg_cidr_blocks" {
  type = map(map(list(string)))
}

variable "igws" {
  type = map(map(string))
}

variable "vpcpeer_name" {
  type = string
}

variable "destination_cidr_blocks_for_routetable" {
  type = map(map(string))
}
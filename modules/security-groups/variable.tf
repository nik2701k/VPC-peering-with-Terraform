variable "sg_name" {
  type = string
}

variable "owner_name" {
  type = string
}

variable "vpc_id" {
  description = "The ID of the VPC to create the subnet in"
  type        = string
}

variable "sg_description" {
  type = string
}

variable "ingress_description" {
  type = string
}

variable "ingress_from_port" {
  type = string
}

variable "ingress_to_port" {
  type = string
}

variable "ingress_protocol" {
  type = string
}

variable "ingress_cidr_blocks" {
  type = list(string)
}
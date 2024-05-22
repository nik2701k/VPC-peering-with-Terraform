variable "subnet_name" {
  type = string
}

variable "subnet_cidr" {
  type = string
}

variable "owner_name" {
  type = string
}

variable "availability_zone" {
  type = string
}

variable "vpc_id" {
  description = "The ID of the VPC to create the subnet in"
  type        = string
}
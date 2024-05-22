# vpc/outputs.tf
output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "default_route_table_id" {
  value = aws_vpc.main_vpc.default_route_table_id
}
# Output the VPC peering connection ID
output "vpc_peering_connection_id" {
  value = aws_vpc_peering_connection.tokyo_sydney_peering.id
}
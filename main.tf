# Create VPC Peering Connection
resource "aws_vpc_peering_connection" "tokyo_sydney_peering" {
  provider      = aws.tokyo
  vpc_id        = data.aws_vpc.tokyo_vpc.id
  peer_vpc_id   = data.aws_vpc.sydney_vpc.id
  peer_region   = "ap-southeast-2"
  auto_accept   = false

  tags = {
    Name = "Tokyo-Sydney-VPC-Peering"
  }
}

# Accept VPC peering connection in Sydney region
resource "aws_vpc_peering_connection_accepter" "sydney_accepter" {
  provider                  = aws.sydney
  vpc_peering_connection_id = aws_vpc_peering_connection.tokyo_sydney_peering.id
  auto_accept               = true

  tags = {
    Name = "Sydney-Tokyo-VPC-Peering-Accepter"
  }
}

# Create route to Sydney VPC from Tokyo VPC
resource "aws_route" "tokyo_to_sydney" {
  provider                  = aws.tokyo
  count                     = length(data.aws_route_tables.tokyo_route_tables.ids)
  route_table_id            = data.aws_route_tables.tokyo_route_tables.ids[count.index]
  destination_cidr_block    = "10.0.0.0/16"  # Sydney VPC CIDR
  vpc_peering_connection_id = aws_vpc_peering_connection.tokyo_sydney_peering.id
}

# Create route to Tokyo VPC from Sydney VPC
resource "aws_route" "sydney_to_tokyo" {
  provider                  = aws.sydney
  count                     = length(data.aws_route_tables.sydney_route_tables.ids)
  route_table_id            = data.aws_route_tables.sydney_route_tables.ids[count.index]
  destination_cidr_block    = "10.50.0.0/16"  # Tokyo VPC CIDR
  vpc_peering_connection_id = aws_vpc_peering_connection.tokyo_sydney_peering.id
}

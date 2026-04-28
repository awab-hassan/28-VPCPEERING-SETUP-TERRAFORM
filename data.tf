# Reference existing VPCs
data "aws_vpc" "tokyo_vpc" {
  provider = aws.tokyo
  id       = "vpc-XXX"
}

data "aws_vpc" "sydney_vpc" {
  provider = aws.sydney
  id       = "vpc-XXX"
}

# Get all route tables for both VPCs
data "aws_route_tables" "tokyo_route_tables" {
  provider = aws.tokyo
  vpc_id   = data.aws_vpc.tokyo_vpc.id
}

data "aws_route_tables" "sydney_route_tables" {
  provider = aws.sydney
  vpc_id   = data.aws_vpc.sydney_vpc.id
}

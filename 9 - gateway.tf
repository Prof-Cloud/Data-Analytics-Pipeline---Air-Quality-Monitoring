#S3 Endpoint
resource "aws_vpc_endpoint" "s3_gateway" {
  vpc_id       = aws_vpc.vpc.id
  service_name = "com.amazonaws.${data.aws_region.current.name}.s3"

  # Gateway Endpoints
  vpc_endpoint_type = "Gateway"

  tags = {
    Name = "S3 VPC Endpoint"
  }
}

# Connecting the endpoint to VPC Route Table
resource "aws_vpc_endpoint_route_table_association" "s3_routing" {
  route_table_id  = aws_vpc.vpc.main_route_table_id
  vpc_endpoint_id = aws_vpc_endpoint.s3_gateway.id
}

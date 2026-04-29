#VPC in London region
resource "aws_vpc" "vpc" {
  cidr_block           = "10.53.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "Air Quality VPC"

  }
}

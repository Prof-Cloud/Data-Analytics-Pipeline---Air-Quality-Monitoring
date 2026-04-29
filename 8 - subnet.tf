#Private Subnets - London
resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.vpc.id

  cidr_block = "10.53.11.0/24"

  tags = {

    Name = "Private Subnet"
  }
}

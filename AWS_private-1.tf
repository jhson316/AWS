# Private망 Subnet 생성
resource "aws_subnet" "pri_sub1-1" {
  vpc_id     = aws_vpc.VPC_test-1.id
  cidr_block = "193.17.10.0/24"
  tags = {
    "Name" = "VPC Test pri_sub1-1"
  }
}

resource "aws_subnet" "pri_sub2-1" {
  vpc_id     = aws_vpc.VPC_test-1.id
  cidr_block = "193.17.11.0/24"
  tags = {
    "Name" = "VPC Test pri_sub2-1"
  }
}

# NAT gateway 생성을 위한 EIP(Elastic IP) 생성
resource "aws_eip" "ngw_ip-1" {
  vpc = true
  lifecycle {
    create_before_destroy = true
  }
}

# NAT gateway 생성 및 EIP와 매핑
resource "aws_nat_gateway" "ngw-1" {
  allocation_id = aws_eip.ngw_ip-1.id
  subnet_id     = aws_subnet.pri_sub1-1.id
  tags = {
    Name = "NAT Gateway-1"
  }
}

# Private망 라우팅 생성
resource "aws_route_table" "private_rt-1" {
  vpc_id = aws_vpc.VPC_test-1.id

  tags = {
    Name = "private route table-1"
  }
}
# Private망 라우팅 설정??
resource "aws_route" "private_rt-1_route" {
  route_table_id         = aws_route_table.private_rt-1.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw-1.id
}

# Private망 Subnet에 Default Gateway 라우팅 매칭
resource "aws_route_table_association" "private_rta_a-1" {
  subnet_id      = aws_subnet.pri_sub1-1.id
  route_table_id = aws_route_table.private_rt-1.id
}

resource "aws_route_table_association" "private_rta_b-1" {
  subnet_id      = aws_subnet.pri_sub2-1.id
  route_table_id = aws_route_table.private_rt-1.id
}

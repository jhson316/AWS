# Private망 Subnet 생성
resource "aws_subnet" "pri_sub1-2" {
  vpc_id     = aws_vpc.VPC_test-2.id
  cidr_block = "193.18.10.0/24"
  tags = {
    "Name" = "VPC Test pri_sub1-2"
  }
}

resource "aws_subnet" "pri_sub2-2" {
  vpc_id     = aws_vpc.VPC_test-2.id
  cidr_block = "193.18.11.0/24"
  tags = {
    "Name" = "VPC Test pri_sub2-2"
  }
}

# NAT gateway 생성을 위한 EIP(Elastic IP) 생성
resource "aws_eip" "ngw_ip-2" {
  vpc = true
  lifecycle {
    create_before_destroy = true
  }
}

# NAT gateway 생성 및 EIP와 매핑
resource "aws_nat_gateway" "ngw-2" {
  allocation_id = aws_eip.ngw_ip-2.id
  subnet_id     = aws_subnet.pri_sub1-2.id
  tags = {
    Name = "NAT Gateway-2"
  }
}

# Private망 라우팅 생성
resource "aws_route_table" "private_rt-2" {
  vpc_id = aws_vpc.VPC_test-2.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw-2.id
  }
  tags = {
    Name = "private route table-2"
  }
}
# Private망 라우팅 설정??
# resource "aws_route" "private_rt-2_route" {
#     route_table_id              = aws_route_table.private_rt-2.id
#     destination_cidr_block      = "0.0.0.0/0"
#     nat_gateway_id              = aws_nat_gateway.ngw-2.id
# }

# Private망 Subnet에 Default Gateway 라우팅 매칭
resource "aws_route_table_association" "private_rta_a-2" {
  subnet_id      = aws_subnet.pri_sub1-2.id
  route_table_id = aws_route_table.private_rt-2.id
}

resource "aws_route_table_association" "private_rta_b-2" {
  subnet_id      = aws_subnet.pri_sub2-2.id
  route_table_id = aws_route_table.private_rt-2.id
}

# Private망 Subnet 생성
resource "aws_subnet" "pri_sub1" {
  vpc_id     = aws_vpc.VPC_test.id
  cidr_block = "193.17.10.0/24"
  tags = {
    "Name" = "VPC Test pri_sub1"
  }
}

resource "aws_subnet" "pri_sub2" {
  vpc_id     = aws_vpc.VPC_test.id
  cidr_block = "193.17.11.0/24"
  tags = {
    "Name" = "VPC Test pri_sub2"
  }
}

# NAT gateway 생성을 위한 EIP(Elastic IP) 생성
resource "aws_eip" "ngw_ip" {
  vpc = true
  lifecycle {
    create_before_destroy = true
  }
}

# NAT gateway 생성 및 EIP와 매핑
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.ngw_ip.id
  subnet_id     = aws_subnet.pri_sub1.id
    tags = {
    Name = "NAT Gateway"
  }
}

# Private망 라우팅 생성
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.VPC_test.id
  tags = {
    Name = "private route table"
  }
}
# Private망 라우팅 설정??
resource "aws_route" "private_rt_route" {
    route_table_id              = aws_route_table.private_rt.id
    destination_cidr_block      = "0.0.0.0/0"
    nat_gateway_id              = aws_nat_gateway.ngw.id
}

# Private망 Subnet에 Default Gateway 라우팅 매칭
resource "aws_route_table_association" "private_rta_a" {
  subnet_id      = aws_subnet.pri_sub1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_rta_b" {
  subnet_id      = aws_subnet.pri_sub2.id
  route_table_id = aws_route_table.private_rt.id
}

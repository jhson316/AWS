# VPC 생성
resource "aws_vpc" "VPC_test" {
  cidr_block = "193.17.0.0/16"

  tags = {
    Name = "VPC Test"
  }
}

# Subnet 생성
resource "aws_subnet" "pub_sub1" {
  vpc_id     = aws_vpc.VPC_test.id
  cidr_block = "193.17.0.0/24"
  tags = {
    "Name" = "VPC Test pub_sub1"
  }
}

resource "aws_subnet" "pub_sub2" {
  vpc_id     = aws_vpc.VPC_test.id
  cidr_block = "193.17.1.0/24"
  tags = {
    "Name" = "VPC Test pub_sub2"
  }
}

resource "aws_subnet" "Pri_sub1" {
  vpc_id     = aws_vpc.VPC_test.id
  cidr_block = "193.17.10.0/24"
  tags = {
    "Name" = "VPC Test Pri_sub1"
  }
}

resource "aws_subnet" "Pri_sub2" {
  vpc_id     = aws_vpc.VPC_test.id
  cidr_block = "193.17.11.0/24"
  tags = {
    "Name" = "VPC Test Pri_sub2"
  }
}

# Internet gateway 생성
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.VPC_test.id

  tags = {
    Name = "Internet Gateway"
  }
}

# NAT gateway 생성을 위한 Elastic IP 생성
resource "aws_eip" "ngw_ip" {
  vpc = true

  lifecycle {
    create_before_destroy = true
  }
}

# NAT gateway 생성
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.ngw_ip.id
  subnet_id     = aws_subnet.pub_sub1.id

  tags = {
    Name = "NAT Gateway"
  }
}

# Default Gateway 라우팅 설정
resource "aws_default_route_table" "public_rt" {
  default_route_table_id = aws_vpc.VPC_test.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public route table"
  }
}

# Subnet(pub_sub1, pub_sub2)에 Default Gateway 라우팅 매칭
resource "aws_route_table_association" "public_rta_a" {
    subnet_id      = aws_subnet.pub_sub1.id
    route_table_id = aws_default_route_table.public_rt.id
}

resource "aws_route_table_association" "public_rta_b" {
    subnet_id      = aws_subnet.pub_sub2.id
    route_table_id = aws_default_route_table.public_rt.id
}

# 내부망 라우팅 설정
resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.VPC_test.id
    tags = {
        Name = "private route table"
    }
}
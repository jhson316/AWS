# Public망 Subnet 생성
resource "aws_subnet" "pub_sub1" {
  vpc_id     = aws_vpc.VPC_test.id
  # availability_zone = aws_instance.app_server.availability_zone
  availability_zone = "ap-northeast-2a"
  cidr_block = "193.17.0.0/24"
  tags = {
    Name = "VPC Test pub_sub1"
  }
}

resource "aws_route_table" "pub_route_table" {
  vpc_id = aws_vpc.VPC_test.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "VPC TEST Public Route Table"
  }
}

# resource "aws_subnet" "pub_sub2" {
#   vpc_id     = aws_vpc.VPC_test.id
#   cidr_block = "193.17.1.0/24"
#   tags = {
#     Name = "VPC Test pub_sub2"
#   }
# }

# # Public망 Default GW 라우팅 설정
# resource "aws_default_route_table" "public_rt" {
#   default_route_table_id = aws_vpc.VPC_test.default_route_table_id
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.igw.id
#   }
#   tags = {
#     Name = "public route table"
#   }
# }

# # Public망 Subnet에 Default Gateway 라우팅 매핑
# resource "aws_route_table_association" "public_rta_a" {
#   subnet_id      = aws_subnet.pub_sub1.id
#   route_table_id = aws_default_route_table.public_rt.id
# }

# resource "aws_route_table_association" "public_rta_b" {
#   subnet_id      = aws_subnet.pub_sub2.id
#   route_table_id = aws_default_route_table.public_rt.id
# }

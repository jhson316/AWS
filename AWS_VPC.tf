# VPC 생성
resource "aws_vpc" "VPC_test" {
  cidr_block = "193.17.0.0/16"

  tags = {
    Name = "VPC Test"
  }
}

# Internet gateway 생성
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.VPC_test.id

  tags = {
    Name = "Internet Gateway"
  }
}
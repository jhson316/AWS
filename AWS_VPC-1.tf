# VPC 생성
resource "aws_vpc" "VPC_test-1" {
  cidr_block = "193.17.0.0/16"

  tags = {
    Name = "VPC Test-1"
  }
}

# Internet gateway 생성
resource "aws_internet_gateway" "igw-1" {
  vpc_id = aws_vpc.VPC_test-1.id

  tags = {
    Name = "Internet Gateway-1"
  }
}
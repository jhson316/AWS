# VPC 생성
resource "aws_vpc" "VPC_test-2" {
  cidr_block = "193.18.0.0/16"

  tags = {
    Name = "VPC Test-2"
  }
}

# Internet gateway 생성
resource "aws_internet_gateway" "igw-2" {
  vpc_id = aws_vpc.VPC_test-2.id

  tags = {
    Name = "Internet Gateway-2"
  }
}
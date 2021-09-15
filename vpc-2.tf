#vpc-2
resource "aws_vpc" "vpc-2" {
  cidr_block = "10.11.0.0/16"
  tags = {
    Name     = "vpc-2"
    scenario = var.scenario
    env      = "dev"
  }
}

#public subnet
resource "aws_subnet" "vpc-2-sub-a" {
  vpc_id            = aws_vpc.vpc-2.id
  cidr_block        = "10.11.1.0/24"
  availability_zone = var.az1

  tags = {
    #Name = aws_vpc.vpc-2.tags.Name-sub-a
    Name = "vpc-2-sub-a"
  }
}

#Private subnets
resource "aws_subnet" "vpc-2-sub-b" {
  vpc_id            = aws_vpc.vpc-2.id
  cidr_block        = "10.11.2.0/24"
  availability_zone = var.az2

  tags = { Name = "vpc-2-sub-b" }
}

resource "aws_subnet" "vpc-2-sub-c" {
  vpc_id            = aws_vpc.vpc-2.id
  cidr_block        = "10.11.3.0/24"
  availability_zone = var.az3

  tags = { Name = "vpc-2-sub-c" }
}

# Internet Gateway

resource "aws_internet_gateway" "vpc-2-igw" {
  vpc_id = aws_vpc.vpc-2.id

  tags = {
    Name = "vpc-2-igw"
  }
}

#Rt.table
resource "aws_route_table" "vpc-2-rt" {
  vpc_id = aws_vpc.vpc-2.id

  route {
    cidr_block         = "10.0.0.0/8"
    transit_gateway_id = aws_ec2_transit_gateway.test-tgw.id
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc-2-igw.id
  }


  tags = {
    Name     = "vpc-2-rt"
    env      = "dev & prod"
    scenario = var.scenario
  }
  depends_on = [aws_ec2_transit_gateway.test-tgw]
}

#resource "aws_main_route_table_association" "main-rt-association-for-vpc-2" {
#  vpc_id         = aws_vpc.vpc-2.id
#  route_table_id = aws_route_table.vpc-2-rt.id
#}

resource "aws_route_table_association" "rt-external-association-2" {
  subnet_id      = aws_subnet.vpc-2-sub-a.id
  route_table_id = aws_route_table.vpc-2-rt.id
}

###

resource "aws_eip" "nat-2" {
  vpc = true
}

resource "aws_nat_gateway" "vpc-2-nat-2-gw" {
  allocation_id = aws_eip.nat-2.id
  subnet_id     = aws_subnet.vpc-2-sub-a.id
  depends_on    = [aws_internet_gateway.vpc-2-igw]
  tags = {
    Name = "vpc2-nat-2-gw"
  }
}

# route table for  NAT Gateway
resource "aws_route_table" "rt-vpc-2-internal" {
  vpc_id = aws_vpc.vpc-2.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.vpc-2-nat-2-gw.id
  }

  route {
    cidr_block     = "10.0.0.0/8"
        transit_gateway_id = aws_ec2_transit_gateway.test-tgw.id
  }

  tags = {
    Name = "vpc-2-nat-2-gw-route-table"
  }
}

# NAT Gateway route table association for internal subnet.
resource "aws_route_table_association" "rt-internal-association-2-b" {
  subnet_id      = aws_subnet.vpc-2-sub-b.id
  route_table_id = aws_route_table.rt-vpc-2-internal.id
}

resource "aws_route_table_association" "rt-internal-association-2-c" {
  subnet_id      = aws_subnet.vpc-2-sub-c.id
  route_table_id = aws_route_table.rt-vpc-2-internal.id
}

#vpc-1
resource "aws_vpc" "vpc-1" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_hostnames = true #assigns a host name to an ec2 instance
  tags = {
    Name     = "vpc-1"
    scenario = var.scenario
    env      = "attack"
  }
}

# Public subnets
resource "aws_subnet" "vpc-1-sub-a" {
  vpc_id                  = aws_vpc.vpc-1.id
  cidr_block              = "10.10.1.0/24"
  availability_zone       = var.az1
  map_public_ip_on_launch = "true"

  tags = {
    Name = "vpc-1-sub-a"
  }
}
###
resource "aws_subnet" "vpc-1-sub-aa" {
  vpc_id                  = aws_vpc.vpc-1.id
  cidr_block              = "10.10.10.0/24"
  availability_zone       = var.az2
  map_public_ip_on_launch = "true"

  tags = {
    Name = "vpc-1-sub-aa"
  }
}
#following subnet "vpc-1-sub-aaa" was newly added 1/14/21
resource "aws_subnet" "vpc-1-sub-aaa" {
  vpc_id                  = aws_vpc.vpc-1.id
  cidr_block              = "10.10.11.0/24"
  availability_zone       = var.az3
  map_public_ip_on_launch = "true"

  tags = {
    Name = "vpc-1-sub-aaa"
  }
}

#Private Subnets
resource "aws_subnet" "vpc-1-sub-b" {
  vpc_id                  = aws_vpc.vpc-1.id
  cidr_block              = "10.10.2.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = var.az3

  tags = {
    Name = "vpc-1-sub-b"
  }
}

resource "aws_subnet" "vpc-1-sub-bb" {
  vpc_id                  = aws_vpc.vpc-1.id
  cidr_block              = "10.10.3.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = var.az4

  tags = {
    Name = "vpc-1-sub-bb"
  }
}

resource "aws_subnet" "vpc-1-sub-bbb" {
  vpc_id                  = aws_vpc.vpc-1.id
  cidr_block              = "10.10.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = var.az5

  tags = {
    Name = "vpc-1-sub-bbb"
  }
}

# Internet Gateway

resource "aws_internet_gateway" "vpc-1-igw" {
  vpc_id = aws_vpc.vpc-1.id

  tags = {
    Name = "vpc-1-igw"
  }
}

# Route Tables
## Usually unecessary to explicitly create a Route Table in Terraform
## since AWS automatically creates and assigns a 'Main Route Table'
## whenever a VPC is created. However, in a Transit Gateway scenario,
## Route Tables are explicitly created so an extra route to the
## Transit Gateway could be defined

resource "aws_route_table" "vpc-1-rt" {
  vpc_id = aws_vpc.vpc-1.id

  route {
    cidr_block         = "10.0.0.0/8"
    #cidr_block         = "10.11.2.0/24"
    transit_gateway_id = aws_ec2_transit_gateway.test-tgw.id
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc-1-igw.id
  }

  tags = {
    Name = "vpc-1-rt"
    env  = "attack"
  }
  depends_on = [aws_ec2_transit_gateway.test-tgw]
}

# Main Route Tables Associations
## Forcing our Route Tables to be the main ones for our VPCs,
## otherwise AWS automatically will create a main Route Table
## for each VPC, leaving our own Route Tables as secondary

#resource "aws_main_route_table_association" "main-rt-association-for-vpc-1" {
#  vpc_id         = aws_vpc.vpc-1.id
#  route_table_id = aws_route_table.vpc-1-rt.id
#}

resource "aws_route_table_association" "rt-external-association" {
  subnet_id      = aws_subnet.vpc-1-sub-a.id
  route_table_id = aws_route_table.vpc-1-rt.id
}

resource "aws_route_table_association" "rt-external-association-aa" {
  subnet_id      = aws_subnet.vpc-1-sub-aa.id
  route_table_id = aws_route_table.vpc-1-rt.id
}

#newly added rt.table association 1/14/21
resource "aws_route_table_association" "rt-external-association-aaa" {
  subnet_id      = aws_subnet.vpc-1-sub-aaa.id
  route_table_id = aws_route_table.vpc-1-rt.id
}

###

resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "vpc-1-nat-gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.vpc-1-sub-a.id
  depends_on    = [aws_internet_gateway.vpc-1-igw]
  tags = {
    Name = "vpc1-nat-gw"
  }
}

# route table for  NAT Gateway
resource "aws_route_table" "rt-vpc-1-internal" {
  vpc_id = aws_vpc.vpc-1.id
  route {
    cidr_block     = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.vpc-1-nat-gw.id
  }

  route {
    cidr_block     = "10.0.0.0/8"
        transit_gateway_id = aws_ec2_transit_gateway.test-tgw.id
  }

  tags = {
    Name = "vpc-1-nat-gw-route-table"
  }
}

# NAT Gateway route table association for internal subnet.
resource "aws_route_table_association" "rt-internal-association" {
  subnet_id      = aws_subnet.vpc-1-sub-b.id
  route_table_id = aws_route_table.rt-vpc-1-internal.id
}

resource "aws_route_table_association" "rt-internal-association-bb" {
  subnet_id      = aws_subnet.vpc-1-sub-bb.id
  route_table_id = aws_route_table.rt-vpc-1-internal.id
}

resource "aws_route_table_association" "rt-internal-association-bbb" {
  subnet_id      = aws_subnet.vpc-1-sub-bbb.id
  route_table_id = aws_route_table.rt-vpc-1-internal.id
}

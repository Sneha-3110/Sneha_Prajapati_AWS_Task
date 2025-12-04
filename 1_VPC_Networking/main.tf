# Define AWS Provider and Region
provider "aws" {
  region = "eu-north-1" 
}

# --- Data Source to select AZs ---
data "aws_availability_zones" "available" {
  state = "available"
}

# --- VPC (1 VPC) ---
resource "aws_vpc" "assessment_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Sneha_Prajapati_VPC"
  }
}

# --- Internet Gateway (IGW) ---
resource "aws_internet_gateway" "assessment_igw" {
  vpc_id = aws_vpc.assessment_vpc.id

  tags = {
    Name = "Sneha_Prajapati_IGW"
  }
}

# --- Subnets (2 Public, 2 Private) ---
resource "aws_subnet" "public_subnet_a" {
  vpc_id            = aws_vpc.assessment_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true 
  tags = { Name = "Sneha_Prajapati_Public_A" }
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id            = aws_vpc.assessment_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true
  tags = { Name = "Sneha_Prajapati_Public_B" }
}

resource "aws_subnet" "private_subnet_a" {
  vpc_id            = aws_vpc.assessment_vpc.id
  cidr_block        = "10.0.11.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = { Name = "Sneha_Prajapati_Private_A" }
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id            = aws_vpc.assessment_vpc.id
  cidr_block        = "10.0.12.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = { Name = "Sneha_Prajapati_Private_B" }
}

# --- NAT Gateway (NGW) ---
resource "aws_eip" "nat_gateway_eip" {
  domain = "vpc"
  tags = { Name = "Sneha_Prajapati_NGW_EIP" }
}

resource "aws_nat_gateway" "assessment_ngw" {
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id     = aws_subnet.public_subnet_a.id # NAT Gateway must be in a Public Subnet
  tags = { Name = "Sneha_Prajapati_NAT_Gateway" }
  depends_on = [aws_internet_gateway.assessment_igw]
}

# --- Route Tables and Associations ---
# Public Route Table (0.0.0.0/0 -> IGW)
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.assessment_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.assessment_igw.id
  }
  tags = { Name = "Sneha_Prajapati_Public_RT" }
}

resource "aws_route_table_association" "public_a_association" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_b_association" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_rt.id
}

# Private Route Table (0.0.0.0/0 -> NGW)
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.assessment_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.assessment_ngw.id
  }
  tags = { Name = "Sneha_Prajapati_Private_RT" }
}

resource "aws_route_table_association" "private_a_association" {
  subnet_id      = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_b_association" {
  subnet_id      = aws_subnet.private_subnet_b.id
  route_table_id = aws_route_table.private_rt.id
}
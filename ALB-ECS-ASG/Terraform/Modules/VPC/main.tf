#------------------------------------------------------------------------------
# AWS VPC
#------------------------------------------------------------------------------
resource "aws_vpc" "aws_vpc" {
  cidr_block           = var.cidr[0]
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "${var.project_name}-${var.environment}-vpc"
  }
}

# Get Region Available Zones
data "aws_availability_zones" "az_availables" {
  state = "available"
}

# VPC - SUBNETS PUBLICS
resource "aws_subnet" "public_subnets" {
  count                   = 2
  availability_zone       = data.aws_availability_zones.az_availables.names[count.index]
  vpc_id                  = aws_vpc.aws_vpc.id
  cidr_block              = cidrsubnet(aws_vpc.aws_vpc.cidr_block, 8, count.index + 1)
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-${var.environment}-public_subnet_${count.index}"
  }
}

# VPC - SUBNETS PRIVATES
resource "aws_subnet" "private_subnets" {
  count             = 2
  availability_zone = data.aws_availability_zones.az_availables.names[count.index]
  vpc_id            = aws_vpc.aws_vpc.id
  cidr_block        = cidrsubnet(aws_vpc.aws_vpc.cidr_block, 8, count.index + 3)
  tags = {
    Name = "${var.project_name}-${var.environment}-private_subnet_${count.index}"
  }
}

# VPC - INTERNET GATEWAY
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.aws_vpc.id
  tags = {
    Name = "${var.project_name}-${var.environment}-igw"
  }
}

# VPC - ROUTE TABLES PUBLICS
resource "aws_default_route_table" "rt_public" {
  default_route_table_id = aws_vpc.aws_vpc.default_route_table_id

  # INTERNET ROUTE
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-public_rt"
  }
}

# VPC - EIP
resource "aws_eip" "eip" {
  count  = var.create_nat_gateway ? 1 : 0
  domain = "vpc"
  tags = {
    Name = "${var.project_name}-${var.environment}-eip"
  }
}

# VPC - NAT GATEWAY
resource "aws_nat_gateway" "natgw" {
  count         = var.create_nat_gateway ? 1 : 0
  allocation_id = aws_eip.eip[0].id
  subnet_id     = aws_subnet.public_subnets[0].id
  tags = {
    Name = "${var.project_name}-${var.environment}-nat"
  }
}



# VPC - ROUTE TABLES PRIVATES
resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.aws_vpc.id

  dynamic "route" {
    for_each = var.create_nat_gateway ? [1] : []
    content {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_nat_gateway.natgw[0].id
    }
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-private_rt"
  }
}

# PRIVATE SUBNETS ASSOCIATIONS
resource "aws_route_table_association" "rt_assoc_priv_subnets" {
  count          = 2
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.rt_private.id
}


# PUBLIC SUBNETS ASSOCIATIONS
resource "aws_route_table_association" "rt_assoc_pub_subnets" {
  count          = 2
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_vpc.aws_vpc.main_route_table_id
}
# VPC
resource "aws_vpc" "my-vpc" {
  cidr_block                = "10.${var.classb_vpc_cidr_block}.0.0/16"
  instance_tenancy          = "default"
  enable_dns_support        = true
  enable_dns_hostnames      = true
  tags = {
      Name                  = "${var.COID}-${var.ASSETID}-${var.APID}-${var.SIDP}-${var.ENV}-00-VPC"
  }
}

# VPC - INTERNET GATEWAY
resource "aws_internet_gateway" "my-internet-gateway" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
      Name                  = "${var.COID}-${var.ASSETID}-${var.APID}-${var.SIDP}-${var.ENV}-00-IG"
    }
}

# VPC - SUBNETS PUBLICS
resource "aws_subnet" "subnet-public-1a" {
  vpc_id                    = aws_vpc.my-vpc.id
  cidr_block                = "10.${var.classb_vpc_cidr_block}.1.0/24"
  availability_zone         = var.aws-zona-1a
  map_public_ip_on_launch   = true
  tags                      = {
      Name                  = "${var.COID}-${var.ASSETID}-${var.APID}-${var.SIDP}-${var.ENV}-00-SUBNET1A-PUBLIC"
  }
}

resource "aws_subnet" "subnet-public-1b" {
  vpc_id                    = aws_vpc.my-vpc.id
  cidr_block                = "10.${var.classb_vpc_cidr_block}.2.0/24"
  availability_zone         = var.aws-zona-1b
  map_public_ip_on_launch   = true
  tags                      = {
      Name                  = "${var.COID}-${var.ASSETID}-${var.APID}-${var.SIDP}-${var.ENV}-00-SUBNET1B-PUBLIC"
  }
}

# VPC - SUBNETS PRIVATES
resource "aws_subnet" "subnet-private-1a" {
  vpc_id                    = aws_vpc.my-vpc.id
  cidr_block              = "10.${var.classb_vpc_cidr_block}.3.0/24"
  availability_zone         = var.aws-zona-1a
  map_public_ip_on_launch   = false
  tags                      = {
      Name                  = "${var.COID}-${var.ASSETID}-${var.APID}-${var.SIDP}-${var.ENV}-00-SUBNET1A-PRIVATE"
  }
}

resource "aws_subnet" "subnet-private-1b" {
  vpc_id                    = aws_vpc.my-vpc.id
  cidr_block              = "10.${var.classb_vpc_cidr_block}.4.0/24"
  availability_zone         = var.aws-zona-1b
  map_public_ip_on_launch   = false
  tags                      = {
      Name                  = "${var.COID}-${var.ASSETID}-${var.APID}-${var.SIDP}-${var.ENV}-00-SUBNET1B-PRIVATE"
  }
}

# VPC - ROUTE TABLES PUBLICS
resource "aws_route_table" "routeTable-Public" {
  vpc_id                    = aws_vpc.my-vpc.id
  route {
    cidr_block              = "0.0.0.0/0"
    gateway_id              = aws_internet_gateway.my-internet-gateway.id
  }
  tags = {
    Name                  = "${var.COID}-${var.ASSETID}-${var.APID}-${var.SIDP}-${var.ENV}-00-RT-PUBLIC"
  }
}

resource "aws_route_table_association" "Assoc-RT-Public-1a" {
  route_table_id            = aws_route_table.routeTable-Public.id
  subnet_id                 = aws_subnet.subnet-public-1a.id
}

resource "aws_route_table_association" "Assoc-RT-Public-1b" {
  route_table_id            = aws_route_table.routeTable-Public.id
  subnet_id                 = aws_subnet.subnet-public-1b.id
}

# VPC - ROUTE TABLES PRIVATES
resource "aws_route_table" "routeTable-Private" {
  vpc_id                    = aws_vpc.my-vpc.id
  route {
    cidr_block              = "0.0.0.0/0"
    gateway_id              = aws_nat_gateway.nat-gateway-1a.id
  }
  tags = {
    Name                  = "${var.COID}-${var.ASSETID}-${var.APID}-${var.SIDP}-${var.ENV}-00-RT-PRIVATE"
  }
/*
  lifecycle {
    prevent_destroy         = true
  }
*/
}

resource "aws_route_table_association" "Assoc-RT-Private-1a" {
  route_table_id            = aws_route_table.routeTable-Private.id
  subnet_id                 = aws_subnet.subnet-private-1a.id
}

resource "aws_route_table_association" "Assoc-RT-Private-1b" {
  route_table_id            = aws_route_table.routeTable-Private.id
  subnet_id                 = aws_subnet.subnet-private-1b.id
}

# VPC - NAT GATEWAY
resource "aws_eip" "eip_nat_gateway" {
  vpc                       = true
  tags = {
    Name                  = "${var.COID}-${var.ASSETID}-${var.APID}-${var.SIDP}-${var.ENV}-00-EIP"
  }
}

resource "aws_nat_gateway" "nat-gateway-1a" {
  allocation_id             = aws_eip.eip_nat_gateway.id
  connectivity_type         = "public"
  subnet_id                 = aws_subnet.subnet-public-1a.id
  tags = {
    Name                  = "${var.COID}-${var.ASSETID}-${var.APID}-${var.SIDP}-${var.ENV}-00-NATGateway"
  }
}

# VPC - SECURITY GROUPS
resource "aws_security_group" "my-security-group" {
  #name                      = var.name-security-group
  name                      = "${var.COID}-${var.ASSETID}-${var.APID}-${var.SIDP}-${var.ENV}-00-SG"
  vpc_id                    = aws_vpc.my-vpc.id
  description               = "${var.COID}-${var.ASSETID}-${var.APID}-${var.SIDP}-${var.ENV}-00-SG"
  ingress {
    from_port               = 0
    to_port                 = 0
    protocol                = "all"
    cidr_blocks             = ["0.0.0.0/0"]
    ipv6_cidr_blocks        = ["::/0"]
  }
  egress {
    from_port               = 0
    to_port                 = 0
    protocol                = "all"
    cidr_blocks             = ["0.0.0.0/0"]
    ipv6_cidr_blocks        = ["::/0"]
  }
  tags = {
    Name                    = "${var.COID}-${var.ASSETID}-${var.APID}-${var.SIDP}-${var.ENV}-00-SG"
  }
}
##### VPC Variables
variable "vpc_cidr_block" {
  description       = "CIDR block VPC"
  type              = string
}

variable "name" {
  description       = "Name of the VPC"
  type              = string
}

variable "project" {
  description       = "Name of project this VPC"
  type              = string
}

variable "environment" {
  description       = "Name of environment this VPC"
  type              = string
}

##### InternetGateway Variables
variable "InternetGateway" {
  description       = "Name of Internet Gateway this VPC"
  type              = string
}

##### SubnetsPublics Variables
variable "cidr-subnet-public-1a" {
  description       = "CIDR block Subnet Public 1a"
  type              = string
}

variable "cidr-subnet-public-1b" {
  description       = "CIDR block Subnet Public 1b"
  type              = string
}

variable "name-public-1a" {
  description       = "Name SubnetPublic 1a"
  type              = string
}

variable "name-public-1b" {
  description       = "Name SubnetPublic 1b"
  type              = string
}

##### SubnetsPrivates Variables
variable "cidr-subnet-private-1a" {
  description       = "CIDR block Subnet Private 1a"
  type              = string
}

variable "cidr-subnet-private-1b" {
  description       = "CIDR block Subnet Private 1b"
  type              = string
}

variable "name-private-1a" {
  description       = "Name SubnetPrivate 1a"
  type              = string
}

variable "name-private-1b" {
  description       = "Name SubnetPrivate 1b"
  type              = string
}

variable "aws-zona-1a" {
  description       = "Availability Zone 1a"
  type              = string
}

variable "aws-zona-1b" {
  description       = "Availability Zone 1b"
  type              = string
}

##### RouteTable Public Variables
variable "route-table-public" {
  description       = "Name Route Table Public"
  type              = string
}

##### RouteTable Private Variables
variable "route-table-private" {
  description       = "Name Route Table Private"
  type              = string
}

##### SecurityGroups Variables
variable "name-security-group" {
  description = "Name for my security group"
  type = string
}
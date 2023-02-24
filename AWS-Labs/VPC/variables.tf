variable "AWS_REGION" {
  description       = "AWS REGION"
  type              = string
}

##### VPC Variables
variable "classb_vpc_cidr_block" {
  description       = "Class B of VPC (10.XXX.0.0/16)"
  type              = number
}

##### Environments Variables
variable "APID" {
  description       = "APID"
  type              = string
}

variable "ASSETID" {
  description       = "ASSETID"
  type              = string
}

variable "COID" {
  description       = "COID"
  type              = string
}

variable "ENV" {
  description       = "ENV"
  type              = string
}

variable "SIDP" {
  description       = "SIDP"
  type              = string
}

##### AZ's Variables
variable "aws-zona-1a" {
  description       = "Availability Zone 1a"
  type              = string
}

variable "aws-zona-1b" {
  description       = "Availability Zone 1b"
  type              = string
}
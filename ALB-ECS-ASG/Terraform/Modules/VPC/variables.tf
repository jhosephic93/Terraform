#------------------------------------------------------------------------------
# AWS VPC VARIABLES
#------------------------------------------------------------------------------
variable "project_name" {
  type = string
  description = "Name of the Project."
}

variable "environment" {
  type = string
  description = "The environment to deploy to"
}

variable "name" {
  description = "Provided name used for name concatenation of resources"
  type        = string
}

variable "cidr" {
  description = "CIDR block"
  type        = list(any)
}

variable "subnets_number" {
  description = "Number of subnets to create (independent from type)"
  default     = 2
}

variable "create_nat_gateway" {
  description = "A flag to determine whether the NAT Gateway should be created"
  type        = bool
}
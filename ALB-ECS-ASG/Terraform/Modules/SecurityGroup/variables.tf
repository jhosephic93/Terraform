variable "project_name" {
  type = string
  description = "Name of the Project."
}

variable "environment" {
  type = string
  description = "The environment to deploy to"
}

variable "vpc_id" {
  description = "The ID of the VPC where the security group will take place"
  type        = string
}
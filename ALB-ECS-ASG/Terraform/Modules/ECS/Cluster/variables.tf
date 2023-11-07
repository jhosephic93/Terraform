#------------------------------------------------------------------------------
# AWS ECS VARIABLES
#------------------------------------------------------------------------------
variable "name" {
  type = string
  description = "Name of the ECS Cluster."
}

variable "project_name" {
  type = string
  description = "Name of the Project."
}

variable "environment" {
  type = string
  description = "The environment to deploy to"
}

variable "additional_tags" {
  type = map(string)
  description = "A map of tags to assign to the resource."
  default = {}
}
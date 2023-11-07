#------------------------------------------------------------------------------
# KEY VARIABLES GENERAL
#------------------------------------------------------------------------------
variable "env" {
  type        = string
  description = "The environment to deploy to"
}

variable "project" {
  type = string
  description = "Name of the Project."
}

variable "tag_description" {
  type = string
  description = "Description for tags."
}

#------------------------------------------------------------------------------
# KEY VARIABLES ECR
#------------------------------------------------------------------------------
variable "ecr_name" {
  type = string
  description = "Name of the repository."
}

variable "ecr_image_tag_mutability" {
  type = string
  description = "The tag mutability setting for the repository. Must be one of: MUTABLE or IMMUTABLE."
}

variable "ecr_scan_on_push" {
  type = bool
  description = "Indicates whether images are scanned after being pushed to the repository (true) or not scanned (false)."
}

variable ecr_expiration_after_days {
  type = number
  description = "Delete images older than X days."
  default = 0
}

#------------------------------------------------------------------------------
# KEY VARIABLES VPC
#------------------------------------------------------------------------------
variable "vpc_cidr" {
  description = "CIDR block of VPC"
  type        = list(any)
}

variable "vpc_create_nat_gateway" {
  description = "A flag to determine whether the NAT Gateway should be created"
  type        = bool
}

#------------------------------------------------------------------------------
# KEY VARIABLES ECS
#------------------------------------------------------------------------------
variable "ecs_name" {
  type = string
  description = "Name of the ECS Cluster."
}

#------------------------------------------------------------------------------
# KEY VARIABLES ECS TASK DEFINITIONS
#------------------------------------------------------------------------------
variable "task_definition_name" {
  type = string
  description = "Name of the ECS TASK DEFINITIONS."
}

variable "task_definition_cpu" {
  description = "The CPU value to assign to the container, read AWS documentation for available values"
  type        = number
}

variable "task_defitinion_memory" {
  description = "The MEMORY value to assign to the container, read AWS documentation to available values"
  type        = number
}

variable "task_definition_container_name" {
  description = "The name of the Container specified in the Task definition"
  type        = string
}

variable "task_definition_image_repo" {
  description = "The docker registry URL in which ecs will get the Docker image"
  type        = string
}

variable "task_definition_container_port" {
  description = "The port that the container will use to listen to requests"
  type        = number
}

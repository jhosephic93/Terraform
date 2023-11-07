#------------------------------------------------------------------------------
# AWS ECS TASK DEFINITIONS VARIABLES
#------------------------------------------------------------------------------
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

variable "task_name" {
  type = string
  description = "Name of the ECS TASK DEFINITIONS."
}

variable "ecs_task_role" {
  type = string
  description = "Task Role for ECS TASK DEFINITIONS."
}

variable "ecs_task_execution_role" {
  type = string
  description = "Task Executions Role for ECS TASK DEFINITIONS."
}

variable "task_cpu" {
  description = "The CPU value to assign to the container, read AWS documentation for available values"
  type        = number
}

variable "task_memory" {
  description = "The MEMORY value to assign to the container, read AWS documentation to available values"
  type        = number
}

variable "container_name" {
  description = "The name of the Container specified in the Task definition"
  type        = string
}

variable "image_repo" {
  description = "The docker registry URL in which ecs will get the Docker image"
  type        = string
}

variable "container_port" {
  description = "The port that the container will use to listen to requests"
  type        = number
}
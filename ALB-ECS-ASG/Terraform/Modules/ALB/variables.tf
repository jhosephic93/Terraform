variable "project_name" {
  type = string
  description = "Name of the Project."
  # Agregar default para que los Modulos del Target Group Green y Blue no se requiera
  default     = ""
}

variable "environment" {
  type = string
  description = "The environment to deploy to"
  # Agregar default para que los Modulos del Target Group Green y Blue no se requiera
  default     = ""
}

variable "name" {
  description = "A name for the target group"
  type        = string
  default     = "value"
}

variable "target_group" {
  description = "The ARN of the created target group"
  type        = string
  default     = ""
}

variable "target_group_green" {
  description = "The ANR of the created target group"
  type        = string
  default     = ""
}

variable "create_alb" {
  description = "Set to true to create an ALB"
  type        = bool
  default     = false
}

variable "enable_https" {
  description = "Set to true to create a HTTPS listener"
  type        = bool
  default     = false
}

variable "create_target_group" {
  description = "Set to true to create a Target Group"
  type        = bool
  default     = false
}

variable "subnets" {
  description = "Subnets IDs for ALB"
  type        = list(any)
  default     = []
}

variable "security_group" {
  description = "Security group ID for the ALB"
  type        = string
  default     = ""
}

variable "port" {
  description = "The port that the targer group will use"
  type        = number
  default     = 80
}

variable "protocol" {
  description = "The protocol that the target group will use"
  type        = string
  default     = ""
}

variable "vpc" {
  description = "VPC ID for the Target Group"
  type        = string
  default     = ""
}

variable "tg_type" {
  description = "Target Group Type (instance, IP, lambda)"
  type        = string
  default     = ""
}

variable "health_check_path" {
  description = "The path in which the ALB will send health checks"
  type        = string
  default     = ""
}

variable "health_check_port" {
  description = "The port to which the ALB will send health checks"
  type        = number
  default     = 80
}
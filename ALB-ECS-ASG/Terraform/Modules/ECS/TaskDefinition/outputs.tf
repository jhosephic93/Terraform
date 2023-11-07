output "arn_task_definition" {
  value = aws_ecs_task_definition.my_task_definition.arn
}

output "task_definition_family" {
  value = aws_ecs_task_definition.my_task_definition.family
}

output "task_definition_container_name" {
  description = "The name of the container"
  value       = "${var.project_name}-${var.environment}-${var.container_name}"
}
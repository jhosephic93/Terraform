#------------------------------------------------------------------------------
# AWS ECS TASK DEFINITIONS - IAM ROLE OUTPUTS
#------------------------------------------------------------------------------
output "arn_ecs_task_role" {
  value = aws_iam_role.ecs_task_role.arn
}

output "arn_ecs_task_execution_role" {
  value = aws_iam_role.ecs_task_execution_role.arn
}

output "arn_devops_role" {
  value = aws_iam_role.devops_role.arn
}

output "arn_codedeploy_role" {
  value = aws_iam_role.codedeploy_role.arn
}
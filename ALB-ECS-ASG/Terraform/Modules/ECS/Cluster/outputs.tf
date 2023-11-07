#------------------------------------------------------------------------------
# AWS ECS CLUSTER OUTPUTS
#------------------------------------------------------------------------------
output "ecs_cluster_name" {
  value = aws_ecs_cluster.cluster.name
}

output "ecs_cluster_id" {
  value = aws_ecs_cluster.cluster.id
}
#------------------------------------------------------------------------------
# AWS ECS CLUSTER AND FARGATE
#------------------------------------------------------------------------------
resource "aws_ecs_cluster" "cluster" {
  name                 = "${var.project_name}-${var.environment}-${var.name}"
  
  tags = merge(
    var.additional_tags,
    {
      ManagedBy = "Terraform"
      Environment = "${var.environment}"
    }
  )
}
#------------------------------------------------------------------------------
# AWS ECS CLUSTER Capacity Provider
#------------------------------------------------------------------------------
resource "aws_ecs_cluster_capacity_providers" "ecs_capacity_providers" {
  cluster_name = aws_ecs_cluster.cluster.name

  capacity_providers = ["FARGATE", "FARGATE_SPOT"]
  default_capacity_provider_strategy {
    base              = 2
    weight            = 100
    capacity_provider = "FARGATE"
  }
  default_capacity_provider_strategy {
    base              = 0
    weight            = 100
    capacity_provider = "FARGATE_SPOT"
  }
}
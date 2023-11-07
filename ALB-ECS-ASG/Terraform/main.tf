#------------------------------------------------------------------------------
# AWS ECR MODULE
#------------------------------------------------------------------------------
module "ecr" {
  source = "./Modules/ECR"

  project_name                  = var.project
  environment                   = var.env
  name                          = var.ecr_name
  image_tag_mutability          = var.ecr_image_tag_mutability
  scan_on_push                  = var.ecr_scan_on_push
  expiration_after_days         = var.ecr_expiration_after_days
  additional_tags = {
    Name_Project                = var.project
    Description                 = var.tag_description
  }
}

#------------------------------------------------------------------------------
# AWS IAM MODULE
#------------------------------------------------------------------------------
module "iam" {
  source = "./Modules/IAM"

  project_name                  = var.project
  environment                   = var.env
  ecr_repositories              = [module.ecr.ecr_repository_arn]
  additional_tags = {
    Name_Project                = var.project
    Description                 = var.tag_description
  }
}

#------------------------------------------------------------------------------
# AWS ECS TASK DEFINITION MODULE
#------------------------------------------------------------------------------
module "ecs_task_definition" {
  source = "./Modules/ECS/TaskDefinition"

  project_name                  = var.project
  environment                   = var.env
  task_name                     = var.task_definition_name
  ecs_task_role                 = module.iam.arn_ecs_task_role
  ecs_task_execution_role       = module.iam.arn_ecs_task_execution_role
  task_cpu                      = var.task_definition_cpu
  task_memory                   = var.task_defitinion_memory
  container_name                = var.task_definition_container_name
  image_repo                    = var.task_definition_image_repo
  container_port                = var.task_definition_container_port
  additional_tags = {
    Name_Project                = var.project
    Description                 = var.tag_description
  }
}

#------------------------------------------------------------------------------
# AWS VPC MODULE
#------------------------------------------------------------------------------
module "vpc" {
  source = "./Modules/VPC"

  project_name                  = var.project
  environment                   = var.env
  cidr                          = var.vpc_cidr
  name                          = var.env
  create_nat_gateway            = var.vpc_create_nat_gateway
}

#------------------------------------------------------------------------------
# AWS SECURITY GROUP
#------------------------------------------------------------------------------
module "security_group" {
  source = "./Modules/SecurityGroup"

  project_name                  = var.project
  environment                   = var.env
  vpc_id                        = module.vpc.aws_vpc
}

#------------------------------------------------------------------------------
# AWS ALB
#------------------------------------------------------------------------------
# AWS ALB TARGET GROUP FOR BLUE ENVIRONMENT
module "target_group_blue" {
  source = "./Modules/ALB"

  project_name                  = var.project
  environment                   = var.env
  name                          = "blue"
  create_target_group           = true
  port                          = 80
  protocol                      = "HTTP"
  vpc                           = module.vpc.aws_vpc
  tg_type                       = "ip"
  health_check_path             = "/"
  health_check_port             = 5000
}
# AWS ALB
module "alb" {
  source = "./Modules/ALB"

  project_name                  = var.project
  environment                   = var.env
  create_alb                    = true
  subnets                       = [module.vpc.public_subnets[0], module.vpc.public_subnets[1]]
  security_group                = module.security_group.security_group_alb_id
  target_group                  = module.target_group_blue.arn_tg
}

#------------------------------------------------------------------------------
# AWS ECS CLUSTER MODULE
#------------------------------------------------------------------------------
module "ecs_cluster" {
  source = "./Modules/ECS/Cluster"

  project_name                  = var.project
  environment                   = var.env
  name                          = var.ecs_name
  additional_tags = {
    Name_Project                = var.project
    Description                 = var.tag_description
  }
}

#------------------------------------------------------------------------------
# AWS ECS CLUSTER SERVICE
#------------------------------------------------------------------------------
module "ecs_service" {
  depends_on = [module.alb, module.ecs_cluster]
  source = "./Modules/ECS/Service"

  project_name                  = var.project
  environment                   = var.env
  ecs_cluster_id                = module.ecs_cluster.ecs_cluster_id
  arn_task_definition           = module.ecs_task_definition.arn_task_definition
  desired_tasks                 = 1
  arn_security_group            = module.security_group.security_group_ecs_task
  subnets_id                    = [module.vpc.private_subnets[0], module.vpc.private_subnets[1]]
  arn_target_group              = module.target_group_blue.arn_tg
  container_name                = module.ecs_task_definition.task_definition_container_name
  container_port                = 5000
}

#------------------------------------------------------------------------------
# AWS ECS CLUSTER AUTO SCALING GROUP
#------------------------------------------------------------------------------
module "ecs_autoscaling" {
  depends_on = [module.ecs_service]
  source = "./Modules/ECS/AutoScaling"

  ecs_service_name              = module.ecs_service.ecs_service_name
  cluster_name                  = module.ecs_cluster.ecs_cluster_name
  min_capacity                  = 1
  max_capacity                  = 4
}
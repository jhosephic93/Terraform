
#------------------------------------------------------------------------------
# VALUE VARIABLES GENERAL
#------------------------------------------------------------------------------
env                             = "dev"
project                         = "demo"
tag_description                 = "This is a demo for description"

#------------------------------------------------------------------------------
# VALUE VARIABLES ECR
#------------------------------------------------------------------------------
ecr_name                        = "my-repository"
ecr_expiration_after_days       = 7
ecr_scan_on_push                = true
ecr_image_tag_mutability        = "IMMUTABLE"

#------------------------------------------------------------------------------
# VALUE VARIABLES VPC
#------------------------------------------------------------------------------
vpc_cidr                        = ["10.120.0.0/16"]
vpc_create_nat_gateway          = true

#------------------------------------------------------------------------------
# VALUE VARIABLES ECS
#------------------------------------------------------------------------------
ecs_name                        = "my-cluster"

#------------------------------------------------------------------------------
# VALUE VARIABLES ECS - TASK DEFINITIONS
#------------------------------------------------------------------------------
task_definition_name            = "my-app"
task_definition_cpu             = 256
task_defitinion_memory          = 512
task_definition_container_name  = "my-container"
task_definition_image_repo      = "<your-id-account>.dkr.ecr.<region>.amazonaws.com/demo-dev-my-repository:v1"
task_definition_container_port  = 5000
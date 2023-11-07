#------------------------------------------------------------------------------
# TASK DEFINITION | CONTAINER DEFINITION
#------------------------------------------------------------------------------
resource "aws_ecs_task_definition" "my_task_definition" {
  family                   = "${var.project_name}-${var.environment}-${var.task_name}"
  requires_compatibilities = ["FARGATE"] # Utilizando FARGATE como ejemplo, pero también puede ser "EC2"
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "ARM64"
  }
  network_mode             = "awsvpc" # Esto es solo un ejemplo, puedes usar otros modos como "bridge", "host", etc.
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn       = var.ecs_task_execution_role
  task_role_arn            = var.ecs_task_role
  container_definitions    = jsonencode([
    {
      name  = "${var.project_name}-${var.environment}-${var.container_name}"
      image = "${var.image_repo}"

      cpu    = "${var.task_cpu}"
      memory = "${var.task_memory}"
      memoryReservation = "${var.task_memory}"
      essential = true

      portMappings = [
        {
          containerPort = "${var.container_port}"
          hostPort      = "${var.container_port}"
          appProtocol   = "http"
          name          = "my_container-80-tcp"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options   = {
          "awslogs-group"         = "/ecs/task-definition/${var.project_name}-${var.environment}-${var.task_name}",
          "awslogs-region"        = "us-east-1",
          "awslogs-stream-prefix" = "${var.container_name}-logs"
        }
      }

      environment = [
        {
          name  = "MY_ENV_VAR",
          value = "value"
        }
      ]
    }
  ])
}

# ------- CloudWatch Logs groups to store ecs-containers logs -------
resource "aws_cloudwatch_log_group" "TaskDF-Log_Group" {
  name              = "/ecs/task-definition/${var.project_name}-${var.environment}-${var.task_name}"
  retention_in_days = 30
}
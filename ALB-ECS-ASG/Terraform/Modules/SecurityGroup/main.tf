#------------------------------------------------------------------------------
# AWS ALB - SECURITY GROUP
#------------------------------------------------------------------------------
resource "aws_security_group" "alb_sg" {
  name                = "${var.project_name}-${var.environment}-alb"
  description         = "Controls access to the client ALB"
  vpc_id              = var.vpc_id

  ingress {
    protocol          = "tcp"
    from_port         = 80
    to_port           = 80
    cidr_blocks       = ["0.0.0.0/0"]
    security_groups   = null
  }
  egress {
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks       = ["0.0.0.0/0"]
  }

  tags = {
    Name              = "${var.project_name}-${var.environment}-alb"
  }
}

#------------------------------------------------------------------------------
# AWS ECS TASK - SECURITY GROUP
#------------------------------------------------------------------------------
resource "aws_security_group" "ecs_task_sg" {
  depends_on          = [aws_security_group.alb_sg]
  name                = "${var.project_name}-${var.environment}-ecs_task"
  description         = "Controls access to the client ECS task"
  vpc_id              = var.vpc_id

  ingress {
    protocol          = "tcp"
    from_port         = 5000
    to_port           = 5000
    security_groups   = [aws_security_group.alb_sg.id]
  }
  egress {
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks       = ["0.0.0.0/0"]
  }

  tags = {
    Name              = "${var.project_name}-${var.environment}-ecs_task"
  }
}
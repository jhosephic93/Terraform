#------------------------------------------------------------------------------
# AWS ECS Task Role
#------------------------------------------------------------------------------
resource "aws_iam_role" "ecs_task_role" {
  name = "${var.project_name}-${var.environment}-ecs_task_role"
  assume_role_policy = file("${path.module}/files/iam/ecs_task_iam_role.json")
  tags = merge(
    var.additional_tags,
    {
      ManagedBy = "Terraform"
      Environment = "${var.environment}"
    }
  )
}

resource "aws_iam_policy" "policy_for_ecs_task_role" {
  name        = "${var.project_name}-${var.environment}-ecs_task_custom_policy"
  description = "IAM Policy for Role"
  policy      = data.aws_iam_policy_document.role_policy_ecs_task_role.json

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "role_policy_ecs_task_role" {
  statement {
    sid    = "AllowS3Actions"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:ListBucket"
    ]
    resources = var.s3_bucket_assets
  }
  statement {
    sid    = "AllowIAMPassRole"
    effect = "Allow"
    actions = [
      "iam:PassRole"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "AllowDynamodbActions"
    effect = "Allow"
    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:Describe*",
      "dynamodb:List*",
      "dynamodb:GetItem",
      "dynamodb:Query",
      "dynamodb:Scan",
    ]
    resources = var.dynamodb_table
  }
}

resource "aws_iam_role_policy_attachment" "ecs_attachment" {
  policy_arn = aws_iam_policy.policy_for_ecs_task_role.arn
  role       = aws_iam_role.ecs_task_role.name

  lifecycle {
    create_before_destroy = true
  }
}
#------------------------------------------------------------------------------
# AWS ECS Task Execution Role
#------------------------------------------------------------------------------
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.project_name}-${var.environment}-ecs_task_execution_role"
  assume_role_policy = file("${path.module}/files/iam/ecs_task_execution_iam_role.json")
  tags = merge(
    var.additional_tags,
    {
      ManagedBy = "Terraform"
      Environment = "${var.environment}"
    }
  )
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_role_policy_attachment" "ecs_execution_role_ecs_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

#------------------------------------------------------------------------------
# AWS CODEBUILD | CODEDEPLOY | CODEPIPELINE Role
#------------------------------------------------------------------------------
resource "aws_iam_role" "devops_role" {
  name               = "${var.project_name}-${var.environment}-code_build-deploy-pipeline_role"
  assume_role_policy = file("${path.module}/files/iam/code_build-deploy-pipeline_iam_role.json")
  tags = merge(
    var.additional_tags,
    {
      ManagedBy = "Terraform"
      Environment = "${var.environment}"
    }
  )
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_policy" "policy_for_role" {
  name        = "${var.project_name}-${var.environment}-devops_custom_policy"
  description = "IAM Policy for Role devops"
  policy      = data.aws_iam_policy_document.role_policy_devops_role.json

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "role_policy_devops_role" {
  statement {
    sid    = "AllowS3Actions"
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketAcl",
      "s3:List*"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "AllowCodebuildActions"
    effect = "Allow"
    actions = [
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild",
      "codebuild:BatchGetBuildBatches",
      "codebuild:StartBuildBatch",
      "codebuild:StopBuild"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "AllowCodebuildList"
    effect = "Allow"
    actions = [
      "codebuild:ListBuilds"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "AllowCodestar"
    effect = "Allow"
    actions = [
      "codestar-connections:UseConnection",
      "codestar-connections:*"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "AllowCodeDeployActions"
    effect = "Allow"
    actions = [
      "codedeploy:CreateDeployment",
      "codedeploy:GetApplication",
      "codedeploy:GetApplicationRevision",
      "codedeploy:GetDeployment",
      "codedeploy:GetDeploymentGroup",
      "codedeploy:RegisterApplicationRevision"
    ]
    resources = var.code_deploy_resources
  }
  statement {
    sid    = "AllowCodeDeployConfigs"
    effect = "Allow"
    actions = [
      "codedeploy:GetDeploymentConfig",
      "codedeploy:CreateDeploymentConfig",
      "codedeploy:CreateDeploymentGroup",
      "codedeploy:GetDeploymentTarget",
      "codedeploy:StopDeployment",
      "codedeploy:ListApplications",
      "codedeploy:ListDeploymentConfigs",
      "codedeploy:ListDeploymentGroups",
      "codedeploy:ListDeployments"

    ]
    resources = ["*"]
  }
  statement {
    sid    = "AllowECRActions"
    effect = "Allow"
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:CompleteLayerUpload",
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart"
    ]
    resources = var.ecr_repositories
  }
  statement {
    sid    = "AllowECRAuthorization"
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken",
    ]
    resources = ["*"]
  }
  statement {
    sid    = "AllowCECSServiceActions"
    effect = "Allow"
    actions = [
      "ecs:ListServices",
      "ecs:ListTasks",
      "ecs:DescribeServices",
      "ecs:DescribeTasks",
      "ecs:DescribeTaskDefinition",
      "ecs:DescribeTaskSets",
      "ecs:DeleteTaskSet",
      "ecs:DeregisterContainerInstance",
      "ecs:CreateTaskSet",
      "ecs:UpdateCapacityProvider",
      "ecs:PutClusterCapacityProviders",
      "ecs:UpdateServicePrimaryTaskSet",
      "ecs:RegisterTaskDefinition",
      "ecs:RunTask",
      "ecs:StartTask",
      "ecs:StopTask",
      "ecs:UpdateService",
      "ecs:UpdateCluster",
      "ecs:UpdateTaskSet"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "AllowIAMPassRole"
    effect = "Allow"
    actions = [
      "iam:PassRole"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "AllowCloudWatchActions"
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy_attachment" "attachment2" {
  policy_arn = aws_iam_policy.policy_for_role.arn
  role       = aws_iam_role.devops_role.name

  lifecycle {
    create_before_destroy = true
  }
}

#------------------------------------------------------------------------------
# AWS CODEDEPLOY Role
#------------------------------------------------------------------------------
resource "aws_iam_role" "codedeploy_role" {
  name               = "${var.project_name}-${var.environment}-code_deploy_role"
  assume_role_policy = file("${path.module}/files/iam/code_deploy_iam_role.json")
  tags = merge(
    var.additional_tags,
    {
      ManagedBy = "Terraform"
      Environment = "${var.environment}"
    }
  )
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_role_policy_attachment" "codedeploy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployRoleForECS"
  role       = aws_iam_role.codedeploy_role.name
}
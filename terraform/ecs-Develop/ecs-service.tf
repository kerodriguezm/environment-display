data "aws_subnet" "public_a" {
  filter {
    name   = "cidr-block"
    values = ["10.0.1.0/24"] 
  }
}

data "aws_subnet" "public_b" {
  filter {
    name   = "cidr-block"
    values = ["10.0.2.0/24"] 
  }
}
data "aws_security_group" "ecs" {
  name = "ecs-sg"
}

resource "aws_ecs_task_definition" "ecs" {
  family                   = "develop"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([{
    name  = "develop"
    image = var.image
    essential = true
    portMappings = [{
      containerPort = 80
      hostPort      = 80
    }]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = var.log_group
        awslogs-region        = var.region
        awslogs-stream-prefix = "ecs"
      }
    }
  }])

  execution_role_arn = aws_iam_role.ecs_task_execution_role_dev.arn
  task_role_arn      = aws_iam_role.ecs_task_execution_role_dev.arn
}

resource "aws_iam_role" "ecs_task_execution_role_dev" {
  name = "ecsTaskExecutionRoleDev"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  ]
}

resource "aws_ecs_service" "develop" {
  name            = "develop-service"
  cluster         = aws_ecs_cluster.develop.id
  task_definition = aws_ecs_task_definition.ecs.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [data.aws_subnet.public_a.id, data.aws_subnet.public_b.id]
    security_groups = [data.aws_security_group.ecs.id]
    assign_public_ip = true
  }
}

resource "aws_cloudwatch_log_group" "ecs" {
  name              = var.log_group
  retention_in_days = 1
}




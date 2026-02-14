resource "aws_cloudwatch_log_group" "proxy" {
  name              = "/ecs/${var.namespace}/${var.environment}/proxy"
  retention_in_days = var.log_retention_in_days
}

resource "aws_cloudwatch_log_group" "backend" {
  name              = "/ecs/${var.namespace}/${var.environment}/backend"
  retention_in_days = var.log_retention_in_days
}

resource "aws_ecs_task_definition" "proxy" {
  family                   = "${var.namespace}-${var.environment}-proxy"
  requires_compatibilities = ["EC2"]
  network_mode             = "host"
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn

  container_definitions = jsonencode([
    {
      name      = "proxy"
      image     = var.proxy_container_image
      cpu       = var.proxy_container_cpu
      memory    = var.proxy_container_memory
      essential = true
      portMappings = [
        {
          containerPort = var.proxy_container_port
          hostPort      = var.proxy_container_port
          protocol      = "tcp"
        },
        {
          containerPort = var.proxy_bedrock_port
          hostPort      = var.proxy_bedrock_port
          protocol      = "udp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.proxy.name
          awslogs-region        = data.aws_region.current.name
          awslogs-stream-prefix = "proxy"
        }
      }
    }
  ])
}

resource "aws_ecs_task_definition" "backend" {
  family                   = "${var.namespace}-${var.environment}-backend"
  requires_compatibilities = ["EC2"]
  network_mode             = "host"
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn

  container_definitions = jsonencode([
    {
      name      = "backend"
      image     = var.backend_container_image
      cpu       = var.backend_container_cpu
      memory    = var.backend_container_memory
      essential = true
      portMappings = [
        {
          containerPort = var.backend_container_port
          hostPort      = var.backend_container_port
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.backend.name
          awslogs-region        = data.aws_region.current.name
          awslogs-stream-prefix = "backend"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "proxy" {
  name            = "${var.namespace}-${var.environment}-proxy"
  cluster         = aws_ecs_cluster.proxy.id
  task_definition = aws_ecs_task_definition.proxy.arn
  desired_count   = var.proxy_desired_count
  launch_type     = "EC2"

  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 100
}

resource "aws_ecs_service" "backend" {
  name            = "${var.namespace}-${var.environment}-backend"
  cluster         = aws_ecs_cluster.backend.id
  task_definition = aws_ecs_task_definition.backend.arn
  desired_count   = var.backend_desired_count
  launch_type     = "EC2"

  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 100
}

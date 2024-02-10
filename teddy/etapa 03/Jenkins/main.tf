provider "aws" {
  region = "us-east-1"
}

resource "aws_ecs_cluster" "teddy" {
  name = "teddy"
}

resource "aws_ecs_log_group" "meu_log_group" {
  name = "/ecs/teddy/app-nxinx-service"
  depends_on = [aws_ecs_service.teddy_service]
}

resource "aws_iam_role" "ecs_execution_role" {
  name = "ecs_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })
}

resource "aws_ecs_task_definition" "my_task" {
  family                   = "app-nginx"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  execution_role_arn       = aws_iam_role.ecs_execution_role.arn

  container_definitions    = jsonencode([
    {
      name  = "app-nginx"
      image = "942436156840.dkr.ecr.us-east-1.amazonaws.com/ecr-teddy-nginx:latest"


      portMappings = [
        {
          containerPort = 80
          hostPort      = 8080
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "teddy_service" {
  name            = "app-nxinx-service"
  cluster         = ["${aws_ecs_cluster.teddy.id}"]
  task_definition = aws_ecs_task_definition.my_task.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets = ["subnet-1234abcd", "subnet-5678efgh"]
    security_groups = ["sg-12345678"]
  }
  depends_on = [aws_ecs_task_definition.my_task]
}
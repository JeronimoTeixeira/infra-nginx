terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
  access_key = "test"
  secret_key = "test"
  skip_credentials_validation = true
  skip_metadata_api_check = true
  endpoints {
    ec2       = "http://localhost:4566"
    s3        = "http://localhost:4566"
    sts       = "http://localhost:4566"
    ecs       = "http://localhost:4566"
    elbv2     = "http://localhost:4566"
  }
}

resource "aws_vpc" "vpc_ms" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "sub_ms_a" {
  vpc_id                  = aws_vpc.vpc_ms.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.region}${var.az_subnet_a}"
}

resource "aws_subnet" "sub_ms_b" {
  vpc_id                  = aws_vpc.vpc_ms.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "${var.region}${var.az_subnet_b}"
}


resource "aws_lb" "nlb_ms" {
  name               = var.nlb_name
  internal           = false
  ip_address_type = "ipv4"
  load_balancer_type = "network"
  
  subnet_mapping {
    subnet_id     = aws_subnet.sub_ms_a.id
  }
  
  subnet_mapping {
    subnet_id     = aws_subnet.sub_ms_b.id
  }

  tags = {
    microservico = "ms"
  }
}

resource "aws_ecs_cluster" "ecs_ms" {
  name = var.ecs_name

  tags = {
    microservico = "ms"
  }
}

resource "aws_security_group" "nginx_ms_sg" {
  name        = "nginx-ms-security-group"
  description = "Security Group para o nginx-ms"

  vpc_id = aws_vpc.vpc_ms.id 

  // Regras de entrada
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Permitir tráfego HTTP de qualquer lugar
  }

  // Regras de saída
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Permitir todo o tráfego de saída
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_ecs_task_definition" "nginx_ms" {
  family                   = "nginx-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name      = "nginx",
      image     = "000000000000.dkr.ecr.us-east-1.localhost.localstack.cloud:4510/nginx-ms:latest",
      memory    = 128,
      cpu       = 128,
      portMappings = [
        {
          containerPort = 80,
          hostPort      = 80
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "nginx_ms" {
  name            = "nginx-ms"
  cluster         = aws_ecs_cluster.ecs_ms.id
  task_definition = aws_ecs_task_definition.nginx_ms.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [aws_subnet.sub_ms_a.id, aws_subnet.sub_ms_b.id]
    security_groups = [aws_security_group.nginx_ms_sg.id]
  }
}

resource "aws_lb_target_group" "nginx_ms_target_group" {
  name     = "nginx-ms-target-group"
  port     = 80
  protocol = "TCP"
  vpc_id   = aws_vpc.vpc_ms.id

  health_check {
    enabled             = true
    interval            = 30
    port                = "80"
    protocol            = "TCP"
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_target_group_attachment" "nginx_ms_attachment" {
  target_group_arn = aws_lb_target_group.nginx_ms_target_group.arn
  target_id        = aws_ecs_service.nginx_ms.id
  port             = 80
}

resource "aws_lb_listener" "nlb_ms_listener" {
  load_balancer_arn = aws_lb.nlb_ms.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx_ms_target_group.arn
  }
}